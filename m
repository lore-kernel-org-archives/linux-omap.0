From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH 2/2] mtd: nand: omap: Correct CONFIG_MTD_NAND_OMAP_BCH help message
Date: Wed, 1 Oct 2014 14:33:30 +0300
Message-ID: <1412163210-12948-3-git-send-email-rogerq@ti.com>
References: <1412163210-12948-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:50180 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751092AbaJALeM (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 1 Oct 2014 07:34:12 -0400
In-Reply-To: <1412163210-12948-1-git-send-email-rogerq@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: computersforpeace@gmail.com
Cc: ezequiel.garcia@free-electrons.com, pekon@pek-sem.com, arnd@arndb.de, dwmw2@infradead.org, linux-mtd@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Roger Quadros <rogerq@ti.com>

The MTD_NAND_OMAP_BCH doesn't harm on legacy OMAP platforms
so don't state that it should be disabled for them.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 drivers/mtd/nand/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/Kconfig b/drivers/mtd/nand/Kconfig
index 1cb4b1b..dd10646 100644
--- a/drivers/mtd/nand/Kconfig
+++ b/drivers/mtd/nand/Kconfig
@@ -104,7 +104,7 @@ config MTD_NAND_OMAP_BCH
 	  locate and correct errors when using BCH ECC scheme. This offloads
 	  the cpu from doing ECC error searching and correction. However some
 	  legacy OMAP families like OMAP2xxx, OMAP3xxx do not have ELM engine
-	  so they should not enable this config symbol.
+	  so this is optional for them.
 
 config MTD_NAND_OMAP_BCH_BUILD
 	def_tristate MTD_NAND_OMAP2 && MTD_NAND_OMAP_BCH
-- 
1.8.3.2

