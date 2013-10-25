From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: [PATCH v2 3/5] mtd: nand: omap2: Fix OMAP_BCH option dependency
Date: Fri, 25 Oct 2013 07:17:55 -0300
Message-ID: <1382696277-9063-4-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1382696277-9063-1-git-send-email-ezequiel.garcia@free-electrons.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:54099 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753095Ab3JYKSP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 25 Oct 2013 06:18:15 -0400
In-Reply-To: <1382696277-9063-1-git-send-email-ezequiel.garcia@free-electrons.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org
Cc: Brian Norris <computersforpeace@gmail.com>, Pekon Gupta <pekon@ti.com>, Felipe Balbi <balbi@ti.com>, marek.belisko@gmail.com, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>

This option does not need to depend in MTD_NAND, for it's enclosed
under it. Also, it's wrong to make it depend in ARCH_OMAP3 only
since the controller is used in a wider range of SoCs.

Instead, just leave the dependency on the OMAP2 driver option.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 drivers/mtd/nand/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/Kconfig b/drivers/mtd/nand/Kconfig
index d885298..8187466 100644
--- a/drivers/mtd/nand/Kconfig
+++ b/drivers/mtd/nand/Kconfig
@@ -95,7 +95,7 @@ config MTD_NAND_OMAP2
 	  platforms.
 
 config MTD_NAND_OMAP_BCH
-	depends on MTD_NAND && MTD_NAND_OMAP2 && ARCH_OMAP3
+	depends on MTD_NAND_OMAP2
 	tristate "Enable support for hardware BCH error correction"
 	default n
 	select BCH
-- 
1.8.1.5

