From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: [PATCH 07/13] OMAP: DSS2: OMAPFB: Add omapfb_update_window prototype
Date: Mon,  8 Feb 2010 17:56:06 +0200
Message-ID: <1265644572-3578-8-git-send-email-tomi.valkeinen@nokia.com>
References: <1265644572-3578-1-git-send-email-tomi.valkeinen@nokia.com>
 <1265644572-3578-2-git-send-email-tomi.valkeinen@nokia.com>
 <1265644572-3578-3-git-send-email-tomi.valkeinen@nokia.com>
 <1265644572-3578-4-git-send-email-tomi.valkeinen@nokia.com>
 <1265644572-3578-5-git-send-email-tomi.valkeinen@nokia.com>
 <1265644572-3578-6-git-send-email-tomi.valkeinen@nokia.com>
 <1265644572-3578-7-git-send-email-tomi.valkeinen@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:45708 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753348Ab0BHPxu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Feb 2010 10:53:50 -0500
In-Reply-To: <1265644572-3578-7-git-send-email-tomi.valkeinen@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@nokia.com>

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@nokia.com>
---
 drivers/video/omap2/omapfb/omapfb.h |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/video/omap2/omapfb/omapfb.h b/drivers/video/omap2/omapfb/omapfb.h
index f7c9c73..4ae0b64 100644
--- a/drivers/video/omap2/omapfb/omapfb.h
+++ b/drivers/video/omap2/omapfb/omapfb.h
@@ -105,6 +105,9 @@ void omapfb_remove_sysfs(struct omapfb2_device *fbdev);
 
 int omapfb_ioctl(struct fb_info *fbi, unsigned int cmd, unsigned long arg);
 
+int omapfb_update_window(struct fb_info *fbi,
+		u32 x, u32 y, u32 w, u32 h);
+
 int dss_mode_to_fb_mode(enum omap_color_mode dssmode,
 			struct fb_var_screeninfo *var);
 
-- 
1.6.5

