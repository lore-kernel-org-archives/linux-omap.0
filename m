From: "vimal singh" <vimalsingh@ti.com>
Subject: [PATCH - Omapzoom][NAND] removing nand hwecc warning for omap
Date: Thu, 6 Nov 2008 19:10:47 +0530 (IST)
Message-ID: <40956.192.168.10.89.1225978847.squirrel@dbdmail.itg.ti.com>
References: <45877.192.168.10.89.1225366740.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:51456 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753325AbYKFNkx (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 6 Nov 2008 08:40:53 -0500
Received: from dlep33.itg.ti.com ([157.170.170.112])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id mA6DelF6025520
	for <linux-omap@vger.kernel.org>; Thu, 6 Nov 2008 07:40:53 -0600
Received: from webmail.ti.com (localhost [127.0.0.1])
	by dlep33.itg.ti.com (8.13.7/8.13.7) with ESMTP id mA6Dej5r000744
	for <linux-omap@vger.kernel.org>; Thu, 6 Nov 2008 07:40:46 -0600 (CST)
In-Reply-To: <45877.192.168.10.89.1225366740.squirrel@dbdmail.itg.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Removing warning:
drivers/mtd/nand/omap2.c: In function 'omap_calculate_ecc':
drivers/mtd/nand/omap2.c:466: warning: unused variable 'chip'

Signed-off-by: Vimal Singh <vimalsingh@ti.com>

---
 drivers/mtd/nand/omap2.c |    1 -
 1 files changed, 1 deletion(-)

Index: omapkernel/drivers/mtd/nand/omap2.c
===================================================================
--- omapkernel.orig/drivers/mtd/nand/omap2.c	2008-11-06 12:48:05.000000000 +0530
+++ omapkernel/drivers/mtd/nand/omap2.c	2008-11-06 12:48:12.000000000 +0530
@@ -463,7 +463,6 @@
 {
 	struct omap_nand_info *info = container_of(mtd, struct omap_nand_info,
 							mtd);
-	register struct nand_chip *chip = mtd->priv;
 	unsigned long val = 0x0;
 	unsigned long reg;



