From: Sebastian Reichel <sre@kernel.org>
Subject: [PATCH] DTS: ARM: OMAP3-N900: use MATRIX_KEY for keymap
Date: Tue,  6 May 2014 15:14:28 +0200
Message-ID: <1399382068-12252-1-git-send-email-sre@kernel.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ring0.de ([5.45.105.125]:52158 "EHLO ring0.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751135AbaEFNOf (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 6 May 2014 09:14:35 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sebastian Reichel <sre@ring0.de>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
Cc: Sebastian Reichel <sre@kernel.org>

Use MATRIX_KEY macro from dt-bindings/input/input.h
to make the keyboard matrix human readable.

Signed-off-by: Sebastian Reichel <sre@kernel.org>
---
 arch/arm/boot/dts/omap3-n900.dts | 103 ++++++++++++++++++++-------------------
 1 file changed, 52 insertions(+), 51 deletions(-)

diff --git a/arch/arm/boot/dts/omap3-n900.dts b/arch/arm/boot/dts/omap3-n900.dts
index 9ba1f08..288a8b9 100644
--- a/arch/arm/boot/dts/omap3-n900.dts
+++ b/arch/arm/boot/dts/omap3-n900.dts
@@ -10,6 +10,7 @@
 /dts-v1/;
 
 #include "omap34xx-hs.dtsi"
+#include <dt-bindings/input/input.h>
 
 / {
 	model = "Nokia N900";
@@ -325,57 +326,57 @@
 };
 
 &twl_keypad {
-	linux,keymap = < 0x00000010 /* KEY_Q */
-			 0x00010018 /* KEY_O */
-			 0x00020019 /* KEY_P */
-			 0x00030033 /* KEY_COMMA */
-			 0x0004000e /* KEY_BACKSPACE */
-			 0x0006001e /* KEY_A */
-			 0x0007001f /* KEY_S */
-
-			 0x01000011 /* KEY_W */
-			 0x01010020 /* KEY_D */
-			 0x01020021 /* KEY_F */
-			 0x01030022 /* KEY_G */
-			 0x01040023 /* KEY_H */
-			 0x01050024 /* KEY_J */
-			 0x01060025 /* KEY_K */
-			 0x01070026 /* KEY_L */
-
-			 0x02000012 /* KEY_E */
-			 0x02010034 /* KEY_DOT */
-			 0x02020067 /* KEY_UP */
-			 0x0203001c /* KEY_ENTER */
-			 0x0205002c /* KEY_Z */
-			 0x0206002d /* KEY_X */
-			 0x0207002e /* KEY_C */
-			 0x02080043 /* KEY_F9 */
-
-			 0x03000013 /* KEY_R */
-			 0x0301002f /* KEY_V */
-			 0x03020030 /* KEY_B */
-			 0x03030031 /* KEY_N */
-			 0x03040032 /* KEY_M */
-			 0x03050039 /* KEY_SPACE */
-			 0x03060039 /* KEY_SPACE */
-			 0x03070069 /* KEY_LEFT */
-
-			 0x04000014 /* KEY_T */
-			 0x0401006c /* KEY_DOWN */
-			 0x0402006a /* KEY_RIGHT */
-			 0x0404001d /* KEY_LEFTCTRL */
-			 0x04050064 /* KEY_RIGHTALT */
-			 0x0406002a /* KEY_LEFTSHIFT */
-			 0x04080044 /* KEY_F10 */
-
-			 0x05000015 /* KEY_Y */
-			 0x05080057 /* KEY_F11 */
-
-			 0x06000016 /* KEY_U */
-
-			 0x07000017 /* KEY_I */
-			 0x07010041 /* KEY_F7 */
-			 0x07020042 /* KEY_F8 */
+	linux,keymap = < MATRIX_KEY(0x00, 0x00, KEY_Q)
+			 MATRIX_KEY(0x00, 0x01, KEY_O)
+			 MATRIX_KEY(0x00, 0x02, KEY_P)
+			 MATRIX_KEY(0x00, 0x03, KEY_COMMA)
+			 MATRIX_KEY(0x00, 0x04, KEY_BACKSPACE)
+			 MATRIX_KEY(0x00, 0x06, KEY_A)
+			 MATRIX_KEY(0x00, 0x07, KEY_S)
+
+			 MATRIX_KEY(0x01, 0x00, KEY_W)
+			 MATRIX_KEY(0x01, 0x01, KEY_D)
+			 MATRIX_KEY(0x01, 0x02, KEY_F)
+			 MATRIX_KEY(0x01, 0x03, KEY_G)
+			 MATRIX_KEY(0x01, 0x04, KEY_H)
+			 MATRIX_KEY(0x01, 0x05, KEY_J)
+			 MATRIX_KEY(0x01, 0x06, KEY_K)
+			 MATRIX_KEY(0x01, 0x07, KEY_L)
+
+			 MATRIX_KEY(0x02, 0x00, KEY_E)
+			 MATRIX_KEY(0x02, 0x01, KEY_DOT)
+			 MATRIX_KEY(0x02, 0x02, KEY_UP)
+			 MATRIX_KEY(0x02, 0x03, KEY_ENTER)
+			 MATRIX_KEY(0x02, 0x05, KEY_Z)
+			 MATRIX_KEY(0x02, 0x06, KEY_X)
+			 MATRIX_KEY(0x02, 0x07, KEY_C)
+			 MATRIX_KEY(0x02, 0x08, KEY_F9)
+
+			 MATRIX_KEY(0x03, 0x00, KEY_R)
+			 MATRIX_KEY(0x03, 0x01, KEY_V)
+			 MATRIX_KEY(0x03, 0x02, KEY_B)
+			 MATRIX_KEY(0x03, 0x03, KEY_N)
+			 MATRIX_KEY(0x03, 0x04, KEY_M)
+			 MATRIX_KEY(0x03, 0x05, KEY_SPACE)
+			 MATRIX_KEY(0x03, 0x06, KEY_SPACE)
+			 MATRIX_KEY(0x03, 0x07, KEY_LEFT)
+
+			 MATRIX_KEY(0x04, 0x00, KEY_T)
+			 MATRIX_KEY(0x04, 0x01, KEY_DOWN)
+			 MATRIX_KEY(0x04, 0x02, KEY_RIGHT)
+			 MATRIX_KEY(0x04, 0x04, KEY_LEFTCTRL)
+			 MATRIX_KEY(0x04, 0x05, KEY_RIGHTALT)
+			 MATRIX_KEY(0x04, 0x06, KEY_LEFTSHIFT)
+			 MATRIX_KEY(0x04, 0x08, KEY_F10)
+
+			 MATRIX_KEY(0x05, 0x00, KEY_Y)
+			 MATRIX_KEY(0x05, 0x08, KEY_F11)
+
+			 MATRIX_KEY(0x06, 0x00, KEY_U)
+
+			 MATRIX_KEY(0x07, 0x00, KEY_I)
+			 MATRIX_KEY(0x07, 0x01, KEY_F7)
+			 MATRIX_KEY(0x07, 0x02, KEY_F8)
 			 >;
 };
 
-- 
2.0.0.rc0

