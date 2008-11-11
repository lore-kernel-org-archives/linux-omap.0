From: Felipe Balbi <me@felipebalbi.com>
Subject: [rft/rfc/patch-2.6.28-rc3+ 34/59] omap: namespace cleanup to drivers/mtd/nand/omap2.c
Date: Wed, 12 Nov 2008 00:56:53 +0200
Message-ID: <1226444238-14614-35-git-send-email-me@felipebalbi.com>
References: <1226444238-14614-1-git-send-email-me@felipebalbi.com>
 <1226444238-14614-2-git-send-email-me@felipebalbi.com>
 <1226444238-14614-3-git-send-email-me@felipebalbi.com>
 <1226444238-14614-4-git-send-email-me@felipebalbi.com>
 <1226444238-14614-5-git-send-email-me@felipebalbi.com>
 <1226444238-14614-6-git-send-email-me@felipebalbi.com>
 <1226444238-14614-7-git-send-email-me@felipebalbi.com>
 <1226444238-14614-8-git-send-email-me@felipebalbi.com>
 <1226444238-14614-9-git-send-email-me@felipebalbi.com>
 <1226444238-14614-10-git-send-email-me@felipebalbi.com>
 <1226444238-14614-11-git-send-email-me@felipebalbi.com>
 <1226444238-14614-12-git-send-email-me@felipebalbi.com>
 <1226444238-14614-13-git-send-email-me@felipebalbi.com>
 <1226444238-14614-14-git-send-email-me@felipebalbi.com>
 <1226444238-14614-15-git-send-email-me@felipebalbi.com>
 <1226444238-14614-16-git-send-email-me@felipebalbi.com>
 <1226444238-14614-17-git-send-email-me@felipebalbi.com>
 <1226444238-14614-18-git-send-email-me@felipebalbi.com>
 <1226444238-14614-19-git-send-email-me@felipebalbi.com>
 <1226444238-14614-20-git-send-email-me@felipebalbi.com>
 <1226444238-14614-21-git-send-email-me@felipebalbi.com>
 <1226444238-14614-22-git-send-email-me@felipebalbi.com>
 <1226444238-14614-23-git-send-email-me@felipebalbi.com>
 <1226444238-14614-24-git-send-email-me@felipebalbi.com>
 <1226444238-14614-25-git-send-email-me@felipebalbi.com>
 <1226444238-14614-26-git-send-email-me@felipebalbi.com>
 <1226444238-14614-27-git-send-email-me@felipebalbi.com>
 <1226444238-14614-28-git-send-email-me@felipebalbi.com>
 <1226444238-14614-29-git-send-email-me@felipebalbi.com>
 <1226444238-14614-30-git-send-email-me@felipebalbi.com>
 <1226444238-14614-31-git-send-email-me@felipebalbi.com>
 <1226444238-14614-32-git-send-email-me@felipebalbi.com>
 <1226444238-14614-33-git-send-email-me@felipebalbi.com>
 <1226444238-14614-34-git-send-email-me@felipebalbi.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:56676 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751409AbYKKXFi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 11 Nov 2008 18:05:38 -0500
In-Reply-To: <1226444238-14614-34-git-send-email-me@felipebalbi.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Felipe Balbi <felipe.balbi@nokia.com>

From: Felipe Balbi <felipe.balbi@nokia.com>

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 drivers/mtd/nand/omap2.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
index 2ede116..170f235 100644
--- a/drivers/mtd/nand/omap2.c
+++ b/drivers/mtd/nand/omap2.c
@@ -187,12 +187,12 @@ static void omap_hwcontrol(struct mtd_info *mtd, int cmd, unsigned int ctrl)
 }
 
 /*
- * omap_read_buf16 - read data from NAND controller into buffer
+ * __raw_read_buf16 - read data from NAND controller into buffer
  * @mtd: MTD device structure
  * @buf: buffer to store date
  * @len: number of bytes to read
  */
-static void omap_read_buf16(struct mtd_info *mtd, u_char *buf, int len)
+static void __raw_read_buf16(struct mtd_info *mtd, u_char *buf, int len)
 {
 	struct nand_chip *nand = mtd->priv;
 
@@ -200,12 +200,12 @@ static void omap_read_buf16(struct mtd_info *mtd, u_char *buf, int len)
 }
 
 /*
- * omap_write_buf16 - write buffer to NAND controller
+ * __raw_write_buf16 - write buffer to NAND controller
  * @mtd: MTD device structure
  * @buf: data buffer
  * @len: number of bytes to write
  */
-static void omap_write_buf16(struct mtd_info *mtd, const u_char * buf, int len)
+static void __raw_write_buf16(struct mtd_info *mtd, const u_char * buf, int len)
 {
 	struct omap_nand_info *info = container_of(mtd,
 						struct omap_nand_info, mtd);
@@ -641,8 +641,8 @@ static int __devinit omap_nand_probe(struct platform_device *pdev)
 
 	/* REVISIT:  only supports 16-bit NAND flash */
 
-	info->nand.read_buf   = omap_read_buf16;
-	info->nand.write_buf  = omap_write_buf16;
+	info->nand.read_buf   = __raw_read_buf16;
+	info->nand.write_buf  = __raw_write_buf16;
 	info->nand.verify_buf = omap_verify_buf;
 
 	/*
-- 
1.6.0.2.307.gc427

