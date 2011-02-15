From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 2/6] arm: omap1: fix compile warning
Date: Tue, 15 Feb 2011 14:49:12 +0200
Message-ID: <1297774156-23312-3-git-send-email-balbi@ti.com>
References: <1297774156-23312-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:46010 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754938Ab1BOMte (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 15 Feb 2011 07:49:34 -0500
Received: by mail-gw0-f53.google.com with SMTP id 10so52519gwb.12
        for <linux-omap@vger.kernel.org>; Tue, 15 Feb 2011 04:49:33 -0800 (PST)
In-Reply-To: <1297774156-23312-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Felipe Balbi <balbi@ti.com>

Fix the following compile warning:
arch/arm/mach-omap1/board-palmte.c:233:13: warning:
'palmte_headphones_detect' defined but not used

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/mach-omap1/board-palmte.c |   13 -------------
 1 files changed, 0 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-omap1/board-palmte.c b/arch/arm/mach-omap1/board-palmte.c
index fb51ce6..c9d38f4 100644
--- a/arch/arm/mach-omap1/board-palmte.c
+++ b/arch/arm/mach-omap1/board-palmte.c
@@ -230,19 +230,6 @@ static struct spi_board_info palmte_spi_info[] __initdata = {
 	},
 };
 
-static void palmte_headphones_detect(void *data, int state)
-{
-	if (state) {
-		/* Headphones connected, disable speaker */
-		gpio_set_value(PALMTE_SPEAKER_GPIO, 0);
-		printk(KERN_INFO "PM: speaker off\n");
-	} else {
-		/* Headphones unplugged, re-enable speaker */
-		gpio_set_value(PALMTE_SPEAKER_GPIO, 1);
-		printk(KERN_INFO "PM: speaker on\n");
-	}
-}
-
 static void __init palmte_misc_gpio_setup(void)
 {
 	/* Set TSC2102 PINTDAV pin as input (used by TSC2102 driver) */
-- 
1.7.4.rc2

