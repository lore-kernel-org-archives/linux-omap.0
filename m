From: <mythripk@ti.com>
Subject: [PATCH v3 03/10] OMAP4: DSS: HDMI: Use specific HDMI timings structure
Date: Fri, 2 Sep 2011 16:17:43 +0530
Message-ID: <1314960470-2616-4-git-send-email-mythripk@ti.com>
References: <1314960470-2616-1-git-send-email-mythripk@ti.com>
 <1314960470-2616-2-git-send-email-mythripk@ti.com>
 <1314960470-2616-3-git-send-email-mythripk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:55344 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933393Ab1IBK4B (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 2 Sep 2011 06:56:01 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id p82Atvpw027233
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 2 Sep 2011 05:55:59 -0500
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id p82AturH016844
	for <linux-omap@vger.kernel.org>; Fri, 2 Sep 2011 16:25:57 +0530 (IST)
In-Reply-To: <1314960470-2616-3-git-send-email-mythripk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com, linux-omap@vger.kernel.org
Cc: Mythri P K <mythripk@ti.com>

From: Mythri P K <mythripk@ti.com>

Define HDMI timings structure for hdmi.c to use instead of OMAP DSS timing
strucutre, As hdmi has few additional parameters such as vsync and hsync
polarity which is missing in DSS timing structure.

Signed-off-by: Mythri P K <mythripk@ti.com>
---
 drivers/video/omap2/dss/hdmi.c |   23 ++++++++++++++++++++---
 drivers/video/omap2/dss/hdmi.h |   15 ++++++++++++++-
 2 files changed, 34 insertions(+), 4 deletions(-)

diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/hdmi.c
index 9a28e5e..09c0b28 100644
--- a/drivers/video/omap2/dss/hdmi.c
+++ b/drivers/video/omap2/dss/hdmi.c
@@ -533,6 +533,21 @@ static int read_edid(struct hdmi_ip_data *ip_data, u8 *pedid, u16 max_length)
 	return 0;
 }
 
+static void copy_hdmi_to_dss_timings(
+		const struct hdmi_video_timings hdmi_timings,
+		struct omap_video_timings *timings)
+{
+	timings->x_res = hdmi_timings.x_res;
+	timings->y_res = hdmi_timings.y_res;
+	timings->pixel_clock = hdmi_timings.pixel_clock;
+	timings->hbp = hdmi_timings.hbp;
+	timings->hfp = hdmi_timings.hfp;
+	timings->hsw = hdmi_timings.hsw;
+	timings->vbp = hdmi_timings.vbp;
+	timings->vfp = hdmi_timings.vfp;
+	timings->vsw = hdmi_timings.vsw;
+}
+
 static int get_timings_index(void)
 {
 	int code;
@@ -557,7 +572,7 @@ static struct hdmi_cm hdmi_get_code(struct omap_video_timings *timing)
 {
 	int i = 0, code = -1, temp_vsync = 0, temp_hsync = 0;
 	int timing_vsync = 0, timing_hsync = 0;
-	struct omap_video_timings temp;
+	struct hdmi_video_timings temp;
 	struct hdmi_cm cm = {-1};
 	DSSDBG("hdmi_get_code\n");
 
@@ -715,7 +730,8 @@ static void hdmi_read_edid(struct omap_video_timings *dp)
 
 	code = get_timings_index();
 
-	*dp = cea_vesa_timings[code].timings;
+	copy_hdmi_to_dss_timings(cea_vesa_timings[code].timings, dp);
+
 }
 
 static void hdmi_core_init(struct hdmi_core_video_config *video_cfg,
@@ -1177,7 +1193,8 @@ static int hdmi_power_on(struct omap_dss_device *dssdev)
 		hdmi_read_edid(p);
 	}
 	code = get_timings_index();
-	dssdev->panel.timings = cea_vesa_timings[code].timings;
+	copy_hdmi_to_dss_timings(cea_vesa_timings[code].timings,
+			&dssdev->panel.timings);
 	update_hdmi_timings(&hdmi.hdmi_data.cfg, p, code);
 
 	phy = p->pixel_clock;
diff --git a/drivers/video/omap2/dss/hdmi.h b/drivers/video/omap2/dss/hdmi.h
index d2913f8..02342f6 100644
--- a/drivers/video/omap2/dss/hdmi.h
+++ b/drivers/video/omap2/dss/hdmi.h
@@ -198,9 +198,22 @@ struct hdmi_reg { u16 idx; };
 #define REG_GET(base, idx, start, end) \
 	FLD_GET(hdmi_read_reg(base, idx), start, end)
 
+struct hdmi_video_timings {
+	u16 x_res;
+	u16 y_res;
+	/* Unit: KHz */
+	u32 pixel_clock;
+	u16 hsw;
+	u16 hfp;
+	u16 hbp;
+	u16 vsw;
+	u16 vfp;
+	u16 vbp;
+};
+
 /* HDMI timing structure */
 struct hdmi_timings {
-	struct omap_video_timings timings;
+	struct hdmi_video_timings timings;
 	int vsync_pol;
 	int hsync_pol;
 };
-- 
1.7.5.4

