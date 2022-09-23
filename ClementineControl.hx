package;

import clementine.Types.SongMetadata;
import clementine.*;

using api.IdeckiaApi;

typedef Props = {
	@:shared
	@:editable("Host", "127.0.0.1")
	var clementine_host:String;
	@:shared
	@:editable("Port", 5500)
	var clementine_port:Int;
	@:shared
	@:editable("AuthCode", -1)
	var clementine_auth_code:Int;
	@:editable("Action", 'playpause', ['previous', 'play', 'next', 'playpause', 'shuffle', 'stop', 'songinfo'])
	var action:String;
}

@:name("clementine-control")
@:description("Control clementine-player")
class ClementineControl extends IdeckiaAction {
	static var client:ClementineClient;

	static var currentSong:SongMetadata;

	override public function init(initialState:ItemState):js.lib.Promise<ItemState> {
		function prepareOnSong() {
			if (props.action != 'songinfo')
				return;

			client.onSong = songMetadata -> {
				if (currentSong != null && currentSong.id == songMetadata.id)
					return;

				currentSong = songMetadata;
				var title = new RichString(currentSong.title).bold();
				var album = new RichString(currentSong.album).underline().size(initialState.textSize * .8);
				var artist = new RichString(currentSong.artist).italic().size(initialState.textSize * .6);

				initialState.text = '$title\n$album\n$artist';

				if (currentSong.art != null)
					initialState.icon = haxe.crypto.Base64.encode(js.node.buffer.Buffer.from(currentSong.art).hxToBytes());

				server.updateClientState(initialState);
			};
		}

		if (client == null) {
			connect().then((_) -> prepareOnSong);
		} else {
			prepareOnSong();
		}

		return super.init(initialState);
	}

	public function execute(currentState:ItemState):js.lib.Promise<ItemState> {
		return new js.lib.Promise((resolve, reject) -> {
			if (client == null) {
				connect();

				reject('Client is connecting to clementine');
				return;
			}

			switch props.action {
				case 'previous': client.previous();
				case 'play': client.play();
				case 'next': client.next();
				case 'playpause': client.playpause();
				case 'shuffle': client.shuffle();
				case 'stop': client.stop();
				case 'songinfo':
				case c:
					reject('Unknown action for clementine $c');
					return;
			}

			resolve(currentState);
		});
	}

	function connect():js.lib.Promise<Bool> {
		return new js.lib.Promise((resolve, reject) -> {
			server.log.debug('Connecting clementine in host [${props.clementine_host}] / port [${props.clementine_port}] / authCode[${props.clementine_auth_code}]');
			client = new ClementineClient(props.clementine_host, props.clementine_port, props.clementine_auth_code);
			client.onConnect = () -> {
				server.log.info('Connected to clementine');
				resolve(true);
			};
			client.onError = (error:String) -> {
				server.dialog.error('Clementine-control error', error);
			};
		});
	}
}
