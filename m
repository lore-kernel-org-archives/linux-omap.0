From: Archit Taneja <archit@ti.com>
Subject: [PATCH] OMAPDSS: HACK: Ensure DSS clock domain gets out of idle when HDMI is enabled
Date: Thu, 9 Feb 2012 12:14:48 +0530
Message-ID: <1328769888-24790-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:51561 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752953Ab2BIGpB (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 9 Feb 2012 01:45:01 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tomi.valkeinen@ti.com, linux@arm.linux.org.uk, linux-fbdev@vger.kernel.org, Archit Taneja <archit@ti.com>

For DSS clock domain to transition from idle to active state, it's necessary
to enable the optional clock DSS_FCLK before we enable the module using the
MODULEMODE bits in the DSS clock domain's CM_DSS_DSS_CLKCTRL register.

This sequence was not followed correctly for the 'dss_hdmi' hwmod and it led
to DSS clock domain not getting out of idle when pm_runtime_get_sync() was
called for hdmi's platform device.

Since the clock domain failed to change it's state to active, the hwmod code
disables any clocks it had enabled before for this hwmod. This led to the clock
'dss_48mhz_clk' getting disabled.

When hdmi's runtime_resume() op is called, the call to dss_runtime_get()
correctly enables the DSS clock domain this time. But the clock 'dss_48mhz_clk'
disabled before is needed for HDMI's PHY to function. Hence, the driver fails
when it tries to enable HDMI's PHY.

Fix this for now by ensuring that dss_runtime_get() is called before we call
pm_runtime_get_sync() for hdmi's platform device. A correct fix for later would
be to modify the DSS related hwmod's mainclks, and also some changes in how
opt clocks are handled in the DSS driver.

This fixes the issue of HDMI not working when it's the default display. The
issue is not seen if any other display is already enabled as the first display
would have already correctly enabled the DSS clock domain.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/hdmi.c |   16 +++++++++++++++-
 1 files changed, 15 insertions(+), 1 deletions(-)

diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/hdmi.c
index d7aa3b0..ce16a91 100644
--- a/drivers/video/omap2/dss/hdmi.c
+++ b/drivers/video/omap2/dss/hdmi.c
@@ -165,9 +165,21 @@ static int hdmi_runtime_get(void)
 
 	DSSDBG("hdmi_runtime_get\n");
 
+	r = dss_runtime_get();
+	if (r < 0)
+		goto err_get_dss;
+
 	r = pm_runtime_get_sync(&hdmi.pdev->dev);
 	WARN_ON(r < 0);
-	return r < 0 ? r : 0;
+	if (r < 0)
+		goto err_get_hdmi;
+
+	return 0;
+
+err_get_hdmi:
+	dss_runtime_put();
+err_get_dss:
+	return r;
 }
 
 static void hdmi_runtime_put(void)
@@ -178,6 +190,8 @@ static void hdmi_runtime_put(void)
 
 	r = pm_runtime_put_sync(&hdmi.pdev->dev);
 	WARN_ON(r < 0);
+
+	dss_runtime_put();
 }
 
 int hdmi_init_display(struct omap_dss_device *dssdev)
-- 
1.7.5.4

