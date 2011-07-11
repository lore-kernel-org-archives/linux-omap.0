From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 08/22] cbus: tahvo: pass tahvo to IRQ handler
Date: Mon, 11 Jul 2011 14:17:21 +0300
Message-ID: <1310383055-20211-9-git-send-email-balbi@ti.com>
References: <1310383055-20211-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog126.obsmtp.com ([74.125.149.155]:60337 "EHLO
	na3sys009aog126.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754517Ab1GKLSZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 11 Jul 2011 07:18:25 -0400
Received: by yih10 with SMTP id 10so2749935yih.1
        for <linux-omap@vger.kernel.org>; Mon, 11 Jul 2011 04:18:24 -0700 (PDT)
In-Reply-To: <1310383055-20211-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, =?UTF-8?q?Michael=20B=C3=BCsch?= <mb@bu3sch.de>, Felipe Balbi <balbi@ti.com>

that way we don't need to access the global
pointer

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/cbus/tahvo.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/cbus/tahvo.c b/drivers/cbus/tahvo.c
index 3a77d12..740bb05 100644
--- a/drivers/cbus/tahvo.c
+++ b/drivers/cbus/tahvo.c
@@ -182,11 +182,11 @@ void tahvo_set_backlight_level(int level)
 }
 EXPORT_SYMBOL(tahvo_set_backlight_level);
 
-static irqreturn_t tahvo_irq_handler(int irq, void *dev_id)
+static irqreturn_t tahvo_irq_handler(int irq, void *_tahvo)
 {
 	struct tahvo_irq_handler_desc *hnd;
 
-	struct tahvo		*tahvo = the_tahvo;
+	struct tahvo		*tahvo = _tahvo;
 	u16			id;
 	u16			im;
 	int			i;
@@ -329,7 +329,7 @@ static int __devinit tahvo_probe(struct platform_device *pdev)
 
 	ret = request_threaded_irq(irq, NULL, tahvo_irq_handler,
 			IRQF_TRIGGER_RISING | IRQF_ONESHOT,
-			"tahvo", 0);
+			"tahvo", tahvo);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "Unable to register IRQ handler\n");
 		goto err1;
-- 
1.7.6

