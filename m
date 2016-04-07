From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH v6 07/17] mtd: nand: omap: Switch to using GPMC-NAND ops for
 writebuffer empty check
Date: Thu, 7 Apr 2016 13:08:25 +0300
Message-ID: <1460023715-19332-8-git-send-email-rogerq@ti.com>
References: <1460023715-19332-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <1460023715-19332-1-git-send-email-rogerq@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
To: tony@atomide.com, computersforpeace@gmail.com, boris.brezillon@free-electrons.com
Cc: devicetree@vger.kernel.org, nsekhar@ti.com, linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org, ezequiel@vanguardiasur.com.ar, javier@dowhile0.org, linux-omap@vger.kernel.org, dwmw2@infradead.org, fcooper@ti.com, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

Instead of accessing the gpmc_status register directly start
using the gpmc_nand_ops->nand_writebuffer_empty() helper
to check write buffer empty status.

Signed-off-by: Roger Quadros <rogerq@ti.com>
Acked-by: Brian Norris <computersforpeace@gmail.com>
---
 drivers/mtd/nand/omap2.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
index cba9bf0..98023d5 100644
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
2.5.0


______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
