From: Afzal Mohammed <afzal@ti.com>
Subject: [PATCH 02/15] mtd: onenand: omap: cleanup gpmc dependency
Date: Fri, 5 Oct 2012 21:23:29 +0530
Message-ID: <77643c064b9d0d639f75f793130bb40768b015e1.1349450454.git.afzal@ti.com>
References: <cover.1349450454.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:52545 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755091Ab2JEPxk (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 5 Oct 2012 11:53:40 -0400
In-Reply-To: <cover.1349450454.git.afzal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Artem Bityutskiy <dedekind1@gmail.com>
Cc: Jon Hunter <jon-hunter@ti.com>, Paul Walmsley <paul@pwsan.com>, David Woodhouse <dwmw2@infradead.org>, Ivan Djelic <ivan.djelic@parrot.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mtd@lists.infradead.org, Afzal Mohammed <afzal@ti.com>

requesting, freeing gpmc cs is now handled fully
by gpmc, remove left out gpmc dependency as well
as unnecessary include of gpmc.h

Signed-off-by: Afzal Mohammed <afzal@ti.com>
---
 drivers/mtd/onenand/omap2.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/mtd/onenand/omap2.c b/drivers/mtd/onenand/omap2.c
index 1961be9..d7ef2c9 100644
--- a/drivers/mtd/onenand/omap2.c
+++ b/drivers/mtd/onenand/omap2.c
@@ -38,7 +38,6 @@
 #include <linux/regulator/consumer.h>
 
 #include <asm/mach/flash.h>
-#include <plat/gpmc.h>
 #include <linux/platform_data/mtd-onenand-omap2.h>
 #include <asm/gpio.h>
 
@@ -803,7 +802,6 @@ static int __devexit omap2_onenand_remove(struct platform_device *pdev)
 	}
 	iounmap(c->onenand.base);
 	release_mem_region(c->phys_base, c->mem_size);
-	gpmc_cs_free(c->gpmc_cs);
 	kfree(c);
 
 	return 0;
-- 
1.7.12

