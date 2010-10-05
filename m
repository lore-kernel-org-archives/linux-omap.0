From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: [PATCH v3] OMAP2/3: NAND: Convert write/read functions to raw read/write
Date: Wed,  6 Oct 2010 03:26:58 +0530
Message-ID: <1286315819-5906-3-git-send-email-manjugk@ti.com>
References: <1286315819-5906-1-git-send-email-manjugk@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:42197 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757227Ab0JEV4d (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 5 Oct 2010 17:56:33 -0400
In-Reply-To: <1286315819-5906-1-git-send-email-manjugk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-mtd@lists.infradead.org

Following sparse warnings exists due to use of writel/w and readl/w functions.

This patch fixes the sparse warnings by converting readl/w functions usage into
__raw_readl/__raw_readw functions.

drivers/mtd/nand/omap2.c:484:15: warning: symbol '__v' shadows an earlier one
drivers/mtd/nand/omap2.c:484:15: originally declared here

drivers/mtd/onenand/omap2.c:86:9: warning: symbol '__v' shadows an earlier one
drivers/mtd/onenand/omap2.c:86:9: originally declared here

Signed-off-by: G, Manjunath Kondaiah <manjugk@ti.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-mtd@lists.infradead.org
---
Changes since v1 and v2:
 - no logical changes, patch seperated from series based on Tony's suggestion.

 drivers/mtd/nand/omap2.c    |    2 +-
 drivers/mtd/onenand/omap2.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
index 439e80d..23d2810 100644
--- a/drivers/mtd/nand/omap2.c
+++ b/drivers/mtd/nand/omap2.c
@@ -481,7 +481,7 @@ static int omap_verify_buf(struct mtd_info *mtd, const u_char * buf, int len)
 
 	len >>= 1;
 	while (len--) {
-		if (*p++ != cpu_to_le16(readw(info->nand.IO_ADDR_R)))
+		if (*p++ != cpu_to_le16(__raw_readw(info->nand.IO_ADDR_R)))
 			return -EFAULT;
 	}
 
diff --git a/drivers/mtd/onenand/omap2.c b/drivers/mtd/onenand/omap2.c
index 608cc8d..b6a2b9f 100644
--- a/drivers/mtd/onenand/omap2.c
+++ b/drivers/mtd/onenand/omap2.c
@@ -83,7 +83,7 @@ static irqreturn_t omap2_onenand_interrupt(int irq, void *dev_id)
 
 static inline unsigned short read_reg(struct omap2_onenand *c, int reg)
 {
-	return readw(c->onenand.base + reg);
+	return __raw_readw(c->onenand.base + reg);
 }
 
 static inline void write_reg(struct omap2_onenand *c, unsigned short value,
-- 
1.7.0.4

