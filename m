From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: [RFC 02/21] OneNAND OMAP2: Complete gpiolib conversion
Date: Wed, 29 Oct 2008 13:36:10 +0200
Message-ID: <1225280189-6559-3-git-send-email-jarkko.nikula@nokia.com>
References: <1225280189-6559-1-git-send-email-jarkko.nikula@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:53207 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753308AbYJ2LhI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 29 Oct 2008 07:37:08 -0400
Received: from esebh107.NOE.Nokia.com (esebh107.ntc.nokia.com [172.21.143.143])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m9TBaGXE030866
	for <linux-omap@vger.kernel.org>; Wed, 29 Oct 2008 06:37:06 -0500
In-Reply-To: <1225280189-6559-1-git-send-email-jarkko.nikula@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Jarkko Nikula <jarkko.nikula@nokia.com>

Signed-off-by: Jarkko Nikula <jarkko.nikula@nokia.com>
---
 drivers/mtd/onenand/omap2.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/onenand/omap2.c b/drivers/mtd/onenand/omap2.c
index 1298563..87b5120 100644
--- a/drivers/mtd/onenand/omap2.c
+++ b/drivers/mtd/onenand/omap2.c
@@ -32,12 +32,12 @@
 #include <linux/platform_device.h>
 #include <linux/interrupt.h>
 #include <linux/delay.h>
+#include <linux/gpio.h>
 
 #include <asm/io.h>
 #include <asm/mach/flash.h>
 #include <mach/gpmc.h>
 #include <mach/onenand.h>
-#include <mach/gpio.h>
 #include <mach/pm.h>
 
 #include <linux/dma-mapping.h>
@@ -630,7 +630,7 @@ static int __devinit omap2_onenand_probe(struct platform_device *pdev)
 	}
 
 	if (c->gpio_irq) {
-		if ((r = omap_request_gpio(c->gpio_irq)) < 0) {
+		if ((r = gpio_request(c->gpio_irq, "OneNAND irq")) < 0) {
 			dev_err(&pdev->dev,  "Failed to request GPIO%d for "
 				"OneNAND\n", c->gpio_irq);
 			goto err_iounmap;
@@ -727,7 +727,7 @@ err_release_dma:
 		free_irq(gpio_to_irq(c->gpio_irq), c);
 err_release_gpio:
 	if (c->gpio_irq)
-		omap_free_gpio(c->gpio_irq);
+		gpio_free(c->gpio_irq);
 err_iounmap:
 	iounmap(c->onenand.base);
 err_release_mem_region:
@@ -762,7 +762,7 @@ static int __devexit omap2_onenand_remove(struct platform_device *pdev)
 	platform_set_drvdata(pdev, NULL);
 	if (c->gpio_irq) {
 		free_irq(gpio_to_irq(c->gpio_irq), c);
-		omap_free_gpio(c->gpio_irq);
+		gpio_free(c->gpio_irq);
 	}
 	iounmap(c->onenand.base);
 	release_mem_region(c->phys_base, ONENAND_IO_SIZE);
-- 
1.5.6.5

