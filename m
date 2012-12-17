From: Sekhar Nori <nori.sekhar@gmail.com>
Subject: Re: [RFC] drm/lcdc: add TI LCD Controller DRM driver
Date: Mon, 17 Dec 2012 20:56:05 +0530
Message-ID: <CAKG51UAunsckFj9g7EMrX6=uFakEidQv2AJJMXPVzeY77eU+JA@mail.gmail.com>
References: <1355443446-8723-1-git-send-email-robdclark@gmail.com>
	<50CF248B.4010401@ti.com>
	<CAF6AEGvm2TmFh7xiYzjt9yGT4kuBFA=_219NkwQAjbBVZ+Z6rg@mail.gmail.com>
	<CAF6AEGtfeXycZjashi=PenX86m7HLBTZ=U04Q4kLSyqJXwQ1fQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0761038172=="
Return-path: <dri-devel-bounces+sf-dri-devel=m.gmane.org@lists.freedesktop.org>
In-Reply-To: <CAF6AEGtfeXycZjashi=PenX86m7HLBTZ=U04Q4kLSyqJXwQ1fQ@mail.gmail.com>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/dri-devel>,
	<mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/dri-devel>,
	<mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: dri-devel-bounces+sf-dri-devel=m.gmane.org@lists.freedesktop.org
Errors-To: dri-devel-bounces+sf-dri-devel=m.gmane.org@lists.freedesktop.org
To: Rob Clark <robdclark@gmail.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "patches@linaro.org" <patches@linaro.org>
List-Id: linux-omap@vger.kernel.org

--===============0761038172==
Content-Type: multipart/alternative; boundary=f46d0447f188f14f7a04d10dff7e

--f46d0447f188f14f7a04d10dff7e
Content-Type: text/plain; charset=ISO-8859-1

Hi Rob,

On Monday, December 17, 2012, Rob Clark wrote:

> On Mon, Dec 17, 2012 at 8:39 AM, Rob Clark <robdclark@gmail.com<javascript:;>>
> wrote:
> >> I'm not very enthusiastic about adding ti-lcdc specific panel/chip
> >> drivers. It's not really a big deal if it's only kernel code, but you
> >> add device-tree bindings also, which is an external API that you need to
> >> support after adding it.
> >>
> >> I'd rather see the energy put to common display framework, and get this
> >> whole panel/chip driver issue solved in a generic manner.
> >
> > yeah, I was expecting to migrate to CDF once it exists, but needed
> > something for now.  I'm using the exercise to get my thoughts straight
> > on how CDF should fit into KMS.  (One thing I plan to add support for
> > is an i2c connected hdmi encoder.. which looks like it would fit well
> > in drivers/gpu/drm/i2c.. so the drm encoder-slave stuff might be the
> > way.)
> >
> > If you have any suggestions on the DT bindings, I'd like to hear 'em.
>
> btw, a little bit of-topic, but speaking of DT...
>
> Anybody have any clue about how backlight devices are supposed to work
> in this brave new DT world?


See Runtime interpreted power sequences here:
 http://lkml.indiana.edu/hypermail/linux/kernel/1208.2/00029.html

It is an attempt to address this need.

Thanks,
Sekhar

 In the old days, the board file would
> stuff a fxn ptr to control backlight in pdata for the driver.  But we
> don't have this any more.  I think I need some way to retrieve the
> 'struct backlight_device' ptr associated with the panel driver, so
> that the appropriate dpms fxn ptrs can enable/disable the backlight.
>
> I'm thinking the dt file should have something that looks roughly like:
>
>                 /* Settings for CDTech_S035Q01 / LCD3 cape: */
>                 panel {
>                         compatible = "lcdc,panel";
>                         pinctrl-names = "default";
>                         pinctrl-0 = <&bone_lcd3_cape_lcd_pins>;
>                         panel-info {
>                                 ac-bias           = <255>;
>                                 ac-bias-intrpt    = <0>;
>                                 dma-burst-sz      = <16>;
>                                 bpp               = <16>;
>                                 fdd               = <0x80>;
>                                 tft-alt-mode      = <0>;
>                                 stn-565-mode      = <0>;
>                                 mono-8bit-mode    = <0>;
>                                 invert-line-clock = <1>;
>                                 invert-frm-clock  = <1>;
>                                 sync-edge         = <0>;
>                                 sync-ctrl         = <1>;
>                                 raster-order      = <0>;
>                                 fifo-th           = <0>;
>                         };
>                         display-timings {
>                                 native-mode = <&timing0>;
>                                 timing0: 320x240 {
>                                         hactive         = <320>;
>                                         vactive         = <240>;
>                                         hback-porch     = <21>;
>                                         hfront-porch    = <58>;
>                                         hsync-len       = <47>;
>                                         vback-porch     = <11>;
>                                         vfront-porch    = <23>;
>                                         vsync-len       = <2>;
>                                         clock-frequency = <8000000>;
>                                 };
>                         };
>
>                         backlight {
>                                 compatible = "tps65217-backlight";
>                                 isel = <1>;
>                                 fdim = <200>;
>
>                                 tps = <&tps>;   /* link to the tps */
>                                 brightness = <100>;
>                         };
>                 };
>
> display-timings is based on the of-videomode helpers patch..
> panel-info probably needs to be made to be something more generic, but
> we need something to know how to configure the crtc properly..
>
> but I'm not quite sure what to do with the backlight..
>
> BR,
> -R
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org <javascript:;>
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>

--f46d0447f188f14f7a04d10dff7e
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Rob,<br><br>On Monday, December 17, 2012, Rob Clark  wrote:<br><blockquo=
te class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc so=
lid;padding-left:1ex">On Mon, Dec 17, 2012 at 8:39 AM, Rob Clark &lt;<a hre=
f=3D"javascript:;" onclick=3D"_e(event, &#39;cvml&#39;, &#39;robdclark@gmai=
l.com&#39;)">robdclark@gmail.com</a>&gt; wrote:<br>

&gt;&gt; I&#39;m not very enthusiastic about adding ti-lcdc specific panel/=
chip<br>
&gt;&gt; drivers. It&#39;s not really a big deal if it&#39;s only kernel co=
de, but you<br>
&gt;&gt; add device-tree bindings also, which is an external API that you n=
eed to<br>
&gt;&gt; support after adding it.<br>
&gt;&gt;<br>
&gt;&gt; I&#39;d rather see the energy put to common display framework, and=
 get this<br>
&gt;&gt; whole panel/chip driver issue solved in a generic manner.<br>
&gt;<br>
&gt; yeah, I was expecting to migrate to CDF once it exists, but needed<br>
&gt; something for now. =A0I&#39;m using the exercise to get my thoughts st=
raight<br>
&gt; on how CDF should fit into KMS. =A0(One thing I plan to add support fo=
r<br>
&gt; is an i2c connected hdmi encoder.. which looks like it would fit well<=
br>
&gt; in drivers/gpu/drm/i2c.. so the drm encoder-slave stuff might be the<b=
r>
&gt; way.)<br>
&gt;<br>
&gt; If you have any suggestions on the DT bindings, I&#39;d like to hear &=
#39;em.<br>
<br>
btw, a little bit of-topic, but speaking of DT...<br>
<br>
Anybody have any clue about how backlight devices are supposed to work<br>
in this brave new DT world?=A0</blockquote><blockquote class=3D"gmail_quote=
" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><=
/blockquote><div><br></div><div dir=3D"ltr">See Runtime interpreted power s=
equences here:</div>
<div dir=3D"ltr"><span></span>=A0<span style=3D"font-family:&#39;.Helvetica=
NeueUI&#39;;white-space:nowrap"><a href=3D"http://lkml.indiana.edu/hypermai=
l/linux/kernel/1208.2/00029.html">http://lkml.indiana.edu/hypermail/linux/k=
ernel/1208.2/00029.html</a></span></div>
<div><br></div><div>It is an attempt to address this need.</div><div><br></=
div><div>Thanks,</div><div>Sekhar</div><div><br></div><blockquote class=3D"=
gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-=
left:1ex">
=A0In the old days, the board file would<br>
stuff a fxn ptr to control backlight in pdata for the driver. =A0But we<br>
don&#39;t have this any more. =A0I think I need some way to retrieve the<br=
>
&#39;struct backlight_device&#39; ptr associated with the panel driver, so<=
br>
that the appropriate dpms fxn ptrs can enable/disable the backlight.<br>
<br>
I&#39;m thinking the dt file should have something that looks roughly like:=
<br>
<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Settings for CDTech_S035Q01 / LCD3 cape:=
 */<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 panel {<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D &quot;lcdc,p=
anel&quot;;<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pinctrl-names =3D &quot;def=
ault&quot;;<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pinctrl-0 =3D &lt;&amp;bone=
_lcd3_cape_lcd_pins&gt;;<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 panel-info {<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ac-bias =A0=
 =A0 =A0 =A0 =A0 =3D &lt;255&gt;;<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ac-bias-int=
rpt =A0 =A0=3D &lt;0&gt;;<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dma-burst-s=
z =A0 =A0 =A0=3D &lt;16&gt;;<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bpp =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =3D &lt;16&gt;;<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 fdd =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =3D &lt;0x80&gt;;<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tft-alt-mod=
e =A0 =A0 =A0=3D &lt;0&gt;;<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 stn-565-mod=
e =A0 =A0 =A0=3D &lt;0&gt;;<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mono-8bit-m=
ode =A0 =A0=3D &lt;0&gt;;<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 invert-line=
-clock =3D &lt;1&gt;;<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 invert-frm-=
clock =A0=3D &lt;1&gt;;<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sync-edge =
=A0 =A0 =A0 =A0 =3D &lt;0&gt;;<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sync-ctrl =
=A0 =A0 =A0 =A0 =3D &lt;1&gt;;<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 raster-orde=
r =A0 =A0 =A0=3D &lt;0&gt;;<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 fifo-th =A0=
 =A0 =A0 =A0 =A0 =3D &lt;0&gt;;<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 };<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 display-timings {<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 native-mode=
 =3D &lt;&amp;timing0&gt;;<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 timing0: 32=
0x240 {<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 hactive =A0 =A0 =A0 =A0 =3D &lt;320&gt;;<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 vactive =A0 =A0 =A0 =A0 =3D &lt;240&gt;;<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 hback-porch =A0 =A0 =3D &lt;21&gt;;<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 hfront-porch =A0 =A0=3D &lt;58&gt;;<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 hsync-len =A0 =A0 =A0 =3D &lt;47&gt;;<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 vback-porch =A0 =A0 =3D &lt;11&gt;;<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 vfront-porch =A0 =A0=3D &lt;23&gt;;<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 vsync-len =A0 =A0 =A0 =3D &lt;2&gt;;<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 clock-frequency =3D &lt;8000000&gt;;<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 };<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 };<br>
<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 backlight {<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =
=3D &quot;tps65217-backlight&quot;;<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 isel =3D &l=
t;1&gt;;<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 fdim =3D &l=
t;200&gt;;<br>
<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tps =3D &lt=
;&amp;tps&gt;; =A0 /* link to the tps */<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 brightness =
=3D &lt;100&gt;;<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 };<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 };<br>
<br>
display-timings is based on the of-videomode helpers patch..<br>
panel-info probably needs to be made to be something more generic, but<br>
we need something to know how to configure the crtc properly..<br>
<br>
but I&#39;m not quite sure what to do with the backlight..<br>
<br>
BR,<br>
-R<br>
<br>
_______________________________________________<br>
linux-arm-kernel mailing list<br>
<a href=3D"javascript:;" onclick=3D"_e(event, &#39;cvml&#39;, &#39;linux-ar=
m-kernel@lists.infradead.org&#39;)">linux-arm-kernel@lists.infradead.org</a=
><br>
<a href=3D"http://lists.infradead.org/mailman/listinfo/linux-arm-kernel" ta=
rget=3D"_blank">http://lists.infradead.org/mailman/listinfo/linux-arm-kerne=
l</a><br>
</blockquote>

--f46d0447f188f14f7a04d10dff7e--

--===============0761038172==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
dri-devel mailing list
dri-devel@lists.freedesktop.org
http://lists.freedesktop.org/mailman/listinfo/dri-devel

--===============0761038172==--
