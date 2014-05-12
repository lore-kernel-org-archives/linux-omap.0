From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v3 1/4] ARM: dts: am335x-bone: add support for beaglebone
 NAND cape
Date: Mon, 12 May 2014 09:46:09 -0700
Message-ID: <20140512164609.GL31772@atomide.com>
References: <1398152020-19391-1-git-send-email-pekon@ti.com>
 <1398152020-19391-2-git-send-email-pekon@ti.com>
 <20140506153430.GD18474@atomide.com>
 <20980858CB6D3A4BAE95CA194937D5E73EACBF42@DBDE04.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:38113 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752482AbaELQqO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 12 May 2014 12:46:14 -0400
Content-Disposition: inline
In-Reply-To: <20980858CB6D3A4BAE95CA194937D5E73EACBF42@DBDE04.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gupta, Pekon" <pekon@ti.com>
Cc: "bcousson@baylibre.com" <bcousson@baylibre.com>, linux-omap <linux-omap@vger.kernel.org>

* Gupta, Pekon <pekon@ti.com> [140509 11:52]:
> >From: Tony Lindgren [mailto:tony@atomide.com]
> >
> >* Pekon Gupta <pekon@ti.com> [140422 00:34]:
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
> >Have you checked that including the capes unconditionally for
> >non-integrated devices is safe? Maybe decompile the dtb using
> >dtc and see what is in the produced dts file?
> >
> >I'm mostly worried about pinmux and GPMC as the pins can be used
> >by other capes and GPMC can have other devices.
> >
> I checked by de-compiling beaglebone.dtb with this patch included,
> where GPMC pinmux conflicts with eMMC (MMC2). It shows that
> both the pin-mux are present, and GPMC node is "disabled" by
> default, whereas the eMMC (MMC2) node.
> So I think this patch is safe pin-muxing wise.
> ---------------
> 	gpmc@50000000 {
> 			...
> 			status = "disabled";
> 			pinctrl-names = "default";
> 			pinctrl-0 = <0x38>;
> 			}
> 	mmc@481d8000 {
> 			ti,hwmods = "mmc2";
> 			...
> 			status = "okay";
> 			pinctrl-0 = <0x2e>;
> 			bus-width = <0x8>;
> 		}
> 
> 		pinmux_emmc_pins {
> 			pinctrl-single,pins = <0x80 0x32 0x84 0x32 0x0 0x31 0x4 0x31 0x8 0x31 0xc 0x31 0x10 0x31 0x14 0x31 0x18 0x31 0x1c 0x31>;
> 			linux,phandle = <0x2e>;
> 			phandle = <0x2e>;
> 		};
> 		nand_flash_x16 {
> 			pinctrl-single,pins = <0x0 0x28 0x4 0x28 0x8 0x28 0xc 0x28 0x10 0x28 0x14 0x28 0x18 0x28 0x1c 0x28 0x20 0x28 0x24 0x28 0x28 0x28 0x2c 0x28 0x30 0x28 0x34 0x28 0x38 0x28 0x3c 0x28 0x70 0x30 0x74 0x17 0x7c 0x10 0x90 0x8 0x94 0x8 0x98 0x8 0x9c 0x8>;
> 			linux,phandle = <0x38>;
> 			phandle = <0x38>;
> 		};
> --------------

OK makes sense as long as the pin names in .dtb are different
for the capes. 
 
> >Also, this should probably also wait until u-boot has been
> >confirmed of being able to enable these devices?
> >
> Would be good if you accept this one, as this will act as reference for
> beaglebone cape users for pin-mux and other GPMC related bindings

What about other GPMC using capes? If we have another cape
that uses a separate GPMC partition we can't just set &gpmc
to status = "disabled" state.

Sorry, I can't merge this until all the issues are sorted out
and we have proven that the concept works by having u-boot
toggle the enabled status for the capes.

Regards,

Tony
