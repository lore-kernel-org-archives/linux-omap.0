From: Sebastian Reichel <sre@kernel.org>
Subject: [PATCH 8/8] ARM: dts: omap4-droid4: Add keypad support
Date: Thu,  2 Mar 2017 02:09:00 +0100
Message-ID: <20170302010900.28532-9-sre@kernel.org>
References: <20170302010900.28532-1-sre@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170302010900.28532-1-sre@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Tony Lindgren <tony@atomide.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Marcel Partap <mpartap@gmx.net>, Michael Scott <michael.scott@linaro.org>
List-Id: linux-omap@vger.kernel.org

From: Tony Lindgren <tony@atomide.com>

Let's configure the keypad in a way where it's usable out of the
box for Linux console use. To do this, let's follow the standard
PC keyboard layout for ctrl, shift and alt keys:

Ctrl = what is labeled as shift
Alt = what is labeled as SYM
Shift = what is lableled as caps lock
Meta = what is labled as OK

Who knows where they got the caps lock idea.. Probably from
some focus group popularity vote or something.

Note that some other keys don't match the labels either as they
don't follow the PC keyboard style. For example we have "shift + ,"
produce "<", and "shift + ." produce ">" instead of ";" and ":".

Pretty much Esc is the only key missing. I've used "Meta + 1"
produce Esc, and that seems to work OK. But that can be mapped
using the standard userspace tools.

Cc: Marcel Partap <mpartap@gmx.net>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Michael Scott <michael.scott@linaro.org>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Tested-By: Sebastian Reichel <sre@kernel.org>
---
 arch/arm/boot/dts/omap4-droid4-xt894.dts | 74 ++++++++++++++++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/arch/arm/boot/dts/omap4-droid4-xt894.dts b/arch/arm/boot/dts/omap4-droid4-xt894.dts
index 364e98e66037..8ea22852ef3f 100644
--- a/arch/arm/boot/dts/omap4-droid4-xt894.dts
+++ b/arch/arm/boot/dts/omap4-droid4-xt894.dts
@@ -64,6 +64,80 @@
 	status = "disabled";
 };
 
+&keypad {
+	keypad,num-rows = <8>;
+	keypad,num-columns = <8>;
+	linux,keymap = <
+
+	/* Row 1 */
+	MATRIX_KEY(0, 2, KEY_1)
+	MATRIX_KEY(0, 6, KEY_2)
+	MATRIX_KEY(2, 3, KEY_3)
+	MATRIX_KEY(0, 7, KEY_4)
+	MATRIX_KEY(0, 4, KEY_5)
+	MATRIX_KEY(5, 5, KEY_6)
+	MATRIX_KEY(0, 1, KEY_7)
+	MATRIX_KEY(0, 5, KEY_8)
+	MATRIX_KEY(0, 0, KEY_9)
+	MATRIX_KEY(1, 6, KEY_0)
+
+	/* Row 2 */
+	MATRIX_KEY(3, 4, KEY_APOSTROPHE)
+	MATRIX_KEY(7, 6, KEY_Q)
+	MATRIX_KEY(7, 7, KEY_W)
+	MATRIX_KEY(7, 2, KEY_E)
+	MATRIX_KEY(1, 0, KEY_R)
+	MATRIX_KEY(4, 4, KEY_T)
+	MATRIX_KEY(1, 2, KEY_Y)
+	MATRIX_KEY(6, 7, KEY_U)
+	MATRIX_KEY(2, 2, KEY_I)
+	MATRIX_KEY(5, 6, KEY_O)
+	MATRIX_KEY(3, 7, KEY_P)
+	MATRIX_KEY(6, 5, KEY_BACKSPACE)
+
+	/* Row 3 */
+	MATRIX_KEY(5, 4, KEY_TAB)
+	MATRIX_KEY(5, 7, KEY_A)
+	MATRIX_KEY(2, 7, KEY_S)
+	MATRIX_KEY(7, 0, KEY_D)
+	MATRIX_KEY(2, 6, KEY_F)
+	MATRIX_KEY(6, 2, KEY_G)
+	MATRIX_KEY(6, 6, KEY_H)
+	MATRIX_KEY(1, 4, KEY_J)
+	MATRIX_KEY(3, 1, KEY_K)
+	MATRIX_KEY(2, 1, KEY_L)
+	MATRIX_KEY(4, 6, KEY_ENTER)
+
+	/* Row 4 */
+	MATRIX_KEY(3, 6, KEY_LEFTSHIFT)		/* KEY_CAPSLOCK */
+	MATRIX_KEY(6, 1, KEY_Z)
+	MATRIX_KEY(7, 4, KEY_X)
+	MATRIX_KEY(5, 1, KEY_C)
+	MATRIX_KEY(1, 7, KEY_V)
+	MATRIX_KEY(2, 4, KEY_B)
+	MATRIX_KEY(4, 1, KEY_N)
+	MATRIX_KEY(1, 1, KEY_M)
+	MATRIX_KEY(3, 5, KEY_COMMA)
+	MATRIX_KEY(5, 2, KEY_DOT)
+	MATRIX_KEY(6, 3, KEY_UP)
+	MATRIX_KEY(7, 3, KEY_RIGHTMETA)		/* KEY_OK */
+
+	/* Row 5 */
+	MATRIX_KEY(2, 5, KEY_LEFTCTRL)		/* KEY_LEFTSHIFT */
+	MATRIX_KEY(4, 5, KEY_LEFTALT)		/* SYM */
+	MATRIX_KEY(6, 0, KEY_MINUS)
+	MATRIX_KEY(4, 7, KEY_EQUAL)
+	MATRIX_KEY(1, 5, KEY_SPACE)
+	MATRIX_KEY(3, 2, KEY_SLASH)
+	MATRIX_KEY(4, 3, KEY_LEFT)
+	MATRIX_KEY(5, 3, KEY_DOWN)
+	MATRIX_KEY(3, 3, KEY_RIGHT)
+
+	/* Side buttons (KEY_VOLUMEDOWN is gpio-key and PWR is cpcap key) */
+	MATRIX_KEY(5, 0, KEY_VOLUMEUP)
+	>;
+};
+
 &mmc1 {
 	vmmc-supply = <&vsimcard>;
 	bus-width = <4>;
-- 
2.11.0
