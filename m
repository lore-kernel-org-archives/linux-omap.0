From: Archit Taneja <archit@ti.com>
Subject: [RFC][PATCH 1/8] OMAP: DSS2: Overlay Manager LCD2 changes in dispay.h
Date: Thu,  1 Jul 2010 16:01:18 +0530
Message-ID: <1277980285-20996-2-git-send-email-archit@ti.com>
References: <1277980285-20996-1-git-send-email-archit@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:34573 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755137Ab0GAKbh (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 1 Jul 2010 06:31:37 -0400
In-Reply-To: <1277980285-20996-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tomi.valkeinen@nokia.com, Sumit Semwal <sumit.semwal@ti.com>, Senthilvadivu Guruswamy <svadivu@ti.com>, Mukund Mittal <mmittal@ti.com>, Archit Taneja <archit@ti.com>, Samreen <samreen@ti.com>

From: Sumit Semwal <sumit.semwal@ti.com>

Overlay Manager LCD2 changes in dispay.h

Signed-off-by: Sumit Semwal <sumit.semwal@ti.com>
Signed-off-by: Senthilvadivu Guruswamy <svadivu@ti.com>
Signed-off-by: Mukund Mittal <mmittal@ti.com>
Signed-off-by: Archit Taneja <archit@ti.com>
Signed-off-by: Samreen <samreen@ti.com>
---
 arch/arm/plat-omap/include/plat/display.h |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/display.h b/arch/arm/plat-omap/include/plat/display.h
index 8bd15bd..c3643f5
--- a/arch/arm/plat-omap/include/plat/display.h
+++ b/arch/arm/plat-omap/include/plat/display.h
@@ -64,6 +64,7 @@ enum omap_plane {
 enum omap_channel {
 	OMAP_DSS_CHANNEL_LCD	= 0,
 	OMAP_DSS_CHANNEL_DIGIT	= 1,
+	OMAP_DSS_CHANNEL_LCD2   = 2,
 };
 
 enum omap_color_mode {
@@ -173,6 +174,7 @@ enum omap_dss_display_state {
 enum omap_dss_overlay_managers {
 	OMAP_DSS_OVL_MGR_LCD,
 	OMAP_DSS_OVL_MGR_TV,
+	OMAP_DSS_OVL_MGR_LCD2,
 };
 
 enum omap_dss_rotation_type {
@@ -462,6 +464,7 @@ struct omap_dss_device {
 	struct omap_overlay_manager *manager;
 
 	enum omap_dss_display_state state;
+	enum omap_channel channel;
 
 	/* platform specific  */
 	int (*platform_enable)(struct omap_dss_device *dssdev);
-- 
1.6.3.3

