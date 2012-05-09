From: Archit Taneja <archit@ti.com>
Subject: [PATCH v4 6/9] OMAPDSS: DPI/HDMI: Apply manager timings even if panel is disabled
Date: Wed, 9 May 2012 15:40:53 +0530
Message-ID: <1336558256-26140-7-git-send-email-archit@ti.com>
References: <1334561027-28569-1-git-send-email-archit@ti.com>
 <1336558256-26140-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:44790 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754227Ab2EIKMG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 May 2012 06:12:06 -0400
In-Reply-To: <1336558256-26140-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Archit Taneja <archit@ti.com>

The DPI and HDMI interfaces use their 'set_timing' functions to take in a new
set of timings. If the panel is disabled, they do not disable and re-enable
the interface. Currently, the manager timings are applied in hdmi_power_on()
and dpi_set_mode() respectively, these are not called by set_timings if the
panel is disabled.

When checking overlay and manager data, the DSS driver uses the last applied
manager timings, and not the timings held by omap_dss_device struct. Hence,
there is a need to apply the new manager timings even if the panel is disabled.

Apply the manager timings if the panel is disabled. Eventually, there should be
one common place where the timings are applied independent of the state of the
panel.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/dpi.c  |    2 ++
 drivers/video/omap2/dss/hdmi.c |    2 ++
 2 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/video/omap2/dss/dpi.c b/drivers/video/omap2/dss/dpi.c
index e01ab98..d6e8fe7 100644
--- a/drivers/video/omap2/dss/dpi.c
+++ b/drivers/video/omap2/dss/dpi.c
@@ -297,6 +297,8 @@ void dpi_set_timings(struct omap_dss_device *dssdev,
 
 		dispc_runtime_put();
 		dss_runtime_put();
+	} else {
+		dss_mgr_set_timings(dssdev->manager, timings);
 	}
 }
 EXPORT_SYMBOL(dpi_set_timings);
diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/hdmi.c
index 8d4ff8c..32ad712 100644
--- a/drivers/video/omap2/dss/hdmi.c
+++ b/drivers/video/omap2/dss/hdmi.c
@@ -435,6 +435,8 @@ void omapdss_hdmi_display_set_timing(struct omap_dss_device *dssdev)
 		r = hdmi_power_on(dssdev);
 		if (r)
 			DSSERR("failed to power on device\n");
+	} else {
+		dss_mgr_set_timings(dssdev->manager, &dssdev->panel.timings);
 	}
 }
 
-- 
1.7.5.4

