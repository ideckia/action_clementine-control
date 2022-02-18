package clementine;

typedef Types = {}

enum abstract ReasonDisconnect(UInt) to UInt from UInt {
	var serverShutdown = 1;
	var wrongAuthCode = 2;
	var notAuthenticated = 3;
	var downloadForbidden = 4;
}

// Valid Repeatmodes
enum abstract RepeatMode(Int) from Int to Int {
	var off = 0;
	var track = 1;
	var album = 2;
	var playlist = 3;
}

// Valid Shuffle modes
enum abstract ShuffleMode(Int) from Int to Int {
	var off = 0;
	var all = 1;
	var insideAlbum = 2;
	var albums = 3;
}

typedef SongMetadata = {
	var ?id:Int; // unique id of the song
	var ?index:Int; // Index of the current row of the active playlist
	var ?title:String;
	var ?album:String;
	var ?artist:String;
	var ?albumartist:String;
	var ?track:Int;
	var ?disc:Int;
	var ?pretty_year:String;
	var ?genre:String;
	var ?playcount:Int;
	var ?pretty_length:String;
	var ?art:String;
	var ?length:Int;
	var ?is_local:Bool;
	var ?filename:String;
	var ?file_size:Int;
	var ?rating:Float; // 0 (0 stars) to 1 (5 stars)
}

typedef Playlist = {
	var ?id:Int;
	var ?name:String;
	var ?item_count:Int;
	var ?active:Bool;
	var ?closed:Bool;
}
