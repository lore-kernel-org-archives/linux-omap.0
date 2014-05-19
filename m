From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: Re: [PATCH v7 1/4] ARM: dts: am335x-bone: add support for beaglebone
 NAND cape
Date: Mon, 19 May 2014 15:16:40 -0300
Message-ID: <20140519181640.GA6957@arch.cereza>
References: <1400490948-11571-1-git-send-email-pekon@ti.com>
 <1400490948-11571-2-git-send-email-pekon@ti.com>
 <20140519162532.GF4849@atomide.com>
 <20980858CB6D3A4BAE95CA194937D5E73EACE21E@DBDE04.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:54156 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751520AbaESSRQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 19 May 2014 14:17:16 -0400
Content-Disposition: inline
In-Reply-To: <20980858CB6D3A4BAE95CA194937D5E73EACE21E@DBDE04.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gupta, Pekon" <pekon@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap <linux-omap@vger.kernel.org>, Stefan Roese <sr@denx.de>, Javier Martinez Canillas <javier@dowhile0.org>, "Quadros, Roger" <rogerq@ti.com>

On 19 May 05:52 PM, Gupta, Pekon wrote:
> Hi Tony,
>=20
> >From: Tony Lindgren [mailto:tony@atomide.com]
> >
> >* Pekon Gupta <pekon@ti.com> [140519 02:16]:
> >> --- a/arch/arm/boot/dts/am335x-bone.dts
> >> +++ b/arch/arm/boot/dts/am335x-bone.dts
> >> @@ -9,6 +9,7 @@
> >>
> >>  #include "am33xx.dtsi"
> >>  #include "am335x-bone-common.dtsi"
> >> +#include "am335x-bone-memory-cape.dts"
> >>
> >>  &ldo3_reg {
> >>  	regulator-min-microvolt =3D <1800000>;
> >> --- a/arch/arm/boot/dts/am335x-boneblack.dts
> >> +++ b/arch/arm/boot/dts/am335x-boneblack.dts
> >> @@ -9,6 +9,7 @@
> >>
> >>  #include "am33xx.dtsi"
> >>  #include "am335x-bone-common.dtsi"
> >> +#include "am335x-bone-memory-cape.dts"
> >>
> >>  &ldo3_reg {
> >>  	regulator-min-microvolt =3D <1800000>;
> >
> >Based on the recent discussions on the capes, it seems that nobody
> >wants to implement toggling of the capes in u-boot. And as there
> >can be other capes using GPMC bus, we can't merge this. And because
> >the capes are stackable, we can't really have .dts files for all
> >the combinations. And no, we're not merging any unconnected .dts
> >files either, sorry.
> >
> Yes, I fully understand. This is like death for most of the capes fro=
m point
> of view of mainline support. But I have submitted this patch just for=
 sake
> of completion. And to provide reference if someone wants to locally w=
ork
> on beaglebone NAND cape.

While I fully agree with Tony on this, I think the reference is much
appreciated. Do you think you can push the NAND cape DT example somewhe=
re?

Maybe some TI wiki page?
--=20
Ezequiel Garc=EDa, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
