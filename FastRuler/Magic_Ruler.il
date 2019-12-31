	procedure(magic_ruler()
	  let(((xwidth 330) (ydelta 30) (prompt 126))
      choice=list("up" "down" "right" "left" "45" "135" "225" "315")
	  space=hiCreateFloatField(?name 'space ?prompt "Space" ?defValue 0.0)
	  dir=hiCreateCyclicField(?name 'dir ?prompt "Direction" ?choices list("up" "down" "right" "left" "45" "135" "225" "315"))

      Deg45=hiCreateButton(?name 'Deg45 ?callback "ChangeChoice(hiGetCurrentForm() nth(4 choice))" ?buttonText "45") 
      Deg135=hiCreateButton(?name 'Deg135 ?callback "ChangeChoice(hiGetCurrentForm() nth(5 choice))" ?buttonText "135" ) 
      Deg225=hiCreateButton(?name 'Deg225 ?callback "ChangeChoice(hiGetCurrentForm() nth(6 choice))" ?buttonText "225" ) 
      Deg315=hiCreateButton(?name 'Deg315 ?callback "ChangeChoice(hiGetCurrentForm() nth(7 choice))" ?buttonText "315" ) 

      logo=hiCreateButton(?name 'logo ?callback "ChangeChoice(hiGetCurrentForm() t" ?buttonText "logo")

      up=hiCreateButton(?name 'up ?callback "ChangeChoice(hiGetCurrentForm() nth(0 choice))" ?buttonText "up" ?buttonIcon "/home/caduser/Desktop/ICONS/11.png" ) 
      down=hiCreateButton(?name 'down ?callback "ChangeChoice(hiGetCurrentForm() nth(1 choice))" ?buttonText "down" ?buttonIcon "/home/caduser/Desktop/ICONS/33.png" )
      left=hiCreateButton(?name 'left ?callback "ChangeChoice(hiGetCurrentForm() nth(2 choice))" ?buttonText "left" ?buttonIcon "/home/caduser/Desktop/ICONS/44.png" )  
      right=hiCreateButton(?name 'right ?callback "ChangeChoice(hiGetCurrentForm() nth(3 choice))" ?buttonText "right" ?buttonIcon "/home/caduser/Desktop/ICONS/22.png" ) 

 field=list(
           list(space 10:0*ydelta xwidth-20:ydelta prompt)
           list(dir 10:1*ydelta xwidth-20:ydelta prompt)
           list(Deg45 (xwidth/2)-55+110:2*ydelta 110:2*ydelta)
           list(Deg135 0:2*ydelta 110:2*ydelta)
           list(Deg225 0:6*ydelta 110:2*ydelta)
           list(Deg315 (xwidth/2)-55+110:6*ydelta 110:2*ydelta)
           list(logo (xwidth/2)-55:4*ydelta 110:2*ydelta)
           list(up (xwidth/2)-55:2*ydelta 110:2*ydelta)
           list(right 0:4*ydelta 110:2*ydelta)
           list(left (xwidth/2)-55+110:4*ydelta 110:2*ydelta)
           list(down (xwidth/2)-55:6*ydelta 110:2*ydelta)

           )   

	hiCreateAppForm(
	  ?name 'ruler
	  ?formTitle "Magic_Ruler"
	  ?fields  field                     ;list
	  ?callback "ruler()"
	 )                                ;AppForm
	 hiDisplayForm(ruler list(800 100))
	 )
	 )


procedure(ChangeChoice(form value)
   cond(
       (value=="up"    form->dir->value="up" )
       (value=="down"  form->dir->value="down")
       (value=="right" form->dir->value="right")
       (value=="left"  form->dir->value="left")
       (value=="45"  form->dir->value="45")
       (value=="135"  form->dir->value="135")
       (value=="225"  form->dir->value="225")
       (value=="315"  form->dir->value="315")
       (value==t  cidHost = ipcBeginProcess("firefox mail.karmic.co.in"))
    );cond

  )



procedure(ruler()

  cv=geGetEditCellView()
  x=enterPoint()
  a=nth(0 x)
  b=nth(1 x)
  s=ruler~>space~>value
unless(ruler~>space~>value==0
  case(ruler~>dir~>value

        ("left" final_cord=list(a-s b))
		("right" final_cord=list(a+s b))
		("up" final_cord=list(a b+s))
		("down" final_cord=list(a b-s)) 
		("45"   x1=a+(s*0.707408781)
			y1=b+(s*0.707408781) 
			final_cord=list(x1 y1)
		)
		("135"  x1=a-(s*0.707408781)
			y1=b+(s*0.707408781) 
			final_cord=list(x1 y1)
		)
		("225"  x1=a-(s*0.707408781)
			y1=b-(s*0.707408781) 
			final_cord=list(x1 y1)
		)
		("315"  x1=a+(s*0.707408781)
			y1=b-(s*0.707408781) 
			final_cord=list(x1 y1)
		)		
		(t final_cord=list(a b))
             )

		leCreateRuler( cv list(a:b final_cord)) 
       )
);unless

hiSetBindKey("Layout" "Ctrl<Key>K" "magic_ruler()")
magic_ruler()




