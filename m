From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 26/27] cbus: use platform_driver_register on tahvo and retu
Date: Thu, 13 Oct 2011 11:35:01 +0300
Message-ID: <1318494902-13093-26-git-send-email-balbi@ti.com>
References: <1318494902-13093-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:59543 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753981Ab1JMIgA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 13 Oct 2011 04:36:00 -0400
Received: by mail-bw0-f52.google.com with SMTP id zs2so133445bkb.39
        for <linux-omap@vger.kernel.org>; Thu, 13 Oct 2011 01:35:58 -0700 (PDT)
In-Reply-To: <1318494902-13093-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Felipe Balbi <balbi@ti.com>

there's no need to use platform_driver_probe() here.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/cbus/retu.c  |    9 +++++----
 drivers/cbus/tahvo.c |    3 ++-
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/cbus/retu.c b/drivers/cbus/retu.c
index 444a21e..35bcb50 100644
--- a/drivers/cbus/retu.c
+++ b/drivers/cbus/retu.c
@@ -427,7 +427,7 @@ static int retu_allocate_children(struct device *parent, int irq_base)
  * Probe for the Retu ASIC and allocate memory
  * for its device-struct if found
  */
-static int __init retu_probe(struct platform_device *pdev)
+static int __devinit retu_probe(struct platform_device *pdev)
 {
 	struct retu	*retu;
 	struct cbus_retu_platform_data *pdata = pdev->dev.platform_data;
@@ -507,7 +507,7 @@ err0:
 	return ret;
 }
 
-static int __exit retu_remove(struct platform_device *pdev)
+static int __devexit retu_remove(struct platform_device *pdev)
 {
 	struct retu		*retu = platform_get_drvdata(pdev);
 
@@ -523,7 +523,8 @@ static int __exit retu_remove(struct platform_device *pdev)
 }
 
 static struct platform_driver retu_driver = {
-	.remove		= __exit_p(retu_remove),
+	.probe		= retu_probe,
+	.remove		= __devexit_p(retu_remove),
 	.driver		= {
 		.name	= "retu",
 	},
@@ -531,7 +532,7 @@ static struct platform_driver retu_driver = {
 
 static int __init retu_init(void)
 {
-	return platform_driver_probe(&retu_driver, retu_probe);
+	return platform_driver_register(&retu_driver);
 }
 subsys_initcall(retu_init);
 
diff --git a/drivers/cbus/tahvo.c b/drivers/cbus/tahvo.c
index c16e27d7..6119d19 100644
--- a/drivers/cbus/tahvo.c
+++ b/drivers/cbus/tahvo.c
@@ -396,6 +396,7 @@ static int __devexit tahvo_remove(struct platform_device *pdev)
 }
 
 static struct platform_driver tahvo_driver = {
+	.probe		= tahvo_probe,
 	.remove		= __devexit_p(tahvo_remove),
 	.driver		= {
 		.name	= "tahvo",
@@ -404,7 +405,7 @@ static struct platform_driver tahvo_driver = {
 
 static int __init tahvo_init(void)
 {
-	return platform_driver_probe(&tahvo_driver, tahvo_probe);
+	return platform_driver_register(&tahvo_driver);
 }
 subsys_initcall(tahvo_init);
 
-- 
1.7.6.396.ge0613

