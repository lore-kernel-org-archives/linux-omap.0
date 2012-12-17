From: Andreas Fenkart <andreas.fenkart@streamunlimited.com>
Subject: [PATCH] gpio/omap: implement irq_enable/disable using mask/unmask.
Date: Mon, 17 Dec 2012 10:27:17 +0100
Message-ID: <1355736437-14186-1-git-send-email-andreas.fenkart@streamunlimited.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.17.20]:59564 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750797Ab2LQJkE (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 17 Dec 2012 04:40:04 -0500
Received: from mailout-de.gmx.net ([10.1.76.12]) by mrigmx.server.lan
 (mrigmx001) with ESMTP (Nemesis) id 0MOEAc-1TnqMV0Azc-005VWx for
 <linux-omap@vger.kernel.org>; Mon, 17 Dec 2012 10:27:27 +0100
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: santosh.shilimkar@ti.com, khilman@ti.com, grant.likely@secretlab.ca, linus.walleij@linaro.org, linux-omap@vger.kernel.org
Cc: Andreas Fenkart <andreas.fenkart@streamunlimited.com>

Signed-off-by: Andreas Fenkart <andreas.fenkart@streamunlimited.com>
---
 drivers/gpio/gpio-omap.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index d335af1..c1951ec 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -815,6 +815,8 @@ static struct irq_chip gpio_irq_chip = {
 	.irq_unmask	= gpio_unmask_irq,
 	.irq_set_type	= gpio_irq_type,
 	.irq_set_wake	= gpio_wake_enable,
+	.irq_disable    = gpio_mask_irq,
+	.irq_enable     = gpio_unmask_irq,
 };
 
 /*---------------------------------------------------------------------*/
-- 
1.7.10.4

