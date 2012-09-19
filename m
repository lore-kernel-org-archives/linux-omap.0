From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 2/8] OMAPDSS: Add dss_get_default_display_name()
Date: Wed, 19 Sep 2012 11:30:32 +0300
Message-ID: <1348043438-2624-3-git-send-email-tomi.valkeinen@ti.com>
References: <1348043438-2624-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:41041 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753111Ab2ISIbH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 19 Sep 2012 04:31:07 -0400
Received: by lbbgj3 with SMTP id gj3so618916lbb.19
        for <linux-omap@vger.kernel.org>; Wed, 19 Sep 2012 01:31:04 -0700 (PDT)
In-Reply-To: <1348043438-2624-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: archit@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

Add function dss_get_default_display_name() which returns the name of
the default display, given from the board file or via module parameters.
The default display name can be used by output drivers to decide which
display is the wanted one.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/core.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/video/omap2/dss/core.c b/drivers/video/omap2/dss/core.c
index 20c8bc8..315f557 100644
--- a/drivers/video/omap2/dss/core.c
+++ b/drivers/video/omap2/dss/core.c
@@ -57,6 +57,11 @@ bool dss_debug;
 module_param_named(debug, dss_debug, bool, 0644);
 #endif
 
+const char *dss_get_default_display_name(void)
+{
+	return core.default_display_name;
+}
+
 /* REGULATORS */
 
 struct regulator *dss_get_vdds_dsi(void)
-- 
1.7.9.5

