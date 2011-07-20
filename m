From: Jan Weitzel <j.weitzel@phytec.de>
Subject: [PATCH v2] MTD: Nand: use MTD_NAND_OMAP2 for OMAP4
Date: Wed, 20 Jul 2011 09:28:04 +0200
Message-ID: <1311146884-22255-1-git-send-email-j.weitzel@phytec.de>
References: <1311137590.20738.135.camel@sauron>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.rapiddevelopmentkit.de ([217.6.246.34]:56948 "EHLO
	root.phytec.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750777Ab1GTH2H (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 20 Jul 2011 03:28:07 -0400
In-Reply-To: <1311137590.20738.135.camel@sauron>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-mtd@lists.infradead.org
Cc: Artem.Bityutskiy@nokia.com, vimalsingh@ti.com, Jan Weitzel <j.weitzel@phytec.de>

use MTD_NAND_OMAP2 also for OMAP4 arch.
testes wit omap4430

Signed-off-by: Jan Weitzel <j.weitzel@phytec.de>
---
v2: add menuconfig description

 drivers/mtd/nand/Kconfig |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/nand/Kconfig b/drivers/mtd/nand/Kconfig
index 4c34252..2a7d305 100644
--- a/drivers/mtd/nand/Kconfig
+++ b/drivers/mtd/nand/Kconfig
@@ -116,10 +116,11 @@ config MTD_NAND_AMS_DELTA
 	  Support for NAND flash on Amstrad E3 (Delta).
 
 config MTD_NAND_OMAP2
-	tristate "NAND Flash device on OMAP2 and OMAP3"
-	depends on ARM && (ARCH_OMAP2 || ARCH_OMAP3)
+	tristate "NAND Flash device on OMAP2, OMAP3 and OMAP4"
+	depends on ARM && (ARCH_OMAP2 || ARCH_OMAP3 || ARCH_OMAP4)
 	help
-          Support for NAND flash on Texas Instruments OMAP2 and OMAP3 platforms.
+          Support for NAND flash on Texas Instruments OMAP2, OMAP3 and OMAP4
+	  platforms.
 
 config MTD_NAND_IDS
 	tristate
-- 
1.7.0.4

