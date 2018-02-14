From: Sebastian Reichel <sebastian.reichel-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
Subject: [PATCHv4 4/4] ARM: dts: omap4-droid4: add soundcard
Date: Wed, 14 Feb 2018 23:07:41 +0100
Message-ID: <20180214220741.28306-5-sebastian.reichel@collabora.co.uk>
References: <20180214220741.28306-1-sebastian.reichel@collabora.co.uk>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20180214220741.28306-1-sebastian.reichel-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sebastian Reichel <sebastian.reichel-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Add sound support to Motorola Droid 4 using simple-soundcard
and CPCAP's audio codec. This does not yet correctly represent
the whole audio routing, since McBSP3 is also connected to
Bluetooth and MDM6600 modem (and probably also 4G modem).
These extra DAI links are not yet supported and have not been
tested.

Signed-off-by: Sebastian Reichel <sebastian.reichel-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
---
 arch/arm/boot/dts/omap4-droid4-xt894.dts | 84 ++++++++++++++++++++++++++++++++
 1 file changed, 84 insertions(+)

diff --git a/arch/arm/boot/dts/omap4-droid4-xt894.dts b/arch/arm/boot/dts/omap4-droid4-xt894.dts
index e11a24397163..bfb0e0ddc269 100644
--- a/arch/arm/boot/dts/omap4-droid4-xt894.dts
+++ b/arch/arm/boot/dts/omap4-droid4-xt894.dts
@@ -118,6 +118,26 @@
 
 		};
 	};
+
+	soundcard {
+		compatible = "audio-graph-card";
+		label = "Droid 4 Audio";
+
+		simple-graph-card,widgets =
+			"Speaker", "Earpiece",
+			"Speaker", "Loudspeaker",
+			"Headphone", "Headphone Jack",
+			"Microphone", "Internal Mic";
+
+		simple-graph-card,routing =
+			"Earpiece", "EP",
+			"Loudspeaker", "SPKR",
+			"Headphone Jack", "HSL",
+			"Headphone Jack", "HSR",
+			"MICR", "Internal Mic";
+
+		dais = <&mcbsp2_port>, <&mcbsp3_port>;
+	};
 };
 
 &dss {
@@ -515,6 +535,24 @@
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
@@ -600,3 +638,49 @@
 				  "0", "0", "1";
 	};
 };
+
+&mcbsp2 {
+	#sound-dai-cells = <0>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&mcbsp2_pins>;
+	status = "okay";
+
+	mcbsp2_port: port {
+		cpu_dai2: endpoint {
+			dai-format = "i2s";
+			remote-endpoint = <&cpcap_audio_codec0>;
+			frame-master = <&cpcap_audio_codec0>;
+			bitclock-master = <&cpcap_audio_codec0>;
+		};
+	};
+};
+
+&mcbsp3 {
+	#sound-dai-cells = <0>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&mcbsp3_pins>;
+	status = "okay";
+
+	mcbsp3_port: port {
+		cpu_dai3: endpoint {
+			dai-format = "dsp_a";
+			frame-master = <&cpcap_audio_codec1>;
+			bitclock-master = <&cpcap_audio_codec1>;
+			remote-endpoint = <&cpcap_audio_codec1>;
+		};
+	};
+};
+
+&cpcap_audio {
+	port@0 {
+		cpcap_audio_codec0: endpoint {
+			remote-endpoint = <&cpu_dai2>;
+		};
+	};
+
+	port@1 {
+		cpcap_audio_codec1: endpoint {
+			remote-endpoint = <&cpu_dai3>;
+		};
+	};
+};
-- 
2.15.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
