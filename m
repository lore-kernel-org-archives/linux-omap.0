From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: [PATCHv5 5/5] ARM: dts: omap4-droid4: add soundcard
Date: Fri, 23 Feb 2018 21:02:54 +0100
Message-ID: <20180223200254.25685-6-sebastian.reichel@collabora.co.uk>
References: <20180223200254.25685-1-sebastian.reichel@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20180223200254.25685-1-sebastian.reichel@collabora.co.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sebastian Reichel <sre@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>, Lee Jones <lee.jones@linaro.org>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, kernel@collabora.com, Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org, Sebastian Reichel <sebastian.reichel@collabora.co.uk>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Add sound support to Motorola Droid 4 using simple-soundcard
and CPCAP's audio codec. This does not yet correctly represent
the whole audio routing, since McBSP3 is also connected to
Bluetooth and MDM6600 modem (and probably also 4G modem).
These extra DAI links are not yet supported and have not been
tested.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
---
 arch/arm/boot/dts/omap4-droid4-xt894.dts | 78 ++++++++++++++++++++++++++++++++
 1 file changed, 78 insertions(+)

diff --git a/arch/arm/boot/dts/omap4-droid4-xt894.dts b/arch/arm/boot/dts/omap4-droid4-xt894.dts
index e11a24397163..fc30d375883a 100644
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
@@ -600,3 +638,43 @@
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
+&cpcap_audio_codec0 {
+	remote-endpoint = <&cpu_dai2>;
+};
+
+&cpcap_audio_codec1 {
+	remote-endpoint = <&cpu_dai3>;
+};
-- 
2.16.1
