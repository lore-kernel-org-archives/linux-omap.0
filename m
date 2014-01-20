From: Nishanth Menon <nm@ti.com>
Subject: [PATCH] ARM: dts: omap3-ldp: fix mmc configuration
Date: Mon, 20 Jan 2014 17:34:33 -0600
Message-ID: <1390260873-22354-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:42361 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753223AbaATXfD (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 20 Jan 2014 18:35:03 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Balaji T K <balajitk@ti.com>, Tony Lindgren <tony@atomide.com>
Cc: devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Nishanth Menon <nm@ti.com>

MMC1 is the only MMC interface available on the platform. Further,
since the platform is based on older revision of SoC which is not
capable of doing multi-block writes, mark it so and add pinmux
to ensure that all relevant pins are configured for non-MMC boot
mode.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
ti,erratum-2.1.1.128 introduced in https://patchwork.kernel.org/patch/3514851/
hence depends on the same.
 arch/arm/boot/dts/omap3-ldp.dts |   22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm/boot/dts/omap3-ldp.dts b/arch/arm/boot/dts/omap3-ldp.dts
index ddce0d8..bc0cc66 100644
--- a/arch/arm/boot/dts/omap3-ldp.dts
+++ b/arch/arm/boot/dts/omap3-ldp.dts
@@ -176,6 +176,17 @@
 &mmc1 {
 	vmmc-supply = <&vmmc1>;
 	bus-width = <4>;
+	ti,erratum-2.1.1.128;
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc1_pins>;
+};
+
+&mmc2 {
+	status="disabled";
+};
+
+&mmc3 {
+	status="disabled";
 };
 
 &omap3_pmx_core {
@@ -209,6 +220,17 @@
 			0x174 (PIN_OUTPUT | MUX_MODE0)	/* hsusb0_stp.hsusb0_stp */
 		>;
 	};
+
+	mmc1_pins: pinmux_mmc1_pins {
+		pinctrl-single,pins = <
+			OMAP3_CORE1_IOPAD(0x2144, PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc1_clk.mmc1_clk */
+			OMAP3_CORE1_IOPAD(0x2146, PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc1_cmd.mmc1_cmd */
+			OMAP3_CORE1_IOPAD(0x2148, PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc1_dat0.mmc1_dat0 */
+			OMAP3_CORE1_IOPAD(0x214A, PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc1_dat1.mmc1_dat1 */
+			OMAP3_CORE1_IOPAD(0x214C, PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc1_dat2.mmc1_dat2 */
+			OMAP3_CORE1_IOPAD(0x214e, PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc1_dat3.mmc1_dat3 */
+		>;
+	};
 };
 
 &usb_otg_hs {
-- 
1.7.9.5

