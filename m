From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 22/27] cbus: tahvo: drop static global pointer
Date: Thu, 13 Oct 2011 11:34:57 +0300
Message-ID: <1318494902-13093-22-git-send-email-balbi@ti.com>
References: <1318494902-13093-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:44767 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753840Ab1JMIfv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 13 Oct 2011 04:35:51 -0400
Received: by mail-bw0-f53.google.com with SMTP id zt12so1277410bkb.12
        for <linux-omap@vger.kernel.org>; Thu, 13 Oct 2011 01:35:50 -0700 (PDT)
In-Reply-To: <1318494902-13093-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Felipe Balbi <balbi@ti.com>

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
1.7.6.396.ge0613

