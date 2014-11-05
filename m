From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 3/5] ARM: dts: Add twl keypad map for LDP
Date: Wed,  5 Nov 2014 10:35:48 -0800
Message-ID: <1415212550-24692-4-git-send-email-tony@atomide.com>
References: <1415212550-24692-1-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:19610 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751122AbaKESht (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Nov 2014 13:37:49 -0500
In-Reply-To: <1415212550-24692-1-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org

Looks like we're still missing the keypad map for LDP.
Let's add it since we have the binding now available
for the twl4030_keypad as otherwise we get the following
errors during the boot:

twl4030_keypad keypad.31: OF: linux,keymap property not defined
in /ocp/i2c@48070000/twl@48/keypad
twl4030_keypad keypad.31: Failed to build keymap
twl4030_keypad: probe of keypad.31 failed with error -2

Reported-by: Russell King <rmk+kernel@arm.linux.org.uk>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/boot/dts/omap3-ldp.dts | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm/boot/dts/omap3-ldp.dts b/arch/arm/boot/dts/omap3-ldp.dts
index f7a45de..77fee3f 100644
--- a/arch/arm/boot/dts/omap3-ldp.dts
+++ b/arch/arm/boot/dts/omap3-ldp.dts
@@ -7,6 +7,7 @@
  */
 /dts-v1/;
 
+#include <dt-bindings/input/input.h>
 #include "omap34xx.dtsi"
 #include "omap-gpmc-smsc911x.dtsi"
 
@@ -263,6 +264,26 @@
 	};
 };
 
+&twl_keypad {
+	linux,keymap = <MATRIX_KEY(0, 0, KEY_1)
+			MATRIX_KEY(0, 1, KEY_2)
+			MATRIX_KEY(0, 2, KEY_3)
+			MATRIX_KEY(1, 0, KEY_4)
+			MATRIX_KEY(1, 1, KEY_5)
+			MATRIX_KEY(1, 2, KEY_6)
+			MATRIX_KEY(1, 3, KEY_F5)
+			MATRIX_KEY(2, 0, KEY_7)
+			MATRIX_KEY(2, 1, KEY_8)
+			MATRIX_KEY(2, 2, KEY_9)
+			MATRIX_KEY(2, 3, KEY_F6)
+			MATRIX_KEY(3, 0, KEY_F7)
+			MATRIX_KEY(3, 1, KEY_0)
+			MATRIX_KEY(3, 2, KEY_F8)
+			MATRIX_KEY(5, 4, KEY_RESERVED)
+			MATRIX_KEY(4, 4, KEY_VOLUMEUP)
+			MATRIX_KEY(5, 5, KEY_VOLUMEDOWN)>;
+};
+
 &uart3 {
 	interrupts-extended = <&intc 74 &omap3_pmx_core OMAP3_UART3_RX>;
 };
-- 
2.1.1

