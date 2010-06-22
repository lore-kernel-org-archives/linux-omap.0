From: Guruswamy Senthilvadivu <svadivu@ti.com>
Subject: [PATCH v4 2/3] OMAP: DSS2: OMAPFB: make VRFB depends on OMAP2,3
Date: Tue, 22 Jun 2010 17:27:06 +0530
Message-ID: <1277207827-15833-3-git-send-email-svadivu@ti.com>
References: <1277207827-15833-1-git-send-email-svadivu@ti.com>
 <1277207827-15833-2-git-send-email-svadivu@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:59105 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756595Ab0FVL5W (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Jun 2010 07:57:22 -0400
In-Reply-To: <1277207827-15833-2-git-send-email-svadivu@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, tony@atomide.com, tomi.valkeinen@nokia.com, hvaibhav@ti.com
Cc: Guruswamy Senthilvadivu <svadivu@ti.com>

config VRFB should depend on ARCH_OMAP2 or ARCH_OMAP3.

Signed-off-by: Senthilvadivu Guruswamy <svadivu@ti.com>
---
 drivers/video/omap2/omapfb/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/video/omap2/omapfb/Kconfig b/drivers/video/omap2/omapfb/Kconfig
index 43496d6..65149b2 100644
--- a/drivers/video/omap2/omapfb/Kconfig
+++ b/drivers/video/omap2/omapfb/Kconfig
@@ -3,7 +3,7 @@ menuconfig FB_OMAP2
         depends on FB && OMAP2_DSS
 
 	select OMAP2_VRAM
-	select OMAP2_VRFB
+	select OMAP2_VRFB if ARCH_OMAP2 || ARCH_OMAP3
         select FB_CFB_FILLRECT
         select FB_CFB_COPYAREA
         select FB_CFB_IMAGEBLIT
-- 
1.5.4.7

