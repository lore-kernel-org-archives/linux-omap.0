From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] ARM: dts: Revert disabling of smc91x for n900
Date: Wed, 7 Jan 2015 10:57:03 +0100
Message-ID: <20150107095703.GA15925@amd>
References: <20150105230228.GO4081@atomide.com>
 <20150106080025.GA6752@amd>
 <20150106165903.GF4025@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:53610 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751969AbbAGJ5G (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Jan 2015 04:57:06 -0500
Content-Disposition: inline
In-Reply-To: <20150106165903.GF4025@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, Kevin Hilman <khilman@kernel.org>, Aaro Koskinen <aaro.koskinen@iki.fi>, Sebastian Reichel <sre@kernel.org>, Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>

On Tue 2015-01-06 08:59:03, Tony Lindgren wrote:
> * Pavel Machek <pavel@ucw.cz> [150106 00:03]:
> > On Mon 2015-01-05 15:02:29, Tony Lindgren wrote:
> > > Revert "ARM: dts: Disable smc91x on n900 until bootloader
> > > dependency is removed". We've now fixed the issues that
> > > caused problems with uninitialized hardware depending on
> > > the bootloader version. Mostly things got fixed with
> > > the following commits:
> > > 
> > > 9a894953a97b ("ARM: dts: Fix bootloader version dependencies by muxing n900 smc91x pins")
> > > 7d2911c43815 ("net: smc91x: Fix gpios for device tree based booting")
> > > 
> > > Note that this only affects the early development boards
> > > with Ethernet that we still have in a few automated boot
> > > test systems.
> > > 
> > > Signed-off-by: Tony Lindgren <tony@atomide.com>
> > 
> > Normally, the early development boards should have separate dts file
> > (then include common parts), no?
> 
> In this case it won't matter. The GPMC hardware is there, the probe
> just fails if no smsc91x is found.
>  
> > Could you at least add a note to the dts file what is it? Because I
> > always thought it is a bug.
> 
> Sure, updated patch below. Can somebody please test boot it on
> a production n900 too to make sure it no longer causes issues?

Actually... how do you manage your n900 to boot? Does it also boot
from 0xffff?

I believe I'm hitting dtb size limit (again), and 3.19-rc3 does not boot
unless I somehow make dtb smaller... like the patch below.

---

make dtb smaller so that it boots.



diff --git a/arch/arm/boot/dts/omap3-n900.dts b/arch/arm/boot/dts/omap3-n900.dts
index 53f3ca0..82f4597 100644
--- a/arch/arm/boot/dts/omap3-n900.dts
+++ b/arch/arm/boot/dts/omap3-n900.dts
@@ -140,14 +140,6 @@
 		>;
 	};
 
-	ethernet_pins: pinmux_ethernet_pins {
-		pinctrl-single,pins = <
-			OMAP3_CORE1_IOPAD(0x20b4, PIN_INPUT_PULLDOWN | MUX_MODE4)	/* gpmc_ncs3.gpio_54 */
-			OMAP3_CORE1_IOPAD(0x20fc, PIN_OUTPUT | MUX_MODE4)		/* dss_data16.gpio_86 */
-			OMAP3_CORE1_IOPAD(0x219c, PIN_OUTPUT | MUX_MODE4)		/* uart3_rts_sd.gpio_164 */
-		>;
-	};
-
 	gpmc_pins: pinmux_gpmc_pins {
 		pinctrl-single,pins = <
 
@@ -700,42 +692,6 @@
 		};
 	};
 
-	ethernet@gpmc {
-		compatible = "smsc,lan91c94";
-
-		status = "disabled";
-
-		interrupt-parent = <&gpio2>;
-		interrupts = <22 IRQ_TYPE_LEVEL_HIGH>;	/* gpio54 */
-		reg = <1 0x300 0xf>;		/* 16 byte IO range at offset 0x300 */
-		bank-width = <2>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&ethernet_pins>;
-		power-gpios = <&gpio3 22 GPIO_ACTIVE_HIGH>;	/* gpio86 */
-		reset-gpios = <&gpio6 4 GPIO_ACTIVE_HIGH>;	/* gpio164 */
-		gpmc,device-width = <2>;
-		gpmc,sync-clk-ps = <0>;
-		gpmc,cs-on-ns = <0>;
-		gpmc,cs-rd-off-ns = <48>;
-		gpmc,cs-wr-off-ns = <24>;
-		gpmc,adv-on-ns = <0>;
-		gpmc,adv-rd-off-ns = <0>;
-		gpmc,adv-wr-off-ns = <0>;
-		gpmc,we-on-ns = <12>;
-		gpmc,we-off-ns = <18>;
-		gpmc,oe-on-ns = <12>;
-		gpmc,oe-off-ns = <48>;
-		gpmc,page-burst-access-ns = <0>;
-		gpmc,access-ns = <42>;
-		gpmc,rd-cycle-ns = <180>;
-		gpmc,wr-cycle-ns = <180>;
-		gpmc,bus-turnaround-ns = <0>;
-		gpmc,cycle2cycle-delay-ns = <0>;
-		gpmc,wait-monitoring-ns = <0>;
-		gpmc,clk-activation-ns = <0>;
-		gpmc,wr-access-ns = <0>;
-		gpmc,wr-data-mux-bus-ns = <12>;
-	};
 };
 
 &mcspi1 {

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
