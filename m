From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 22/22] cbus: tahvo: drop static global pointer
Date: Mon, 11 Jul 2011 14:17:35 +0300
Message-ID: <1310383055-20211-23-git-send-email-balbi@ti.com>
References: <1310383055-20211-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog118.obsmtp.com ([74.125.149.244]:60956 "EHLO
	na3sys009aog118.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754477Ab1GKLTg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 11 Jul 2011 07:19:36 -0400
Received: by gxk8 with SMTP id 8so1929789gxk.23
        for <linux-omap@vger.kernel.org>; Mon, 11 Jul 2011 04:19:35 -0700 (PDT)
In-Reply-To: <1310383055-20211-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, =?UTF-8?q?Michael=20B=C3=BCsch?= <mb@bu3sch.de>, Felipe Balbi <balbi@ti.com>

that's not used anywhere anymore. We can
safely drop it.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/cbus/tahvo.c |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/drivers/cbus/tahvo.c b/drivers/cbus/tahvo.c
index 784431c..43f6d6a 100644
--- a/drivers/cbus/tahvo.c
+++ b/drivers/cbus/tahvo.c
@@ -56,8 +56,6 @@ struct tahvo {
 	unsigned int	is_betty:1;
 };
 
-static struct tahvo *the_tahvo;
-
 /**
  * __tahvo_read_reg - Reads a value from a register in Tahvo
  * @tahvo: pointer to tahvo structure
@@ -334,7 +332,6 @@ static int __devinit tahvo_probe(struct platform_device *pdev)
 	tahvo->irq_end	= ret + MAX_TAHVO_IRQ_HANDLERS;
 	tahvo->dev	= &pdev->dev;
 	tahvo->irq	= irq;
-	the_tahvo	= tahvo;
 
 	tahvo_irq_init(tahvo);
 
@@ -388,7 +385,6 @@ static int __devexit tahvo_remove(struct platform_device *pdev)
 	free_irq(irq, 0);
 	irq_free_descs(tahvo->irq_base, MAX_TAHVO_IRQ_HANDLERS);
 	kfree(tahvo);
-	the_tahvo = NULL;
 
 	return 0;
 }
-- 
1.7.6

