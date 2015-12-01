From: Dmitry Lifshitz <lifshitz-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
Subject: [PATCH V2 10/19] ARM: dts: am57xx: cl-som-am57x: add analog audio support
Date: Tue,  1 Dec 2015 20:03:12 +0200
Message-ID: <1448993001-19495-11-git-send-email-lifshitz@compulab.co.il>
References: <1448433590-1399-1-git-send-email-lifshitz@compulab.co.il>
 <1448993001-19495-1-git-send-email-lifshitz@compulab.co.il>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1448993001-19495-1-git-send-email-lifshitz-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Toni Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Igor Grinberg <grinberg-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>, Nikita Kiryanov <nikita-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, Dmitry Lifshitz <lifshitz-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Add analog audio DT nodes:

1. simple-audio-card node
2. wm8731 codec node
3. MCASP3 pinmux

Signed-off-by: Dmitry Lifshitz <lifshitz-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
Acked-by: Igor Grinberg <grinberg-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
---

  v2:

   * No fuctional changes
   * Reformat subject

 arch/arm/boot/dts/am57xx-cl-som-am57x.dts | 67 +++++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/arch/arm/boot/dts/am57xx-cl-som-am57x.dts b/arch/arm/boot/dts/am57xx-cl-som-am57x.dts
index a75c382..b2c4451 100644
--- a/arch/arm/boot/dts/am57xx-cl-som-am57x.dts
+++ b/arch/arm/boot/dts/am57xx-cl-som-am57x.dts
@@ -50,6 +50,33 @@
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
 	};
+
+	sound0: sound@0 {
+		compatible = "simple-audio-card";
+		simple-audio-card,name = "CL-SOM-AM57x-Sound-Card";
+		simple-audio-card,format = "i2s";
+		simple-audio-card,bitclock-master = <&dailink0_master>;
+		simple-audio-card,frame-master = <&dailink0_master>;
+		simple-audio-card,widgets =
+					"Headphone", "Headphone Jack",
+					"Microphone", "Microphone Jack",
+					"Line", "Line Jack";
+		simple-audio-card,routing =
+					"Headphone Jack", "RHPOUT",
+					"Headphone Jack", "LHPOUT",
+					"LLINEIN", "Line Jack",
+					"MICIN", "Mic Bias",
+					"Mic Bias", "Microphone Jack";
+
+		dailink0_master: simple-audio-card,cpu {
+			sound-dai = <&mcasp3>;
+		};
+
+		simple-audio-card,codec {
+			sound-dai = <&wm8731>;
+			system-clock-frequency = <12000000>;
+		};
+	};
 };
 
 &dra7_pmx_core {
@@ -196,6 +223,24 @@
 			DRA7XX_CORE_IOPAD(0x3464, PIN_INPUT_PULLDOWN | MUX_MODE14) /* gpmc_a9.gpio1_31 */
 		>;
 	};
+
+	mcasp3_pins_default: mcasp3_pins_default {
+		pinctrl-single,pins = <
+			DRA7XX_CORE_IOPAD(0x3724, PIN_INPUT_PULLDOWN | MUX_MODE0) /* mcasp3_aclkx.mcasp3_aclkx */
+			DRA7XX_CORE_IOPAD(0x3728, PIN_INPUT_PULLDOWN | MUX_MODE0) /* mcasp3_fsx.mcasp3_fsx */
+			DRA7XX_CORE_IOPAD(0x372c, PIN_OUTPUT_PULLDOWN | MUX_MODE0) /* mcasp3_axr0.mcasp3_axr0 */
+			DRA7XX_CORE_IOPAD(0x3730, PIN_INPUT_PULLDOWN | MUX_MODE0) /* mcasp3_axr1.mcasp3_axr1 */
+		>;
+	};
+
+	mcasp3_pins_sleep: mcasp3_pins_sleep {
+		pinctrl-single,pins = <
+			DRA7XX_CORE_IOPAD(0x3724, PIN_INPUT | MUX_MODE15)
+			DRA7XX_CORE_IOPAD(0x3728, PIN_INPUT | MUX_MODE15)
+			DRA7XX_CORE_IOPAD(0x372c, PIN_INPUT | MUX_MODE15)
+			DRA7XX_CORE_IOPAD(0x3730, PIN_INPUT | MUX_MODE15)
+		>;
+	};
 };
 
 &i2c1 {
@@ -392,6 +437,13 @@
 		reg = <0x50>;
 		pagesize = <16>;
 	};
+
+	wm8731: wm8731@1a {
+		#sound-dai-cells = <0>;
+		compatible = "wlf,wm8731";
+		reg = <0x1a>;
+		status = "okay";
+	};
 };
 
 &cpu0 {
@@ -538,3 +590,18 @@
 &usb2 {
 	dr_mode = "peripheral";
 };
+
+&mcasp3 {
+	#sound-dai-cells = <0>;
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&mcasp3_pins_default>;
+	pinctrl-1 = <&mcasp3_pins_sleep>;
+	status = "okay";
+
+	op-mode = <0>;	/* MCASP_IIS_MODE */
+	tdm-slots = <2>;
+	/* 4 serializers */
+	serial-dir = <	/* 0: INACTIVE, 1: TX, 2: RX */
+		1 2 0 0
+	>;
+};
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
