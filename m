From: Enric Balletbo i Serra <eballetbo@gmail.com>
Subject: [PATCH] ARM: dts: igep00x0: Add pinmux configuration for MCBSP2.
Date: Tue, 10 Sep 2013 17:35:23 +0200
Message-ID: <1378827323-15433-1-git-send-email-eballetbo@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ee0-f51.google.com ([74.125.83.51]:59449 "EHLO
	mail-ee0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752818Ab3IJPfd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Sep 2013 11:35:33 -0400
Received: by mail-ee0-f51.google.com with SMTP id c1so3917201eek.24
        for <linux-omap@vger.kernel.org>; Tue, 10 Sep 2013 08:35:32 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, Benoit Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Javier Martinez Canillas <martinez.javier@gmail.com>
Cc: Enric Balletbo i Serra <eballetbo@gmail.com>

Add pinmux configuration for MCBSP2 connected to the TDM interface. With
this configuration the Headset modules works as expected.

Signed-off-by: Enric Balletbo i Serra <eballetbo@gmail.com>
Acked-by: Javier Martinez Canillas <javier@dowhile0.org>
---
 arch/arm/boot/dts/omap3-igep.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/omap3-igep.dtsi b/arch/arm/boot/dts/omap3-igep.dtsi
index bc48b11..2326d11 100644
--- a/arch/arm/boot/dts/omap3-igep.dtsi
+++ b/arch/arm/boot/dts/omap3-igep.dtsi
@@ -48,6 +48,15 @@
 		>;
 	};
 
+	mcbsp2_pins: pinmux_mcbsp2_pins {
+		pinctrl-single,pins = <
+			0x10c (PIN_INPUT | MUX_MODE0)		/* mcbsp2_fsx.mcbsp2_fsx */
+			0x10e (PIN_INPUT | MUX_MODE0)		/* mcbsp2_clkx.mcbsp2_clkx */
+			0x110 (PIN_INPUT | MUX_MODE0)		/* mcbsp2_dr.mcbsp2.dr */
+			0x112 (PIN_OUTPUT | MUX_MODE0)		/* mcbsp2_dx.mcbsp2_dx */
+		>;
+	};
+
 	mmc1_pins: pinmux_mmc1_pins {
 		pinctrl-single,pins = <
 			0x114 (PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc1_clk.sdmmc1_clk */
@@ -93,6 +102,11 @@
 	clock-frequency = <400000>;
 };
 
+&mcbsp2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mcbsp2_pins>;
+};
+
 &mmc1 {
       pinctrl-names = "default";
       pinctrl-0 = <&mmc1_pins>;
-- 
1.8.1.2

