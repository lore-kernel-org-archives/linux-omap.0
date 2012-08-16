From: Archit Taneja <archit@ti.com>
Subject: [PATCH 4/6] OMAPDSS: RFBI: Maitain copy of rfbi timings in driver data
Date: Thu, 16 Aug 2012 13:06:32 +0530
Message-ID: <1345102594-6222-5-git-send-email-archit@ti.com>
References: <343817088-29645-1-git-send-email-archit@ti.com>
 <1345102594-6222-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:42135 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753102Ab2HPHiV (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 16 Aug 2012 03:38:21 -0400
In-Reply-To: <1345102594-6222-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Archit Taneja <archit@ti.com>

The RFBI driver currently relies on the omap_dss_device struct to receive the
rfbi specific timings requested by the panel driver. This makes the RFBI
interface driver dependent on the omap_dss_device struct.

Make the RFBI driver data maintain it's own rfbi specific timings field. The
panel driver is expected to call omapdss_rfbi_set_interface_timings() to
configure the rfbi timings before the interface is enabled. The function takes
a void pointer rather than a pointer to rfbi_timings struct. This is because
this function will finally be an output op shared across different outputs to
set custom or private timings.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/displays/panel-n8x0.c |    2 ++
 drivers/video/omap2/dss/rfbi.c            |   14 +++++++++++---
 include/video/omapdss.h                   |    2 ++
 3 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/video/omap2/displays/panel-n8x0.c b/drivers/video/omap2/displays/panel-n8x0.c
index 3ffd987..14adc1d 100644
--- a/drivers/video/omap2/displays/panel-n8x0.c
+++ b/drivers/video/omap2/displays/panel-n8x0.c
@@ -307,6 +307,8 @@ static int n8x0_panel_power_on(struct omap_dss_device *dssdev)
 		dssdev->panel.timings.y_res);
 	omapdss_rfbi_set_pixel_size(dssdev, dssdev->ctrl.pixel_size);
 	omapdss_rfbi_set_data_lines(dssdev, dssdev->phy.rfbi.data_lines);
+	omapdss_rfbi_set_interface_timings(dssdev,
+		(void *) &dssdev->ctrl.rfbi_timings);
 
 	r = omapdss_rfbi_display_enable(dssdev);
 	if (r)
diff --git a/drivers/video/omap2/dss/rfbi.c b/drivers/video/omap2/dss/rfbi.c
index 698d5b9..b5b0bc6 100644
--- a/drivers/video/omap2/dss/rfbi.c
+++ b/drivers/video/omap2/dss/rfbi.c
@@ -115,6 +115,7 @@ static struct {
 	struct omap_video_timings timings;
 	int pixel_size;
 	int data_lines;
+	struct rfbi_timings intf_timings;
 } rfbi;
 
 static inline void rfbi_write_reg(const struct rfbi_reg idx, u32 val)
@@ -799,6 +800,15 @@ void omapdss_rfbi_set_data_lines(struct omap_dss_device *dssdev, int data_lines)
 }
 EXPORT_SYMBOL(omapdss_rfbi_set_data_lines);
 
+void omapdss_rfbi_set_interface_timings(struct omap_dss_device *dssdev,
+		void *timings)
+{
+	struct rfbi_timings *t = (struct rfbi_timings *) timings;
+
+	rfbi.intf_timings = *t;
+}
+EXPORT_SYMBOL(omapdss_rfbi_set_interface_timings);
+
 static void rfbi_dump_regs(struct seq_file *s)
 {
 #define DUMPREG(r) seq_printf(s, "%-35s %08x\n", #r, rfbi_read_reg(r))
@@ -907,9 +917,7 @@ int omapdss_rfbi_display_enable(struct omap_dss_device *dssdev)
 	rfbi_configure(dssdev->phy.rfbi.channel, rfbi.pixel_size,
 			rfbi.data_lines);
 
-	rfbi_set_timings(dssdev->phy.rfbi.channel,
-			 &dssdev->ctrl.rfbi_timings);
-
+	rfbi_set_timings(dssdev->phy.rfbi.channel, &rfbi.intf_timings);
 
 	return 0;
 err1:
diff --git a/include/video/omapdss.h b/include/video/omapdss.h
index faac986..91eba93 100644
--- a/include/video/omapdss.h
+++ b/include/video/omapdss.h
@@ -765,5 +765,7 @@ void omapdss_rfbi_set_pixel_size(struct omap_dss_device *dssdev,
 		int pixel_size);
 void omapdss_rfbi_set_data_lines(struct omap_dss_device *dssdev,
 		int data_lines);
+void omapdss_rfbi_set_interface_timings(struct omap_dss_device *dssdev,
+		void *timings);
 
 #endif
-- 
1.7.9.5

