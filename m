From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 2/3] ARM: dts: Add muxing for wl12xx on the SDIO bus for
 pandaboard
Date: Thu, 25 Apr 2013 20:52:13 -0700
Message-ID: <20130426035213.26065.63243.stgit@muffinssi.local>
References: <20130426034858.26065.65118.stgit@muffinssi.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:41623 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1759864Ab3DZDwQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Apr 2013 23:52:16 -0400
In-Reply-To: <20130426034858.26065.65118.stgit@muffinssi.local>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Luciano Coelho <coelho@ti.com>, devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, Benoit Cousson <b-cousson@ti.com>, Rajendra Nayak <rnayak@ti.com>

This is needed to get wl12xx working with device tree based
booting.

Note that we claim the various GPIO inputs in the regulator
as the proper muxing is needed to enable and disable the
regulator.

Also, we want to use non-removable instead of ti,non-removable
as the ti,non-removable also sets no_regulator_off_init which
is really not what we want as then wl12xx won't get powered
up and down which is needed for resetting it.

Cc: Luciano Coelho <coelho@ti.com>
Cc: Benoit Cousson <b-cousson@ti.com>
Cc: Rajendra Nayak <rnayak@ti.com>
Cc: devicetree-discuss@lists.ozlabs.org
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/boot/dts/omap4-panda-common.dtsi |   43 ++++++++++++++++++++++++++++-
 1 file changed, 42 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/omap4-panda-common.dtsi b/arch/arm/boot/dts/omap4-panda-common.dtsi
index 628f744..16b23bf 100644
--- a/arch/arm/boot/dts/omap4-panda-common.dtsi
+++ b/arch/arm/boot/dts/omap4-panda-common.dtsi
@@ -86,6 +86,19 @@
 		clock-names = "main_clk";
 		clock-frequency = <19200000>;
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
+		gpio = <&gpio2 11 0>;
+		startup-delay-us = <70000>;
+		enable-active-high;
+	};
 };
 
 &omap4_pmx_core {
@@ -185,6 +198,30 @@
 			0xf0 0x118     /* i2c4_sda PULLUP | INPUTENABLE | MODE0 */
 		>;
 	};
+
+	/* wl12xx GPIO outputs for WLAN_EN, BT_EN, FM_EN, BT_WAKEUP */
+	wl12xx_gpio: pinmux_wl12xx_gpio {
+		pinctrl-single,pins = <
+			0x26 0x3	/* gpmc_a19.gpio_43 OUTPUT | MODE3 */
+			0x2c 0x3	/* gpmc_a22.gpio_46 OUTPUT | MODE3 */
+			0x30 0xb	/* gpmc_a24.gpio_48 OUTPUT | MODE3 */
+			0x32 0xb	/* gpmc_a25.gpio_49 OUTPUT | MODE3 */
+		>;
+	};
+
+	/* wl12xx GPIO inputs and SDIO pins */
+	wl12xx_pins: pinmux_wl12xx_pins {
+		pinctrl-single,pins = <
+			0x38 0x103	/* gpmc_ncs2.gpio_52 INPUT | MODE3 */
+			0x3a 0x103	/* gpmc_ncs3.gpio_53 INPUT | MODE3 */
+			0x108 0x118	/* sdmmc5_clk.sdmmc5_clk INPUT_PULLUP | MODE0 */
+			0x10a 0x118	/* sdmmc5_cmd.sdmmc5_cmd INPUT_PULLUP | MODE0 */
+			0x10c 0x118	/* sdmmc5_dat0.sdmmc5_dat0 INPUT_PULLUP | MODE0 */
+			0x10e 0x118	/* sdmmc5_dat1.sdmmc5_dat1 INPUT_PULLUP | MODE0 */
+			0x110 0x118	/* sdmmc5_dat2.sdmmc5_dat2 INPUT_PULLUP | MODE0 */
+			0x112 0x118	/* sdmmc5_dat3.sdmmc5_dat3 INPUT_PULLUP | MODE0 */
+      		>;
+	};
 };
 
 &i2c1 {
@@ -264,8 +301,12 @@
 };
 
 &mmc5 {
-	ti,non-removable;
+	pinctrl-names = "default";
+	pinctrl-0 = <&wl12xx_pins>;
+	vmmc-supply = <&wl12xx_vmmc>;
+	non-removable;
 	bus-width = <4>;
+	cap-power-off-card;
 };
 
 &emif1 {

