From: Dmitry Lifshitz <lifshitz@compulab.co.il>
Subject: [PATCH 1/4] ARM: dts: cm-t3x: add I2C1 pinmux
Date: Sun, 23 Nov 2014 11:41:59 +0200
Message-ID: <1416735722-26167-2-git-send-email-lifshitz@compulab.co.il>
References: <1416735722-26167-1-git-send-email-lifshitz@compulab.co.il>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from softlayer.compulab.co.il ([50.23.254.55]:59504 "EHLO
	compulab.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751390AbaKWJm1 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 23 Nov 2014 04:42:27 -0500
In-Reply-To: <1416735722-26167-1-git-send-email-lifshitz@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Dmitry Lifshitz <lifshitz@compulab.co.il>

Add missing I2C1 pinmux setup.

Signed-off-by: Dmitry Lifshitz <lifshitz@compulab.co.il>
---
 arch/arm/boot/dts/omap3-cm-t3x.dtsi |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/omap3-cm-t3x.dtsi b/arch/arm/boot/dts/omap3-cm-t3x.dtsi
index 3a98ce1..620a3f4 100644
--- a/arch/arm/boot/dts/omap3-cm-t3x.dtsi
+++ b/arch/arm/boot/dts/omap3-cm-t3x.dtsi
@@ -137,6 +137,13 @@
 			OMAP3_CORE1_IOPAD(0x21ce, PIN_INPUT_PULLDOWN | MUX_MODE0) /* mcspi1_cs0 */
 		>;
 	};
+
+	i2c1_pins: pinmux_i2c1_pins {
+		pinctrl-single,pins = <
+			OMAP3_CORE1_IOPAD(0x21ba, PIN_INPUT_PULLUP | MUX_MODE0)	/* i2c1_scl */
+			OMAP3_CORE1_IOPAD(0x21bc, PIN_INPUT_PULLUP | MUX_MODE0)	/* i2c1_sda */
+		>;
+	};
 };
 
 &uart3 {
@@ -155,6 +162,9 @@
 };
 
 &i2c1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c1_pins>;
+
 	clock-frequency = <400000>;
 
 	at24@50 {
-- 
1.7.5.4

