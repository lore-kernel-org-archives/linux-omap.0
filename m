From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: [PATCH 3/3] ARM: dts: omap4-droid4: add soundcard
Date: Fri,  7 Jul 2017 18:42:29 +0200
Message-ID: <20170707164229.5868-4-sebastian.reichel@collabora.co.uk>
References: <20170707164229.5868-1-sebastian.reichel@collabora.co.uk>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170707164229.5868-1-sebastian.reichel@collabora.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Sebastian Reichel <sebastian.reichel@collabora.co.uk>
List-Id: linux-omap@vger.kernel.org

Add sound support to Motorola Droid 4 using simple-soundcard
and CPCAP's audio codec. This does not yet correctly represent
the whole audio routing, since McBSP3 is also connected to
Bluetooth and MDM6600 modem (and probably also 4G modem).
These extra DAI links are not yet supported and have not been
tested.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
---
 arch/arm/boot/dts/omap4-droid4-xt894.dts | 76 ++++++++++++++++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/arch/arm/boot/dts/omap4-droid4-xt894.dts b/arch/arm/boot/dts/omap4-droid4-xt894.dts
index 10ca1c174995..642b7ed1713b 100644
--- a/arch/arm/boot/dts/omap4-droid4-xt894.dts
+++ b/arch/arm/boot/dts/omap4-droid4-xt894.dts
@@ -116,6 +116,50 @@
 
 		};
 	};
+
+	soundcard {
+		compatible = "simple-audio-card";
+		simple-audio-card,name = "Droid 4 Audio";
+
+		simple-audio-card,widgets =
+			"Speaker", "Earpiece",
+			"Speaker", "Loudspeaker",
+			"Headphone", "Headphone Jack",
+			"Microphone", "Internal Mic";
+
+		simple-audio-card,routing =
+			"Earpiece", "EP",
+			"Loudspeaker", "SPKR",
+			"Headphone Jack", "HSL",
+			"Headphone Jack", "HSR",
+			"MICR", "Internal Mic";
+
+		simple-audio-card,dai-link@0 {
+			format = "i2s";
+			frame-master = <&codec0>;
+			bitclock-master = <&codec0>;
+			cpu {
+				sound-dai = <&mcbsp2>;
+			};
+			codec0: codec {
+				sound-dai = <&cpcap_audio 0>;
+			};
+		};
+
+		simple-audio-card,dai-link@1 {
+			format = "dsp_a";
+			frame-master = <&codec1>;
+			bitclock-master = <&codec1>;
+			bitclock-inversion;
+
+			cpu {
+				sound-dai = <&mcbsp3>;
+			};
+			codec1: codec {
+				sound-dai = <&cpcap_audio 1>;
+			};
+		};
+	};
 };
 
 &dss {
@@ -479,6 +523,24 @@
 		OMAP4_IOPAD(0x112, PIN_OUTPUT_PULLUP | MUX_MODE5)	/* uart4_rts */
 		>;
 	};
+
+	mcbsp2_pins: pinmux_mcbsp2_pins {
+		pinctrl-single,pins = <
+		OMAP4_IOPAD(0x0f6, PIN_INPUT | MUX_MODE0)	/* abe_mcbsp2_clkx */
+		OMAP4_IOPAD(0x0f8, PIN_INPUT | MUX_MODE0)	/* abe_mcbsp2_dr */
+		OMAP4_IOPAD(0x0fa, PIN_OUTPUT | MUX_MODE0)	/* abe_mcbsp2_dx */
+		OMAP4_IOPAD(0x0fc, PIN_INPUT | MUX_MODE0)	/* abe_mcbsp2_fsx */
+		>;
+	};
+
+	mcbsp3_pins: pinmux_mcbsp3_pins {
+		pinctrl-single,pins = <
+		OMAP4_IOPAD(0x106, PIN_INPUT | MUX_MODE1)	/* abe_mcbsp3_dr */
+		OMAP4_IOPAD(0x108, PIN_OUTPUT | MUX_MODE1)	/* abe_mcbsp3_dx */
+		OMAP4_IOPAD(0x10a, PIN_INPUT | MUX_MODE1)	/* abe_mcbsp3_clkx */
+		OMAP4_IOPAD(0x10c, PIN_INPUT | MUX_MODE1)	/* abe_mcbsp3_fsx */
+		>;
+	};
 };
 
 &omap4_pmx_wkup {
@@ -552,3 +614,17 @@
 				  "0", "0", "1";
 	};
 };
+
+&mcbsp2 {
+	#sound-dai-cells = <0>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&mcbsp2_pins>;
+	status = "okay";
+};
+
+&mcbsp3 {
+	#sound-dai-cells = <0>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&mcbsp3_pins>;
+	status = "okay";
+};
-- 
2.13.2
