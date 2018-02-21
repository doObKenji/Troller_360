package br.com.savoir.troller360.moduloCores 
{
	import com.greensock.plugins.TintPlugin;
	import com.greensock.plugins.TweenPlugin;
	import com.greensock.TweenLite;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	/**
	 * ...
	 * @author Edson Prata Ishii
	 */
	public class ItemCor extends MovieClip
	{
		public var corThumb:MovieClip;
		
		//Seta o nome da cor.
		public var _nomeCor:String;
		public function get nomeCor():String { return _nomeCor; };
		public function set nomeCor(value:String):void { _nomeCor = value; };
		//Seta o id do item
		public var _id:int;
		public function get id():int { return _id; };
		public function set id(value:int):void { _id = value;};
		//Recupera o hexa e chama função para pintar as thumbs.
		public var _hexa:String;
		public function get hexa():String { return _hexa; };
		public function set hexa(value:String):void { _hexa = value; pintaThumb(value);};
		
		public function ItemCor() 
		{
			super();
		}
		
		private function pintaThumb(hexa:String):void
		{
			TweenPlugin.activate([TintPlugin]);
			TweenLite.to(corThumb, 0, {tint:hexa});
		}
		
	}

}