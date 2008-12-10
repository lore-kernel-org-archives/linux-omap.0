From: "vimal singh" <vimalsingh@ti.com>
Subject: [PATCH - Omapzoom][NAND] 32-bit read in prefetch for NAND
Date: Wed, 10 Dec 2008 15:47:58 +0530 (IST)
Message-ID: <57874.192.168.10.89.1228904278.squirrel@dbdmail.itg.ti.com>
References: <55273.192.168.10.89.1225979835.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:58903 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755162AbYLJKSG (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 10 Dec 2008 05:18:06 -0500
Received: from dlep36.itg.ti.com ([157.170.170.91])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id mBAAHw4Q006125
	for <linux-omap@vger.kernel.org>; Wed, 10 Dec 2008 04:18:03 -0600
Received: from webmail.ti.com (localhost [127.0.0.1])
	by dlep36.itg.ti.com (8.13.8/8.13.8) with ESMTP id mBAAHu91020367
	for <linux-omap@vger.kernel.org>; Wed, 10 Dec 2008 04:17:57 -0600 (CST)
In-Reply-To: <55273.192.168.10.89.1225979835.squirrel@dbdmail.itg.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Changing 16-bit read access to 32-bit to improve the performance in prefetch
support.

Signed-off-by: Vimal Singh <vimalsingh@ti.com>
---
 drivers/mtd/nand/omap2.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

Index: omapkernel/drivers/mtd/nand/omap2.c
===================================================================
--- omapkernel.orig/drivers/mtd/nand/omap2.c	2008-11-06 18:33:49.000000000 +0530
+++ omapkernel/drivers/mtd/nand/omap2.c	2008-11-06 18:36:32.000000000 +0530
@@ -375,27 +375,27 @@
 	struct omap_nand_info *info = container_of(mtd,
 						struct omap_nand_info, mtd);
 	uint32_t prefetch_status = 0, read_count = 0;
-	u16 *p = (u16 *)buf;
+	u32 *p = (u32 *)buf;

 	if ((use_dma && len <= mtd->oobsize) || (!use_dma)) {

 		/* take care of subpage reads */
-		if (len % 2 != 0) {
+		for (; len % 4 != 0; ) {
 			*buf++ = __raw_readb(info->nand.IO_ADDR_R);
-			p = (u16 *) buf;
 			len--;
 		}
+		p = (u32 *) buf;

 		/* configure and start prefetch transfer */
 		gpmc_prefetch_start(info->gpmc_cs, 0x0, len, 0x0);

 		do {
 			prefetch_status = gpmc_prefetch_status();
-			read_count = ((prefetch_status >> 24) & 0x7F) >> 1;
-			__raw_readsw(info->nand_pref_fifo_add, p,
+			read_count = ((prefetch_status >> 24) & 0x7F) >> 2;
+			__raw_readsl(info->nand_pref_fifo_add, p,
 							read_count);
 			p += read_count;
-			len -= read_count << 1;
+			len -= read_count << 2;
 		} while (len);

 		/* disable and stop the PFPW engine */


