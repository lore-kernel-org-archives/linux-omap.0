From: Mayuresh Janorkar <mayur@ti.com>
Subject: [PATCH] Adding help for FB_OMAP_LCD_VGA option
Date: Thu, 24 Feb 2011 15:09:17 +0530
Message-ID: <1298540357-30365-1-git-send-email-mayur@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:34880 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753907Ab1BXJLU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Feb 2011 04:11:20 -0500
Received: from dlep36.itg.ti.com ([157.170.170.91])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id p1O9BKLs013300
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 24 Feb 2011 03:11:20 -0600
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, Mayuresh Janorkar <mayur@ti.com>

CONFIG_FB_OMAP_LCD_VGA option is present in drivers/video/omap
There is no explaination about what this flag does.
Lets add information about it.

FB_OMAP_LCD_VGA flag sets resolution of display to VGA (640 X 480).
The default resolution of 3430 LDP is 320 X 240.

Signed-off-by: Mayuresh Janorkar <mayur@ti.com>
---
 drivers/video/omap/Kconfig |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/drivers/video/omap/Kconfig b/drivers/video/omap/Kconfig
index 083c8fe..ff7049b 100644
--- a/drivers/video/omap/Kconfig
+++ b/drivers/video/omap/Kconfig
@@ -11,7 +11,11 @@ config FB_OMAP
 config FB_OMAP_LCD_VGA
         bool "Use LCD in VGA mode"
 	        depends on MACH_OMAP_3430SDP || MACH_OMAP_LDP
-
+		help
+		  Set LCD resolution as VGA (640 X 480).
+		  Default resolution without this option is QVGA(320 X 240).
+		  Please take a look at drivers/video/omap/lcd_ldp.c file
+		  for lcd driver code.
 choice
 	depends on FB_OMAP && MACH_OVERO
 	prompt "Screen resolution"
-- 
1.7.1

