From: Jonathan McDowell <noodles@earth.li>
Subject: [PATCH] Fix section mismatch warnings on some OMAP1 boards
Date: Tue, 11 Nov 2008 22:57:20 +0000
Message-ID: <20081111225720.GA3162@earth.li>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from the.earth.li ([217.147.81.2]:45578 "EHLO the.earth.li"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752047AbYKKXnM (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 11 Nov 2008 18:43:12 -0500
Received: from noodles by the.earth.li with local (Exim 4.63)
	(envelope-from <noodles@earth.li>)
	id 1L02Ai-0003Tl-Fj
	for linux-omap@vger.kernel.org; Tue, 11 Nov 2008 22:57:20 +0000
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

I got some section mismatch warnings when compiling latest git for
MACH_AMS_DELTA this evening; this seems to be due to a missing
__initdata on the omap_board_config_kernel. Adding it fixes the
warnings. I noticed that although this had been done for other OMAP1
boards fsample, innovator and voiceblue were all lacking it too, so I
fixed them up at the same time.

Signed-off-by: Jonathan McDowell <noodles@earth.li>

-----
diff --git a/arch/arm/mach-omap1/board-ams-delta.c b/arch/arm/mach-omap1/board-ams-delta.c
index 2e61839..682cb91 100644
--- a/arch/arm/mach-omap1/board-ams-delta.c
+++ b/arch/arm/mach-omap1/board-ams-delta.c
@@ -172,7 +172,7 @@ static struct omap_usb_config ams_delta_usb_config __initdata = {
 	.pins[0]	= 2,
 };
 
-static struct omap_board_config_kernel ams_delta_config[] = {
+static struct omap_board_config_kernel ams_delta_config[] __initdata = {
 	{ OMAP_TAG_LCD,		&ams_delta_lcd_config },
 	{ OMAP_TAG_UART,	&ams_delta_uart_config },
 	{ OMAP_TAG_USB,		&ams_delta_usb_config },
diff --git a/arch/arm/mach-omap1/board-fsample.c b/arch/arm/mach-omap1/board-fsample.c
index db78946..38f4f18 100644
--- a/arch/arm/mach-omap1/board-fsample.c
+++ b/arch/arm/mach-omap1/board-fsample.c
@@ -216,7 +216,7 @@ static struct omap_lcd_config fsample_lcd_config __initdata = {
 	.ctrl_name	= "internal",
 };
 
-static struct omap_board_config_kernel fsample_config[] = {
+static struct omap_board_config_kernel fsample_config[] __initdata = {
 	{ OMAP_TAG_UART,	&fsample_uart_config },
 	{ OMAP_TAG_LCD,		&fsample_lcd_config },
 };
diff --git a/arch/arm/mach-omap1/board-innovator.c b/arch/arm/mach-omap1/board-innovator.c
index 7a97f6b..b86eb95 100644
--- a/arch/arm/mach-omap1/board-innovator.c
+++ b/arch/arm/mach-omap1/board-innovator.c
@@ -408,7 +408,7 @@ static struct omap_uart_config innovator_uart_config __initdata = {
 	.enabled_uarts = ((1 << 0) | (1 << 1) | (1 << 2)),
 };
 
-static struct omap_board_config_kernel innovator_config[] = {
+static struct omap_board_config_kernel innovator_config[] __initdata = {
 	{ OMAP_TAG_USB,         NULL },
 	{ OMAP_TAG_LCD,		NULL },
 	{ OMAP_TAG_UART,	&innovator_uart_config },
diff --git a/arch/arm/mach-omap1/board-voiceblue.c b/arch/arm/mach-omap1/board-voiceblue.c
index 3ab5bbf..93de7e0 100644
--- a/arch/arm/mach-omap1/board-voiceblue.c
+++ b/arch/arm/mach-omap1/board-voiceblue.c
@@ -145,7 +145,7 @@ static struct omap_uart_config voiceblue_uart_config __initdata = {
 	.enabled_uarts = ((1 << 0) | (1 << 1) | (1 << 2)),
 };
 
-static struct omap_board_config_kernel voiceblue_config[] = {
+static struct omap_board_config_kernel voiceblue_config[] __initdata = {
 	{ OMAP_TAG_USB,  &voiceblue_usb_config },
 	{ OMAP_TAG_UART, &voiceblue_uart_config },
 };
-----

J.

-- 
                                            jid: noodles@jabber.earth.li
Are you out of my mind?
