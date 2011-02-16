From: Sumit Semwal <sumit.semwal@ti.com>
Subject: [PATCH v4 1/3] OMAP2PLUS: DSS2: Add OMAP4 Kconfig support
Date: Wed, 16 Feb 2011 10:24:29 +0530
Message-ID: <1297832069-3678-1-git-send-email-sumit.semwal@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:37709 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752656Ab1BPEyh (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 15 Feb 2011 23:54:37 -0500
Received: from dlep34.itg.ti.com ([157.170.170.115])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id p1G4sbZD031629
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 15 Feb 2011 22:54:37 -0600
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com, linux-omap@vger.kernel.org
Cc: Mayuresh Janorkar <mayur@ti.com>

From: Mayuresh Janorkar <mayur@ti.com>

Enable DSS2 and OMAPFB for OMAP4 in Kconfig

Signed-off-by: Mayuresh Janorkar <mayur@ti.com>
---
 drivers/video/omap2/dss/Kconfig    |    6 +++---
 drivers/video/omap2/omapfb/Kconfig |    6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/video/omap2/dss/Kconfig b/drivers/video/omap2/dss/Kconfig
index 43b6440..db01473 100644
--- a/drivers/video/omap2/dss/Kconfig
+++ b/drivers/video/omap2/dss/Kconfig
@@ -1,8 +1,8 @@
 menuconfig OMAP2_DSS
-        tristate "OMAP2/3 Display Subsystem support (EXPERIMENTAL)"
-        depends on ARCH_OMAP2 || ARCH_OMAP3
+        tristate "OMAP2+ Display Subsystem support (EXPERIMENTAL)"
+        depends on ARCH_OMAP2PLUS
         help
-          OMAP2/3 Display Subsystem support.
+	  OMAP2+ Display Subsystem support.
 
 if OMAP2_DSS
 
diff --git a/drivers/video/omap2/omapfb/Kconfig b/drivers/video/omap2/omapfb/Kconfig
index 65149b2..aa33386 100644
--- a/drivers/video/omap2/omapfb/Kconfig
+++ b/drivers/video/omap2/omapfb/Kconfig
@@ -1,5 +1,5 @@
 menuconfig FB_OMAP2
-        tristate "OMAP2/3 frame buffer support (EXPERIMENTAL)"
+        tristate "OMAP2+ frame buffer support (EXPERIMENTAL)"
         depends on FB && OMAP2_DSS
 
 	select OMAP2_VRAM
@@ -8,10 +8,10 @@ menuconfig FB_OMAP2
         select FB_CFB_COPYAREA
         select FB_CFB_IMAGEBLIT
         help
-          Frame buffer driver for OMAP2/3 based boards.
+	  Frame buffer driver for OMAP2+ based boards.
 
 config FB_OMAP2_DEBUG_SUPPORT
-	bool "Debug support for OMAP2/3 FB"
+        bool "Debug support for OMAP2+ FB"
 	default y
 	depends on FB_OMAP2
 	help
-- 
1.7.1

