From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH v5 06/26] mtd: nand: omap2: Switch to using GPMC-NAND ops for writebuffer empty check
Date: Fri, 19 Feb 2016 23:15:28 +0200
Message-ID: <1455916548-3441-7-git-send-email-rogerq@ti.com>
References: <1455916548-3441-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1455916548-3441-1-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com, computersforpeace@gmail.com
Cc: dwmw2@infradead.org, ezequiel@vanguardiasur.com.ar, javier@dowhile0.org, fcooper@ti.com, nsekhar@ti.com, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

Instead of accessing the gpmc_status register directly start
using the gpmc_nand_ops->nand_writebuffer_empty() helper
to check write buffer empty status.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 drivers/mtd/nand/omap2.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
index eb18c04..088ff62 100644
--- a/drivers/mtd/nand/omap2.c
+++ b/drivers/mtd/nand/omap2.c
@@ -291,14 +291,13 @@ static void omap_write_buf8(struct mtd_info *mtd, const u_char *buf, int len)
 {
 	struct omap_nand_info *info = mtd_to_omap(mtd);
 	u_char *p = (u_char *)buf;
-	u32	status = 0;
+	bool status;
 
 	while (len--) {
 		iowrite8(*p++, info->nand.IO_ADDR_W);
 		/* wait until buffer is available for write */
 		do {
-			status = readl(info->reg.gpmc_status) &
-					STATUS_BUFF_EMPTY;
+			status = info->ops->nand_writebuffer_empty();
 		} while (!status);
 	}
 }
@@ -326,7 +325,7 @@ static void omap_write_buf16(struct mtd_info *mtd, const u_char * buf, int len)
 {
 	struct omap_nand_info *info = mtd_to_omap(mtd);
 	u16 *p = (u16 *) buf;
-	u32	status = 0;
+	bool status;
 	/* FIXME try bursts of writesw() or DMA ... */
 	len >>= 1;
 
@@ -334,8 +333,7 @@ static void omap_write_buf16(struct mtd_info *mtd, const u_char * buf, int len)
 		iowrite16(*p++, info->nand.IO_ADDR_W);
 		/* wait until buffer is available for write */
 		do {
-			status = readl(info->reg.gpmc_status) &
-					STATUS_BUFF_EMPTY;
+			status = info->ops->nand_writebuffer_empty();
 		} while (!status);
 	}
 }
-- 
2.1.4
