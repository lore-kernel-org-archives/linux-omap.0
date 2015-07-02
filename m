From: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 2/2] ARM: DTS: am437x-sk-evm: Switch using simple-audio-card for audio support
Date: Thu, 2 Jul 2015 14:58:06 +0300
Message-ID: <1435838286-30491-3-git-send-email-peter.ujfalusi@ti.com>
References: <1435838286-30491-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1435838286-30491-1-git-send-email-peter.ujfalusi-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

The sound support consist only Headset output on the board and can be
handled by "simple-audio-card"

Signed-off-by: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
---
 arch/arm/boot/dts/am437x-sk-evm.dts | 30 ++++++++++++++++++++++--------
 1 file changed, 22 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/am437x-sk-evm.dts b/arch/arm/boot/dts/am437x-sk-evm.dts
index b5de6b0d622c..e09216cb14df 100644
--- a/arch/arm/boot/dts/am437x-sk-evm.dts
+++ b/arch/arm/boot/dts/am437x-sk-evm.dts
@@ -32,14 +32,26 @@
 	};
 
 	sound {
-		compatible = "ti,da830-evm-audio";
-		ti,model = "AM437x-SK-EVM";
-		ti,audio-codec = <&tlv320aic3106>;
-		ti,mcasp-controller = <&mcasp1>;
-		ti,codec-clock-rate = <24000000>;
-		ti,audio-routing =
-			"Headphone Jack",       "HPLOUT",
-			"Headphone Jack",       "HPROUT";
+		compatible = "simple-audio-card";
+		simple-audio-card,name = "AM437x-SK-EVM";
+		simple-audio-card,widgets =
+			"Headphone", "Headphone Jack";
+		simple-audio-card,routing =
+			"Headphone Jack",	"HPLOUT",
+			"Headphone Jack",	"HPROUT";
+		simple-audio-card,format = "dsp_b";
+		simple-audio-card,bitclock-master = <&sound_master>;
+		simple-audio-card,frame-master = <&sound_master>;
+		simple-audio-card,bitclock-inversion;
+
+		simple-audio-card,cpu {
+			sound-dai = <&mcasp1>;
+		};
+
+		sound_master: simple-audio-card,codec {
+			sound-dai = <&tlv320aic3106>;
+			system-clock-frequency = <24000000>;
+		};
 	};
 
 	matrix_keypad: matrix_keypad@0 {
@@ -489,6 +501,7 @@
 	};
 
 	tlv320aic3106: tlv320aic3106@1b {
+		#sound-dai-cells = <0>;
 		compatible = "ti,tlv320aic3106";
 		reg = <0x1b>;
 		status = "okay";
@@ -649,6 +662,7 @@
 };
 
 &mcasp1 {
+	#sound-dai-cells = <0>;
 	pinctrl-names = "default", "sleep";
 	pinctrl-0 = <&mcasp1_pins>;
 	pinctrl-1 = <&mcasp1_pins_sleep>;
-- 
2.4.5

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
