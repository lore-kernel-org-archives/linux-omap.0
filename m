From: Sebastian Reichel <sre@kernel.org>
Subject: [PATCH 5/5] ARM: dts: OMAP3-N950-N9: Enable modem
Date: Sun, 17 Jan 2016 16:49:09 +0100
Message-ID: <1453045749-22642-6-git-send-email-sre@kernel.org>
References: <1453045749-22642-1-git-send-email-sre@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1453045749-22642-1-git-send-email-sre@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Tony Lindgren <tony@atomide.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Paul Walmsley <paul@pwsan.com>, Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

The Nokia N950 and Nokia N9 have a modem attached to their
first ssi port. This change adds the modem to the SSI port.

Signed-off-by: Sebastian Reichel <sre@kernel.org>
---
 arch/arm/boot/dts/omap3-n9.dts       |  4 ++++
 arch/arm/boot/dts/omap3-n950-n9.dtsi | 40 ++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/omap3-n950.dts     |  4 ++++
 3 files changed, 48 insertions(+)

diff --git a/arch/arm/boot/dts/omap3-n9.dts b/arch/arm/boot/dts/omap3-n9.dts
index f2e213931e09..5c67429a4da7 100644
--- a/arch/arm/boot/dts/omap3-n9.dts
+++ b/arch/arm/boot/dts/omap3-n9.dts
@@ -53,3 +53,7 @@
 		};
 	};
 };
+
+&modem {
+	compatible = "nokia,n9-modem";
+};
diff --git a/arch/arm/boot/dts/omap3-n950-n9.dtsi b/arch/arm/boot/dts/omap3-n950-n9.dtsi
index 95893003c67d..a1930e511f71 100644
--- a/arch/arm/boot/dts/omap3-n950-n9.dtsi
+++ b/arch/arm/boot/dts/omap3-n950-n9.dtsi
@@ -57,6 +57,22 @@
 			OMAP3_CORE1_IOPAD(0x218a, PIN_OUTPUT | MUX_MODE1)            /* ssi1_wake */
 		>;
 	};
+
+	modem_pins1: pinmux_modem_core1_pins {
+		pinctrl-single,pins = <
+			OMAP3_CORE1_IOPAD(0x207a, PIN_INPUT | WAKEUP_EN | MUX_MODE4) /* gpio_34 (ape_rst_rq) */
+			OMAP3_CORE1_IOPAD(0x2100, PIN_OUTPUT | MUX_MODE4)            /* gpio_88 (cmt_rst_rq) */
+			OMAP3_CORE1_IOPAD(0x210a, PIN_OUTPUT | MUX_MODE4)            /* gpio_93 (cmt_apeslpx) */
+		>;
+	};
+};
+
+&omap3_pmx_core2 {
+	modem_pins2: pinmux_modem_core2_pins {
+		pinctrl-single,pins = <
+			OMAP3630_CORE2_IOPAD(0x25ec, PIN_OUTPUT | MUX_MODE4)         /* gpio_23 (cmt_en) */
+		>;
+	};
 };
 
 &i2c1 {
@@ -210,6 +226,30 @@
 	pinctrl-0 = <&ssi_pins>;
 
 	ti,ssi-cawake-gpio = <&gpio5 23 GPIO_ACTIVE_HIGH>; /* 151 */
+
+	modem: hsi-client {
+		pinctrl-names = "default";
+		pinctrl-0 = <&modem_pins1 &modem_pins2>;
+
+		hsi-channel-ids = <0>, <1>, <2>, <3>;
+		hsi-channel-names = "mcsaab-control",
+				    "speech-control",
+				    "speech-data",
+				    "mcsaab-data";
+		hsi-speed-kbps = <96000>;
+		hsi-mode = "frame";
+		hsi-flow = "synchronized";
+		hsi-arb-mode = "round-robin";
+
+		interrupts-extended = <&gpio2 2 IRQ_TYPE_EDGE_RISING>; /* gpio 34 */
+
+		gpios = <&gpio3 29 GPIO_ACTIVE_HIGH>, /* gpio 93 */
+			<&gpio3 24 GPIO_ACTIVE_HIGH>, /* gpio 88 */
+			<&gpio1 23 GPIO_ACTIVE_HIGH>; /* gpio 23 */
+		gpio-names = "cmt_apeslpx",
+			     "cmt_rst_rq",
+			     "cmt_en";
+	};
 };
 
 &ssi_port2 {
diff --git a/arch/arm/boot/dts/omap3-n950.dts b/arch/arm/boot/dts/omap3-n950.dts
index 0885b34d5d7d..21060d96c67d 100644
--- a/arch/arm/boot/dts/omap3-n950.dts
+++ b/arch/arm/boot/dts/omap3-n950.dts
@@ -53,3 +53,7 @@
 		};
 	};
 };
+
+&modem {
+	compatible = "nokia,n950-modem";
+};
-- 
2.7.0.rc3
