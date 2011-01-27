From: Sumit Semwal <sumit.semwal@ti.com>
Subject: [PATCH v3 1/3] OMAP2PLUS: DSS2: Add OMAP4 Kconfig support
Date: Thu, 27 Jan 2011 16:47:02 +0530
Message-ID: <1296127024-17507-2-git-send-email-sumit.semwal@ti.com>
References: <1296127024-17507-1-git-send-email-sumit.semwal@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:58554 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753846Ab1A0LRU (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 27 Jan 2011 06:17:20 -0500
In-Reply-To: <1296127024-17507-1-git-send-email-sumit.semwal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@nokia.com, paul@pwsan.com, khilman@ti.com, hvaibhav@ti.com, linux-omap@vger.kernel.org, b-cousson@ti.com
Cc: Mayuresh Janorkar <mayur@ti.com>

From: Mayuresh Janorkar <mayur@ti.com>

Enable DSS2 and OMAPFB for OMAP4 in Kconfig

Signed-off-by: Mayuresh Janorkar <mayur@ti.com>
---
 drivers/video/omap2/dss/Kconfig    |    6 +++---
 drivers/video/omap2/omapfb/Kconfig |    6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/video/omap2/dss/Kconfig b/drivers/video/omap2/dss/Kconfig
index 43b6440..0d031b2 100644
--- a/drivers/video/omap2/dss/Kconfig
+++ b/drivers/video/omap2/dss/Kconfig
@@ -1,8 +1,8 @@
 menuconfig OMAP2_DSS
-        tristate "OMAP2/3 Display Subsystem support (EXPERIMENTAL)"
-        depends on ARCH_OMAP2 || ARCH_OMAP3
+	tristate "OMAP2+ Display Subsystem support (EXPERIMENTAL)"
+	depends on ARCH_OMAP2PLUS
         help
-          OMAP2/3 Display Subsystem support.
+		OMAP2+ Display Subsystem support.
 
 if OMAP2_DSS
 
diff --git a/drivers/video/omap2/omapfb/Kconfig b/drivers/video/omap2/omapfb/Kconfig
index 65149b2..1da712e 100644
--- a/drivers/video/omap2/omapfb/Kconfig
+++ b/drivers/video/omap2/omapfb/Kconfig
@@ -1,5 +1,5 @@
 menuconfig FB_OMAP2
-        tristate "OMAP2/3 frame buffer support (EXPERIMENTAL)"
+	 tristate "OMAP2+ frame buffer support (EXPERIMENTAL)"
         depends on FB && OMAP2_DSS
 
 	select OMAP2_VRAM
@@ -8,10 +8,10 @@ menuconfig FB_OMAP2
         select FB_CFB_COPYAREA
         select FB_CFB_IMAGEBLIT
         help
-          Frame buffer driver for OMAP2/3 based boards.
+		Frame buffer driver for OMAP2+ based boards.
 
 config FB_OMAP2_DEBUG_SUPPORT
-	bool "Debug support for OMAP2/3 FB"
+	bool "Debug support for OMAP2+ FB"
 	default y
 	depends on FB_OMAP2
 	help
-- 
1.7.1

