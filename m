From: Jason Kridner <jkridner-hcmAuCOw+vXj4SYmN/TMmA@public.gmane.org>
Subject: Re: Debugging LCD and encountering NULL pointer in omap_vout_probe
Date: Thu, 8 Sep 2011 04:19:36 -0700 (PDT)
Message-ID: <10651908.679.1315480776490.JavaMail.geo-discussion-forums@yqap15>
References: <968502.699.1315478251635.JavaMail.geo-discussion-forums@yqej16>
 <4E689FCB.30008@gmail.com>
Reply-To: beagleboard-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_678_677432.1315480776488"
Return-path: <beagleboard+bncCNSPtrLdDRDJyaLzBBoEXVTHAA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <4E689FCB.30008-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Post: <http://groups.google.com/group/beagleboard/post?hl=en_US>, <mailto:beagleboard-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/?hl=en_US>, <mailto:beagleboard+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/beagleboard?hl=en_US>
Sender: beagleboard-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Unsubscribe: <http://groups.google.com/group/beagleboard/subscribe?hl=en_US>,
 <mailto:beagleboard+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: beagleboard-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

------=_Part_678_677432.1315480776488
Content-Type: text/plain; charset=ISO-8859-1

On Thursday, September 8, 2011 6:58:19 AM UTC-4, vladimir wrote:
>
> Jason Kridner wrote:
> > Any ideas on debugging this crash in omap_vout_probe? This is a 3.0.4 
> kernel with PM patches applied from Kevin's tree.


I tried against the latest copy of the mainline I could get (commit 
9e79e3e9dd9672b37ac9412e9a926714306551fe) to see what that would do (without 
applying any of my patches) and got a linker error in the same function in 
question.

  CC      drivers/media/video/omap/omap_vout.o
drivers/media/video/omap/omap_vout.c: In function 'omap_vout_probe':
drivers/media/video/omap/omap_vout.c:2202:15: error: 'struct 
omap_dss_driver' has no member named 'set_update_mode'
drivers/media/video/omap/omap_vout.c:2203:12: error: 'struct 
omap_dss_driver' has no member named 'set_update_mode'
drivers/media/video/omap/omap_vout.c:2204:8: error: 'OMAP_DSS_UPDATE_MANUAL' 
undeclared (first use in this function)
drivers/media/video/omap/omap_vout.c:2204:8: note: each undeclared 
identifier is reported only once for each function it appears in
drivers/media/video/omap/omap_vout.c:2206:15: error: 'struct 
omap_dss_driver' has no member named 'set_update_mode'
drivers/media/video/omap/omap_vout.c:2207:12: error: 'struct 
omap_dss_driver' has no member named 'set_update_mode'
drivers/media/video/omap/omap_vout.c:2208:8: error: 'OMAP_DSS_UPDATE_AUTO' 
undeclared (first use in this function)
make[4]: *** [drivers/media/video/omap/omap_vout.o] Error 1
make[3]: *** [drivers/media/video/omap] Error 2
make[2]: *** [drivers/media/video] Error 2
make[1]: *** [drivers/media] Error 2
make: *** [drivers] Error 2

http://paste.ubuntu.com/685168/


it crashed where in omap_vout_probe?
>

At offset 0x6b8, per the paste below...
 

> >
> > Built using: 
> https://gitorious.org/beagleboard-validation/linux/commits/ulcd-20110907
> >
>
> [ 3.676513] Unable to handle kernel NULL pointer dereference at virtual 
address 0000005c

> > [ 3.685058] pgd = c0004000
> > [ 3.687896] [0000005c] *pgd=00000000
> > [ 3.691680] Internal error: Oops: 5 [#1]
> > [ 3.695831] Modules linked in:
> > [ 3.699066] CPU: 0 Not tainted (3.0.4+ #2)
> > [ 3.703735] PC is at omap_vout_probe+0x6b8/0x7e0
> > [ 3.708618] LR is at omap_vout_probe+0x684/0x7e0
>
.
.
.
 

> > [ 3.855529] [<c00297bc>] (omap_vout_probe+0x6b8/0x7e0) from [<c02a79b4>] 
> (platform_drv_probe+0x14/0x18)
> > [ 3.865447] [<c02a79b4>] (platform_drv_probe+0x14/0x18) from [<c02a6944>] 
> (driver_probe_device+0xc8/0x184)
> > [ 3.875610] [<c02a6944>] (driver_probe_device+0xc8/0x184) from 
> [<c02a6a60>] (__driver_attach+0x60/0x84)
> > [ 3.885528] [<c02a6a60>] (__driver_attach+0x60/0x84) from [<c02a5bf4>] 
> (bus_for_each_dev+0x4c/0x78)
> > [ 3.895050] [<c02a5bf4>] (bus_for_each_dev+0x4c/0x78) from [<c02a6264>] 
> (bus_add_driver+0x98/0x210)
> > [ 3.904602] [<c02a6264>] (bus_add_driver+0x98/0x210) from [<c02a6f6c>] 
> (driver_register+0xa0/0x120)
> > [ 3.914154] [<c02a6f6c>] (driver_register+0xa0/0x120) from [<c00290e4>] 
> (omap_vout_init+0xc/0x2c)
> > [ 3.923492] [<c00290e4>] (omap_vout_init+0xc/0x2c) from [<c003d45c>] 
> (do_one_initcall+0x90/0x160)
> > [ 3.932861] [<c003d45c>] (do_one_initcall+0x90/0x160) from [<c000894c>] 
> (kernel_init+0x88/0x130)
> > [ 3.942138] [<c000894c>] (kernel_init+0x88/0x130) from [<c0042cd4>] 
> (kernel_thread_exit+0x0/0x8)
> > [ 3.951416] Code: e3e05012 ea000016 e59a0094 e5903200 (e593c05c)
> > [ 3.957885] ---[ end trace cbb5c332507f77c9 ]---
> > [ 3.962890] Kernel panic - not syncing: Attempted to kill init!
>
>
>

-- 
You received this message because you are subscribed to the Google Groups "Beagle Board" group.
To view this discussion on the web visit https://groups.google.com/d/msg/beagleboard/-/BUAXSWVTewgJ.
To post to this group, send email to beagleboard-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
To unsubscribe from this group, send email to beagleboard+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit this group at http://groups.google.com/group/beagleboard?hl=en.


------=_Part_678_677432.1315480776488
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Thursday, September 8, 2011 6:58:19 AM UTC-4, vladimir wrote:<blockquote=
 class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; border-left: 1px=
 solid rgb(204, 204, 204); padding-left: 1ex;">Jason Kridner wrote:<br>&gt;=
 Any ideas on debugging this crash in omap_vout_probe? This is a 3.0.4 kern=
el with PM patches applied from Kevin's tree.</blockquote><div style=3D"tex=
t-align: left;"><br>I tried against the latest copy of the mainline I could=
 get (commit 9e79e3e9dd9672b37ac9412e9a926714306551fe) to see what that wou=
ld do (without applying any of my patches) and got a linker error in the sa=
me function in question.<br><br>&nbsp; CC&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dri=
vers/media/video/omap/omap_vout.o<br>drivers/media/video/omap/omap_vout.c: =
In function 'omap_vout_probe':<br>drivers/media/video/omap/omap_vout.c:2202=
:15: error: 'struct omap_dss_driver' has no member named 'set_update_mode'<=
br>drivers/media/video/omap/omap_vout.c:2203:12: error: 'struct omap_dss_dr=
iver' has no member named 'set_update_mode'<br>drivers/media/video/omap/oma=
p_vout.c:2204:8: error: 'OMAP_DSS_UPDATE_MANUAL' undeclared (first use in t=
his function)<br>drivers/media/video/omap/omap_vout.c:2204:8: note: each un=
declared identifier is reported only once for each function it appears in<b=
r>drivers/media/video/omap/omap_vout.c:2206:15: error: 'struct omap_dss_dri=
ver' has no member named 'set_update_mode'<br>drivers/media/video/omap/omap=
_vout.c:2207:12: error: 'struct omap_dss_driver' has no member named 'set_u=
pdate_mode'<br>drivers/media/video/omap/omap_vout.c:2208:8: error: 'OMAP_DS=
S_UPDATE_AUTO' undeclared (first use in this function)<br>make[4]: *** [dri=
vers/media/video/omap/omap_vout.o] Error 1<br>make[3]: *** [drivers/media/v=
ideo/omap] Error 2<br>make[2]: *** [drivers/media/video] Error 2<br>make[1]=
: *** [drivers/media] Error 2<br>make: *** [drivers] Error 2<br><br>http://=
paste.ubuntu.com/685168/<br><br><br></div><blockquote class=3D"gmail_quote"=
 style=3D"margin: 0pt 0pt 0pt 0.8ex; border-left: 1px solid rgb(204, 204, 2=
04); padding-left: 1ex;"><p>it crashed where in omap_vout_probe?</p></block=
quote><div style=3D"text-align: left;"><br>At offset 0x6b8, per the paste b=
elow...<br>&nbsp;</div><blockquote class=3D"gmail_quote" style=3D"margin: 0=
pt 0pt 0pt 0.8ex; border-left: 1px solid rgb(204, 204, 204); padding-left: =
1ex;"><p>&gt;<br>&gt; Built using: <a href=3D"https://gitorious.org/beagleb=
oard-validation/linux/commits/ulcd-20110907" target=3D"_blank">https://gito=
rious.org/<wbr>beagleboard-validation/linux/<wbr>commits/ulcd-20110907</a><=
br>&gt;<br></p></blockquote>&gt; [ 3.676513] Unable to handle kernel NULL p=
ointer dereference at virtual address 0000005c<br><blockquote class=3D"gmai=
l_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; border-left: 1px solid rgb(204=
, 204, 204); padding-left: 1ex;"><p>&gt; [ 3.685058] pgd =3D c0004000<br>&g=
t; [ 3.687896] [0000005c] *pgd=3D00000000<br>&gt; [ 3.691680] Internal erro=
r: Oops: 5 [#1]<br>&gt; [ 3.695831] Modules linked in:<br>&gt; [ 3.699066] =
CPU: 0 Not tainted (3.0.4+ #2)<br>&gt; [ 3.703735] PC is at omap_vout_probe=
+0x6b8/0x7e0<br>&gt; [ 3.708618] LR is at omap_vout_probe+0x684/0x7e0<br></=
p></blockquote><div style=3D"text-align: left;">.<br>.<br>.<br>&nbsp;</div>=
<div style=3D"text-align: left;"><blockquote class=3D"gmail_quote" style=3D=
"margin: 0pt 0pt 0pt 0.8ex; border-left: 1px solid rgb(204, 204, 204); padd=
ing-left: 1ex;"><div style=3D"text-align: left;">&gt; [ 3.855529] [&lt;c002=
97bc&gt;] (omap_vout_probe+0x6b8/0x7e0) from [&lt;c02a79b4&gt;] (platform_d=
rv_probe+0x14/0x18)<br>&gt; [ 3.865447] [&lt;c02a79b4&gt;] (platform_drv_pr=
obe+0x14/0x18) from [&lt;c02a6944&gt;] (driver_probe_device+0xc8/<wbr>0x184=
)<br>&gt; [ 3.875610] [&lt;c02a6944&gt;] (driver_probe_device+0xc8/<wbr>0x1=
84) from [&lt;c02a6a60&gt;] (__driver_attach+0x60/0x84)<br>&gt; [ 3.885528]=
 [&lt;c02a6a60&gt;] (__driver_attach+0x60/0x84) from [&lt;c02a5bf4&gt;] (bu=
s_for_each_dev+0x4c/0x78)<br>&gt; [ 3.895050] [&lt;c02a5bf4&gt;] (bus_for_e=
ach_dev+0x4c/0x78) from [&lt;c02a6264&gt;] (bus_add_driver+0x98/0x210)<br>&=
gt; [ 3.904602] [&lt;c02a6264&gt;] (bus_add_driver+0x98/0x210) from [&lt;c0=
2a6f6c&gt;] (driver_register+0xa0/0x120)<br>&gt; [ 3.914154] [&lt;c02a6f6c&=
gt;] (driver_register+0xa0/0x120) from [&lt;c00290e4&gt;] (omap_vout_init+0=
xc/0x2c)<br>&gt; [ 3.923492] [&lt;c00290e4&gt;] (omap_vout_init+0xc/0x2c) f=
rom [&lt;c003d45c&gt;] (do_one_initcall+0x90/0x160)<br>&gt; [ 3.932861] [&l=
t;c003d45c&gt;] (do_one_initcall+0x90/0x160) from [&lt;c000894c&gt;] (kerne=
l_init+0x88/0x130)<br>&gt; [ 3.942138] [&lt;c000894c&gt;] (kernel_init+0x88=
/0x130) from [&lt;c0042cd4&gt;] (kernel_thread_exit+0x0/0x8)<br>&gt; [ 3.95=
1416] Code: e3e05012 ea000016 e59a0094 e5903200 (e593c05c)<br>&gt; [ 3.9578=
85] ---[ end trace cbb5c332507f77c9 ]---<br>&gt; [ 3.962890] Kernel panic -=
 not syncing: Attempted to kill init!<br></div><p><br></p></blockquote></di=
v>

<p></p>

-- <br />
You received this message because you are subscribed to the Google Groups "=
Beagle Board" group.<br />
To view this discussion on the web visit <a href=3D"https://groups.google.c=
om/d/msg/beagleboard/-/BUAXSWVTewgJ">https://groups.google.com/d/msg/beagle=
board/-/BUAXSWVTewgJ</a>.<br />=20
To post to this group, send email to beagleboard-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org<br />
To unsubscribe from this group, send email to beagleboard+unsubscribe@googl=
egroups.com.<br />

For more options, visit this group at http://groups.google.com/group/beagle=
board?hl=3Den.<br />



------=_Part_678_677432.1315480776488--
