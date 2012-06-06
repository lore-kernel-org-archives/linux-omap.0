From: Uri Yosef <uri.y@variscite.com>
Subject: Re: [PATCH] arm/dts: OMAP4: Add Variscite OMAP4 System-On-Modeule
 support
Date: Wed, 6 Jun 2012 15:08:54 +0300
Message-ID: <CAHooxd7WG2BrT+dHuuETMUONjbSu3DoVyZ_VW9On-vwCn3rRaA@mail.gmail.com>
References: <20120509213156.GZ5140@atomide.com>
 <1337257051-5004-1-git-send-email-uri.y@variscite.com>
 <20120606090931.GV12766@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1794021303907347795=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20120606090931.GV12766@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux@arm.linux.org.uk, devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, oren@variscite.com
List-Id: linux-omap@vger.kernel.org

--===============1794021303907347795==
Content-Type: multipart/alternative; boundary=20cf305b0c1a8ef6aa04c1cca1bb

--20cf305b0c1a8ef6aa04c1cca1bb
Content-Type: text/plain; charset=ISO-8859-1

CCed devicetree-discuss@lists.ozlabs.org.

On Wed, Jun 6, 2012 at 12:09 PM, Tony Lindgren <tony@atomide.com> wrote:

> Hi,
>
> * Uri Yosef <uri.y@variscite.com> [120517 05:34]:
> > Hi Tony,
> >
> > This is the updated DTS patch for Vatiscite OMAP4 SOM support
>
> Looks OK to me, but can you please repost one more time with
> devicetree-discuss@lists.ozlabs.org in Cc so people have a chance
> to ack this patch there?
>
>
Thanks,
Uri


>
> >  arch/arm/boot/dts/omap4-var_som.dts |   96
> +++++++++++++++++++++++++++++++++++
> >  1 files changed, 96 insertions(+), 0 deletions(-)
> >  create mode 100644 arch/arm/boot/dts/omap4-var_som.dts
> >
> > diff --git a/arch/arm/boot/dts/omap4-var_som.dts
> b/arch/arm/boot/dts/omap4-var_som.dts
> > new file mode 100644
> > index 0000000..d41161d
> > --- /dev/null
> > +++ b/arch/arm/boot/dts/omap4-var_som.dts
> > @@ -0,0 +1,96 @@
> > +/*
> > + * Copyright (C) 2012 Variscite Ltd. - http://www.variscite.com
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License version 2 as
> > + * published by the Free Software Foundation.
> > + */
> > +/dts-v1/;
> > +
> > +/include/ "omap4.dtsi"
> > +
> > +/ {
> > +     model = "Variscite OMAP4 SOM";
> > +     compatible = "var,omap4-var_som", "ti,omap4430", "ti,omap4";
> > +
> > +     memory {
> > +             device_type = "memory";
> > +             reg = <0x80000000 0x40000000>; /* 1 GB */
> > +     };
> > +
> > +     vdd_eth: fixedregulator@0 {
> > +             compatible = "regulator-fixed";
> > +             regulator-name = "VDD_ETH";
> > +             regulator-min-microvolt = <3300000>;
> > +             regulator-max-microvolt = <3300000>;
> > +             enable-active-high;
> > +             regulator-boot-on;
> > +     };
> > +};
> > +
> > +&i2c1 {
> > +     clock-frequency = <400000>;
> > +
> > +     twl: twl@48 {
> > +             reg = <0x48>;
> > +             /* SPI = 0, IRQ# = 7, 4 = active high level-sensitive */
> > +             interrupts = <0 7 4>; /* IRQ_SYS_1N cascaded to gic */
> > +             interrupt-parent = <&gic>;
> > +     };
> > +};
> > +
> > +/include/ "twl6030.dtsi"
> > +
> > +&i2c2 {
> > +     clock-frequency = <400000>;
> > +};
> > +
> > +&i2c3 {
> > +     clock-frequency = <400000>;
> > +
> > +     /*
> > +      * Temperature Sensor
> > +      * http://www.ti.com/lit/ds/symlink/tmp105.pdf
> > +      */
> > +     tmp105@49 {
> > +             compatible = "ti,tmp105";
> > +             reg = <0x49>;
> > +     };
> > +};
> > +
> > +&i2c4 {
> > +     clock-frequency = <400000>;
> > +};
> > +
> > +&mcspi1 {
> > +     eth@0 {
> > +             compatible = "ks8851";
> > +             spi-max-frequency = <24000000>;
> > +             reg = <0>;
> > +             interrupt-parent = <&gpio6>;
> > +             interrupts = <11>; /* gpio line 171 */
> > +             vdd-supply = <&vdd_eth>;
> > +     };
> > +};
> > +
> > +&mmc1 {
> > +     vmmc-supply = <&vmmc>;
> > +     ti,bus-width = <8>;
> > +     ti,non-removable;
> > +};
> > +
> > +&mmc2 {
> > +     status = "disable";
> > +};
> > +
> > +&mmc3 {
> > +     status = "disable";
> > +};
> > +
> > +&mmc4 {
> > +     status = "disable";
> > +};
> > +
> > +&mmc5 {
> > +     ti,bus-width = <4>;
> > +};
> > --
> > 1.7.5.4
> >
>

--20cf305b0c1a8ef6aa04c1cca1bb
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">CCed=A0<a href=3D"mailto:devicetree-discuss@lists.ozlabs.o=
rg">devicetree-discuss@lists.ozlabs.org</a>.<div><br></div><div>On Wed, Jun=
 6, 2012 at 12:09 PM, Tony Lindgren <span dir=3D"ltr">&lt;<a href=3D"mailto=
:tony@atomide.com" target=3D"_blank">tony@atomide.com</a>&gt;</span> wrote:=
</div>
<div><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"=
margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">Hi,<br>
<br>
* Uri Yosef &lt;<a href=3D"mailto:uri.y@variscite.com">uri.y@variscite.com<=
/a>&gt; [120517 05:34]:<br>
<div class=3D"im">&gt; Hi Tony,<br>
&gt;<br>
&gt; This is the updated DTS patch for Vatiscite OMAP4 SOM support<br>
<br>
</div>Looks OK to me, but can you please repost one more time with<br>
<a href=3D"mailto:devicetree-discuss@lists.ozlabs.org">devicetree-discuss@l=
ists.ozlabs.org</a> in Cc so people have a chance<br>
to ack this patch there?<br>
<br></blockquote><div><br></div><div>Thanks,</div><div>Uri</div><div>=A0</d=
iv><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left=
:1px #ccc solid;padding-left:1ex"><div class=3D"HOEnZb"><div class=3D"h5"><=
br>
&gt; =A0arch/arm/boot/dts/omap4-var_som.dts | =A0 96 ++++++++++++++++++++++=
+++++++++++++<br>
&gt; =A01 files changed, 96 insertions(+), 0 deletions(-)<br>
&gt; =A0create mode 100644 arch/arm/boot/dts/omap4-var_som.dts<br>
&gt;<br>
&gt; diff --git a/arch/arm/boot/dts/omap4-var_som.dts b/arch/arm/boot/dts/o=
map4-var_som.dts<br>
&gt; new file mode 100644<br>
&gt; index 0000000..d41161d<br>
&gt; --- /dev/null<br>
&gt; +++ b/arch/arm/boot/dts/omap4-var_som.dts<br>
&gt; @@ -0,0 +1,96 @@<br>
&gt; +/*<br>
&gt; + * Copyright (C) 2012 Variscite Ltd. - <a href=3D"http://www.variscit=
e.com" target=3D"_blank">http://www.variscite.com</a><br>
&gt; + *<br>
&gt; + * This program is free software; you can redistribute it and/or modi=
fy<br>
&gt; + * it under the terms of the GNU General Public License version 2 as<=
br>
&gt; + * published by the Free Software Foundation.<br>
&gt; + */<br>
&gt; +/dts-v1/;<br>
&gt; +<br>
&gt; +/include/ &quot;omap4.dtsi&quot;<br>
&gt; +<br>
&gt; +/ {<br>
&gt; + =A0 =A0 model =3D &quot;Variscite OMAP4 SOM&quot;;<br>
&gt; + =A0 =A0 compatible =3D &quot;var,omap4-var_som&quot;, &quot;ti,omap4=
430&quot;, &quot;ti,omap4&quot;;<br>
&gt; +<br>
&gt; + =A0 =A0 memory {<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 device_type =3D &quot;memory&quot;;<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 reg =3D &lt;0x80000000 0x40000000&gt;; /* 1 =
GB */<br>
&gt; + =A0 =A0 };<br>
&gt; +<br>
&gt; + =A0 =A0 vdd_eth: fixedregulator@0 {<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D &quot;regulator-fixed&quot;;<=
br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 regulator-name =3D &quot;VDD_ETH&quot;;<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 regulator-min-microvolt =3D &lt;3300000&gt;;=
<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 regulator-max-microvolt =3D &lt;3300000&gt;;=
<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 enable-active-high;<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 regulator-boot-on;<br>
&gt; + =A0 =A0 };<br>
&gt; +};<br>
&gt; +<br>
&gt; +&amp;i2c1 {<br>
&gt; + =A0 =A0 clock-frequency =3D &lt;400000&gt;;<br>
&gt; +<br>
&gt; + =A0 =A0 twl: twl@48 {<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 reg =3D &lt;0x48&gt;;<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 /* SPI =3D 0, IRQ# =3D 7, 4 =3D active high =
level-sensitive */<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 interrupts =3D &lt;0 7 4&gt;; /* IRQ_SYS_1N =
cascaded to gic */<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 interrupt-parent =3D &lt;&amp;gic&gt;;<br>
&gt; + =A0 =A0 };<br>
&gt; +};<br>
&gt; +<br>
&gt; +/include/ &quot;twl6030.dtsi&quot;<br>
&gt; +<br>
&gt; +&amp;i2c2 {<br>
&gt; + =A0 =A0 clock-frequency =3D &lt;400000&gt;;<br>
&gt; +};<br>
&gt; +<br>
&gt; +&amp;i2c3 {<br>
&gt; + =A0 =A0 clock-frequency =3D &lt;400000&gt;;<br>
&gt; +<br>
&gt; + =A0 =A0 /*<br>
&gt; + =A0 =A0 =A0* Temperature Sensor<br>
&gt; + =A0 =A0 =A0* <a href=3D"http://www.ti.com/lit/ds/symlink/tmp105.pdf"=
 target=3D"_blank">http://www.ti.com/lit/ds/symlink/tmp105.pdf</a><br>
&gt; + =A0 =A0 =A0*/<br>
&gt; + =A0 =A0 tmp105@49 {<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D &quot;ti,tmp105&quot;;<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 reg =3D &lt;0x49&gt;;<br>
&gt; + =A0 =A0 };<br>
&gt; +};<br>
&gt; +<br>
&gt; +&amp;i2c4 {<br>
&gt; + =A0 =A0 clock-frequency =3D &lt;400000&gt;;<br>
&gt; +};<br>
&gt; +<br>
&gt; +&amp;mcspi1 {<br>
&gt; + =A0 =A0 eth@0 {<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D &quot;ks8851&quot;;<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 spi-max-frequency =3D &lt;24000000&gt;;<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 reg =3D &lt;0&gt;;<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 interrupt-parent =3D &lt;&amp;gpio6&gt;;<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 interrupts =3D &lt;11&gt;; /* gpio line 171 =
*/<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 vdd-supply =3D &lt;&amp;vdd_eth&gt;;<br>
&gt; + =A0 =A0 };<br>
&gt; +};<br>
&gt; +<br>
&gt; +&amp;mmc1 {<br>
&gt; + =A0 =A0 vmmc-supply =3D &lt;&amp;vmmc&gt;;<br>
&gt; + =A0 =A0 ti,bus-width =3D &lt;8&gt;;<br>
&gt; + =A0 =A0 ti,non-removable;<br>
&gt; +};<br>
&gt; +<br>
&gt; +&amp;mmc2 {<br>
&gt; + =A0 =A0 status =3D &quot;disable&quot;;<br>
&gt; +};<br>
&gt; +<br>
&gt; +&amp;mmc3 {<br>
&gt; + =A0 =A0 status =3D &quot;disable&quot;;<br>
&gt; +};<br>
&gt; +<br>
&gt; +&amp;mmc4 {<br>
&gt; + =A0 =A0 status =3D &quot;disable&quot;;<br>
&gt; +};<br>
&gt; +<br>
&gt; +&amp;mmc5 {<br>
&gt; + =A0 =A0 ti,bus-width =3D &lt;4&gt;;<br>
&gt; +};<br>
&gt; --<br>
&gt; 1.7.5.4<br>
&gt;<br>
</div></div></blockquote></div><br></div></div>

--20cf305b0c1a8ef6aa04c1cca1bb--


--===============1794021303907347795==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============1794021303907347795==--
