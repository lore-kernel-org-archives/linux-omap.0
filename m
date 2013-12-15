From: Sebastian Reichel <sre@debian.org>
Subject: [RFCv4 10/11] DTS: ARM: OMAP3-N900: Add CMT support
Date: Mon, 16 Dec 2013 00:28:03 +0100
Message-ID: <1387150085-23173-11-git-send-email-sre@debian.org>
References: <1387150085-23173-1-git-send-email-sre@debian.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1387150085-23173-1-git-send-email-sre@debian.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@ring0.de>, Linus Walleij <linus.walleij@linaro.org>, Shubhrajyoti Datta <omaplinuxkernel@gmail.com>, Carlos Chinea <cch.devel@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, Grant Likely <grant.likely@linaro.org>, Rob Herring <rob.herring@calxeda.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Rob Landley <rob@landley.net>, =?UTF-8?q?=27Beno=C3=AEt=20Cousson=27?= <bcousson@baylibre.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>, =?UTF-8?q?=D0=98=D0=B2=D0=B0=D0=B9=D0=BB=D0=BE=20=D0=94=D0=B8=D0=BC=D0=B8=D1=82=D1=80=D0=BE=D0=B2?= <freemangordon@abv.bg>, Joni Lapilainen <joni.lapilainen@gmail.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Sebastian Reichel <sre@debian.org>
List-Id: linux-omap@vger.kernel.org

This adds support for the Nokia N900 cellular modem.

Signed-off-by: Sebastian Reichel <sre@debian.org>
---
 arch/arm/boot/dts/omap3-n900.dts | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/arch/arm/boot/dts/omap3-n900.dts b/arch/arm/boot/dts/omap3-n900.dts
index 52f5099..c557a77 100644
--- a/arch/arm/boot/dts/omap3-n900.dts
+++ b/arch/arm/boot/dts/omap3-n900.dts
@@ -74,6 +74,26 @@
 		};
 	};
 
+	cmt: nokia-cmt {
+		compatible = "nokia,cmt";
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&cmt_pins>;
+
+		interrupt-parent = <&gpio3>;
+		interrupts = <8 IRQ_TYPE_EDGE_FALLING>; /* gpio line 72 */
+
+		gpios = <&gpio3  6 GPIO_ACTIVE_HIGH>, /* 70 */
+			<&gpio3  9 GPIO_ACTIVE_HIGH>, /* 73 */
+			<&gpio3 10 GPIO_ACTIVE_HIGH>, /* 74 */
+			<&gpio3 11 GPIO_ACTIVE_HIGH>, /* 75 */
+			<&gpio5 29 GPIO_ACTIVE_HIGH>; /* 157 */
+		gpio-names = "cmt_apeslpx",
+			     "cmt_rst_rq",
+			     "cmt_en",
+			     "cmt_rst",
+			     "cmt_bsi";
+	};
 };
 
 &omap3_pmx_core {
@@ -158,6 +178,17 @@
 			0x15a (PIN_OUTPUT | MUX_MODE1)		/* ssi1_wake */
 		>;
 	};
+
+	cmt_pins: pinmux_cmt {
+		pinctrl-single,pins = <
+			0x0ac (PIN_OUTPUT | MUX_MODE4)		/* gpio 70 => cmt_apeslpx */
+			0x0b0 (PIN_INPUT | WAKEUP_EN | MUX_MODE4) /* gpio 72 => ape_rst_rq */
+			0x0b2 (PIN_OUTPUT | MUX_MODE4)		/* gpio 73 => cmt_rst_rq */
+			0x0b4 (PIN_OUTPUT | MUX_MODE4)		/* gpio 74 => cmt_en */
+			0x0b6 (PIN_OUTPUT | MUX_MODE4)		/* gpio 75 => cmt_rst */
+			0x15e (PIN_OUTPUT | MUX_MODE4)		/* gpio 157 => cmt_bsi */
+		>;
+	};
 };
 
 &i2c1 {
-- 
1.8.5.1
