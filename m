From: Adrian Hunter <ext-adrian.hunter@nokia.com>
Subject: [PATCH] [MTD] OneNAND OMAP3: add delay for GPIO
Date: Thu, 14 Aug 2008 14:00:12 +0300
Message-ID: <48A4103C.9090603@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:39189 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752450AbYHNK6F (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 14 Aug 2008 06:58:05 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>
Cc: linux-omap@vger.kernel.org

On OMAP3, the driver was occasionally not seeing the GPIO
interrupt.  Adding a small delay of one register read
eliminates the problem.

Signed-off-by: Adrian Hunter <ext-adrian.hunter@nokia.com>
---
 drivers/mtd/onenand/omap2.c |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/onenand/omap2.c b/drivers/mtd/onenand/omap2.c
index 2bd8746..bf6bba5 100644
--- a/drivers/mtd/onenand/omap2.c
+++ b/drivers/mtd/onenand/omap2.c
@@ -141,8 +141,13 @@ static int omap2_onenand_wait(struct mtd_info *mtd, int state)
 
 		/* Turn interrupts on */
 		syscfg = read_reg(c, ONENAND_REG_SYS_CFG1);
-		syscfg |= ONENAND_SYS_CFG1_IOBE;
-		write_reg(c, syscfg, ONENAND_REG_SYS_CFG1);
+		if (!(syscfg & ONENAND_SYS_CFG1_IOBE)) {
+			syscfg |= ONENAND_SYS_CFG1_IOBE;
+			write_reg(c, syscfg, ONENAND_REG_SYS_CFG1);
+			if (cpu_is_omap34xx())
+				/* Add a delay to let GPIO settle */
+				syscfg = read_reg(c, ONENAND_REG_SYS_CFG1);
+		}
 
 		INIT_COMPLETION(c->irq_done);
 		if (c->gpio_irq) {
-- 
1.5.4.3
