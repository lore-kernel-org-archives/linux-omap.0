From: Sebastian Reichel <sre@kernel.org>
Subject: [RFC 6/7] ARM: dts: OMAP3-N900: Add bluetooth
Date: Sat, 13 Aug 2016 05:14:37 +0200
Message-ID: <1471058078-5579-7-git-send-email-sre@kernel.org>
References: <1471058078-5579-1-git-send-email-sre@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1471058078-5579-1-git-send-email-sre@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Marcel Holtmann <marcel@holtmann.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: Ville Tervo <ville.tervo@iki.fi>, =?UTF-8?q?Filip=20Matijevi=C4=87?= <filip.matijevic.pz@gmail.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Pavel Machek <pavel@ucw.cz>, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>, ivo.g.dimitrov.75@gmail.com, linux-bluetooth@vger.kernel.org, linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Add bcm2048 node and its system clock to the N900 device tree file.
Apart from that a reference to the new clock has been added to
wl1251 (which uses it, too).

Signed-off-by: Sebastian Reichel <sre@kernel.org>
---
 arch/arm/boot/dts/omap3-n900.dts | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/omap3-n900.dts b/arch/arm/boot/dts/omap3-n900.dts
index 1d7b1d0d471a..1dba4a64d8fd 100644
--- a/arch/arm/boot/dts/omap3-n900.dts
+++ b/arch/arm/boot/dts/omap3-n900.dts
@@ -155,6 +155,13 @@
 		compatible = "nokia,n900-ir";
 		pwms = <&pwm9 0 26316 0>; /* 38000 Hz */
 	};
+
+	/* controlled (enabled/disabled) directly by bcm2048 and wl1251 */
+	vctcxo: vctcxo {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <38400000>;
+	};
 };
 
 &omap3_pmx_core {
@@ -162,8 +169,10 @@
 
 	uart2_pins: pinmux_uart2_pins {
 		pinctrl-single,pins = <
-			OMAP3_CORE1_IOPAD(0x217a, PIN_INPUT | MUX_MODE0)		/* uart2_rx */
+			OMAP3_CORE1_IOPAD(0x2174, PIN_INPUT | MUX_MODE0)		/* uart2_cts */
+			OMAP3_CORE1_IOPAD(0x2176, PIN_OUTPUT | MUX_MODE0)		/* uart2_rts */
 			OMAP3_CORE1_IOPAD(0x2178, PIN_OUTPUT | MUX_MODE0)		/* uart2_tx */
+			OMAP3_CORE1_IOPAD(0x217a, PIN_INPUT | MUX_MODE0)		/* uart2_rx */
 		>;
 	};
 
@@ -917,6 +926,8 @@
 
 		interrupt-parent = <&gpio2>;
 		interrupts = <10 IRQ_TYPE_NONE>; /* gpio line 42 */
+
+		clocks = <&vctcxo>;
 	};
 };
 
@@ -937,6 +948,15 @@
 	interrupts-extended = <&intc 73 &omap3_pmx_core OMAP3_UART2_RX>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart2_pins>;
+
+	bcm2048: bluetooth {
+		compatible = "nokia,brcm,bcm2048";
+		reset-gpios = <&gpio3 27 GPIO_ACTIVE_HIGH>; /* 91 */
+		host-wakeup-gpios = <&gpio4 5 GPIO_ACTIVE_HIGH>; /* 101 */
+		bluetooth-wakeup-gpios = <&gpio2 5 GPIO_ACTIVE_HIGH>; /* 37 */
+		clocks = <&vctcxo>;
+		clock-names = "sysclk";
+	};
 };
 
 &uart3 {
-- 
2.8.1
