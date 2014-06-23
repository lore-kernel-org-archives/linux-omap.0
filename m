From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v7 1/4] ARM: dts: am335x-bone: add support for beaglebone
 NAND cape
Date: Sun, 22 Jun 2014 22:48:39 -0700
Message-ID: <20140623054838.GB28884@atomide.com>
References: <1400490948-11571-1-git-send-email-pekon@ti.com>
 <1400490948-11571-2-git-send-email-pekon@ti.com>
 <20140519162532.GF4849@atomide.com>
 <20980858CB6D3A4BAE95CA194937D5E73EAF6A7C@DBDE04.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:65496 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751731AbaFWFsl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 23 Jun 2014 01:48:41 -0400
Content-Disposition: inline
In-Reply-To: <20980858CB6D3A4BAE95CA194937D5E73EAF6A7C@DBDE04.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gupta, Pekon" <pekon@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Stefan Roese <sr@denx.de>, Javier Martinez Canillas <javier@dowhile0.org>, "Quadros, Roger" <rogerq@ti.com>, "Jason Kridner (jkridner@gmail.com)" <jkridner@gmail.com>, "Robert Nelson (robertcnelson@gmail.com)" <robertcnelson@gmail.com>

* Gupta, Pekon <pekon@ti.com> [140622 22:42]:
> Hi Tony,
> 
> Just reviving this thread for some information..
> 
> >From: Tony Lindgren [mailto:tony@atomide.com]
> >Sent: Monday, May 19, 2014 9:56 PM
> >To: Gupta, Pekon
> >Cc: linux-omap; Ezequiel Garcia; Stefan Roese; Javier Martinez Canillas; Quadros, Roger
> >Subject: Re: [PATCH v7 1/4] ARM: dts: am335x-bone: add support for beaglebone NAND cape
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
> >>  	regulator-min-microvolt = <1800000>;
> >> --- a/arch/arm/boot/dts/am335x-boneblack.dts
> >> +++ b/arch/arm/boot/dts/am335x-boneblack.dts
> >> @@ -9,6 +9,7 @@
> >>
> >>  #include "am33xx.dtsi"
> >>  #include "am335x-bone-common.dtsi"
> >> +#include "am335x-bone-memory-cape.dts"
> >>
> >>  &ldo3_reg {
> >>  	regulator-min-microvolt = <1800000>;
> >
> >Based on the recent discussions on the capes, it seems that nobody
> >wants to implement toggling of the capes in u-boot. And as there
> >can be other capes using GPMC bus, we can't merge this.
> 
> I have been able to get toggling of capes (enabling and disabling of DT nodes)
> in u-boot. It was already there in u-boot mainline [1], may be no-body tried it.
> 
> Example: Below sequence works for NAND cape patch mentioned in this thread.
> ---------------
> /* load DTB */
> u-boot> tftp 0x81000000 am335x-boneblack.dtb
> u-boot> fdt addr 0x81000000
> /* disable MMC2 node */
> u-boot> fdt list /ocp/mmc@481d8000
> u-boot> fdt set  /ocp/mmc@481d8000 status \d\i\s\a\b\l\e\d
> u-boot> fdt list /ocp/mmc@481d8000 status
> /* enable GPMC node */
> u-boot> fdt list /ocp/gpmc
> u-boot> fdt set  /ocp/gpmc status \o\k\a\y
> u-boot> fdt list /ocp/gpmc status
> /* enable ELM node */
> u-boot> fdt list /ocp/elm
> u-boot> fdt set  /ocp/elm status \o\k\a\y
> u-boot> fdt list /ocp/elm status
> /* boot uImage */
> tftp 0x82000000 uImage
> bootm 0x82000000 - 0x81000000
> 
> Note: "fdt set" command does not accept string literals
> as binding values, it internally converts them to string, so
> escape sequenced characters were used here..
> "okay" == \o\k\a\y
> "disabled" == \d\i\s\a\b\l\e\d"

Cool. Now all we need is a few helper functions in u-boot
so it can be done a bit easier :)

Regards,

Tony
