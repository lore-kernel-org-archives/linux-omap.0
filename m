From: "Arnout Vandecappelle (Essensium/Mind)" <arnout@mind.be>
Subject: [PATCH] mtd: omap2-nand: avoid unaligned DMA accesses, fall back on prefetch method
Date: Thu, 20 Sep 2012 17:44:10 +0200
Message-ID: <1348155850-26174-1-git-send-email-arnout@mind.be>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 132.79-246-81.adsl-static.isp.belgacom.be ([81.246.79.132]:34608
	"EHLO viper.mind.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755109Ab2ITPom (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 20 Sep 2012 11:44:42 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>, Tony Lindgren <tony@atomide.com>
Cc: "Arnout Vandecappelle (Essensium/Mind)" <arnout@mind.be>, Sven Krauss <sven.krauss@web.de>

From: "Arnout Vandecappelle (Essensium/Mind)" <arnout@mind.be>

The buffers given to the read_buf and write_buf methods are not
necessarily u32-aligned, while the DMA engine is configured with
32-bit accesses.  As a consequence, the DMA engine gives an error
which appears in the log as follows:

DMA misaligned error with device 4

After this, no accesses to the NAND are possible anymore because the
access never completes.  This usually means the system hangs if the
rootfs is in NAND.

To avoid this, use the prefetch method if the buffer is not aligned.

It's difficult to reproduce the error, because the buffers are
aligned most of the time.

This bug and a patch was originally reported by Sven Krauss in
http://article.gmane.org/gmane.linux.drivers.mtd/34548

Signed-off-by: Arnout Vandecappelle (Essensium/Mind) <arnout@mind.be>
Cc: Sven Krauss <sven.krauss@web.de>
---
Perhaps a better method is to fetch the first few unaligned bytes
with the prefetch method, and then continue with DMA.  However,
since it's hard to force an unaligned buffer, it's also hard to
test that this method works.
---
 drivers/mtd/nand/omap2.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
index c719b86..a313e83 100644
--- a/drivers/mtd/nand/omap2.c
+++ b/drivers/mtd/nand/omap2.c
@@ -441,7 +441,7 @@ out_copy:
  */
 static void omap_read_buf_dma_pref(struct mtd_info *mtd, u_char *buf, int len)
 {
-	if (len <= mtd->oobsize)
+	if (len <= mtd->oobsize || !IS_ALIGNED((unsigned long)buf, 4))
 		omap_read_buf_pref(mtd, buf, len);
 	else
 		/* start transfer in DMA mode */
@@ -457,7 +457,7 @@ static void omap_read_buf_dma_pref(struct mtd_info *mtd, u_char *buf, int len)
 static void omap_write_buf_dma_pref(struct mtd_info *mtd,
 					const u_char *buf, int len)
 {
-	if (len <= mtd->oobsize)
+	if (len <= mtd->oobsize || !IS_ALIGNED((unsigned long)buf, 4))
 		omap_write_buf_pref(mtd, buf, len);
 	else
 		/* start transfer in DMA mode */
-- 
1.7.10.4

