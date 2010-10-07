From: Guruswamy Senthilvadivu <svadivu@ti.com>
Subject: [PATCH v4 2/3] OMAP: DSS2: OMAPFB: make VRFB depends on OMAP2,3
Date: Thu,  7 Oct 2010 14:38:54 +0530
Message-ID: <1286442535-28308-3-git-send-email-svadivu@ti.com>
References: <1286442535-28308-1-git-send-email-svadivu@ti.com>
 <1286442535-28308-2-git-send-email-svadivu@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:45333 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753103Ab0JGJJF (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 7 Oct 2010 05:09:05 -0400
In-Reply-To: <1286442535-28308-2-git-send-email-svadivu@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@nokia.com, hvaibhav@ti.com, linux-omap@vger.kernel.org
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

