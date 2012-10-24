From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 13/20] OMAPDSS: HDMI: add 1920x1200 video mode
Date: Wed, 24 Oct 2012 12:29:04 +0300
Message-ID: <1351070951-18616-14-git-send-email-tomi.valkeinen@ti.com>
References: <1351070951-18616-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:48089 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934498Ab2JXJ3q (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 24 Oct 2012 05:29:46 -0400
In-Reply-To: <1351070951-18616-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: archit@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, Ricardo Neri <ricardo.neri@ti.com>

Add 1920x1200 video mode to hdmi driver's static modelist.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Ricardo Neri <ricardo.neri@ti.com>
---
 drivers/video/omap2/dss/hdmi.c |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/hdmi.c
index b809490..dfbc1e7 100644
--- a/drivers/video/omap2/dss/hdmi.c
+++ b/drivers/video/omap2/dss/hdmi.c
@@ -295,6 +295,12 @@ static const struct hdmi_config vesa_timings[] = {
 			false, },
 		{ 0x55, HDMI_DVI },
 	},
+	{
+		{ 1920, 1200, 154000, 32, 48, 80, 6, 3, 26,
+			OMAPDSS_SIG_ACTIVE_LOW, OMAPDSS_SIG_ACTIVE_HIGH,
+			false, },
+		{ 0x44, HDMI_DVI },
+	},
 };
 
 static int hdmi_runtime_get(void)
-- 
1.7.9.5

