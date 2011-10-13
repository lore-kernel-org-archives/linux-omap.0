From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 08/27] cbus: tahvo: pass tahvo to IRQ handler
Date: Thu, 13 Oct 2011 11:34:43 +0300
Message-ID: <1318494902-13093-8-git-send-email-balbi@ti.com>
References: <1318494902-13093-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog124.obsmtp.com ([74.125.149.151]:55220 "EHLO
	na3sys009aog124.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753890Ab1JMIfZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 13 Oct 2011 04:35:25 -0400
Received: by mail-bw0-f53.google.com with SMTP id zt12so1410273bkb.40
        for <linux-omap@vger.kernel.org>; Thu, 13 Oct 2011 01:35:23 -0700 (PDT)
In-Reply-To: <1318494902-13093-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Felipe Balbi <balbi@ti.com>

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
1.7.6.396.ge0613

