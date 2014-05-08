package  {
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	
	public class Fond extends Sprite {
		var ventAcc:Number = 0;
		var vent:Number = 0;
		var Herbes:Array = [];
		var ennemis:Array = []
		var bullets:Array = []
		
		var EnnemiSuivant:int=0;
		var Nuages:Array = [];
		var NuagesSprite:Sprite = new Sprite();
		var NuageSuivant:int;
		var NuagesVisibles:Array = [];
		
		var VaguesSprite:Sprite = new Sprite()
		var Vagues:Array = []
		
		var Arbres:Array = [];
		var ArbresSprite:Sprite = new Sprite();
		var ArbreSuivant:int;
		var sol:Sprite = new Sprite()
		var ArbresVisibles:Array = []
		public var hauteur:Number = 0;
		public var slide:Number = 0;
		var Randomness:Number = 0;
		const HauteurArbres:int = 400;
		public function Fond() {
			addChild(NuagesSprite)
			addChild(sol)
			//GenererSol()
			addChild(VaguesSprite)
			GenererHerbes();
			addEventListener(Event.ENTER_FRAME, eFrame)
		}
		private function GenererSol(){
			sol.graphics.clear()
			sol.graphics.beginFill(0x0961c6)
			sol.graphics.drawRect(0,200+200/600*hauteur+hauteur*0.5,800,150+150/600*hauteur+hauteur*0.5)
			sol.graphics.beginFill(0x5e3a1b)
			sol.graphics.drawRect(0,350+350/600*hauteur+hauteur*0.5,800,250+250/600*hauteur+hauteur*0.5)
		}
		private function GenererNuages(){
			NuagesSprite.y = hauteur*0.5;
			while(NuageSuivant<slide/5+1000){
				var n:Nuage = new Nuage()
				n.x = slide/5+NuageSuivant
				n.y = Math.random()*300
				Nuages.push(n)
				NuagesVisibles.push(false);
				NuageSuivant += 80+Math.random()*300;
			}
			for(var i:int = 0; i<Nuages.length; i++){
				if(NuagesVisibles[i]&&Nuages[i].x<slide/5-200){
					NuagesSprite.removeChild(Nuages[i]);
					NuagesVisibles[i] = false;
				} else if(!NuagesVisibles[i]&&Nuages[i].x>slide/5-200){
					NuagesSprite.addChild(Nuages[i]);
					NuagesVisibles[i] = true;
				}
			}

		}
		private function GenererHerbes(){
			var h:Herbe;
			for(var i:int = 0; i<25;i++){
				h = new Herbe(12,80,0x3e8119,0x6cb138,16)
				h.y = i*2+350
				addChild(h)
				Herbes.push(h)
			}
			addChild(ArbresSprite);
			for(i = 0; i<25;i++){
				h = new Herbe(12,80,0x3e8119,0x6cb138,16)
				h.y = i*2+400
				addChild(h)
				Herbes.push(h)
			}
			for(i = 0; i<50;i++){
				h = new Herbe(12,80,0x3e8119,0x6cb138,16)
				h.y = i*2+550
				addChild(h)
				Herbes.push(h)
			}
		}
		private function GenererArbres(){
			ArbresSprite.y = HauteurArbres/600*hauteur+hauteur*0.5;
			while(ArbreSuivant<slide+800){
				var Rang:int = 10-(Math.random()*5+2)*Randomness;
				var LC1:uint = randomizeColor(0x157025,Randomness*256);
				var LC2:uint = randomizeColor(0x45bD05,Randomness*256);
				var LR:int = Randomness*128+16;
				var TC1:uint = randomizeColor(0x9b3e00,Randomness*256);
				var TC2:uint = randomizeColor(0x5c1e00,Randomness*256);
				var TR:int = Randomness*128+8;
				var diffRot:int = 12 + Math.pow(Math.random()*16-4,2)*Randomness;
				var LSize:int = 7 + (Math.random()*10-5)*Randomness;
				var a:Arbre = new Arbre(1000,Rang,LC1,LC2,LR,TC1,TC2,TR,diffRot,LSize)
				a.x = ArbreSuivant+slide;
				a.y = HauteurArbres;
				//ArbresSprite.addChild(a)
				var sc:Number = 1.3+Math.random()*0.3;
				a.scaleX = a.scaleY = sc
				Arbres.push(a)
				ArbresVisibles.push(false)
				ArbreSuivant += 400+Math.random()*800;
			}
			
			for(var i:int = 0; i<Arbres.length; i++){
				if(ArbresVisibles[i]&&(Arbres[i].x<slide-200||Arbres[i].x>slide+1000)){
					ArbresSprite.removeChild(Arbres[i]);
					ArbresVisibles[i] = false;
				} else if(!ArbresVisibles[i]&&(Arbres[i].x>slide-200&&Arbres[i].x<slide+1000)){
					ArbresSprite.addChild(Arbres[i]);
					ArbresVisibles[i] = true;
				}
			}
		}
		private function GenererEnnemis(){
			if(EnnemiSuivant<slide){
				var f:int = Math.floor(Math.random()*6+1)
				for(var i:int = 0; i<Math.pow(Math.random()*3,Math.random()*3);i++){
					var e:Ennemis = new Ennemis(Math.random()*500+1000+slide,300+Math.random()*150,this)
					e.gotoAndStop(f);
					e.scaleX = e.scaleY = Math.pow(Math.random()*3,Math.random()*2)+3;
					e.vie = e.scaleX*f;
					ennemis.push(e)
					addChild(e)
				}
				EnnemiSuivant += 600+Math.random()*1200;
			}
			for(var j:int = ennemis.length-1; j>=0; j--){
				if(ennemis[j].x<-300||ennemis[j].x>1500){
					ennemis[j].removeEventListener(Event.ENTER_FRAME, eFrame)
					removeChild(ennemis[j]);
					ennemis.splice(j,1);
				}
			}
		}
		private function GenererVent(){
			if(Math.random()<0.05){
				ventAcc+=2*Math.random()
				var v:Vent = new Vent()
				v.x = Math.random()*1200-400;
				v.y = Math.random()*600;
				addChild(v)
			}
		}
		private function GenererVagues(){
			if(true){
				var pt:Point = new Point(Math.random()*2000-200+slide/2,Math.random()*150+200)
				var ok:Boolean = true;
				for(var j:int = 0; j<Vagues.length; j++){
					if(Math.sqrt(Math.pow(pt.x-Vagues[j].x,2)+Math.pow(pt.y-Vagues[j].y,2))<35)ok=false;
				}
				if(ok){
					var v:Vague = new Vague()
					v.x = pt.x
					v.y = pt.y
					v.scaleX = v.scaleY = (pt.y)/250
					VaguesSprite.addChild(v)
					Vagues.push(v)
				}

			}
			for(var i:int = Vagues.length-1; i>=0; i--){
				Vagues[i].ht = Vagues[i].y/600*hauteur+hauteur*0.5
				if(Vagues[i].pts.length==0){
					Vagues[i].removeEventListener(Event.ENTER_FRAME,eFrame)
					VaguesSprite.removeChild(Vagues[i]);
					Vagues.splice(i,1)
				}
			}

		}
		private function eFrame(e:Event){
			//slide+=5;
			GenererEnnemis()
			GenererSol()
			GenererCourant()
			GenererNuages()
			GenererArbres()
			GenererVent()
			GenererVagues()
			Deplacer()
			CheckCollisions()
			//Randomness = slide/50000;
		}
		private function CheckCollisions(){
			for(var j:int = bullets.length-1; j>=0; j--){
				if(bullets[j].x>1500){
					bullets[j].removeEventListener(Event.ENTER_FRAME, eFrame)
					removeChild(bullets[j])
					bullets.splice(j,1)
				} else {
					for(var i:int = ennemis.length-1; i>=0; i--){
						if(bullets[j].hitTestObject(ennemis[i])){
							bullets[j].removeEventListener(Event.ENTER_FRAME, eFrame)
							removeChild(bullets[j])
							bullets.splice(j,1)
							ennemis[i].vie -=1;
							if(ennemis[i].vie <=0){
								ennemis[i].removeEventListener(Event.ENTER_FRAME, eFrame)
								removeChild(ennemis[i])
								ennemis.splice(i,1)
							}
							break;
						}
					}
				}
			}
		}
		private function GenererCourant(){
			ventAcc+=(Math.random()-0.3)/2
			vent+=ventAcc
			ventAcc*=0.95;
			vent*=0.70;
		}
		public function Bulleter(X:int, Y:int){
			var b:Bullet = new Bullet(X+slide,Y,this)
			addChild(b)
			bullets.push(b)
		}
		public function Deplacer(){
			for(var i:int = 0; i<Herbes.length; i++){
				Herbes[i].Render(vent,slide,hauteur)
			}
			VaguesSprite.x = -slide/2;
			NuagesSprite.x = -slide/5;
			ArbresSprite.x = -slide;
		}
		function randomizeColor(color:uint, difmax:int):uint{
			var r:int = Bornes(color/256/256+Math.floor(Math.random()*difmax*2-difmax));
			var v:int = Bornes(color/256%256+Math.floor(Math.random()*difmax*2-difmax));
			var b:int = Bornes(color%256+Math.floor(Math.random()*difmax*2-difmax));
			return r*256*256+v*256+b;
		}
		
		function Bornes(a:int){
			if(a>256)a=256;
			if(a<0)a=0;
			return a;
		}

	}
	
}
