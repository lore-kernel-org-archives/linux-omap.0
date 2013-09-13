From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 2/2] ARM: dts: Fix muxing and regulator for wl12xx on the
 SDIO bus for blaze
Date: Fri, 13 Sep 2013 12:09:57 -0700
Message-ID: <20130913190957.24617.95520.stgit@localhost>
References: <20130913190811.24617.97699.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:43914 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753384Ab3IMTKD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 13 Sep 2013 15:10:03 -0400
In-Reply-To: <20130913190811.24617.97699.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Rajendra Nayak <rnayak@ti.com>, devicetree-discuss@lists.ozlabs.org, Ruslan Bilovol <ruslan.bilovol@ti.com>, Benoit Cousson <bcousson@baylibre.com>, linux-omap@vger.kernel.org, Luciano Coelho <luca@coelho.fi>

Commit 76787b3b (ARM: OMAP2+: Remove board-4430sdp.c)
removed legacy booting in favor of device tree based booting
for 4430sdp. That caused the WLAN to stop working as the
related .dts entries fell through the cracks.

I don't have the "1283 PG 2.21 connectivity device" on my 4430sdp,
but the earlier version of this patch was tested by Luciano
Coelho. This version has left out the input logic for MMC CLK
line compared to the earlier version as that is not bidirectional,
and should be safe to do.

Cc: Benoit Cousson <bcousson@baylibre.com>
Cc: Rajendra Nayak <rnayak@ti.com>
Cc: Luciano Coelho <luca@coelho.fi>
Cc: Ruslan Bilovol <ruslan.bilovol@ti.com>
Cc: devicetree-discuss@lists.ozlabs.org
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/boot/dts/omap4-sdp.dts |   39 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 38 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/omap4-sdp.dts b/arch/arm/boot/dts/omap4-sdp.dts
index 7951b4e..4f78380 100644
--- a/arch/arm/boot/dts/omap4-sdp.dts
+++ b/arch/arm/boot/dts/omap4-sdp.dts
@@ -140,6 +140,19 @@
 			"DMic", "Digital Mic",
 			"Digital Mic", "Digital Mic1 Bias";
 	};
+
+	/* regulator for wl12xx on sdio5 */
+	wl12xx_vmmc: wl12xx_vmmc {
+		pinctrl-names = "default";
+		pinctrl-0 = <&wl12xx_gpio>;
+		compatible = "regulator-fixed";
+		regulator-name = "vwl1271";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		gpio = <&gpio2 22 0>;
+		startup-delay-us = <70000>;
+		enable-active-high;
+	};
 };
 
 &omap4_pmx_wkup {
@@ -295,6 +308,26 @@
 			0xf0 (PIN_INPUT_PULLUP | MUX_MODE0)	/* i2c4_sda */
 		>;
 	};
+
+	/* wl12xx GPIO output for WLAN_EN */
+	wl12xx_gpio: pinmux_wl12xx_gpio {
+		pinctrl-single,pins = <
+			0x3c (PIN_OUTPUT | MUX_MODE3)		/* gpmc_nwp.gpio_54 */
+		>;
+	};
+
+	/* wl12xx GPIO inputs and SDIO pins */
+	wl12xx_pins: pinmux_wl12xx_pins {
+		pinctrl-single,pins = <
+			0x3a (PIN_INPUT | MUX_MODE3)		/* gpmc_ncs3.gpio_53 */
+			0x108 (PIN_OUTPUT | MUX_MODE3)		/* sdmmc5_clk.sdmmc5_clk */
+			0x10a (PIN_INPUT_PULLUP | MUX_MODE3)	/* sdmmc5_cmd.sdmmc5_cmd */
+			0x10c (PIN_INPUT_PULLUP | MUX_MODE3)	/* sdmmc5_dat0.sdmmc5_dat0 */
+			0x10e (PIN_INPUT_PULLUP | MUX_MODE3)	/* sdmmc5_dat1.sdmmc5_dat1 */
+			0x110 (PIN_INPUT_PULLUP | MUX_MODE3)	/* sdmmc5_dat2.sdmmc5_dat2 */
+			0x112 (PIN_INPUT_PULLUP | MUX_MODE3)	/* sdmmc5_dat3.sdmmc5_dat3 */
+		>;
+	};
 };
 
 &i2c1 {
@@ -420,8 +453,12 @@
 };
 
 &mmc5 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&wl12xx_pins>;
+	vmmc-supply = <&wl12xx_vmmc>;
+	non-removable;
 	bus-width = <4>;
-	ti,non-removable;
+	cap-power-off-card;
 };
 
 &emif1 {

