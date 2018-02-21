package br.com.savoir.troller360 
{
	import br.com.savoir.troller360.eventos.TrollerEvent;
	import br.com.savoir.troller360.moduloCores.ItemCor;
	import br.com.savoir.troller360.moduloCores.NomeCapota;
	import br.com.savoir.troller360.moduloCores.NomeCarroceria;
	import com.greensock.TweenMax;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	/**
	 * ...
	 * @author Edson Prata Ishii
	 */
	public class Cores extends MovieClip
	{
		private var loader						:URLLoader;
		private var urlXML						:String;
		private var guardaXML					:XML;
		private var itemCarroceria				:ItemCor;
		private var itemCapota					:ItemCor;
		private var arrayLengthCapota			:int;
		private var arrayLengthCarroceria		:int;
		
		public var nomeCarroceria				:NomeCarroceria;
		public var nomeCapota					:NomeCapota;
		public var alvoCarroceria				:MovieClip;
		public var alvoCapota					:MovieClip;
		
		public var setaCarroceriaEsquerda		:MovieClip;
		public var setaCarroceriaDireita		:MovieClip;
		public var setaCapotaDireita			:MovieClip;
		public var setaCapotaEsquerda			:MovieClip;
		
		public function Cores() 
		{
			super();
			addEventListener(Event.ADDED_TO_STAGE, inicializa);
		}
		
		private function inicializa(e:Event):void 
		{
			carregaXML();
			setaCarroceriaEsquerda.buttonMode = setaCarroceriaDireita.buttonMode = setaCapotaDireita.buttonMode = setaCapotaEsquerda.buttonMode = true; 
			setaCarroceriaEsquerda.visible = setaCarroceriaDireita.visible = setaCapotaDireita.visible = setaCapotaEsquerda.visible = false; 
			
		}
		
		private function carregaXML():void
		{
			//URL de Homologação
			//urlXML = "http://troller.savoir.com.br/wp-content/themes/troller-2010/flash/troller_360.xml";
			urlXML = "troller_360.xml";
			//URL de Produção
			//urlXML = "http://www.troller.com.br/wp-content/themes/troller-2010/flash/troller_360.xml";
			loader = new URLLoader();
			loader.addEventListener(Event.COMPLETE, xmlCarregado);
			loader.load (new URLRequest(urlXML));
		}
		/**
		 * Função de carregamento do XML, utilizando um loop para criar os itens "ItemCor", adcionando eventos do "ItemCor", Propriedades e posicionando os itens dinamicamente.
		 * @param	e
		 */
		private function xmlCarregado(e:Event):void 
		{
			var capotaAtual:ItemCor;
			var capotaAnterior:ItemCor;
			
			var carroceriaAtual:ItemCor;
			var carroceriaAnterior:ItemCor;
			
			guardaXML = new XML(loader.data);
			
			arrayLengthCarroceria = guardaXML.colors.carroceria.cor.length();
			arrayLengthCapota = guardaXML.colors.capota.cor.length();
			
			for (var i:int = 0; i < guardaXML.colors.carroceria.cor.length(); i++) 
			{
				itemCarroceria = new ItemCor();
				itemCarroceria.buttonMode = true;
				itemCarroceria.addEventListener(MouseEvent.CLICK, itemCarroceriaClicadaHandler);
				
				itemCarroceria.nomeCor = guardaXML.colors.carroceria.cor[i].@label;
				itemCarroceria.hexa = guardaXML.colors.carroceria.cor[i].@rgb;
				itemCarroceria.id = guardaXML.colors.carroceria.cor[i].@id;
				
				carroceriaAtual = itemCarroceria;
				if (!carroceriaAnterior)
					carroceriaAtual.y = 0, carroceriaAtual.x = 0;
				else
					carroceriaAtual.x = carroceriaAnterior.x + carroceriaAtual.width + 2;
					
				carroceriaAnterior = carroceriaAtual;	
				
				alvoCarroceria.addChild(itemCarroceria);
				if (i == 0)
					itemCarroceria.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
					
				if (i > 6) {
					//Evento não utilizado.
					//setaCarroceriaDireita.visible = true;
					setaCarroceriaDireita.addEventListener(MouseEvent.CLICK, moveCarroceriaHandler);
				}
				
			}
			
			for (var j:int = 0; j < guardaXML.colors.capota.cor.length(); j++) 
			{
				itemCapota = new ItemCor();
				itemCapota.buttonMode = true;
				itemCapota.addEventListener(MouseEvent.CLICK, itemCapotaClicadaHandler);
				
				itemCapota.nomeCor = guardaXML.colors.capota.cor[j].@label;
				itemCapota.hexa = guardaXML.colors.capota.cor[j].@rgb;
				itemCapota.id = guardaXML.colors.capota.cor[j].@id;
				
				capotaAtual = itemCapota;
				if (!capotaAnterior)
					capotaAtual.y = 0, capotaAtual.x = 0;
				else
					capotaAtual.x = capotaAnterior.x + capotaAtual.width + 2;
					
				capotaAnterior = capotaAtual;
				
				alvoCapota.addChild(itemCapota);
				
				if (j == 0)
					itemCapota.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
				
				if (j > 6) {
					//Evento não utilizado.
					//setaCapotaDireita.visible = true;
					setaCapotaDireita.addEventListener(MouseEvent.CLICK, moveCapotaHandler);
				}
			}
		}
		//Função que setamos o nome da cor da carroceria, e tambem o hexa da cor. E dispara evento de seleção
		private function itemCapotaClicadaHandler(e:MouseEvent):void 
		{
			nomeCapota._nomeCor = e.currentTarget.nomeCor;
			nomeCapota.hexaItemCor = e.currentTarget.hexa;
			//Evento de seleção da capota passando o id do item para Classe TrollerModulo360.
			dispatchEvent(new TrollerEvent(TrollerEvent.CAPOTA_SELECIONADA, e.currentTarget.id));
		}
		//Função que setamos o nome da cor da carroceria, e tambem o hexa da cor. E dispara evento de seleção
		private function itemCarroceriaClicadaHandler(e:MouseEvent):void 
		{
			nomeCarroceria._nomeCor = e.currentTarget.nomeCor;
			nomeCarroceria.hexaItemCor = e.currentTarget.hexa;
			//Evento de seleção da carroceria passando o id do item para Classe TrollerModulo360.
			dispatchEvent(new TrollerEvent(TrollerEvent.CARROCERIA_SELECIONADA, e.currentTarget.id));
		}
		
		//Está função não é mais utilizada pois antigamente tinha uma navegação horizontal dos "ItemCor" e foi retirada essa navegação.
		private function moveCapotaHandler(e:MouseEvent):void 
		{
			if (e.currentTarget.name == "setaCapotaDireita")
			{
				setaCapotaEsquerda.visible = true;
				setaCapotaEsquerda.addEventListener(MouseEvent.CLICK, moveCapotaHandler);
				
				TweenMax.to(alvoCapota, .3, { x:Math.round(alvoCapota.x - (itemCapota.width + 7)), blurFilter: { blurX:10 }, onComplete:paraBlurCapotaHandler } );
				setaCapotaEsquerda.mouseEnabled = false;
				setaCapotaDireita.mouseEnabled = false;
				if (Math.round(alvoCapota.x + alvoCapota.width - itemCapota.width) <= 878)
				{
					setaCapotaDireita.visible = false;
				}
				
			}else {
				//setaCapotaDireita.visible = true;
				TweenMax.to(alvoCapota, .3, { x:Math.round(alvoCapota.x + (itemCapota.width + 7)), blurFilter: { blurX:10 }, onComplete:paraBlurCapotaHandler } );
				setaCapotaEsquerda.mouseEnabled = false;
				setaCapotaDireita.mouseEnabled = false;
				if (alvoCapota.x >= 446)
				{
					setaCapotaEsquerda.visible = false;
				}
			}
			
		}
		//Animação não mais utlizada
		private function paraBlurCapotaHandler():void {
			TweenMax.to(alvoCapota, 0, { blurFilter: { blurX:0 }} );
			setaCapotaEsquerda.mouseEnabled = true;
			setaCapotaDireita.mouseEnabled = true;
		}
		//Animação não mais utlizada
		private function paraBlurCarroceriaHandler():void {
			TweenMax.to(alvoCarroceria, 0, { blurFilter: { blurX:0 }} );
			setaCarroceriaEsquerda.mouseEnabled = true;
			setaCarroceriaDireita.mouseEnabled = true;
		}
		
		//Está função não é mais utilizada pois antigamente tinha uma navegação horizontal dos "ItemCor" e foi retirada essa navegação.
		private function moveCarroceriaHandler(e:MouseEvent):void 
		{
			if (e.currentTarget.name == "setaCarroceriaDireita")
			{
				setaCarroceriaEsquerda.visible = true;
				setaCarroceriaEsquerda.addEventListener(MouseEvent.CLICK, moveCarroceriaHandler);
				TweenMax.to(alvoCarroceria, .3, { x:Math.round(alvoCarroceria.x - (itemCarroceria.width + 7)), blurFilter: { blurX:10 }, onComplete:paraBlurCarroceriaHandler } );
				setaCarroceriaEsquerda.mouseEnabled = false;
				setaCarroceriaDireita.mouseEnabled = false;
				if (Math.round(alvoCarroceria.x + alvoCarroceria.width - itemCarroceria.width) <= 878)
				{
					setaCarroceriaDireita.visible = false;
				}
			}else {
				//setaCarroceriaDireita.visible = true;
				TweenMax.to(alvoCarroceria, .3, { x:Math.round(alvoCarroceria.x + (itemCarroceria.width + 7)), blurFilter: { blurX:10 }, onComplete:paraBlurCarroceriaHandler } );
				setaCarroceriaEsquerda.mouseEnabled = false;
				setaCarroceriaDireita.mouseEnabled = false;
				if (alvoCarroceria.x >= 446)
				{
					setaCarroceriaEsquerda.visible = false;
				}
			}
			
		}
	}

}