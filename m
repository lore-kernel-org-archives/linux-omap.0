From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 16/22] cbus: tahvo: usb: drop unused variable
Date: Mon, 11 Jul 2011 14:17:29 +0300
Message-ID: <1310383055-20211-17-git-send-email-balbi@ti.com>
References: <1310383055-20211-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:57472 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754511Ab1GKLTG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 11 Jul 2011 07:19:06 -0400
Received: by mail-gx0-f175.google.com with SMTP id 3so1682634gxk.20
        for <linux-omap@vger.kernel.org>; Mon, 11 Jul 2011 04:19:05 -0700 (PDT)
In-Reply-To: <1310383055-20211-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, =?UTF-8?q?Michael=20B=C3=BCsch?= <mb@bu3sch.de>, Felipe Balbi <balbi@ti.com>

no functional changes.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/cbus/tahvo-usb.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/cbus/tahvo-usb.c b/drivers/cbus/tahvo-usb.c
index 10619a8..e078440 100644
--- a/drivers/cbus/tahvo-usb.c
+++ b/drivers/cbus/tahvo-usb.c
@@ -116,7 +116,6 @@ static struct platform_device *tahvo_otg_dev;
 
 static irqreturn_t omap_otg_irq(int irq, void *arg)
 {
-	struct tahvo_usb *tu = arg;
 	u16 otg_irq;
 
 	otg_irq = omap_readw(OTG_IRQ_SRC);
-- 
1.7.6

