From: Wolfram Sang <wsa@the-dreams.de>
Subject: [RFC] mtd: gpmc: add BCH support for plain AM335x
Date: Wed, 20 Nov 2013 18:39:12 +0100
Message-ID: <1384969152-10411-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:42790 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753915Ab3KTRjh (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 20 Nov 2013 12:39:37 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-mtd@lists.infradead.org
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Wolfram Sang <wsa@the-dreams.de>

When building a kernel without OMAP3 support but only AM335x, we can't
activate the needed MTD_NAND_OMAP_BCH symbol.

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
---

Actually, I wonder if this is fix will scale. Maybe someone with more insight
about TI SoCs could find a better expression of supported SoCs. This is the
only one I could test .

 drivers/mtd/nand/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/Kconfig b/drivers/mtd/nand/Kconfig
index 93ae6a6..f9455e4 100644
--- a/drivers/mtd/nand/Kconfig
+++ b/drivers/mtd/nand/Kconfig
@@ -95,7 +95,7 @@ config MTD_NAND_OMAP2
 	  platforms.
 
 config MTD_NAND_OMAP_BCH
-	depends on MTD_NAND && MTD_NAND_OMAP2 && ARCH_OMAP3
+	depends on MTD_NAND && MTD_NAND_OMAP2 && (ARCH_OMAP3 || SOC_AM33XX)
 	tristate "Support hardware based BCH error correction"
 	default n
 	select BCH
-- 
1.8.4.2

