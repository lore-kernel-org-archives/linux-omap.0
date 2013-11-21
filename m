From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 3/3] ARM: OMAP2+: Fix eMMC on n900 with device tree
Date: Thu, 21 Nov 2013 15:57:29 -0800
Message-ID: <20131121235729.GD10023@atomide.com>
References: <1385059866-10646-1-git-send-email-tony@atomide.com>
 <1385059866-10646-4-git-send-email-tony@atomide.com>
 <20131121231751.GA9772@earth.universe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:19849 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752079Ab3KUX5d (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 21 Nov 2013 18:57:33 -0500
Content-Disposition: inline
In-Reply-To: <20131121231751.GA9772@earth.universe>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, Aaro Koskinen <aaro.koskinen@iki.fi>

* Sebastian Reichel <sre@debian.org> [131121 15:18]:
> Hi Tony,
> 
> On Thu, Nov 21, 2013 at 10:51:06AM -0800, Tony Lindgren wrote:
> > Looks like we need to configure the regulators and use the pdata
> > quirk to make eMMC work with device tree.
> > 
> > It seems that mostly vmmc2 is used, and only some earlier revisions
> > like the macro board used vaux3.
> > 
> > Note that we can add support for the macro board later as needed
> > by including the common n900 .dts file and configuring the vaux3
> > instead of vmmc2, and adding support for the smc91x Ethernet.
> >
> > ---
> > 
> > Can you guys please test this on production n900 devices?
> > 
> > I've tested it with my old macro board where I had to patch in vaux3
> > instead of vmmc2. I think there's some confusion in the legacy code
> > comments, or else I'm confused. In any case, vaux3 works for the macro
> > board, and I suspect that the production versions have vmmc2.
> > 
> > If this does not work and vaux3 as regulator works, please also dump
> > out the system_rev from your board.
> 
> The good news is, that I got eMMC working :) The bad news is, that it
> did not work with your patch :( I included my DTS nodes below. The
> phone is HW/System revision 0x2101.

Oh ok, I must have parsed the revisions wrong way then, and the macro
I tried it on must be something newer than I thought :)
 
> I have a second N900, which has HW revision 0x2204. I did not yet test
> the patch with this phone, but legacy code also seems to use vaux3 for
> it. Seems like we need two n900.dts files?

Well let's use just vaux3 then with a comment to the .dts file if that
works also on your 0x2204. It works on my 0x0010 too.

I folded in your changes to the updated patch below. Care to reply with
your Signed-off-by too assuming it works also on your 0x2204 n900?

Regards,

Tony 


From: Tony Lindgren <tony@atomide.com>
Date: Wed, 20 Nov 2013 18:03:39 -0800
Subject: [PATCH] ARM: OMAP2+: Fix eMMC on n900 with device tree

Looks like we need to configure the regulators and use the pdata
quirk to make eMMC work with device tree.

It seems that mostly vaux3 is used, and only some earlier revisions
used vmmc2. This has been tested to work on devices where the
system_rev passed by the bootloader has versions 0x0010 and 0x2101.

Cc: devicetree@vger.kernel.org
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Sebastian Reichel <sre@debian.org>
[tony@atomide.com: updated with pinctrl changes and comments from Sebastian]
Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/boot/dts/omap3-n900.dts b/arch/arm/boot/dts/omap3-n900.dts
index c4f20bf..c2c306d 100644
--- a/arch/arm/boot/dts/omap3-n900.dts
+++ b/arch/arm/boot/dts/omap3-n900.dts
@@ -125,6 +125,21 @@
 		>;
 	};
 
+	mmc2_pins: pinmux_mmc2_pins {
+		pinctrl-single,pins = <
+			0x128 (PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc2_clk */
+			0x12a (PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc2_cmd */
+			0x12c (PIN_INPUT_PULLUP | MUX_MODE0) 	/* sdmmc2_dat0 */
+			0x12e (PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc2_dat1 */
+			0x130 (PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc2_dat2 */
+			0x132 (PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc2_dat3 */
+			0x134 (PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc2_dat4 */
+			0x136 (PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc2_dat5 */
+			0x138 (PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc2_dat6 */
+			0x13a (PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc2_dat7 */
+		>;
+	};
+
 	display_pins: pinmux_display_pins {
 		pinctrl-single,pins = <
 			0x0d4 (PIN_OUTPUT | MUX_MODE4)		/* RX51_LCD_RESET_GPIO */
@@ -358,8 +373,14 @@
 	cd-gpios = <&gpio6 0 GPIO_ACTIVE_HIGH>; /* 160 */
 };
 
+/* most boards use vaux3, only some old versions use vmmc2 instead */
 &mmc2 {
-	status = "disabled";
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc2_pins>;
+	vmmc-supply = <&vaux3>;
+	vmmc_aux-supply = <&vsim>;
+	bus-width = <8>;
+	non-removable;
 };
 
 &mmc3 {
diff --git a/arch/arm/mach-omap2/pdata-quirks.c b/arch/arm/mach-omap2/pdata-quirks.c
index 10c7145..39f020c 100644
--- a/arch/arm/mach-omap2/pdata-quirks.c
+++ b/arch/arm/mach-omap2/pdata-quirks.c
@@ -139,6 +139,7 @@ struct of_dev_auxdata omap_auxdata_lookup[] __initdata = {
 
 static struct pdata_init pdata_quirks[] __initdata = {
 #ifdef CONFIG_ARCH_OMAP3
+	{ "nokia,omap3-n900", hsmmc2_internal_input_clk, },
 	{ "nokia,omap3-n9", hsmmc2_internal_input_clk, },
 	{ "nokia,omap3-n950", hsmmc2_internal_input_clk, },
 	{ "isee,omap3-igep0020", omap3_igep0020_legacy_init, },
