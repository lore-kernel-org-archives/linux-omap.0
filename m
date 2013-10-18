From: Eric Witcher <ewitcher@mindspring.com>
Subject: [PATCH] ARM: dts: omap5-uevm: fix mcspi node pin descriptions
Date: Fri, 18 Oct 2013 02:42:34 -0400
Message-ID: <1382078554-31628-1-git-send-email-ewitcher@mindspring.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from elasmtp-mealy.atl.sa.earthlink.net ([209.86.89.69]:38496 "EHLO
	elasmtp-mealy.atl.sa.earthlink.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751783Ab3JTVCu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sun, 20 Oct 2013 17:02:50 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: nm@ti.com, bcousson@baylibre.com, linux-omap@vger.kernel.org, devicetree@vger.kernel.org

Correct mcspi pin descriptions to match corresponding node name and
add chip select number to be consistent with OMAP5 TRM.

Signed-off-by: Eric Witcher <ewitcher@mindspring.com>
---
 arch/arm/boot/dts/omap5-uevm.dts | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/arm/boot/dts/omap5-uevm.dts b/arch/arm/boot/dts/omap5-uevm.dts
index d784b3a..90c7843 100644
--- a/arch/arm/boot/dts/omap5-uevm.dts
+++ b/arch/arm/boot/dts/omap5-uevm.dts
@@ -131,25 +131,25 @@
 			0xbc (PIN_INPUT | MUX_MODE0)		/*  mcspi2_clk */
 			0xbe (PIN_INPUT | MUX_MODE0)		/*  mcspi2_simo */
 			0xc0 (PIN_INPUT_PULLUP | MUX_MODE0)	/*  mcspi2_somi */
-			0xc2 (PIN_OUTPUT | MUX_MODE0)		/*  mcspi2_cs */
+			0xc2 (PIN_OUTPUT | MUX_MODE0)		/*  mcspi2_cs0 */
 		>;
 	};
 
 	mcspi3_pins: pinmux_mcspi3_pins {
 		pinctrl-single,pins = <
-			0x78 (PIN_INPUT | MUX_MODE1)		/*  mcspi2_somi */
-			0x7a (PIN_INPUT | MUX_MODE1)		/*  mcspi2_cs */
-			0x7c (PIN_INPUT | MUX_MODE1)		/*  mcspi2_simo */
-			0x7e (PIN_INPUT | MUX_MODE1)		/*  mcspi2_clk */
+			0x78 (PIN_INPUT | MUX_MODE1)		/*  mcspi3_somi */
+			0x7a (PIN_INPUT | MUX_MODE1)		/*  mcspi3_cs0 */
+			0x7c (PIN_INPUT | MUX_MODE1)		/*  mcspi3_simo */
+			0x7e (PIN_INPUT | MUX_MODE1)		/*  mcspi3_clk */
 		>;
 	};
 
 	mcspi4_pins: pinmux_mcspi4_pins {
 		pinctrl-single,pins = <
-			0x164 (PIN_INPUT | MUX_MODE1)		/*  mcspi2_clk */
-			0x168 (PIN_INPUT | MUX_MODE1)		/*  mcspi2_simo */
-			0x16a (PIN_INPUT | MUX_MODE1)		/*  mcspi2_somi */
-			0x16c (PIN_INPUT | MUX_MODE1)		/*  mcspi2_cs */
+			0x164 (PIN_INPUT | MUX_MODE1)		/*  mcspi4_clk */
+			0x168 (PIN_INPUT | MUX_MODE1)		/*  mcspi4_simo */
+			0x16a (PIN_INPUT | MUX_MODE1)		/*  mcspi4_somi */
+			0x16c (PIN_INPUT | MUX_MODE1)		/*  mcspi4_cs0 */
 		>;
 	};
 
-- 
1.7.11.7

