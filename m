From: Afzal Mohammed <afzal@ti.com>
Subject: [PATCH v2 06/14] mtd: onenand: omap: use pdata info instead of cpu_is
Date: Mon, 8 Oct 2012 11:07:21 +0530
Message-ID: <860ba92c34cbb490beccd5442087087c1751a6a2.1349672877.git.afzal@ti.com>
References: <cover.1349672877.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:35339 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753157Ab2JHFhd (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 8 Oct 2012 01:37:33 -0400
In-Reply-To: <cover.1349672877.git.afzal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Artem Bityutskiy <dedekind1@gmail.com>
Cc: Jon Hunter <jon-hunter@ti.com>, Paul Walmsley <paul@pwsan.com>, David Woodhouse <dwmw2@infradead.org>, Ivan Djelic <ivan.djelic@parrot.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mtd@lists.infradead.org, Afzal Mohammed <afzal@ti.com>

platform data now contains a field to indicate whether
soc belongs to omap34xx family, use it instead of
cpu_is_* check.

This helps in removing dependency of platform specific
header file - cpu.h

Signed-off-by: Afzal Mohammed <afzal@ti.com>
---
 drivers/mtd/onenand/omap2.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/onenand/omap2.c b/drivers/mtd/onenand/omap2.c
index d7ef2c9..959f465 100644
--- a/drivers/mtd/onenand/omap2.c
+++ b/drivers/mtd/onenand/omap2.c
@@ -42,7 +42,6 @@
 #include <asm/gpio.h>
 
 #include <plat/dma.h>
-#include <plat/cpu.h>
 
 #define DRIVER_NAME "omap2-onenand"
 
@@ -62,6 +61,7 @@ struct omap2_onenand {
 	int freq;
 	int (*setup)(void __iomem *base, int *freq_ptr);
 	struct regulator *regulator;
+	u8 flags;
 };
 
 static void omap2_onenand_dma_cb(int lch, u16 ch_status, void *data)
@@ -154,7 +154,7 @@ static int omap2_onenand_wait(struct mtd_info *mtd, int state)
 		if (!(syscfg & ONENAND_SYS_CFG1_IOBE)) {
 			syscfg |= ONENAND_SYS_CFG1_IOBE;
 			write_reg(c, syscfg, ONENAND_REG_SYS_CFG1);
-			if (cpu_is_omap34xx())
+			if (c->flags & ONENAND_IN_OMAP34XX)
 				/* Add a delay to let GPIO settle */
 				syscfg = read_reg(c, ONENAND_REG_SYS_CFG1);
 		}
@@ -638,6 +638,7 @@ static int __devinit omap2_onenand_probe(struct platform_device *pdev)
 
 	init_completion(&c->irq_done);
 	init_completion(&c->dma_done);
+	c->flags = pdata->flags;
 	c->gpmc_cs = pdata->cs;
 	c->gpio_irq = pdata->gpio_irq;
 	c->dma_channel = pdata->dma_channel;
@@ -728,7 +729,7 @@ static int __devinit omap2_onenand_probe(struct platform_device *pdev)
 	this = &c->onenand;
 	if (c->dma_channel >= 0) {
 		this->wait = omap2_onenand_wait;
-		if (cpu_is_omap34xx()) {
+		if (c->flags & ONENAND_IN_OMAP34XX) {
 			this->read_bufferram = omap3_onenand_read_bufferram;
 			this->write_bufferram = omap3_onenand_write_bufferram;
 		} else {
-- 
1.7.12

