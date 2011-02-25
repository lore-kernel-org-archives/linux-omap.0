From: Guy Eilam <guy@wizery.com>
Subject: [PATCH] omap: panda: Add TI-ST driver support
Date: Fri, 25 Feb 2011 08:52:35 +0200
Message-ID: <1298616755-10192-1-git-send-email-guy@wizery.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:59318 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752127Ab1BYGyr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 25 Feb 2011 01:54:47 -0500
Received: by eyx24 with SMTP id 24so495206eyx.19
        for <linux-omap@vger.kernel.org>; Thu, 24 Feb 2011 22:54:46 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com

Added the KIM (Kernel initialization module for the
Shared Transport driver) device entry in the board file

Only the Blutooth enable GPIO is set for now

Signed-off-by: Guy Eilam <guy@wizery.com>
---
 arch/arm/mach-omap2/board-omap4panda.c |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-omap2/board-omap4panda.c
index cd43020..c5994ad 100644
--- a/arch/arm/mach-omap2/board-omap4panda.c
+++ b/arch/arm/mach-omap2/board-omap4panda.c
@@ -50,6 +50,16 @@
 #define GPIO_WIFI_PMENA		43
 #define GPIO_WIFI_IRQ		53
 
+/* wl127x BT, FM, GPS connectivity chip */
+static int wl1271_gpios[] = {46, -1, -1};
+static struct platform_device wl1271_device = {
+	.name	= "kim",
+	.id	= -1,
+	.dev	= {
+		.platform_data	= &wl1271_gpios,
+	},
+};
+
 static struct gpio_led gpio_leds[] = {
 	{
 		.name			= "pandaboard::status1",
@@ -78,6 +88,7 @@ static struct platform_device leds_gpio = {
 
 static struct platform_device *panda_devices[] __initdata = {
 	&leds_gpio,
+	&wl1271_device,
 };
 
 static void __init omap4_panda_init_early(void)
-- 
1.7.1

