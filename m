From: Marek Belisko <marek@goldelico.com>
Subject: [PATCH] ARM: dts: omap3-gta04: Add GSM audio support
Date: Thu,  7 May 2015 21:35:05 +0200
Message-ID: <1431027305-17627-1-git-send-email-marek@goldelico.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: bcousson@baylibre.com, tony@atomide.com
Cc: linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, hns@goldelico.com, Marek Belisko <marek@goldelico.com>
List-Id: linux-omap@vger.kernel.org

Add voice audio card which is used for telephony on gta04 board.
gtm601 codec is UMTS modem with pcm interface which get samples from
microphone and provide data from other party side. Use simple audio card
to describe audio card.

Signed-off-by: Marek Belisko <marek@goldelico.com>
---
 arch/arm/boot/dts/omap3-gta04.dtsi | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm/boot/dts/omap3-gta04.dtsi b/arch/arm/boot/dts/omap3-gta04.dtsi
index b9f6881..a3a4156 100644
--- a/arch/arm/boot/dts/omap3-gta04.dtsi
+++ b/arch/arm/boot/dts/omap3-gta04.dtsi
@@ -48,6 +48,28 @@
 		ti,mcbsp = <&mcbsp2>;
 	};
 
+	 /* GSM audio */
+	sound_telephony {
+		compatible = "simple-audio-card";
+		simple-audio-card,name = "GTA04 voice";
+		simple-audio-card,bitclock-master = <&telephony_link_master>;
+		simple-audio-card,frame-master = <&telephony_link_master>;
+		simple-audio-card,format = "i2s";
+
+		simple-audio-card,cpu {
+			sound-dai = <&mcbsp4>;
+		};
+
+		telephony_link_master: simple-audio-card,codec {
+			sound-dai = <&gtm601_codec>;
+		};
+	};
+
+	gtm601_codec: gsm_codec {
+		compatible = "option,gtm601";
+		#sound-dai-cells = <0>;
+	};
+
 	spi_lcd {
 		compatible = "spi-gpio";
 		#address-cells = <0x1>;
@@ -517,3 +539,7 @@
 &mcbsp2 {
 	status = "okay";
 };
+
+&mcbsp4 {
+	status = "okay";
+};
-- 
1.9.1
