From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: dts: Add keypad support for droid 4
Date: Thu, 26 Jan 2017 20:28:45 -0800
Message-ID: <20170127042844.GU7403@atomide.com>
References: <20170127041525.29648-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20170127041525.29648-1-tony@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>, Marcel Partap <mpartap@gmx.net>, linux-arm-kernel@lists.infradead.org, Michael Scott <michael.scott@linaro.org>
List-Id: linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [170126 20:16]:
> Let's configure the keypad in a way where it's usable out of the
> box for Linux console use. To do this, let's follow the standard
> PC keyboard layout for ctrl, shift and alt keys:
> 
> Ctrl = what is labeled as shift
> Alt = what is labeled as SYM
> Shift = what is lableled as caps lock
> Meta = what is labled as OK
> 
> Who knows where they got the caps lock idea.. Probably from
> some focus group popularity vote or something.
> 
> Note that some other keys don't match the labels either as they
> don't follow the PC keyboard style. For example we have "shift + ,"
> produce "<", and "shift + ." produce ">" instead of ";" and ":".
> 
> Pretty much Esc is the only key missing. I've used "Meta + 1"
> produce Esc, and that seems to work OK. But that can be mapped
> using the standard userspace tools.

Oh looks like KEY_VOLUMEUP is on omap4-keypad, then POWER and
VOLUMEDOWN must be on the CPCAP.

Updated patch below with KEY_VOLUMEUP added.

Regards,

Tony

8< ------------------------------
>From tony Mon Sep 17 00:00:00 2001
From: Tony Lindgren <tony@atomide.com>
Date: Thu, 26 Jan 2017 16:14:55 -0800
Subject: [PATCH] ARM: dts: Add keypad support for droid 4

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
---
 arch/arm/boot/dts/omap4-droid4-xt894.dts | 75 ++++++++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/arch/arm/boot/dts/omap4-droid4-xt894.dts b/arch/arm/boot/dts/omap4-droid4-xt894.dts
--- a/arch/arm/boot/dts/omap4-droid4-xt894.dts
+++ b/arch/arm/boot/dts/omap4-droid4-xt894.dts
@@ -5,6 +5,7 @@
  */
 /dts-v1/;
 
+#include <dt-bindings/input/input.h>
 #include "omap443x.dtsi"
 
 / {
@@ -60,6 +61,80 @@
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
+	/* Side buttons, KEY_VOLUMEDOWN and KEY_PWER are on CPCAP? */
+	MATRIX_KEY(5, 0, KEY_VOLUMEUP)
+	>;
+};
+
 &mmc1 {
 	vmmc-supply = <&vmmc>;
 	bus-width = <4>;
-- 
2.11.0
