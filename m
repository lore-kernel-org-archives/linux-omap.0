From: Felipe Balbi <balbi@ti.com>
Subject: [RFT/PATCH 8/8] cbus: tahvo: avoid section mismatch
Date: Tue, 14 Sep 2010 11:30:16 +0300
Message-ID: <1284453016-8295-9-git-send-email-balbi@ti.com>
References: <1284453016-8295-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:52455 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752516Ab0INIak (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Sep 2010 04:30:40 -0400
In-Reply-To: <1284453016-8295-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux OMAP Mailing List <linux-omap@vger.kernel.org>
Cc: Jarkko Nikula <jhnikula@gmail.com>, Tony Lindgren <tony@atomide.com>, Felipe Balbi <balbi@ti.com>

... by removing references to init section from
platform_driver structure

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/cbus/tahvo.c |    9 ++++-----
 1 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/cbus/tahvo.c b/drivers/cbus/tahvo.c
index 8e41758..2ae1ac4 100644
--- a/drivers/cbus/tahvo.c
+++ b/drivers/cbus/tahvo.c
@@ -301,7 +301,7 @@ EXPORT_SYMBOL(tahvo_free_irq);
  * Probe for the Tahvo ASIC and allocate memory
  * for its device-struct if found
  */
-static int __devinit tahvo_probe(struct platform_device *pdev)
+static int __init tahvo_probe(struct platform_device *pdev)
 {
 	int rev, id, ret;
 	int irq;
@@ -350,7 +350,7 @@ static int __devinit tahvo_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int __devexit tahvo_remove(struct platform_device *pdev)
+static int __exit tahvo_remove(struct platform_device *pdev)
 {
 	int irq;
 
@@ -368,8 +368,7 @@ static int __devexit tahvo_remove(struct platform_device *pdev)
 }
 
 static struct platform_driver tahvo_driver = {
-	.probe		= tahvo_probe,
-	.remove		= __devexit_p(tahvo_remove),
+	.remove		= __exit_p(tahvo_remove),
 	.driver		= {
 		.name	= "tahvo",
 	},
@@ -425,7 +424,7 @@ static int __init tahvo_init(void)
 
 	tahvo_resource[0].start = gpio_to_irq(tahvo_irq_pin);
 
-	ret = platform_driver_register(&tahvo_driver);
+	ret = platform_driver_probe(&tahvo_driver, tahvo_probe);
 	if (ret)
 		goto err1;
 
-- 
1.7.3.rc0.35.g8ac8c

