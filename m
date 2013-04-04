From: Jon Hunter <jon-hunter@ti.com>
Subject: [PATCH 1/5] gpio/omap: free irq domain in probe() failure paths
Date: Thu, 4 Apr 2013 15:16:12 -0500
Message-ID: <1365106576-31816-2-git-send-email-jon-hunter@ti.com>
References: <1365106576-31816-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:60931 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763426Ab3DDUQe (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 4 Apr 2013 16:16:34 -0400
In-Reply-To: <1365106576-31816-1-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, Grant Likely <grant.likely@secretlab.ca>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Kevin Hilman <khilman@linaro.org>
Cc: device-tree <devicetree-discuss@lists.ozlabs.org>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Jon Hunter <jon-hunter@ti.com>

Currently the IRQ domain is not freed once allocated, in the case where
omap_gpio_probe() fails. Therefore, ensure we free the domain if the
probe does fail. Furthermore, the local variable "ret" is not needed
and so remove this.

Signed-off-by: Jon Hunter <jon-hunter@ti.com>
---
 drivers/gpio/gpio-omap.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index 0d30c7a..1e666c8 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -1094,7 +1094,6 @@ static int omap_gpio_probe(struct platform_device *pdev)
 	const struct omap_gpio_platform_data *pdata;
 	struct resource *res;
 	struct gpio_bank *bank;
-	int ret = 0;
 
 	match = of_match_device(of_match_ptr(omap_gpio_match), dev);
 
@@ -1143,18 +1142,21 @@ static int omap_gpio_probe(struct platform_device *pdev)
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (unlikely(!res)) {
 		dev_err(dev, "Invalid mem resource\n");
+		irq_domain_remove(bank->domain);
 		return -ENODEV;
 	}
 
 	if (!devm_request_mem_region(dev, res->start, resource_size(res),
 				     pdev->name)) {
 		dev_err(dev, "Region already claimed\n");
+		irq_domain_remove(bank->domain);
 		return -EBUSY;
 	}
 
 	bank->base = devm_ioremap(dev, res->start, resource_size(res));
 	if (!bank->base) {
 		dev_err(dev, "Could not ioremap\n");
+		irq_domain_remove(bank->domain);
 		return -ENOMEM;
 	}
 
@@ -1178,7 +1180,7 @@ static int omap_gpio_probe(struct platform_device *pdev)
 
 	list_add_tail(&bank->node, &omap_gpio_list);
 
-	return ret;
+	return 0;
 }
 
 #ifdef CONFIG_ARCH_OMAP2PLUS
-- 
1.7.10.4

