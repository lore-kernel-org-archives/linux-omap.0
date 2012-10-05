From: Afzal Mohammed <afzal@ti.com>
Subject: [PATCH 04/15] mtd: nand: omap: read nand using register address
Date: Fri, 5 Oct 2012 21:23:48 +0530
Message-ID: <571607de9b49c4d44a03e793a9b36654e5ff4570.1349450454.git.afzal@ti.com>
References: <cover.1349450454.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:40801 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755314Ab2JEPyB (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 5 Oct 2012 11:54:01 -0400
In-Reply-To: <cover.1349450454.git.afzal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Artem Bityutskiy <dedekind1@gmail.com>
Cc: Jon Hunter <jon-hunter@ti.com>, Paul Walmsley <paul@pwsan.com>, David Woodhouse <dwmw2@infradead.org>, Ivan Djelic <ivan.djelic@parrot.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mtd@lists.infradead.org, Afzal Mohammed <afzal@ti.com>

Now that gpmc-nand registers are available in driver, use it
to read nand data.

"65b97cf  mtd: nand: omap2: handle nand on gpmc" modified all
other instances. After initial versions of that patch, a new
change added reading nand data using gpmc exposed function.
In the final version this change was not taken care.

Signed-off-by: Afzal Mohammed <afzal@ti.com>
---
 drivers/mtd/nand/omap2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
index 4c33135..abfc602 100644
--- a/drivers/mtd/nand/omap2.c
+++ b/drivers/mtd/nand/omap2.c
@@ -996,7 +996,7 @@ static int omap_wait(struct mtd_info *mtd, struct nand_chip *chip)
 		cond_resched();
 	}
 
-	status = gpmc_nand_read(info->gpmc_cs, GPMC_NAND_DATA);
+	status = readb(info->reg.gpmc_nand_data);
 	return status;
 }
 
-- 
1.7.12

