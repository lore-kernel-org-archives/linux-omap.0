From: Shubhrajyoti D <shubhrajyoti@ti.com>
Subject: [PATCH] MTD: nand: Making  MTD_NAND_OMAP2 depend on ARCH_OMAP2PLUS
Date: Wed, 16 Nov 2011 10:48:00 +0530
Message-ID: <1321420680-4677-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:40457 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752618Ab1KPFSU (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 16 Nov 2011 00:18:20 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-mtd@lists.infradead.org
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Shubhrajyoti D <shubhrajyoti@ti.com>

Making  MTD_NAND_OMAP2 depend on ARCH_OMAP2PLUS instead of
oring with ARCH2/3/4.

Reported-by: Russell King <rmk+kernel@arm.linux.org.uk>
Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
---
 drivers/mtd/nand/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mtd/nand/Kconfig b/drivers/mtd/nand/Kconfig
index cce7b70..b68dd5e 100644
--- a/drivers/mtd/nand/Kconfig
+++ b/drivers/mtd/nand/Kconfig
@@ -110,7 +110,7 @@ config MTD_NAND_AMS_DELTA
 
 config MTD_NAND_OMAP2
 	tristate "NAND Flash device on OMAP2, OMAP3 and OMAP4"
-	depends on ARM && (ARCH_OMAP2 || ARCH_OMAP3 || ARCH_OMAP4)
+	depends on ARCH_OMAP2PLUS
 	help
           Support for NAND flash on Texas Instruments OMAP2, OMAP3 and OMAP4
 	  platforms.
-- 
1.7.1

