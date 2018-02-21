package br.com.savoir.troller360.eventos 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Edson Prata Ishii
	 */
	public class TrollerEvent extends Event 
	{
		public static const CAPOTA_SELECIONADA		 	:String	= "capota_selecionada";
		public static const CARROCERIA_SELECIONADA		:String	= "carroceria_selecionada";
		
		public var dados:*;
		
		public function TrollerEvent(type:String, parametros:*= null, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			dados = parametros;
		} 
		
		public override function clone():Event 
		{ 
			return new TrollerEvent(type, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("TrollerEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
}