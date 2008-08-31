From: David Brownell <david-b@pacbell.net>
Subject: [patch 2.6.27-rc3-omap1] omap2_nand updates
Date: Sun, 31 Aug 2008 14:19:05 -0700
Message-ID: <200808311419.05598.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp124.sbc.mail.sp1.yahoo.com ([69.147.64.97]:27551 "HELO
	smtp124.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1758126AbYHaVTR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sun, 31 Aug 2008 17:19:17 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: David Brownell <dbrownell@users.sourceforge.net>

Minor updates to the OMAP{2,3} NAND driver:

 - Rename those buffer PIO routines as *_buf16()
 - Get rid of pointless LE16 data conversions; OMAP is always LE
 - Speed up buffer reads by switching to __raw_readsl()

Right now this driver only handles 16-bit NAND, but eventually it
should handle 8-bit too.  Moreover it may be worth using DMA...

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
---
 drivers/mtd/nand/omap2.c |   26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

--- a/drivers/mtd/nand/omap2.c	2008-08-10 21:17:47.000000000 -0700
+++ b/drivers/mtd/nand/omap2.c	2008-08-10 21:19:46.000000000 -0700
@@ -187,39 +187,35 @@ static void omap_hwcontrol(struct mtd_in
 }
 
 /*
- * omap_read_buf - read data from NAND controller into buffer
+ * omap_read_buf16 - read data from NAND controller into buffer
  * @mtd: MTD device structure
  * @buf: buffer to store date
  * @len: number of bytes to read
  */
-static void omap_read_buf(struct mtd_info *mtd, u_char *buf, int len)
+static void omap_read_buf16(struct mtd_info *mtd, u_char *buf, int len)
 {
-	struct omap_nand_info *info = container_of(mtd,
-					struct omap_nand_info, mtd);
-	u16 *p = (u16 *) buf;
-
-	len >>= 1;
+	struct nand_chip *nand = mtd->priv;
 
-	while (len--)
-		*p++ = cpu_to_le16(readw(info->nand.IO_ADDR_R));
+	__raw_readsl(nand->IO_ADDR_R, buf, len / 2);
 }
 
 /*
- * omap_write_buf - write buffer to NAND controller
+ * omap_write_buf16 - write buffer to NAND controller
  * @mtd: MTD device structure
  * @buf: data buffer
  * @len: number of bytes to write
  */
-static void omap_write_buf(struct mtd_info *mtd, const u_char * buf, int len)
+static void omap_write_buf16(struct mtd_info *mtd, const u_char * buf, int len)
 {
 	struct omap_nand_info *info = container_of(mtd,
 						struct omap_nand_info, mtd);
 	u16 *p = (u16 *) buf;
 
+	/* FIXME try bursts of writesw() or DMA ... */
 	len >>= 1;
 
 	while (len--) {
-		writew(cpu_to_le16(*p++), info->nand.IO_ADDR_W);
+		writew(*p++, info->nand.IO_ADDR_W);
 
 		while (GPMC_BUF_EMPTY == (readl(info->gpmc_baseaddr +
 						GPMC_STATUS) & GPMC_BUF_FULL));
@@ -643,8 +639,10 @@ static int __devinit omap_nand_probe(str
 	info->nand.IO_ADDR_W = info->nand.IO_ADDR_R;
 	info->nand.cmd_ctrl  = omap_hwcontrol;
 
-	info->nand.read_buf   = omap_read_buf;
-	info->nand.write_buf  = omap_write_buf;
+	/* REVISIT:  only supports 16-bit NAND flash */
+
+	info->nand.read_buf   = omap_read_buf16;
+	info->nand.write_buf  = omap_write_buf16;
 	info->nand.verify_buf = omap_verify_buf;
 
 	/*
