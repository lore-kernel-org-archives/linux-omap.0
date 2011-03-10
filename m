From: Mythri P K <mythripk@ti.com>
Subject: [PATCH v5 03/10] OMAP4 : DSS2 : HDMI: Dispc gamma enable set/reset function for TV.
Date: Thu, 10 Mar 2011 16:14:11 +0530
Message-ID: <1299753858-12222-4-git-send-email-mythripk@ti.com>
References: <1299753858-12222-1-git-send-email-mythripk@ti.com>
 <1299753858-12222-2-git-send-email-mythripk@ti.com>
 <1299753858-12222-3-git-send-email-mythripk@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:44169 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751368Ab1CJKu4 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 10 Mar 2011 05:50:56 -0500
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id p2AAor3D021442
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 10 Mar 2011 04:50:55 -0600
In-Reply-To: <1299753858-12222-3-git-send-email-mythripk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tomi.valkeinen@ti.com
Cc: Mythri P K <mythripk@ti.com>

Adding function to reset/set gamma table bit for TV interface
currentl only support for disabled is added.

Signed-off-by: Mythri P K <mythripk@ti.com>
---
 drivers/video/omap2/dss/dispc.c |   13 +++++++++++++
 drivers/video/omap2/dss/dss.h   |    1 +
 2 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index b8c576a..9b86f5f 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -1008,6 +1008,19 @@ void dispc_set_burst_size(enum omap_plane plane,
 	enable_clocks(0);
 }
 
+void dispc_enable_gamma_table(bool enable)
+{
+	/* This is partially implemented to support only
+	 *  disabling of the gamma table.
+	 */
+	if (enable) {
+		DSSWARN("Gamma table enabling for TV not yet supported");
+		return;
+	}
+
+	REG_FLD_MOD(DISPC_CONFIG, enable, 9, 9);
+}
+
 static void _dispc_set_vid_color_conv(enum omap_plane plane, bool enable)
 {
 	u32 val;
diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index c2c0fcf..9f563a6 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -376,6 +376,7 @@ void dispc_set_plane_size(enum omap_plane plane, u16 width, u16 height);
 void dispc_set_channel_out(enum omap_plane plane,
 		enum omap_channel channel_out);
 
+void dispc_enable_gamma_table(bool enable);
 int dispc_setup_plane(enum omap_plane plane,
 		      u32 paddr, u16 screen_width,
 		      u16 pos_x, u16 pos_y,
-- 
1.5.6.3

