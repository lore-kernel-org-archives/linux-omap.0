From: Uri Mashiach <uri.mashiach-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
Subject: [PATCH 3/3] ARM: dts: cm-t335: add audio support
Date: Wed, 30 Dec 2015 13:41:35 +0200
Message-ID: <1451475695-26921-4-git-send-email-uri.mashiach@compulab.co.il>
References: <1451475695-26921-1-git-send-email-uri.mashiach@compulab.co.il>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1451475695-26921-1-git-send-email-uri.mashiach-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Igor Grinberg <grinberg-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>, Uri Mashiach <uri.mashiach-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

The TLV320AIC23B codec is connected to the CPU by McASP controller 1 for
data and I2C0 for control.

Modifications:
- Enable and configure McASP controller 1.
- Add TLV320AIC23B codec pinmux.
- Add TLV320AIC23B codec configurations.
- Use simple-audio-card as CPU to codec glue.

Signed-off-by: Uri Mashiach <uri.mashiach-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
Acked-by: Igor Grinberg <grinberg-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
---
 arch/arm/boot/dts/am335x-cm-t335.dts | 69 ++++++++++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/arch/arm/boot/dts/am335x-cm-t335.dts b/arch/arm/boot/dts/am335x-cm-t335.dts
index f232322..080340e 100644
--- a/arch/arm/boot/dts/am335x-cm-t335.dts
+++ b/arch/arm/boot/dts/am335x-cm-t335.dts
@@ -56,6 +56,36 @@
 		brightness-levels = <0 51 53 56 62 75 101 152 255>;
 		default-brightness-level = <8>;
 	};
+
+	sound {
+		compatible = "simple-audio-card";
+		simple-audio-card,name = "cm-t335";
+
+		simple-audio-card,widgets =
+			"Microphone", "Mic Jack",
+			"Line", "Line In",
+			"Headphone", "Headphone Jack";
+
+		simple-audio-card,routing =
+			"Headphone Jack", "LHPOUT",
+			"Headphone Jack", "RHPOUT",
+			"LLINEIN", "Line In",
+			"RLINEIN", "Line In",
+			"MICIN", "Mic Jack";
+
+		simple-audio-card,format = "i2s";
+		simple-audio-card,bitclock-master = <&sound_master>;
+		simple-audio-card,frame-master = <&sound_master>;
+
+		simple-audio-card,cpu {
+			sound-dai = <&mcasp1>;
+		};
+
+		sound_master: simple-audio-card,codec {
+			sound-dai = <&tlv320aic23>;
+			system-clock-frequency = <12000000>;
+		};
+	};
 };
 
 &am33xx_pinmux {
@@ -283,6 +313,20 @@
 			AM33XX_IOPAD(0x9b4, PIN_OUTPUT | MUX_MODE7)
 		>;
 	};
+
+	/* TLV320AIC23B codec */
+	mcasp1_pins: pinmux_mcasp1_pins {
+		pinctrl-single,pins = <
+			/* MII1_CRS.mcasp1_aclkx */
+			AM33XX_IOPAD(0x90c, PIN_INPUT_PULLDOWN | MUX_MODE4)
+			/* MII1_RX_ER.mcasp1_fsx */
+			AM33XX_IOPAD(0x910, PIN_INPUT_PULLDOWN | MUX_MODE4)
+			/* MII1_COL.mcasp1_axr2 */
+			AM33XX_IOPAD(0x908, PIN_INPUT_PULLDOWN | MUX_MODE4)
+			/* RMII1_REF_CLK.mcasp1_axr3 */
+			AM33XX_IOPAD(0x944, PIN_INPUT_PULLDOWN | MUX_MODE4)
+		>;
+	};
 };
 
 &uart0 {
@@ -317,6 +361,13 @@ status = "okay";
 		compatible = "emmicro,em3027";
 		reg = <0x56>;
 	};
+	/* Audio codec */
+	tlv320aic23: codec@1a {
+		compatible = "ti,tlv320aic23";
+		reg = <0x1a>;
+		#sound-dai-cells= <0>;
+		status = "okay";
+	};
 };
 
 &usb {
@@ -495,3 +546,21 @@ status = "okay";
 	};
 };
 
+/* CPU audio */
+&mcasp1 {
+		pinctrl-names = "default";
+		pinctrl-0 = <&mcasp1_pins>;
+
+		op-mode = <0>;          /* MCASP_IIS_MODE */
+		tdm-slots = <2>;
+		/* 16 serializers */
+		num-serializer = <16>;
+		serial-dir = <  /* 0: INACTIVE, 1: TX, 2: RX */
+			0 0 2 1 0 0 0 0 0 0 0 0 0 0 0 0
+		>;
+		tx-num-evt = <1>;
+		rx-num-evt = <1>;
+
+		#sound-dai-cells= <0>;
+		status = "okay";
+};
-- 
2.5.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
