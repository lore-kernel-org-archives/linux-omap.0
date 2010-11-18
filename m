From: Sukumar Ghorai <s-ghorai@ti.com>
Subject: [PATCH] omap: nand: remove hardware ECC as default
Date: Thu, 18 Nov 2010 19:52:10 +0530
Message-ID: <1290090130-20835-1-git-send-email-s-ghorai@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:40068 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752190Ab0KROWX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Nov 2010 09:22:23 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-mtd@lists.infradead.org, Sukumar Ghorai <s-ghorai@ti.com>

CONFIG_MTD_NAND_OMAP_HWECC defined wronly in patch submitted during 2.6.36
that using the hardware ECC by default

Signed-off-by: Sukumar Ghorai <s-ghorai@ti.com>
---
 drivers/mtd/nand/omap2.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
index cd41c58..15682ec 100644
--- a/drivers/mtd/nand/omap2.c
+++ b/drivers/mtd/nand/omap2.c
@@ -7,7 +7,6 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
-#define CONFIG_MTD_NAND_OMAP_HWECC
 
 #include <linux/platform_device.h>
 #include <linux/dma-mapping.h>
-- 
1.7.0.4

