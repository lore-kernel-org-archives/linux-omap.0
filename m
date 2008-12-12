From: "vimal singh" <vimalsingh@ti.com>
Subject: [PATCH - Omapzoom] [NAND] [OMAP2]: Change __raw_readsl() to
     __raw_readsw()
Date: Fri, 12 Dec 2008 17:47:39 +0530 (IST)
Message-ID: <33411.192.168.10.89.1229084259.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:33693 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754101AbYLLMRq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 12 Dec 2008 07:17:46 -0500
Received: from dlep34.itg.ti.com ([157.170.170.115])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id mBCCHeUX009549
	for <linux-omap@vger.kernel.org>; Fri, 12 Dec 2008 06:17:45 -0600
Received: from webmail.ti.com (localhost [127.0.0.1])
	by dlep34.itg.ti.com (8.13.7/8.13.7) with ESMTP id mBCCHbZJ022897
	for <linux-omap@vger.kernel.org>; Fri, 12 Dec 2008 06:17:38 -0600 (CST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

OMAP2 NAND: Change __raw_readsl() to __raw_readsw()

This patch is taken from linux-omap tree submitted by Juha Kuikka (commit id:
352eeeabb67c2cb2cc613a02a62623790f360224).

Singed-off-by: Vimal Singh <vimalsingh@ti.com>
Signed-off-by: Juha Kuikka <juha.kuikka@gmail.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
Patch is reworked to make it apply on omapzoom tree.

diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
index a542272..cf26958 100644
--- a/drivers/mtd/nand/omap2.c
+++ b/drivers/mtd/nand/omap2.c
@@ -338,7 +338,7 @@ static void omap_read_buf16(struct mtd_info *mtd, u_char
*buf, int len)
 {
 	struct nand_chip *nand = mtd->priv;

-	__raw_readsl(nand->IO_ADDR_R, buf, len / 2);
+	__raw_readsw(nand->IO_ADDR_R, buf, len / 2);
 }

 /*


