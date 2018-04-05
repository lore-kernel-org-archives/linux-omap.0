From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH] ARM: dts: omap3-gta04: Add fixed 26MHz clock as fck for twl
Date: Thu,  5 Apr 2018 18:05:16 +0200
Message-ID: <c0b35797744a71df9d8088508814675cc5f07710.1522944315.git.hns@goldelico.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: letux-kernel@openphoenux.org, linux-omap <linux-omap@vger.kernel.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-kernel@vger.kernel.org, "H. Nikolaus Schaller" <hns@goldelico.com>
List-Id: linux-omap@vger.kernel.org

The board uses 26MHz oscillator for the twl4030 HFCLK.
This way we will not depend on the bootloader to configure the
CFG_BOOT:HFCLK_FREQ

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 arch/arm/boot/dts/omap3-gta04.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/omap3-gta04.dtsi b/arch/arm/boot/dts/omap3-gta04.dtsi
index 4170be70460e..ac830b917776 100644
--- a/arch/arm/boot/dts/omap3-gta04.dtsi
+++ b/arch/arm/boot/dts/omap3-gta04.dtsi
@@ -30,6 +30,13 @@
 		display0 = &lcd;
 	};
 
+	/* fixed 26MHz oscillator */
+	hfclk_26m: oscillator {
+		#clock-cells = <0>;
+		compatible = "fixed-clock";
+		clock-frequency = <26000000>;
+	};
+
 	gpio-keys {
 		compatible = "gpio-keys";
 
@@ -312,6 +319,9 @@
 		interrupts = <7>; /* SYS_NIRQ cascaded to intc */
 		interrupt-parent = <&intc>;
 
+		clocks = <&hfclk_26m>;
+		clock-names = "fck";
+
 		twl_audio: audio {
 			compatible = "ti,twl4030-audio";
 			ti,enable-vibra = <1>;
-- 
2.12.2
