From: Ricardo Neri <ricardo.neri@ti.com>
Subject: [PATCH v2 3/7] OMAPDSS: HDMI: Make panel return dssdev register errors
Date: Fri, 2 Nov 2012 18:31:44 -0600
Message-ID: <1351902708-866-4-git-send-email-ricardo.neri@ti.com>
References: <1351902708-866-1-git-send-email-ricardo.neri@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:39759 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752650Ab2KBXeN (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 2 Nov 2012 19:34:13 -0400
Received: from dlelxv30.itg.ti.com ([172.17.2.17])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id qA2NYDFv031807
	for <linux-omap@vger.kernel.org>; Fri, 2 Nov 2012 18:34:13 -0500
Received: from DFLE72.ent.ti.com (dfle72.ent.ti.com [128.247.5.109])
	by dlelxv30.itg.ti.com (8.13.8/8.13.8) with ESMTP id qA2NYDqY013383
	for <linux-omap@vger.kernel.org>; Fri, 2 Nov 2012 18:34:13 -0500
In-Reply-To: <1351902708-866-1-git-send-email-ricardo.neri@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: peter.ujfalusi@ti.com, s-guiriec@ti.com, b-cousson@ti.com, linux-omap@vger.kernel.org, Ricardo Neri <ricardo.neri@ti.com>

Do not assume blindly that the DSS driver was registered successfully.

Signed-off-by: Ricardo Neri <ricardo.neri@ti.com>
---
 drivers/video/omap2/dss/hdmi_panel.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/drivers/video/omap2/dss/hdmi_panel.c b/drivers/video/omap2/dss/hdmi_panel.c
index 69fb115..129107b 100644
--- a/drivers/video/omap2/dss/hdmi_panel.c
+++ b/drivers/video/omap2/dss/hdmi_panel.c
@@ -454,9 +454,7 @@ int hdmi_panel_init(void)
 	spin_lock_init(&hdmi.audio_lock);
 #endif
 
-	omap_dss_register_driver(&hdmi_driver);
-
-	return 0;
+	return omap_dss_register_driver(&hdmi_driver);
 }
 
 void hdmi_panel_exit(void)
-- 
1.7.5.4

