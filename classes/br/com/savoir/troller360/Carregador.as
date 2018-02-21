package br.com.savoir.troller360 
{
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
	import flash.system.Security;
	import flash.text.TextField;
	
	/**
	 * ...
	 * @author Edson Prata Ishii
	 */
	public class Carregador extends Sprite
	{
		private var carregador	:Loader;
		public var alvo			:Sprite;
		public var txt_loader	:TextField;
		
		public function Carregador():void
		{
			super();
			carregador = new Loader();
			carregador.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, onCarregadoHandler);
			//carregador.load(new URLRequest("http://troller.savoir.com.br/wp-content/themes/troller-2010/flash/troller360.swf"));
			carregador.load(new URLRequest("http://www.troller.com.br/wp-content/themes/troller-2010/flash/troller360.swf"));
			
			alvo.addChild(carregador);
		}
		
		private function onCarregadoHandler(e:ProgressEvent):void 
		{
			txt_loader.text = String(Math.round(e.bytesLoaded / e.bytesTotal * 100)) + "%";
		}
	}
}