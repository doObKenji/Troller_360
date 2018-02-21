package br.com.savoir.troller360.moduloCores
{
	import com.greensock.plugins.TintPlugin;
	import com.greensock.plugins.TweenPlugin;
	import com.greensock.TweenLite;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	/**
	 * ...
	 * @author Edson Prata Ishii
	 */
	public class NomeCor extends MovieClip
	{
		public var fundo	:MovieClip;
		public var setaCor	:Sprite;
		
		//Seta o nome da cor, e redimensiona o fundo de acordo com o tamanho do nome
		public var nomeCor:TextField;
		public function get _nomeCor():String { return nomeCor.text; };
		public function set _nomeCor(value:String):void
		{ 
			nomeCor.autoSize = "left";
			nomeCor.text = value;
			fundo.width = Math.round(nomeCor.width + 75);
		};
		//Recupera o hexa da cor e chama função que pinta a seta de acordo com a cor.
		private var _hexaItemCor:String;
		public function get hexaItemCor():String { return _hexaItemCor; };
		public function set hexaItemCor(value:String):void { _hexaItemCor = value; pintaSeta(value);};
		
		public function NomeCor()
		{
			super();
		}
		
		private function pintaSeta(hexa:String):void
		{
			TweenPlugin.activate([TintPlugin]);
			TweenLite.to(setaCor, 0, {tint:hexa});
		}
		
	}

}