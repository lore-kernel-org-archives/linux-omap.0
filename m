From: Mythri P K <mythripk@ti.com>
Subject: [PATCH v4 3/9] OMAP4 : DSS2 : HDMI: HDMI dispc gamma table disable.
Date: Wed,  9 Mar 2011 17:15:12 +0530
Message-ID: <1299671118-20839-4-git-send-email-mythripk@ti.com>
References: <1299671118-20839-1-git-send-email-mythripk@ti.com>
 <1299671118-20839-2-git-send-email-mythripk@ti.com>
 <1299671118-20839-3-git-send-email-mythripk@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:41929 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756887Ab1CILv4 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 9 Mar 2011 06:51:56 -0500
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id p29BprWu017233
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 9 Mar 2011 05:51:55 -0600
In-Reply-To: <1299671118-20839-3-git-send-email-mythripk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tomi.valkeinen@ti.com
Cc: Mythri P K <mythripk@ti.com>

Adding changes to set gamma table bit for TV interface to make sure it is disabled

Signed-off-by: Mythri P K <mythripk@ti.com>
---
 drivers/video/omap2/dss/dispc.c |   10 ++++++++++
 drivers/video/omap2/dss/dss.h   |    1 +
 2 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index 4a368c4..0defe16 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -1008,6 +1008,16 @@ void dispc_set_burst_size(enum omap_plane plane,
 	enable_clocks(0);
 }
 
+void dispc_enable_gamma_table(bool enable)
+{
+	/* This is partially implemented to support only
+	 *  disabling of the gamma table.
+	 */
+	BUG_ON(enable);
+
+	REG_FLD_MOD(DISPC_CONFIG, enable, 9, 9);
+}
+
 static void _dispc_set_vid_color_conv(enum omap_plane plane, bool enable)
 {
 	u32 val;
diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index 29f31fd..008cbf4 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -363,6 +363,7 @@ void dispc_set_plane_size(enum omap_plane plane, u16 width, u16 height);
 void dispc_set_channel_out(enum omap_plane plane,
 		enum omap_channel channel_out);
 
+void dispc_enable_gamma_table(bool enable);
 int dispc_setup_plane(enum omap_plane plane,
 		      u32 paddr, u16 screen_width,
 		      u16 pos_x, u16 pos_y,
-- 
1.5.6.3

