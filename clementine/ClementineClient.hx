package clementine;

import clementine.Types;

class ClementineClient {
	var clientJs:ClementineClientJs;

	public function new(host:String, port:Int, authCode:Int) {
		clientJs = new ClementineClientJs({
			host: host,
			port: Std.string(port),
			authCode: authCode
		});

		clientJs.on('alive', (_) -> onAlive());
		clientJs.on('connect', (_) -> onConnect());
		clientJs.on('disconnect', (r) -> onDisconnect(cast r));
		clientJs.on('error', (e) -> onError(cast e));
		clientJs.on('volume', (v) -> onVolume(cast v));
		clientJs.on('repeat', (r) -> onRepeat(cast r));
		clientJs.on('shuffle', (s) -> onShuffle(cast s));
		clientJs.on('info', (v) -> onInfo(cast v));
		clientJs.on('play', (_) -> onPlay());
		clientJs.on('playpause', (_) -> onPlaypause());
		clientJs.on('pause', (_) -> onPause());
		clientJs.on('stop', (_) -> onStop());
		clientJs.on('next', (_) -> onNext());
		clientJs.on('previous', (_) -> onPrevious());
		clientJs.on('song', (s) -> onSong(cast s));
		clientJs.on('playlists', (v) -> onPlaylists(cast v));
		clientJs.on('position', (v) -> onPosition(cast v));
		clientJs.on('ready', (_) -> onReady());
		clientJs.on('library', (l) -> onLibrary(cast l));
	}

	public function previous() {
		assertClientNull();
		clientJs.previous();
	}

	public function play() {
		assertClientNull();
		clientJs.play();
	}

	public function next() {
		assertClientNull();
		clientJs.next();
	}

	public function playpause() {
		assertClientNull();
		clientJs.playpause();
	}

	public function shuffle() {
		assertClientNull();
		clientJs.shuffle();
	}

	public function stop() {
		assertClientNull();
		clientJs.stop();
	}

	public function setVolume(percentage:UInt) {
		assertClientNull();
		clientJs.setVolume(percentage);
	}

	function assertClientNull() {
		if (clientJs == null)
			throw 'You must initialize the client';
	}

	public dynamic function onAlive() {}

	public dynamic function onConnect() {}

	public dynamic function onError(error:String) {}

	public dynamic function onDisconnect(reason:ReasonDisconnect) {}

	public dynamic function onVolume(volume:Int) {}

	public dynamic function onRepeat(repeatMode:RepeatMode) {}

	public dynamic function onShuffle(shuffleMode:ShuffleMode) {}

	public dynamic function onInfo(clementineVersion:String) {}

	public dynamic function onPlay() {}

	public dynamic function onPlaypause() {}

	public dynamic function onPause() {}

	public dynamic function onStop() {}

	public dynamic function onNext() {}

	public dynamic function onPrevious() {}

	public dynamic function onSong(songMetadata:SongMetadata) {}

	public dynamic function onPlaylists(playslists:Array<Playlist>) {}

	public dynamic function onPosition(position:Int) {}

	public dynamic function onReady() {}

	public dynamic function onLibrary(library:Any) {}
}

@:jsRequire('clementine-client')
extern class ClementineClientJs {
	public function new(params:{host:String, port:String, authCode:UInt});
	public function next():Void;
	public function play():Void;
	public function previous():Void;
	public function playpause():Void;
	public function shuffle():Void;
	public function stop():Void;
	public function setVolume(percentage:UInt):Void;

	public function on(event:String, callback:Any->Void):Void;
}
