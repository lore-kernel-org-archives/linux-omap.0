From: Ricardo Neri <ricardo.neri@ti.com>
Subject: [PATCH v3 3/7] OMAPDSS: HDMI: Make panel return dssdev register errors
Date: Tue, 6 Nov 2012 00:19:13 -0600
Message-ID: <1352182757-1216-4-git-send-email-ricardo.neri@ti.com>
References: <1352182757-1216-1-git-send-email-ricardo.neri@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:45790 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751323Ab2KFFVv (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 6 Nov 2012 00:21:51 -0500
Received: from dlelxv30.itg.ti.com ([172.17.2.17])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id qA65LpAv004780
	for <linux-omap@vger.kernel.org>; Mon, 5 Nov 2012 23:21:51 -0600
Received: from DFLE73.ent.ti.com (dfle73.ent.ti.com [128.247.5.110])
	by dlelxv30.itg.ti.com (8.13.8/8.13.8) with ESMTP id qA65LpkK016114
	for <linux-omap@vger.kernel.org>; Mon, 5 Nov 2012 23:21:51 -0600
In-Reply-To: <1352182757-1216-1-git-send-email-ricardo.neri@ti.com>
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

