pico-8 cartridge // http://www.pico-8.com
version 42
__lua__
function _init()
	ship={x=64,y=64,sx=0,sy=0,r=.5}
 sg={ 0, 4, 3,-3,
						2,-3,0,-2,
						0,-2,-2,-3,
 				-3,-3, 0, 4,}
	as={
			{
    4, 2,
    5, 0,
    5, 0,
    3, -2,
    3, -2,
    1, -4,
    1, -4,
    -1, -5,
    -1, -5,
    -3, -3,
    -3, -3,
    -5, -1,
    -5, -1,
    -4, 1,
    -4, 1,
    -2, 3,
    -2, 3,
    0, 5,
    0, 5,
    2, 4,
    2, 4,
    4, 2
},
{
    4, 1,
    3, -3,
    3, -3,
    1, -4,
    1, -4,
    -2, -3,
    -2, -3,
    -4, -1,
    -4, -1,
    -3, 2,
    -3, 2,
    -1, 4,
    -1, 4,
    2, 3,
    2, 3,
    4, 1
},
{
    3, 1,
    2, -2,
    2, -2,
    0, -3,
    0, -3,
    -2, -2,
    -2, -2,
    -3, 0,
    -3, 0,
    -2, 2,
    -2, 2,
    0, 3,
    0, 3,
    2, 2,
    2, 2,
    3, 1
}}

 ast={}
 for i=1,10 do
	 add_ast(100+rnd(38),100+rnd(38),rnd(0.4)-0.2,rnd(0.4)-0.2,rnd(.1),rnd(0.005),1)
 end
 
 exp={}
 deb={}
 bu={}
 tck=0
 wcd=0
 pts=0
end

function _update()
 tck+=1
 if btn(⬅️) then
 	ship.r+=.015
 end 
 if btn(➡️) then
 	ship.r-=.015
 end
 if btn(⬆️) then
 	ship.sx-=0.1*sin(ship.r)
 	ship.sy+=0.1*cos(ship.r)
 else
 	ship.sx*=0.99
 	ship.sy*=0.99
 end
 if (btn(🅾️) and wcd<0) then 
  wcd=12
  add(bu,{x=ship.x-sin(ship.r)*3,
  								y=ship.y+cos(ship.r)*3,
  								sx=-sin(ship.r)*1.1+ship.sx,
  								sy= cos(ship.r)*1.1+ship.sy,
  								t=60
  								})
 else
  wcd-=1
 end
 ship.x+=ship.sx
 ship.y+=ship.sy
 if ship.x>127 then ship.x=1 end
 if ship.y>127 then ship.y=1 end
 if ship.x<1   then ship.x=127 end
 if ship.y<1   then ship.y=127 end
end

function _draw()
	cls()
	-- asteroids
	for a in all(ast) do
		draw_obj(a.x,a.y,a.r,as[a.s],6)
		a.r+=a.rs
		a.x+=a.xs
		a.y+=a.ys
		if a.x>132 then a.x=-5 end
		if a.y>132 then a.y=-5 end
		if a.x<-5   then a.x=132 end
		if a.y<-5   then a.y=132 end		
	end
	-- bullets
	local aast=ast
	for b in all(bu) do
		b.x+=b.sx
		b.y+=b.sy
		if b.x>127 then b.x=0 end
		if b.y>127 then b.y=0 end
		if b.x<0 then b.x=127 end
		if b.y<0 then b.y=127 end
		b.t-=1
		for a in all(aast) do
		 if b.x>a.x-5 and b.x<a.x+5 and b.y>a.y-5 and b.y<a.y+5 then
--		  del(ast,a)
				del(bu,b)
				for i=1,20 do
					add(exp,{x=b.x+rnd(3)-1.5,y=b.y+rnd(3)-1.5,t=5+rnd(15),c=8+flr(rnd(3))})
					add(exp,{x=a.x+rnd(6)-3,y=a.y+rnd(6)-3,t=5+rnd(24),c=5+flr(rnd(2))})
				end
		  if a.s<3 then
		  	for i=1,5-a.s do
				  add_ast(a.x+rnd(4)-2,a.y+rnd(4)-2,rnd(.4)-.2,rnd(.4)-.2,rnd(.1),rnd(.005),a.s+1)
		   end
		  end
		  del(ast,a)
		  pts+=1
--		  del(bu,b)
		 end
		end
		if b.t>0 then
			circ(b.x,b.y,1,8)
		else
		 del(bu,b)
		end
	end
	for e in all(exp) do
  e.x+=rnd(2)-1
  e.y+=rnd(2)-1
		pset(e.x,e.y,e.c)
		e.t-=1
		if e.t<0 then del(exp,e) end
	end
 -- ship
 draw_obj(ship.x,ship.y,ship.r,sg,11)
 print("points : "..pts,1,1,9)
end

-->8
--func
function draw_obj(x,y,r,cor,c)
 for i=1,#cor,4 do
		co=cos(r)
		si=sin(r)
		x1=x+cor[i]*co  -cor[i+1]*si
		y1=y+cor[i]*si  +cor[i+1]*co
		x2=x+cor[i+2]*co-cor[i+3]*si
		y2=y+cor[i+2]*si+cor[i+3]*co
 	line(x1,y1,x2,y2,c)
 end
end

function add_ast(ax,ay,axs,ays,ar,ars,as)
 add(ast,{x=ax,y=ay,xs=axs,ys=ays,r=ar,rs=ars,s=as})
end
-->8
--asteroids

big = {

}

__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
