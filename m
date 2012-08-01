From: Archit Taneja <archit@ti.com>
Subject: [RFC 11/17] OMAPDSS: HDMI: Add locking for hdmi interface get/set timing functions
Date: Wed, 1 Aug 2012 16:01:22 +0530
Message-ID: <1343817088-29645-12-git-send-email-archit@ti.com>
References: <1343817088-29645-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:43813 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753934Ab2HAKdq (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 1 Aug 2012 06:33:46 -0400
In-Reply-To: <1343817088-29645-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, sumit.semwal@ti.com, rob@ti.com, Archit Taneja <archit@ti.com>

The hdmi interface driver exposes functions to the hdmi panel driver to
get and configure the interface timings maintained by the hdmi driver.

These timings(stored in hdmi.ip_data.cfg) should be protected by the hdmi lock
to ensure they are called sequentially, this is similar to how hdmi enable and
disable functions need locking.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/hdmi.c |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/hdmi.c
index 2de1f91..dfd582e 100644
--- a/drivers/video/omap2/dss/hdmi.c
+++ b/drivers/video/omap2/dss/hdmi.c
@@ -547,7 +547,11 @@ static void hdmi_power_off(struct omap_dss_device *dssdev)
 void omapdss_hdmi_display_get_timing(struct omap_dss_device *dssdev,
 		struct omap_video_timings *timings)
 {
+	mutex_lock(&hdmi.lock);
+
 	*timings = hdmi.ip_data.cfg.timings;
+
+	mutex_unlock(&hdmi.lock);
 }
 
 int omapdss_hdmi_display_check_timing(struct omap_dss_device *dssdev,
@@ -570,6 +574,8 @@ void omapdss_hdmi_display_set_timing(struct omap_dss_device *dssdev,
 	struct hdmi_cm cm;
 	const struct hdmi_config *timing;
 
+	mutex_lock(&hdmi.lock);
+
 	cm = hdmi_get_code(timings);
 	hdmi.ip_data.cfg.cm = cm;
 
@@ -588,6 +594,8 @@ void omapdss_hdmi_display_set_timing(struct omap_dss_device *dssdev,
 	} else {
 		dss_mgr_set_timings(dssdev->manager, &timing->timings);
 	}
+
+	mutex_unlock(&hdmi.lock);
 }
 
 static void hdmi_dump_regs(struct seq_file *s)
-- 
1.7.9.5

