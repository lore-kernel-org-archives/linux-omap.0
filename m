From: Archit Taneja <archit@ti.com>
Subject: [PATCH v2] OMAPDSS: HACK: Ensure DSS clock domain gets out of idle when HDMI is enabled
Date: Fri, 10 Feb 2012 11:45:52 +0530
Message-ID: <1328854552-30714-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:34410 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751810Ab2BJGQJ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 10 Feb 2012 01:16:09 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tomi.valkeinen@ti.com, linux@arm.linux.org.uk, linux-fbdev@vger.kernel.org, Archit Taneja <archit@ti.com>

For DSS clock domain to transition from idle to active state. It's necessary
to enable the optional clock DSS_FCLK before we enable the module using the
MODULEMODE bits in the clock domain's CM_DSS_DSS_CLKCTRL register.

This sequence was not followed correctly for the 'dss_hdmi' hwmod and it led
to DSS clock domain not getting out of idle when pm_runtime_get_sync() was
called for hdmi's platform device.

Since the clock domain failed to change it's state to active, the hwmod code
disables any clocks it had enabled before for this hwmod. This led to the clock
'dss_48mhz_clk' gettind disabled.

When hdmi's runtime_resume() op is called, the call to dss_runtime_get()
correctly enables the DSS clock domain this time. However, the clock
'dss_48mhz_clk' is needed for HDMI's PHY to function correctly. Since it was
disabled previously, the driver fails when it tries to enable HDMI's PHY.

Fix this for now by ensuring that dss_runtime_get() is called before we call
pm_runtime_get_sync() for hdmi's platform device. A correct fix for later would
be to modify the DSS related hwmod's mainclks, and also some changes in how
opt clocks are handled in the DSS driver.

This fixes the issue of HDMI not working when it's the default display. The
issue is not seen if any other display is already enabled as the first display
would have correctly enabled the DSS clockdomain.

Signed-off-by: Archit Taneja <archit@ti.com>
---
Changes in v2:
- Rewrite an unclear paragraph in the commit message
- Add comments mentioning that this is a hack

 drivers/video/omap2/dss/hdmi.c |   24 +++++++++++++++++++++++-
 1 files changed, 23 insertions(+), 1 deletions(-)

diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/hdmi.c
index d7aa3b0..a36b934 100644
--- a/drivers/video/omap2/dss/hdmi.c
+++ b/drivers/video/omap2/dss/hdmi.c
@@ -165,9 +165,25 @@ static int hdmi_runtime_get(void)
 
 	DSSDBG("hdmi_runtime_get\n");
 
+	/*
+	 * HACK: Add dss_runtime_get() to ensure DSS clock domain is enabled.
+	 * This should be removed later.
+	 */
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
@@ -178,6 +194,12 @@ static void hdmi_runtime_put(void)
 
 	r = pm_runtime_put_sync(&hdmi.pdev->dev);
 	WARN_ON(r < 0);
+
+	/*
+	 * HACK: This is added to complement the dss_runtime_get() call in
+	 * hdmi_runtime_get(). This should be removed later.
+	 */
+	dss_runtime_put();
 }
 
 int hdmi_init_display(struct omap_dss_device *dssdev)
-- 
1.7.5.4

