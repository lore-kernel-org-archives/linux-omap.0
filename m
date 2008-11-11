From: Felipe Balbi <me@felipebalbi.com>
Subject: [rft/rfc/patch-2.6.28-rc3+ 48/59] omap: namespace cleanup to drivers/video/omap/lcd_osk.c
Date: Wed, 12 Nov 2008 00:57:07 +0200
Message-ID: <1226444238-14614-49-git-send-email-me@felipebalbi.com>
References: <1226444238-14614-1-git-send-email-me@felipebalbi.com>
 <1226444238-14614-2-git-send-email-me@felipebalbi.com>
 <1226444238-14614-3-git-send-email-me@felipebalbi.com>
 <1226444238-14614-4-git-send-email-me@felipebalbi.com>
 <1226444238-14614-5-git-send-email-me@felipebalbi.com>
 <1226444238-14614-6-git-send-email-me@felipebalbi.com>
 <1226444238-14614-7-git-send-email-me@felipebalbi.com>
 <1226444238-14614-8-git-send-email-me@felipebalbi.com>
 <1226444238-14614-9-git-send-email-me@felipebalbi.com>
 <1226444238-14614-10-git-send-email-me@felipebalbi.com>
 <1226444238-14614-11-git-send-email-me@felipebalbi.com>
 <1226444238-14614-12-git-send-email-me@felipebalbi.com>
 <1226444238-14614-13-git-send-email-me@felipebalbi.com>
 <1226444238-14614-14-git-send-email-me@felipebalbi.com>
 <1226444238-14614-15-git-send-email-me@felipebalbi.com>
 <1226444238-14614-16-git-send-email-me@felipebalbi.com>
 <1226444238-14614-17-git-send-email-me@felipebalbi.com>
 <1226444238-14614-18-git-send-email-me@felipebalbi.com>
 <1226444238-14614-19-git-send-email-me@felipebalbi.com>
 <1226444238-14614-20-git-send-email-me@felipebalbi.com>
 <1226444238-14614-21-git-send-email-me@felipebalbi.com>
 <1226444238-14614-22-git-send-email-me@felipebalbi.com>
 <1226444238-14614-23-git-send-email-me@felipebalbi.com>
 <1226444238-14614-24-git-send-email-me@felipebalbi.com>
 <1226444238-14614-25-git-send-email-me@felipebalbi.com>
 <1226444238-14614-26-git-send-email-me@felipebalbi.com>
 <1226444238-14614-27-git-send-email-me@felipebalbi.com>
 <1226444238-14614-28-git-send-email-me@felipebalbi.com>
 <1226444238-14614-29-git-send-email-me@felipebalbi.com>
 <1226444238-14614-30-git-send-email-me@felipebalbi.com>
 <1226444238-14614-31-git-send-email-me@felipebalbi.com>
 <1226444238-14614-32-git-send-email-me@felipebalbi.com>
 <1226444238-14614-33-git-send-email-me@felipebalbi.com>
 <1226444238-14614-34-git-send-email-me@felipebalbi.com>
 <1226444238-14614-35-git-send-email-me@felipebalbi.com>
 <1226444238-14614-36-git-send-email-me@felipebalbi.com>
 <1226444238-14614-37-git-send-email-me@felipebalbi.com>
 <1226444238-14614-38-git-send-email-me@felipebalbi.com>
 <1226444238-14614-39-git-send-email-me@felipebalbi.com>
 <1226444238-14614-40-git-send-email-me@felipebalbi.com>
 <1226444238-14614-41-git-send-email-me@felipebalbi.com>
 <1226444238-14614-42-git-send-email-me@felipebalbi.com>
 <1226444238-14614-43-git-send-email-me@felipebalbi.com>
 <1226444238-14614-44-git-send-email-me@felipebalbi.com>
 <1226444238-14614-45-git-send-email-me@felipebalbi.com>
 <1226444238-14614-46-git-send-email-me@felipebalbi.com>
 <1226444238-14614-47-git-send-email-me@felipebalbi.com>
 <1226444238-14614-48-git-send-email-me@felipebalbi.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:56694 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751667AbYKKXFr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 11 Nov 2008 18:05:47 -0500
In-Reply-To: <1226444238-14614-48-git-send-email-me@felipebalbi.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Felipe Balbi <felipe.balbi@nokia.com>

From: Felipe Balbi <felipe.balbi@nokia.com>

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 drivers/video/omap/lcd_osk.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/video/omap/lcd_osk.c b/drivers/video/omap/lcd_osk.c
index 379c96d..51fb476 100644
--- a/drivers/video/omap/lcd_osk.c
+++ b/drivers/video/omap/lcd_osk.c
@@ -43,10 +43,10 @@ static int osk_panel_enable(struct lcd_panel *panel)
 	omap_cfg_reg(PWL);
 
 	/* Enable PWL unit */
-	omap_writeb(0x01, OMAP_PWL_CLK_ENABLE);
+	__raw_writeb(0x01, OMAP_PWL_CLK_ENABLE);
 
 	/* Set PWL level */
-	omap_writeb(0xFF, OMAP_PWL_ENABLE);
+	__raw_writeb(0xFF, OMAP_PWL_ENABLE);
 
 	/* set GPIO2 high (lcd power enabled) */
 	gpio_set_value(2, 1);
@@ -57,10 +57,10 @@ static int osk_panel_enable(struct lcd_panel *panel)
 static void osk_panel_disable(struct lcd_panel *panel)
 {
 	/* Set PWL level to zero */
-	omap_writeb(0x00, OMAP_PWL_ENABLE);
+	__raw_writeb(0x00, OMAP_PWL_ENABLE);
 
 	/* Disable PWL unit */
-	omap_writeb(0x00, OMAP_PWL_CLK_ENABLE);
+	__raw_writeb(0x00, OMAP_PWL_CLK_ENABLE);
 
 	/* set GPIO2 low */
 	gpio_set_value(2, 0);
-- 
1.6.0.2.307.gc427

