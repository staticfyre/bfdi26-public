package funkin.data;

import haxe.ds.StringMap;

class Highscore
{
	public static var songScoreDatas:Map<String,SongScoreData> = new Map();
	public static var songScores:Map<String, Int> = new Map<String, Int>();
	public static var songMisses:Map<String, Int> = new Map<String, Int>();
	public static var songRating:Map<String, Float> = new Map<String, Float>();

	public static var ratingData:StringMap<Array<Int>> = new StringMap();

	public static function resetSong(song:String, diff:Int = 0):Void
	{
		var daSong:String = formatSong(song, diff);
		setScore(daSong, 0);
		setRating(daSong, 0);
	}

	public static function saveScore(song:String, score:Int = 0, ?diff:Int = 0, ?rating:Float = -1):Void
	{
		var daSong:String = formatSong(song, diff);

		if (songScores.exists(daSong)) {
			if (songScores.get(daSong) < score) {
				setScore(daSong, score);
				if(rating >= 0) setRating(daSong, rating);
			}
		}
		else {
			setScore(daSong, score);
			if(rating >= 0) setRating(daSong, rating);
		}
	}

	/**
	 * YOU SHOULD FORMAT SONG WITH formatSong() BEFORE TOSSING IN SONG VARIABLE
	 */
	static function setScore(song:String, score:Int):Void
	{
		// Reminder that I don't need to format this song, it should come formatted!
		songScores.set(song, score);
		FlxG.save.data.songScores = songScores;
		FlxG.save.flush();
	}

	static function setRating(song:String, rating:Float):Void
	{
		// Reminder that I don't need to format this song, it should come formatted!
		songRating.set(song, rating);
		FlxG.save.data.songRating = songRating;
		FlxG.save.flush();
	}

	public static function formatSong(song:String, diff:Int):String
	{
		return Paths.formatToSongPath(song) + Difficulty.getFilePath(diff);
	}

	public static function getScore(song:String, diff:Int):Int
	{
		var daSong:String = formatSong(song, diff);
		if (!songScores.exists(daSong))
			setScore(daSong, 0);

		return songScores.get(daSong);
	}

	public static function getRating(song:String, diff:Int):Float
	{
		var daSong:String = formatSong(song, diff);
		if (!songRating.exists(daSong))
			setRating(daSong, 0);

		return songRating.get(daSong);
	}

	public static function load():Void
	{
		if (FlxG.save.data.songScores != null)
		{
			songScores = FlxG.save.data.songScores;
		}
		if (FlxG.save.data.songRating != null)
		{
			songRating = FlxG.save.data.songRating;
		}
		
		if (FlxG.save.data.songScoreDatas != null) songScoreDatas = FlxG.save.data.songScoreDatas;
	}

	public static function getSongRatings(songName:String):Array<Int> {
        return ratingData.exists(songName) ? ratingData.get(songName) : [0, 0, 0, 0];
    }

	public static function getSongData(song:String,diff:Int) 
	{
		var songToGet:String = formatSong(song, diff);
		if (songScoreDatas.exists(songToGet)) return songScoreDatas.get(songToGet);
		return songScoreDataTemplate();
	}
	
	public static function saveSongData(song:String,diff:Int,score:Int = 0,rating:Float = 0,fc:FCLevel = SDCB,sick:Int = 0,good:Int = 0,bad:Int = 0,shit:Int = 0) 
	{
		var songToSave:String = formatSong(song, diff);
	
		var tempData = songScoreDataTemplate();
		if (songScoreDatas.exists(songToSave)) tempData = songScoreDatas.get(songToSave);
			
		tempData.songScore = setSongScore(tempData.songScore,score);
		tempData.songRating = setSongRating(tempData.songRating,rating);
		tempData.songFC = cast(setSongFC(tempData.songFC,fc),FCLevel);
		tempData.sick = sick;
		tempData.good = good;
		tempData.bad = bad;
		tempData.shit = shit;
		songScoreDatas.set(songToSave,tempData);
	
		FlxG.save.data.songScoreDatas = songScoreDatas;
		FlxG.save.flush();
	}
	
	static function setSongScore(songScore:Int,score:Int) return songScore = songScore < score ? score : songScore;
	static function setSongRating(songRating:Float,rating:Float) return songRating = songRating < rating ? rating : songRating;
	static function setSongFC(songFC:FCLevel,fc:FCLevel) return cast(songFC,Int) < cast(fc,Int) ? fc : songFC;

	public static function calculateFC(misses:Int = 0,rating:Float = 0) {
		if (misses == 0) {
			if (rating == 1) return PFC;
			if (rating < 1) return GFC;
			return FC;
		}
		return SDCB;
	}

	static function songScoreDataTemplate():SongScoreData 
	{
		return {
			songScore: 0,
			songRating: 0.0,
			songFC: SDCB,
			sick: 0,
			good: 0,
			bad: 0,
			shit: 0
		}
	}
}

typedef SongScoreData = {
	songScore:Int,
	songRating:Float,
	songFC:FCLevel,
	sick:Int,
	good:Int,
	bad:Int,
	shit:Int
}

enum abstract FCLevel(Int) to Int from Int 
{
	var PFC:Int = 3;
	var GFC:Int = 2;
	var FC:Int = 1;
	var SDCB:Int = 0;
}