From: Jan Weitzel <j.weitzel@phytec.de>
Subject: [PATCH] MTD: Nand: use MTD_NAND_OMAP2 for OMAP4
Date: Fri, 15 Jul 2011 12:52:54 +0200
Message-ID: <1310727174-8183-1-git-send-email-j.weitzel@phytec.de>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.visioncatalog.com ([217.6.246.34]:49525 "EHLO
	root.phytec.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965172Ab1GOKw5 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 15 Jul 2011 06:52:57 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-mtd@lists.infradead.org
Cc: Artem.Bityutskiy@nokia.com, vimalsingh@ti.com, Jan Weitzel <j.weitzel@phytec.de>

use MTD_NAND_OMAP2 also for OMAP4 arch.
testes wit omap4430

Signed-off-by: Jan Weitzel <j.weitzel@phytec.de>
---
 drivers/mtd/nand/Kconfig |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/Kconfig b/drivers/mtd/nand/Kconfig
index 4c34252..40e64b8 100644
--- a/drivers/mtd/nand/Kconfig
+++ b/drivers/mtd/nand/Kconfig
@@ -117,9 +117,10 @@ config MTD_NAND_AMS_DELTA
 
 config MTD_NAND_OMAP2
 	tristate "NAND Flash device on OMAP2 and OMAP3"
-	depends on ARM && (ARCH_OMAP2 || ARCH_OMAP3)
+	depends on ARM && (ARCH_OMAP2 || ARCH_OMAP3 || ARCH_OMAP4)
 	help
-          Support for NAND flash on Texas Instruments OMAP2 and OMAP3 platforms.
+          Support for NAND flash on Texas Instruments OMAP2, OMAP3 and OMAP4
+	  platforms.
 
 config MTD_NAND_IDS
 	tristate
-- 
1.7.0.4

