From: Yong Li <yong.b.li@intel.com>
Subject: [PATCH] ARM: dts: am335x-boneblack: add i2c1 DT entry
Date: Thu,  2 Jun 2016 15:41:50 +0800
Message-ID: <1464853310-8738-1-git-send-email-yong.b.li@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: bcousson@baylibre.com, tony@atomide.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux@arm.linux.org.uk, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: sdliyong@gmail.com
List-Id: linux-omap@vger.kernel.org

From: Yong Li <sdliyong@gmail.com>

Without this patch, I2C-1 is missing on beaglebone black boards

Signed-off-by: Yong Li <sdliyong@gmail.com>
---
 arch/arm/boot/dts/am335x-boneblack.dts | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm/boot/dts/am335x-boneblack.dts b/arch/arm/boot/dts/am335x-boneblack.dts
index 55c0e95..7eee5c4 100644
--- a/arch/arm/boot/dts/am335x-boneblack.dts
+++ b/arch/arm/boot/dts/am335x-boneblack.dts
@@ -64,6 +64,13 @@
 			AM33XX_IOPAD(0x9b0, PIN_OUTPUT_PULLDOWN | MUX_MODE3)	/* xdma_event_intr0 */
 		>;
 	};
+
+	i2c1_pins: pinmux_i2c1_pins {
+		pinctrl-single,pins = <
+			AM33XX_IOPAD(0x958, PIN_INPUT_PULLUP | MUX_MODE2)       /* spi0_d1.i2c1_sda */
+			AM33XX_IOPAD(0x95c, PIN_INPUT_PULLUP | MUX_MODE2)       /* spi0_cs0.i2c1_scl */
+		>;
+	};
 };
 
 &lcdc {
@@ -91,6 +98,14 @@
 	};
 };
 
+&i2c1 {
+       pinctrl-names = "default";
+       pinctrl-0 = <&i2c2_pins>;
+
+       status = "okay";
+       clock-frequency = <100000>;
+};
+
 &rtc {
 	system-power-controller;
 };
-- 
2.7.4
