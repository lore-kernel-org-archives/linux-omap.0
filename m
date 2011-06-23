From: Shubhrajyoti D <shubhrajyoti@ti.com>
Subject: [PATCH] OMAP4: Keyboard: Mux changes in the board file
Date: Thu, 23 Jun 2011 17:45:17 +0530
Message-ID: <1308831317-17092-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:40192 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756030Ab1FWMP1 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 23 Jun 2011 08:15:27 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id p5NCFOSR019591
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 23 Jun 2011 07:15:26 -0500
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id p5NCFNPC020208
	for <linux-omap@vger.kernel.org>; Thu, 23 Jun 2011 17:45:23 +0530 (IST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Shubhrajyoti D <shubhrajyoti@ti.com>

The mux settings for keypad  are done for omap4430sdp in
board file.

Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
---
 arch/arm/mach-omap2/board-4430sdp.c            |   67 +++++++++++++++++++++++-
 arch/arm/mach-omap2/devices.c                  |    3 +-
 arch/arm/plat-omap/include/plat/omap4-keypad.h |    3 +-
 3 files changed, 70 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index 63de2d3..47e6ab9 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -125,6 +125,64 @@ static const int sdp4430_keymap[] = {
 	KEY(7, 6, KEY_OK),
 	KEY(7, 7, KEY_DOWN),
 };
+static struct omap_device_pad keypad_pads[] __initdata = {
+	{	.name   = "kpd_col1.kpd_col1",
+		.enable = OMAP_WAKEUP_EN | OMAP_MUX_MODE1,
+	},
+	{	.name   = "kpd_col1.kpd_col1",
+		.enable = OMAP_WAKEUP_EN | OMAP_MUX_MODE1,
+	},
+	{	.name   = "kpd_col2.kpd_col2",
+		.enable = OMAP_WAKEUP_EN | OMAP_MUX_MODE1,
+	},
+	{	.name   = "kpd_col3.kpd_col3",
+		.enable = OMAP_WAKEUP_EN | OMAP_MUX_MODE1,
+	},
+	{	.name   = "kpd_col4.kpd_col4",
+		.enable = OMAP_WAKEUP_EN | OMAP_MUX_MODE1,
+	},
+	{	.name   = "kpd_col5.kpd_col5",
+		.enable = OMAP_WAKEUP_EN | OMAP_MUX_MODE1,
+	},
+	{	.name   = "gpmc_a23.kpd_col7",
+		.enable = OMAP_WAKEUP_EN | OMAP_MUX_MODE1,
+	},
+	{	.name   = "gpmc_a22.kpd_col6",
+		.enable = OMAP_WAKEUP_EN | OMAP_MUX_MODE1,
+	},
+	{	.name   = "kpd_row0.kpd_row0",
+		.enable = OMAP_PULL_ENA | OMAP_PULL_UP | OMAP_WAKEUP_EN |
+			OMAP_MUX_MODE1 | OMAP_INPUT_EN,
+	},
+	{	.name   = "kpd_row1.kpd_row1",
+		.enable = OMAP_PULL_ENA | OMAP_PULL_UP | OMAP_WAKEUP_EN |
+			OMAP_MUX_MODE1 | OMAP_INPUT_EN,
+	},
+	{	.name   = "kpd_row2.kpd_row2",
+		.enable = OMAP_PULL_ENA | OMAP_PULL_UP | OMAP_WAKEUP_EN |
+			OMAP_MUX_MODE1 | OMAP_INPUT_EN,
+	},
+	{	.name   = "kpd_row3.kpd_row3",
+		.enable = OMAP_PULL_ENA | OMAP_PULL_UP | OMAP_WAKEUP_EN |
+			OMAP_MUX_MODE1 | OMAP_INPUT_EN,
+	},
+	{	.name   = "kpd_row4.kpd_row4",
+		.enable = OMAP_PULL_ENA | OMAP_PULL_UP | OMAP_WAKEUP_EN |
+			OMAP_MUX_MODE1 | OMAP_INPUT_EN,
+	},
+	{	.name   = "kpd_row5.kpd_row5",
+		.enable = OMAP_PULL_ENA | OMAP_PULL_UP | OMAP_WAKEUP_EN |
+			OMAP_MUX_MODE1 | OMAP_INPUT_EN,
+	},
+	{	.name   = "gpmc_a18.kpd_row6",
+		.enable = OMAP_PULL_ENA | OMAP_PULL_UP | OMAP_WAKEUP_EN |
+			OMAP_MUX_MODE1 | OMAP_INPUT_EN,
+	},
+	{	.name   = "gpmc_a19.kpd_row7",
+		.enable = OMAP_PULL_ENA | OMAP_PULL_UP | OMAP_WAKEUP_EN |
+			OMAP_MUX_MODE1 | OMAP_INPUT_EN,
+	},
+};
 
 static struct matrix_keymap_data sdp4430_keymap_data = {
 	.keymap			= sdp4430_keymap,
@@ -136,6 +194,13 @@ static struct omap4_keypad_platform_data sdp4430_keypad_data = {
 	.rows			= 8,
 	.cols			= 8,
 };
+
+static struct omap_board_data keypad_data = {
+	.id	    = 1,
+	.pads	 = keypad_pads,
+	.pads_cnt       = ARRAY_SIZE(keypad_pads),
+};
+
 static struct gpio_led sdp4430_gpio_leds[] = {
 	{
 		.name	= "omap4:green:debug0",
@@ -752,7 +817,7 @@ static void __init omap_4430sdp_init(void)
 				ARRAY_SIZE(sdp4430_spi_board_info));
 	}
 
-	status = omap4_keyboard_init(&sdp4430_keypad_data);
+	status = omap4_keyboard_init(&sdp4430_keypad_data, &keypad_data);
 	if (status)
 		pr_err("Keypad initialization failed: %d\n", status);
 
diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index 5b8ca68..1077ad6 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -230,7 +230,7 @@ struct omap_device_pm_latency omap_keyboard_latency[] = {
 };
 
 int __init omap4_keyboard_init(struct omap4_keypad_platform_data
-						*sdp4430_keypad_data)
+			*sdp4430_keypad_data, struct omap_board_data *bdata)
 {
 	struct omap_device *od;
 	struct omap_hwmod *oh;
@@ -257,6 +257,7 @@ int __init omap4_keyboard_init(struct omap4_keypad_platform_data
 						name, oh->name);
 		return PTR_ERR(od);
 	}
+	oh->mux = omap_hwmod_mux_init(bdata->pads, bdata->pads_cnt);
 
 	return 0;
 }
diff --git a/arch/arm/plat-omap/include/plat/omap4-keypad.h b/arch/arm/plat-omap/include/plat/omap4-keypad.h
index 2b1d9bc..9fe6c87 100644
--- a/arch/arm/plat-omap/include/plat/omap4-keypad.h
+++ b/arch/arm/plat-omap/include/plat/omap4-keypad.h
@@ -10,5 +10,6 @@ struct omap4_keypad_platform_data {
 	u8 cols;
 };
 
-extern int omap4_keyboard_init(struct omap4_keypad_platform_data *);
+extern int omap4_keyboard_init(struct omap4_keypad_platform_data *,
+				struct omap_board_data *);
 #endif
-- 
1.7.1

