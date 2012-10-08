From: Afzal Mohammed <afzal@ti.com>
Subject: [PATCH v2 09/14] mtd: nand: omap: bring in gpmc nand macros
Date: Mon, 8 Oct 2012 11:07:40 +0530
Message-ID: <2c357dd43c39a04e7f7fc773e425381fb1b2febe.1349672877.git.afzal@ti.com>
References: <cover.1349672877.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:55270 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751969Ab2JHFhw (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 8 Oct 2012 01:37:52 -0400
In-Reply-To: <cover.1349672877.git.afzal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Artem Bityutskiy <dedekind1@gmail.com>
Cc: Jon Hunter <jon-hunter@ti.com>, Paul Walmsley <paul@pwsan.com>, David Woodhouse <dwmw2@infradead.org>, Ivan Djelic <ivan.djelic@parrot.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mtd@lists.infradead.org, Afzal Mohammed <afzal@ti.com>

Bring onto driver the macros defined in gpmc.h that are
not necessary outside driver, helps in removing inclusion
of gpmc.h too. Also remove GPMC prefix on those macros to
make clear it's independence with gpmc header.

Signed-off-by: Afzal Mohammed <afzal@ti.com>
---
 drivers/mtd/nand/omap2.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
index abfc602..f0a1b1d 100644
--- a/drivers/mtd/nand/omap2.c
+++ b/drivers/mtd/nand/omap2.c
@@ -110,6 +110,11 @@
 #define	ECC1RESULTSIZE			0x1
 #define	ECCCLEAR			0x100
 #define	ECC1				0x1
+#define	PREFETCH_FIFOTHRESHOLD_MAX	0x40
+#define	PREFETCH_FIFOTHRESHOLD(val)	((val) << 8)
+#define	PREFETCH_STATUS_COUNT(val)	(val & 0x00003fff)
+#define	PREFETCH_STATUS_FIFO_CNT(val)	((val >> 24) & 0x7F)
+#define	STATUS_BUFF_EMPTY		0x00000001
 
 /* oob info generated runtime depending on ecc algorithm and layout selected */
 static struct nand_ecclayout omap_oobinfo;
@@ -269,7 +274,7 @@ static void omap_write_buf8(struct mtd_info *mtd, const u_char *buf, int len)
 		/* wait until buffer is available for write */
 		do {
 			status = readl(info->reg.gpmc_status) &
-					GPMC_STATUS_BUFF_EMPTY;
+					STATUS_BUFF_EMPTY;
 		} while (!status);
 	}
 }
@@ -307,7 +312,7 @@ static void omap_write_buf16(struct mtd_info *mtd, const u_char * buf, int len)
 		/* wait until buffer is available for write */
 		do {
 			status = readl(info->reg.gpmc_status) &
-					GPMC_STATUS_BUFF_EMPTY;
+					STATUS_BUFF_EMPTY;
 		} while (!status);
 	}
 }
@@ -348,7 +353,7 @@ static void omap_read_buf_pref(struct mtd_info *mtd, u_char *buf, int len)
 	} else {
 		do {
 			r_count = readl(info->reg.gpmc_prefetch_status);
-			r_count = GPMC_PREFETCH_STATUS_FIFO_CNT(r_count);
+			r_count = PREFETCH_STATUS_FIFO_CNT(r_count);
 			r_count = r_count >> 2;
 			ioread32_rep(info->nand.IO_ADDR_R, p, r_count);
 			p += r_count;
@@ -395,7 +400,7 @@ static void omap_write_buf_pref(struct mtd_info *mtd,
 	} else {
 		while (len) {
 			w_count = readl(info->reg.gpmc_prefetch_status);
-			w_count = GPMC_PREFETCH_STATUS_FIFO_CNT(w_count);
+			w_count = PREFETCH_STATUS_FIFO_CNT(w_count);
 			w_count = w_count >> 1;
 			for (i = 0; (i < w_count) && len; i++, len -= 2)
 				iowrite16(*p++, info->nand.IO_ADDR_W);
@@ -407,7 +412,7 @@ static void omap_write_buf_pref(struct mtd_info *mtd,
 		do {
 			cpu_relax();
 			val = readl(info->reg.gpmc_prefetch_status);
-			val = GPMC_PREFETCH_STATUS_COUNT(val);
+			val = PREFETCH_STATUS_COUNT(val);
 		} while (val && (tim++ < limit));
 
 		/* disable and stop the PFPW engine */
@@ -493,7 +498,7 @@ static inline int omap_nand_dma_transfer(struct mtd_info *mtd, void *addr,
 	do {
 		cpu_relax();
 		val = readl(info->reg.gpmc_prefetch_status);
-		val = GPMC_PREFETCH_STATUS_COUNT(val);
+		val = PREFETCH_STATUS_COUNT(val);
 	} while (val && (tim++ < limit));
 
 	/* disable and stop the PFPW engine */
@@ -556,7 +561,7 @@ static irqreturn_t omap_nand_irq(int this_irq, void *dev)
 	u32 bytes;
 
 	bytes = readl(info->reg.gpmc_prefetch_status);
-	bytes = GPMC_PREFETCH_STATUS_FIFO_CNT(bytes);
+	bytes = PREFETCH_STATUS_FIFO_CNT(bytes);
 	bytes = bytes  & 0xFFFC; /* io in multiple of 4 bytes */
 	if (info->iomode == OMAP_NAND_IO_WRITE) { /* checks for write io */
 		if (this_irq == info->gpmc_irq_count)
@@ -682,7 +687,7 @@ static void omap_write_buf_irq_pref(struct mtd_info *mtd,
 	limit = (loops_per_jiffy *  msecs_to_jiffies(OMAP_NAND_TIMEOUT_MS));
 	do {
 		val = readl(info->reg.gpmc_prefetch_status);
-		val = GPMC_PREFETCH_STATUS_COUNT(val);
+		val = PREFETCH_STATUS_COUNT(val);
 		cpu_relax();
 	} while (val && (tim++ < limit));
 
-- 
1.7.12

