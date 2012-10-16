From: Ricardo Neri <ricardo.neri@ti.com>
Subject: [PATCH 3/6] OMAPDSS: HDMI: Make panel return error if cannot register driver
Date: Mon, 15 Oct 2012 20:27:16 -0500
Message-ID: <1350350839-30408-4-git-send-email-ricardo.neri@ti.com>
References: <1350350839-30408-1-git-send-email-ricardo.neri@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:52189 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755509Ab2JPB3n (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Oct 2012 21:29:43 -0400
Received: from dlelxv30.itg.ti.com ([172.17.2.17])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id q9G1Thdd009335
	for <linux-omap@vger.kernel.org>; Mon, 15 Oct 2012 20:29:43 -0500
Received: from DLEE74.ent.ti.com (dlee74.ent.ti.com [157.170.170.8])
	by dlelxv30.itg.ti.com (8.13.8/8.13.8) with ESMTP id q9G1Th0n015139
	for <linux-omap@vger.kernel.org>; Mon, 15 Oct 2012 20:29:43 -0500
In-Reply-To: <1350350839-30408-1-git-send-email-ricardo.neri@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: s-guiriec@ti.com, peter.ujfalusi@ti.com, b-cousson@ti.com, linux-omap@vger.kernel.org, Ricardo Neri <ricardo.neri@ti.com>

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

