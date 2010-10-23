From: Enric Balletbo i Serra <eballetbo@gmail.com>
Subject: [PATCH 1/1] mtd: OneNAND: fix bufferram management when chip has 2-planes.
Date: Sat, 23 Oct 2010 15:43:54 +0200
Message-ID: <1287841434-3349-2-git-send-email-eballetbo@gmail.com>
References: <1287841434-3349-1-git-send-email-eballetbo@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:37127 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756981Ab0JWNoO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 23 Oct 2010 09:44:14 -0400
Received: by wwe15 with SMTP id 15so1916831wwe.1
        for <linux-omap@vger.kernel.org>; Sat, 23 Oct 2010 06:44:12 -0700 (PDT)
In-Reply-To: <1287841434-3349-1-git-send-email-eballetbo@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-mtd@lists.infradead.org, kyungmin.park@samsung.com, dwmw2@infradead.org, Artem.Bityutskiy@nokia.com, adrian.hunter@nokia.com, m.szyprowski@samsung.com
Cc: Enric Balletbo i Serra <eballetbo@gmail.com>

This patch adds code that I think was lost when it was applied the commit
  5988af2319781bc8e0ce418affec4e09cfa77907 - mtd: Flex-OneNAND support

Test case:
 1. Stress a jffs2 filesystem using
    bonnie++ -u 0:0 -s 32 -m 16 -r 16
 2. dmesg shows various 'Header CRC failed' errors like:
    Header CRC failed on REF_PRISTINE node at 0x1e81315c: Read 0x000000e0,
    calculated 0x564fc9e8

Tested on IGEP v2 board with a Muxed OneNAND(DDP) 512MB 1.8V 16-bit (0x58)
with 2 planes from Numonyx and CONFIG_MTD_ONENAND_2X_PROGRAM set to y

Signed-off-by: Enric Balletbo i Serra <eballetbo@gmail.com>
---
 drivers/mtd/onenand/onenand_base.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/mtd/onenand/onenand_base.c b/drivers/mtd/onenand/onenand_base.c
index a2bb520..53aa13e 100644
--- a/drivers/mtd/onenand/onenand_base.c
+++ b/drivers/mtd/onenand/onenand_base.c
@@ -1964,6 +1964,10 @@ static int onenand_write_ops_nolock(struct mtd_info *mtd, loff_t to,
 
 			/* In partial page write we don't update bufferram */
 			onenand_update_bufferram(mtd, to, !ret && !subpage);
+			ONENAND_SET_BUFFERRAM1(this);
+			onenand_update_bufferram(mtd, to + this->writesize,
+				!ret && !subpage);
+
 			if (ret) {
 				printk(KERN_ERR "%s: write failed %d\n",
 					__func__, ret);
-- 
1.7.1

