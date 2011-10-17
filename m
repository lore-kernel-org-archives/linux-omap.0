From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 2/4] cbus: retu: no need to pass devid via pdata
Date: Mon, 17 Oct 2011 23:50:41 +0300
Message-ID: <1318884643-4137-2-git-send-email-balbi@ti.com>
References: <1318884643-4137-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog126.obsmtp.com ([74.125.149.155]:56507 "EHLO
	na3sys009aog126.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754093Ab1JQUuv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 17 Oct 2011 16:50:51 -0400
Received: by bkar19 with SMTP id r19so9873208bka.21
        for <linux-omap@vger.kernel.org>; Mon, 17 Oct 2011 13:50:48 -0700 (PDT)
In-Reply-To: <1318884643-4137-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Felipe Balbi <balbi@ti.com>

that's a constant, which will never change.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/cbus/retu.c |    8 ++------
 1 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/cbus/retu.c b/drivers/cbus/retu.c
index 464fc0c..d2f43bb 100644
--- a/drivers/cbus/retu.c
+++ b/drivers/cbus/retu.c
@@ -46,8 +46,6 @@ struct retu {
 	struct mutex		mutex;
 	struct device		*dev;
 
-	int			devid;
-
 	int			irq_base;
 	int			irq_end;
 
@@ -71,7 +69,7 @@ static struct retu *the_retu;
  */
 static int __retu_read_reg(struct retu *retu, unsigned reg)
 {
-	return cbus_read_reg(retu->dev, retu->devid, reg);
+	return cbus_read_reg(retu->dev, CBUS_RETU_DEVICE_ID, reg);
 }
 
 /**
@@ -82,7 +80,7 @@ static int __retu_read_reg(struct retu *retu, unsigned reg)
  */
 static void __retu_write_reg(struct retu *retu, unsigned reg, u16 val)
 {
-	cbus_write_reg(retu->dev, retu->devid, reg, val);
+	cbus_write_reg(retu->dev, CBUS_RETU_DEVICE_ID, reg, val);
 }
 
 /**
@@ -430,7 +428,6 @@ static int retu_allocate_children(struct device *parent, int irq_base)
 static int __devinit retu_probe(struct platform_device *pdev)
 {
 	struct retu	*retu;
-	struct cbus_retu_platform_data *pdata = pdev->dev.platform_data;
 
 	int		ret = -ENOMEM;
 	int		rev;
@@ -452,7 +449,6 @@ static int __devinit retu_probe(struct platform_device *pdev)
 	retu->irq	= platform_get_irq(pdev, 0);
 	retu->irq_base	= ret;
 	retu->irq_end	= ret + MAX_RETU_IRQ_HANDLERS;
-	retu->devid	= pdata->devid;
 	retu->dev	= &pdev->dev;
 	the_retu	= retu;
 
-- 
1.7.7

