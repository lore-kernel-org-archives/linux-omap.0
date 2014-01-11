From: Sebastian Reichel <sre@debian.org>
Subject: [PATCH 2/6] DTS: ARM: OMAP3-N900: Add TWL4030 Keypad Matrix
Date: Sat, 11 Jan 2014 22:16:59 +0100
Message-ID: <1389475023-11616-3-git-send-email-sre@debian.org>
References: <1389475023-11616-1-git-send-email-sre@debian.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ring0.de ([91.143.88.219]:51002 "EHLO smtp.ring0.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751317AbaAKVRi (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 11 Jan 2014 16:17:38 -0500
In-Reply-To: <1389475023-11616-1-git-send-email-sre@debian.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <bcousson@baylibre.com>
Cc: linux-omap@vger.kernel.org, Sebastian Reichel <sre@debian.org>

Add Keyboard Matrix information to N900's DTS file.
This patch maps the keys exactly as the original
board code.

Signed-off-by: Sebastian Reichel <sre@debian.org>
---
 arch/arm/boot/dts/omap3-n900.dts | 55 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/arch/arm/boot/dts/omap3-n900.dts b/arch/arm/boot/dts/omap3-n900.dts
index 6fc85f9..40473cb 100644
--- a/arch/arm/boot/dts/omap3-n900.dts
+++ b/arch/arm/boot/dts/omap3-n900.dts
@@ -254,6 +254,61 @@
 	};
 };
 
+&twl_keypad {
+	linux,keymap = < 0x00000010 /* KEY_Q */
+			 0x00010018 /* KEY_O */
+			 0x00020019 /* KEY_P */
+			 0x00030033 /* KEY_COMMA */
+			 0x0004000e /* KEY_BACKSPACE */
+			 0x0006001e /* KEY_A */
+			 0x0007001f /* KEY_S */
+
+			 0x01000011 /* KEY_W */
+			 0x01010020 /* KEY_D */
+			 0x01020021 /* KEY_F */
+			 0x01030022 /* KEY_G */
+			 0x01040023 /* KEY_H */
+			 0x01050024 /* KEY_J */
+			 0x01060025 /* KEY_K */
+			 0x01070026 /* KEY_L */
+
+			 0x02000012 /* KEY_E */
+			 0x02010034 /* KEY_DOT */
+			 0x02020067 /* KEY_UP */
+			 0x0203001c /* KEY_ENTER */
+			 0x0205002c /* KEY_Z */
+			 0x0206002d /* KEY_X */
+			 0x0207002e /* KEY_C */
+			 0x02080043 /* KEY_F9 */
+
+			 0x03000013 /* KEY_R */
+			 0x0301002f /* KEY_V */
+			 0x03020030 /* KEY_B */
+			 0x03030031 /* KEY_N */
+			 0x03040032 /* KEY_M */
+			 0x03050039 /* KEY_SPACE */
+			 0x03060039 /* KEY_SPACE */
+			 0x03070069 /* KEY_LEFT */
+
+			 0x04000014 /* KEY_T */
+			 0x0401006c /* KEY_DOWN */
+			 0x0402006a /* KEY_RIGHT */
+			 0x0404001d /* KEY_LEFTCTRL */
+			 0x04050064 /* KEY_RIGHTALT */
+			 0x0406002a /* KEY_LEFTSHIFT */
+			 0x04080044 /* KEY_F10 */
+
+			 0x05000015 /* KEY_Y */
+			 0x05080057 /* KEY_F11 */
+
+			 0x06000016 /* KEY_U */
+
+			 0x07000017 /* KEY_I */
+			 0x07010041 /* KEY_F7 */
+			 0x07020042 /* KEY_F8 */
+			 >;
+};
+
 &twl_gpio {
 	ti,pullups	= <0x0>;
 	ti,pulldowns	= <0x03ff3f>; /* BIT(0..5) | BIT(8..17) */
-- 
1.8.5.2

