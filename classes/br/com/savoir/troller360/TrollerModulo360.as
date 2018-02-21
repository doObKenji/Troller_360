package br.com.savoir.troller360 
{
	import br.com.savoir.troller360.eventos.TrollerEvent;
	import com.greensock.TweenLite;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.external.ExternalInterface;
	import flash.system.Security;
	/**
	 * ...
	 * @author Edson Prata Ishii
	 */
	public class TrollerModulo360 extends MovieClip
	{
		//Carrocerias e ja criando os objetos
		private var carroceriaAmarela 			:CarroceriaAmarela = new CarroceriaAmarela();
		private var carroceriaAzulAragon 		:CarroceriaAzulAragon = new CarroceriaAzulAragon();
		private var carroceriaBrancoArtico 	 	:CarroceriaBrancoArtico = new CarroceriaBrancoArtico();
		private var carroceriaCinzaMetalico		:CarroceriaCinzaMetalico = new CarroceriaCinzaMetalico();
		private var carroceriaLaranjaMarrocos 	:CarroceriaLaranjaMarrocos = new CarroceriaLaranjaMarrocos();
		private var carroceriaPrataGeada 		:CarroceriaPrataGeada = new CarroceriaPrataGeada();
		private var carroceriaPretoMendoza 		:CarroceriaPretoMendoza = new CarroceriaPretoMendoza();
		private var carroceriaVerdeSenegal 		:CarroceriaVerdeSenegal = new CarroceriaVerdeSenegal();
		private var carroceriaVermelhoBari 		:CarroceriaVermelhoBari = new CarroceriaVermelhoBari();
		
		//Capotas e ja criando os objetos
		private var capotaAmarela 				:CapotaAmarela = new CapotaAmarela();
		private var capotaAzulAragon 			:CapotaAzulAragon = new CapotaAzulAragon();
		private var capotaBrancoArtico 			:CapotaBrancoArtico = new CapotaBrancoArtico();
		private var capotaCinzaMetalico 		:CapotaCinzaMetalico = new CapotaCinzaMetalico();
		private var capotaDouradoGranada 		:CapotaDouradoGranada = new CapotaDouradoGranada();
		private var capotaLaranjaMarrocos 		:CapotaLaranjaMarrocos = new CapotaLaranjaMarrocos();
		private var capotaPrataGeada 			:CapotaPrataGeada = new CapotaPrataGeada();
		private var capotaPretoMendoza 			:CapotaPretoMendoza = new CapotaPretoMendoza();
		private var capotaPretoSahara 			:CapotaPretoSahara = new CapotaPretoSahara();
		private var capotaVerdeSenegal 			:CapotaVerdeSenegal = new CapotaVerdeSenegal();
		private var capotaVermelhoBari 			:CapotaVermelhoBari = new CapotaVermelhoBari();
		
		private var moduloCores					:Cores;
		private var arrayCapotas				:Array;
		private var arrayCarrocerias			:Array;
		
		public var alvoCapota					:MovieClip;
		public var alvoCarroceria				:MovieClip;
		public var alvoAtual					:MovieClip;
		public var alvoAtualCapota				:MovieClip;
		public var alvoAnterior					:MovieClip;
		public var alvoAnteriorCapota			:MovieClip;
		
		private var idCarroceriaAnterior		:int = 0;
		private var idCarroceria				:int = 0;
		private var idCapotaAnterior			:int = 0;
		private var idCapota					:int = 0;
		
		private var frameCorrente				:int = 0;
		
		public var botaoInterno					:Sprite;
		
		private var contadorCarroceria			:int = 0;
		private var contadorCapota				:int = 0;
			
		public function TrollerModulo360() 
		{
			super();
			addEventListener(Event.ADDED_TO_STAGE, inicializa);
		}
		
		private function inicializa(e:Event):void 
		{
			//setando alvo atual e anterior.
			alvoAtual = alvoCarroceria.alvo1;
			alvoAnterior = alvoCarroceria.alvo2;
			
			//Criando Modulo de cores e posicionando.
			moduloCores = new Cores();
			moduloCores.x = 500;
			addChild(moduloCores);
			TweenLite.to(moduloCores, .5, { x:0 } );
			
			//Criando um array com os itens "capotas" da library
			arrayCapotas = new Array(capotaBrancoArtico, capotaPrataGeada, capotaCinzaMetalico, capotaAmarela, capotaLaranjaMarrocos, capotaVermelhoBari, capotaAzulAragon, capotaVerdeSenegal, capotaPretoMendoza, capotaDouradoGranada, capotaPretoSahara);
			//Criando um array com os itens "carroceria" da library
			arrayCarrocerias = new Array(carroceriaBrancoArtico, carroceriaPrataGeada, carroceriaCinzaMetalico, carroceriaAmarela, carroceriaLaranjaMarrocos, carroceriaVermelhoBari, carroceriaAzulAragon,  carroceriaVerdeSenegal, carroceriaPretoMendoza);
			
			//Adicionando eventos do modulo de cores.
			moduloCores.addEventListener(TrollerEvent.CAPOTA_SELECIONADA, capotaSelecionadaHandler);
			moduloCores.addEventListener(TrollerEvent.CARROCERIA_SELECIONADA, carroceriaSelecionadaHandler);
			
			//Botao para 360º interno
			botaoInterno.buttonMode = true;
			botaoInterno.addEventListener(MouseEvent.CLICK, chama360InternoHandler);
		}
		
		//Função que abre o 360º interno
		private function chama360InternoHandler(e:MouseEvent):void 
		{
			//URL para Homologação
			ExternalInterface.call("openIframe", "http://troller.savoir.com.br/wp-content/themes/troller-2010/giro/Troller_360_interno_2_flash.html", 0, 0);
			//URL para Produção
			//ExternalInterface.call("openIframe", "http://www.troller.com.br/wp-content/themes/troller-2010/giro/Troller_360_interno_2_flash.html", 0, 0);
		}
		
		/**
		 * Função de seleção da carroceria, aqui guardamos o id da carroceria anterior para usarmos no FADE de entrada da nova carroceria, e onde fazemos os controle de alvos das carrocerias.
		 * @param	e
		 */
		private function carroceriaSelecionadaHandler(e:TrollerEvent):void 
		{
			idCarroceriaAnterior = idCarroceria;
			
			// Verificação de dados diferentes, caso o mesmo carro seja clicado.
			if (idCarroceriaAnterior != e.dados || contadorCarroceria == 0)
			{
				alvoAtual = (alvoAtual == alvoCarroceria.alvo1 ? alvoCarroceria.alvo2 : alvoCarroceria.alvo1);
				alvoAnterior = (alvoAnterior == alvoCarroceria.alvo2 ? alvoCarroceria.alvo1 : alvoCarroceria.alvo2);
				
				if (contadorCarroceria == 0) {
					
				}else {
					alvoAtual.alpha = 0;
				}
				idCarroceria = e.dados;
				
				//Array com o id do carro, passando o currentFrame.
				arrayCarrocerias[e.dados].gotoAndStop(frameCorrente);
				alvoAtual.addChild(arrayCarrocerias[e.dados]);
				alvoCarroceria.setChildIndex(alvoAtual, alvoCarroceria.numChildren - 1);
				
				if ( contadorCarroceria > 0)
					fadeInCarroceriaHandler();
					
				contadorCarroceria ++;
			}
		}
		/**
		 * Função de seleção da capota, aqui guardamos o id da capota anterior para usarmos no FADE de entrada da nova carroceria, e onde fazemos os controle de alvos das capotas.
		 * @param	e
		 */
		private function capotaSelecionadaHandler(e:TrollerEvent):void 
		{
			idCapotaAnterior = idCapota;
			// Verificação de dados diferentes, caso o mesmo carro seja clicado.
			if (idCapotaAnterior != e.dados || contadorCapota == 0)
			{
				alvoAtualCapota = (alvoAtualCapota == alvoCapota.alvo3 ? alvoCapota.alvo4 : alvoCapota.alvo3);
				alvoAnteriorCapota = (alvoAnteriorCapota == alvoCapota.alvo4 ? alvoCapota.alvo3 : alvoCapota.alvo4);
				
				if (contadorCapota == 0) {
					
				}else {
					alvoAtualCapota.alpha = 0;
				}
				
				idCapota = e.dados;
				//Array com o id do carro, passando o currentFrame.
				arrayCapotas[e.dados].gotoAndStop(frameCorrente);
				alvoAtualCapota.addChild(arrayCapotas[e.dados]);
				alvoCapota.setChildIndex(alvoAtualCapota, alvoCapota.numChildren - 1);
				
				arrayCapotas[e.dados].addEventListener(MouseEvent.MOUSE_OUT, desAcionaGiroCarro);
				arrayCapotas[e.dados].addEventListener(MouseEvent.MOUSE_OVER, acionaGiroCarro);
				
				if ( contadorCapota > 0)
					fadeInCapotaHandler();
				
				contadorCapota ++;
			}
		}
		//Função para parar o giro.
		private function desAcionaGiroCarro(e:MouseEvent):void 
		{
			arrayCapotas[idCapota].stop();
			arrayCarrocerias[idCarroceria].stop();
			frameCorrente = arrayCarrocerias[idCarroceria].currentFrame;
		}
		//Função para começar o giro.
		private function acionaGiroCarro(e:MouseEvent):void 
		{
			arrayCapotas[idCapota].gotoAndPlay(frameCorrente);
			arrayCarrocerias[idCarroceria].gotoAndPlay(frameCorrente);
		}
		// Animação de Fade da entrada da nova capota
		private function fadeInCapotaHandler():void
		{
			TweenLite.to(alvoAtualCapota, .3, { alpha:1, onComplete:fadeOutCapotaHandler } );
		}
		// Animação de Fade da saida da capota antiga
		private function fadeOutCapotaHandler():void
		{
			if (idCapota != idCapotaAnterior) {
				alvoAnteriorCapota.removeChild(arrayCapotas[idCapotaAnterior]);
			}
		}
		// Animação de Fade da entrada da nova carroceria
		private function fadeInCarroceriaHandler():void
		{
			TweenLite.to(alvoAtual, .3, { alpha:1, onComplete:fadeOutCarroceriaHandler } );
		}
		// Animação de Fade da saida da carroceria antiga
		private function fadeOutCarroceriaHandler():void
		{
			if (idCarroceria != idCarroceriaAnterior) {
				alvoAnterior.removeChild(arrayCarrocerias[idCarroceriaAnterior]);
			}
		}
	}

}