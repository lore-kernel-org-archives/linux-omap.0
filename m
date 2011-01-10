From: Enric Balletbo i Serra <eballetbo@gmail.com>
Subject: [PATCH 3/3] omap3: igep2: Add keypad support.
Date: Mon, 10 Jan 2011 14:26:14 +0100
Message-ID: <1294665974-10590-4-git-send-email-eballetbo@gmail.com>
References: <1294665974-10590-1-git-send-email-eballetbo@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:46222 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753883Ab1AJN0b (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 10 Jan 2011 08:26:31 -0500
Received: by wwa36 with SMTP id 36so651111wwa.1
        for <linux-omap@vger.kernel.org>; Mon, 10 Jan 2011 05:26:29 -0800 (PST)
In-Reply-To: <1294665974-10590-1-git-send-email-eballetbo@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com
Cc: Enric Balletbo i Serra <eballetbo@gmail.com>

Support twl4030 keypad and gpio keys on IGEP v2.

Signed-off-by: Enric Balletbo i Serra <eballetbo@gmail.com>
---
 arch/arm/mach-omap2/board-igep0020.c |   33 +++++++++++++++++++++++++++++++++
 1 files changed, 33 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-igep0020.c b/arch/arm/mach-omap2/board-igep0020.c
index 0afa301..3a6cce5 100644
--- a/arch/arm/mach-omap2/board-igep0020.c
+++ b/arch/arm/mach-omap2/board-igep0020.c
@@ -17,6 +17,7 @@
 #include <linux/io.h>
 #include <linux/gpio.h>
 #include <linux/interrupt.h>
+#include <linux/input.h>
 
 #include <linux/regulator/machine.h>
 #include <linux/regulator/fixed.h>
@@ -535,6 +536,37 @@ static struct twl4030_codec_data igep2_codec_data = {
 	.audio = &igep2_audio_data,
 };
 
+static int igep2_keymap[] = {
+	KEY(0, 0, KEY_LEFT),
+	KEY(0, 1, KEY_RIGHT),
+	KEY(0, 2, KEY_A),
+	KEY(0, 3, KEY_B),
+	KEY(1, 0, KEY_DOWN),
+	KEY(1, 1, KEY_UP),
+	KEY(1, 2, KEY_E),
+	KEY(1, 3, KEY_F),
+	KEY(2, 0, KEY_ENTER),
+	KEY(2, 1, KEY_I),
+	KEY(2, 2, KEY_J),
+	KEY(2, 3, KEY_K),
+	KEY(3, 0, KEY_M),
+	KEY(3, 1, KEY_N),
+	KEY(3, 2, KEY_O),
+	KEY(3, 3, KEY_P)
+};
+
+static struct matrix_keymap_data igep2_keymap_data = {
+	.keymap			= igep2_keymap,
+	.keymap_size		= ARRAY_SIZE(igep2_keymap),
+};
+
+static struct twl4030_keypad_data igep2_keypad_pdata = {
+	.keymap_data	= &igep2_keymap_data,
+	.rows		= 4,
+	.cols		= 4,
+	.rep		= 1,
+};
+
 static struct twl4030_platform_data igep2_twldata = {
 	.irq_base	= TWL4030_IRQ_BASE,
 	.irq_end	= TWL4030_IRQ_END,
@@ -543,6 +575,7 @@ static struct twl4030_platform_data igep2_twldata = {
 	.usb		= &igep2_usb_data,
 	.codec		= &igep2_codec_data,
 	.gpio		= &igep2_twl4030_gpio_pdata,
+	.keypad		= &igep2_keypad_pdata,
 	.vmmc1          = &igep2_vmmc1,
 	.vpll2		= &igep2_vpll2,
 	.vio		= &igep2_vio,
-- 
1.7.0.4

