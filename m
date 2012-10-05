From: Tobias Klauser <tklauser@distanz.ch>
Subject: [PATCH] gpio/gpio-omap: Use existing pointer to struct device
Date: Fri,  5 Oct 2012 11:37:38 +0200
Message-ID: <1349429858-17943-1-git-send-email-tklauser@distanz.ch>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mx1.zhaw.ch ([160.85.104.50]:64430 "EHLO mx1.zhaw.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755237Ab2JEJpW (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 5 Oct 2012 05:45:22 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>, Kevin Hilman <khilman@ti.com>, Grant Likely <grant.likely@secretlab.ca>, Linus Walleij <linus.walleij@linaro.org>
Cc: linux-omap@vger.kernel.org

A pointer to "pdev->dev" is already stored in "dev", so use it in
devm_kzalloc.

Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
---
 drivers/gpio/gpio-omap.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index 94cbc84..eb73dee 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -1070,7 +1070,7 @@ static int __devinit omap_gpio_probe(struct platform_device *pdev)
 	if (!pdata)
 		return -EINVAL;
 
-	bank = devm_kzalloc(&pdev->dev, sizeof(struct gpio_bank), GFP_KERNEL);
+	bank = devm_kzalloc(dev, sizeof(struct gpio_bank), GFP_KERNEL);
 	if (!bank) {
 		dev_err(dev, "Memory alloc failed\n");
 		return -ENOMEM;
-- 
1.7.5.4

