From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: [PATCH 4/4] ARM: dts: am335x-sl50: Fix audio codec setup.
Date: Sat, 16 Jan 2016 11:51:13 +0100
Message-ID: <1452941473-6349-5-git-send-email-enric.balletbo@collabora.com>
References: <1452941473-6349-1-git-send-email-enric.balletbo@collabora.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1452941473-6349-1-git-send-email-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Javier Martinez Canillas <javier@osg.samsung.com>, Linus Walleij <linus.walleij@linaro.org>, Pau Pajuel <ppajuel@gmail.com>
List-Id: linux-omap@vger.kernel.org

The MCLK is provided by an external clock of 24.576MHz.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---
 arch/arm/boot/dts/am335x-sl50.dts | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/am335x-sl50.dts b/arch/arm/boot/dts/am335x-sl50.dts
index 9e1dac6..a676869 100644
--- a/arch/arm/boot/dts/am335x-sl50.dts
+++ b/arch/arm/boot/dts/am335x-sl50.dts
@@ -67,12 +67,28 @@
 		default-brightness-level = <6>;
 	};
 
+	clocks {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		/* audio external oscillator */
+		tlv320aic3x_mclk: oscillator@0 {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency  = <24576000>;	/* 24.576MHz */
+		};
+	};
+
 	sound {
 		compatible = "ti,da830-evm-audio";
 		ti,model = "AM335x-SL50";
 		ti,audio-codec = <&audio_codec>;
 		ti,mcasp-controller = <&mcasp0>;
-		ti,codec-clock-rate = <12000000>;
+
+		clocks = <&tlv320aic3x_mclk>;
+		clock-names = "mclk";
+
 		ti,audio-routing =
 			"Headphone Jack",	"HPLOUT",
 			"Headphone Jack",	"HPROUT",
@@ -230,7 +246,7 @@
 			AM33XX_IOPAD(0x994, PIN_INPUT_PULLDOWN | MUX_MODE0)	/* mcasp0_fsx.mcasp0_fsx */
 			AM33XX_IOPAD(0x990, PIN_INPUT_PULLDOWN | MUX_MODE0)	/* mcasp0_aclkx.mcasp0_aclkx */
 			AM33XX_IOPAD(0x998, PIN_INPUT_PULLDOWN | MUX_MODE0)	/* mcasp0_axr0.mcasp0_axr0 */
-			AM33XX_IOPAD(0x99c, PIN_INPUT_PULLDOWN | MUX_MODE2)	/* mcasp0_ahclkr.mcasp0_axr2*/
+			AM33XX_IOPAD(0x99c, PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* mcasp0_ahclkr.mcasp0_axr2 */
 		>;
 	};
 
-- 
2.1.0
