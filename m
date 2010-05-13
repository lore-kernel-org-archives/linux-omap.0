From: Senthilvadivu Guruswamy <svadivu@ti.com>
Subject: [PATCH v2 2/2] DSS2: make VRFB depends on OMAP2,3
Date: Thu, 13 May 2010 20:50:28 +0530
Message-ID: <1273764028-25822-3-git-send-email-svadivu@ti.com>
References: <1273764028-25822-1-git-send-email-svadivu@ti.com>
 <1273764028-25822-2-git-send-email-svadivu@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:44699 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751545Ab0EMPUj (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 13 May 2010 11:20:39 -0400
In-Reply-To: <1273764028-25822-2-git-send-email-svadivu@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, tony@atomide.com, tomi.valkeinen@nokia.com, hvaibhav@ti.com
Cc: Senthilvadivu Guruswamy <svadivu@ti.com>

config VRFB should depend on ARCH_OMAP2 or ARCH_OMAP3.

Changes from v1:
	- Addressed multi-omap build issue

Signed-off-by: Senthilvadivu Guruswamy <svadivu@ti.com>
---
 drivers/video/omap2/Kconfig            |    4 ++++
 drivers/video/omap2/omapfb/Kconfig     |    1 -
 2 files changed,  4 insertions(+), 1 deletions(-)

diff --git a/drivers/video/omap2/Kconfig b/drivers/video/omap2/Kconfig
index d877c36..18bb835 100644
--- a/drivers/video/omap2/Kconfig
+++ b/drivers/video/omap2/Kconfig
@@ -3,6 +3,10 @@ config OMAP2_VRAM
 
 config OMAP2_VRFB
 	bool
+	depends on ARCH_OMAP2 || ARCH_OMAP3
+	default y if FB_OMAP2
+	help
+	  OMAP VRFB buffer support is efficient for rotation
 
 source "drivers/video/omap2/dss/Kconfig"
 source "drivers/video/omap2/omapfb/Kconfig"
diff --git a/drivers/video/omap2/omapfb/Kconfig b/drivers/video/omap2/omapfb/Kconfig
index a3ed15c..f186c2b 100644
--- a/drivers/video/omap2/omapfb/Kconfig
+++ b/drivers/video/omap2/omapfb/Kconfig
@@ -3,7 +3,6 @@ menuconfig FB_OMAP2
         depends on FB && OMAP2_DSS
 
 	select OMAP2_VRAM
-	select OMAP2_VRFB
         select FB_CFB_FILLRECT
         select FB_CFB_COPYAREA
         select FB_CFB_IMAGEBLIT
-- 
1.5.4.7

