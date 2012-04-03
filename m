From: Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH] remove unused FB_OMAP_BOOTLOADER_INIT config option
Date: Tue,  3 Apr 2012 10:59:15 +0200
Message-ID: <1333443555-21559-1-git-send-email-pmeerw@pmeerw.net>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:57878 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751330Ab2DCJAS (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 3 Apr 2012 05:00:18 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tomi.valkeinen@ti.com, Peter Meerwald <p.meerwald@bct-electronic.com>

From: Peter Meerwald <p.meerwald@bct-electronic.com>

code depending on FB_OMAP_BOOTLOADER_INIT has been removed long before
(e.g. Tomi Valkeinen, 03 Mar 2011: OMAP: DSS2: Remove FB_OMAP_BOOTLOADER_INIT
support), but the option still exists Kconfig and has no use

Signed-off-by: Peter Meerwald <p.meerwald@bct-electronic.com>

---
 drivers/video/omap/Kconfig |    8 --------
 1 files changed, 0 insertions(+), 8 deletions(-)

diff --git a/drivers/video/omap/Kconfig b/drivers/video/omap/Kconfig
index 1e7536d..b48f95f 100644
--- a/drivers/video/omap/Kconfig
+++ b/drivers/video/omap/Kconfig
@@ -39,14 +39,6 @@ config FB_OMAP_LCD_MIPID
 	  the Mobile Industry Processor Interface DBI-C/DCS
 	  specification. (Supported LCDs: Philips LPH8923, Sharp LS041Y3)
 
-config FB_OMAP_BOOTLOADER_INIT
-	bool "Check bootloader initialization"
-	depends on FB_OMAP
-	help
-	  Say Y here if you want to enable checking if the bootloader has
-	  already initialized the display controller. In this case the
-	  driver will skip the initialization.
-
 config FB_OMAP_CONSISTENT_DMA_SIZE
 	int "Consistent DMA memory size (MB)"
 	depends on FB_OMAP
-- 
1.7.4.1

