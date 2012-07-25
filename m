From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 1/6] w1: omap-hdq: add section annotation to remove
Date: Wed, 25 Jul 2012 15:05:27 +0300
Message-ID: <1343217932-25372-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog138.obsmtp.com ([74.125.149.19]:41915 "EHLO
	na3sys009aog138.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932089Ab2GYMIs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 25 Jul 2012 08:08:48 -0400
Received: by lbbgm6 with SMTP id gm6so583193lbb.19
        for <linux-omap@vger.kernel.org>; Wed, 25 Jul 2012 05:08:45 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: zbr@ioremap.net
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Felipe Balbi <balbi@ti.com>

trivial patch, no functional changes.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/w1/masters/omap_hdq.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/w1/masters/omap_hdq.c b/drivers/w1/masters/omap_hdq.c
index 291897c..46e1f6f 100644
--- a/drivers/w1/masters/omap_hdq.c
+++ b/drivers/w1/masters/omap_hdq.c
@@ -73,11 +73,11 @@ struct hdq_data {
 };
 
 static int __devinit omap_hdq_probe(struct platform_device *pdev);
-static int omap_hdq_remove(struct platform_device *pdev);
+static int __devexit omap_hdq_remove(struct platform_device *pdev);
 
 static struct platform_driver omap_hdq_driver = {
 	.probe =	omap_hdq_probe,
-	.remove =	omap_hdq_remove,
+	.remove =	__devexit_p(omap_hdq_remove),
 	.driver =	{
 		.name =	"omap_hdq",
 	},
@@ -630,7 +630,7 @@ err_kmalloc:
 
 }
 
-static int omap_hdq_remove(struct platform_device *pdev)
+static int __devexit omap_hdq_remove(struct platform_device *pdev)
 {
 	struct hdq_data *hdq_data = platform_get_drvdata(pdev);
 
-- 
1.7.11

