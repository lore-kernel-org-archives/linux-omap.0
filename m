From: Sebastian Reichel <sre@kernel.org>
Subject: [PATCH 1/2] ARM: dts: OMAP3-N950-N9: Add ssi idle pinctrl state
Date: Sun, 31 Jan 2016 01:52:37 +0100
Message-ID: <1454201558-31285-2-git-send-email-sre@kernel.org>
References: <1454201558-31285-1-git-send-email-sre@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1454201558-31285-1-git-send-email-sre@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Tony Lindgren <tony@atomide.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

This adds an idle pinctrl state, which will be used
by the driver to avoid incoming data during clock
rate changes or data flushing.

Signed-off-By: Sebastian Reichel <sre@kernel.org>
---
 arch/arm/boot/dts/omap3-n950-n9.dtsi | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/omap3-n950-n9.dtsi b/arch/arm/boot/dts/omap3-n950-n9.dtsi
index aa8232828155..66c65e8008ef 100644
--- a/arch/arm/boot/dts/omap3-n950-n9.dtsi
+++ b/arch/arm/boot/dts/omap3-n950-n9.dtsi
@@ -73,6 +73,19 @@
 		>;
 	};
 
+	ssi_pins_idle: pinmux_ssi_pins_idle {
+		pinctrl-single,pins = <
+			OMAP3_CORE1_IOPAD(0x217c, PIN_OUTPUT | MUX_MODE7)            /* ssi1_dat_tx */
+			OMAP3_CORE1_IOPAD(0x217e, PIN_OUTPUT | MUX_MODE7)            /* ssi1_flag_tx */
+			OMAP3_CORE1_IOPAD(0x2180, PIN_INPUT_PULLDOWN | MUX_MODE7)    /* ssi1_rdy_tx */
+			OMAP3_CORE1_IOPAD(0x2182, PIN_INPUT | WAKEUP_EN | MUX_MODE4) /* ssi1_wake_tx (cawake) */
+			OMAP3_CORE1_IOPAD(0x2184, PIN_INPUT | MUX_MODE7)             /* ssi1_dat_rx */
+			OMAP3_CORE1_IOPAD(0x2186, PIN_INPUT | MUX_MODE7)             /* ssi1_flag_rx */
+			OMAP3_CORE1_IOPAD(0x2188, PIN_OUTPUT | MUX_MODE4)            /* ssi1_rdy_rx */
+			OMAP3_CORE1_IOPAD(0x218a, PIN_OUTPUT | MUX_MODE7)            /* ssi1_wake */
+		>;
+	};
+
 	modem_pins1: pinmux_modem_core1_pins {
 		pinctrl-single,pins = <
 			OMAP3_CORE1_IOPAD(0x207a, PIN_INPUT | WAKEUP_EN | MUX_MODE4) /* gpio_34 (ape_rst_rq) */
@@ -237,8 +250,9 @@
 };
 
 &ssi_port1 {
-	pinctrl-names = "default";
+	pinctrl-names = "default", "idle";
 	pinctrl-0 = <&ssi_pins>;
+	pinctrl-1 = <&ssi_pins_idle>;
 
 	ti,ssi-cawake-gpio = <&gpio5 23 GPIO_ACTIVE_HIGH>; /* 151 */
 
-- 
2.7.0.rc3
