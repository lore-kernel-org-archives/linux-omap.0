From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 08/20] ARM: DTS: am43xx-epos-evm: Enable analog audio via simple-card
Date: Thu, 2 Jul 2015 17:06:23 +0300
Message-ID: <1435845995-19085-9-git-send-email-peter.ujfalusi@ti.com>
References: <1435845995-19085-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1435845995-19085-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, balbi@ti.com
List-Id: linux-omap@vger.kernel.org

Use simple card for audio support on ePOS-EVM.
The audio on the board is: McASP1 <-> tlv320aic3111 codec.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/boot/dts/am43x-epos-evm.dts | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/arch/arm/boot/dts/am43x-epos-evm.dts b/arch/arm/boot/dts/am43x-epos-evm.dts
index d171e734d3cf..86c2dfbe8875 100644
--- a/arch/arm/boot/dts/am43x-epos-evm.dts
+++ b/arch/arm/boot/dts/am43x-epos-evm.dts
@@ -106,6 +106,38 @@
 		brightness-levels = <0 51 53 56 62 75 101 152 255>;
 		default-brightness-level = <8>;
 	};
+
+	sound0: sound@0 {
+		compatible = "simple-audio-card";
+		simple-audio-card,name = "AM43-EPOS-EVM";
+		simple-audio-card,widgets =
+			"Microphone", "Microphone Jack",
+			"Headphone", "Headphone Jack",
+			"Speaker", "Speaker";
+		simple-audio-card,routing =
+			"MIC1LP", "Microphone Jack",
+			"MIC1RP", "Microphone Jack",
+			"MIC1LP", "MICBIAS",
+			"MIC1RP", "MICBIAS",
+			"Headphone Jack", "HPL",
+			"Headphone Jack", "HPR",
+			"Speaker", "SPL",
+			"Speaker", "SPR";
+		simple-audio-card,format = "dsp_b";
+		simple-audio-card,bitclock-master = <&sound0_master>;
+		simple-audio-card,frame-master = <&sound0_master>;
+		simple-audio-card,bitclock-inversion;
+
+		simple-audio-card,cpu {
+			sound-dai = <&mcasp1>;
+			system-clock-frequency = <12000000>;
+		};
+
+		sound0_master: simple-audio-card,codec {
+			sound-dai = <&tlv320aic3111>;
+			system-clock-frequency = <12000000>;
+		};
+	};
 };
 
 &am43xx_pinmux {
@@ -468,6 +500,7 @@
 	};
 
 	tlv320aic3111: tlv320aic3111@18 {
+		#sound-dai-cells = <0>;
 		compatible = "ti,tlv320aic3111";
 		reg = <0x18>;
 		status = "okay";
@@ -743,6 +776,7 @@
 };
 
 &mcasp1 {
+	#sound-dai-cells = <0>;
 	pinctrl-names = "default", "sleep";
 	pinctrl-0 = <&mcasp1_pins>;
 	pinctrl-1 = <&mcasp1_sleep_pins>;
-- 
2.4.5
