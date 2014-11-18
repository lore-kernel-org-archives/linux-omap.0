From: Dmitry Lifshitz <lifshitz@compulab.co.il>
Subject: [PATCH 9/9] ARM: dts: cm-t3x30: add keypad support
Date: Tue, 18 Nov 2014 11:13:24 +0200
Message-ID: <1416302004-22199-10-git-send-email-lifshitz@compulab.co.il>
References: <1416302004-22199-1-git-send-email-lifshitz@compulab.co.il>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from softlayer.compulab.co.il ([50.23.254.55]:46698 "EHLO
	compulab.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753878AbaKRJNt (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 18 Nov 2014 04:13:49 -0500
In-Reply-To: <1416302004-22199-1-git-send-email-lifshitz@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Dmitry Lifshitz <lifshitz@compulab.co.il>

Add twl4030 matrtix keypad support.

Signed-off-by: Dmitry Lifshitz <lifshitz@compulab.co.il>
---
 arch/arm/boot/dts/omap3-cm-t3x30.dtsi |   17 +++++++++++++++++
 1 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/omap3-cm-t3x30.dtsi b/arch/arm/boot/dts/omap3-cm-t3x30.dtsi
index bcd896f..3a91204 100644
--- a/arch/arm/boot/dts/omap3-cm-t3x30.dtsi
+++ b/arch/arm/boot/dts/omap3-cm-t3x30.dtsi
@@ -78,6 +78,7 @@
 
 #include "twl4030.dtsi"
 #include "twl4030_omap3.dtsi"
+#include <dt-bindings/input/input.h>
 
 &mmc1 {
 	vmmc-supply = <&vmmc1>;
@@ -89,6 +90,22 @@
 	ti,pullups = <0x000001>;
 };
 
+&twl_keypad {
+	linux,keymap = <
+				MATRIX_KEY(0x00, 0x01, KEY_A)
+				MATRIX_KEY(0x00, 0x02, KEY_B)
+				MATRIX_KEY(0x00, 0x03, KEY_LEFT)
+
+				MATRIX_KEY(0x01, 0x01, KEY_UP)
+				MATRIX_KEY(0x01, 0x02, KEY_ENTER)
+				MATRIX_KEY(0x01, 0x03, KEY_DOWN)
+
+				MATRIX_KEY(0x02, 0x01, KEY_RIGHT)
+				MATRIX_KEY(0x02, 0x02, KEY_C)
+				MATRIX_KEY(0x02, 0x03, KEY_D)
+			>;
+};
+
 &hsusb1_phy {
 	reset-gpios = <&twl_gpio 6 GPIO_ACTIVE_LOW>;
 };
-- 
1.7.5.4

