From: Ricardo Neri <ricardo.neri@ti.com>
Subject: [PATCH] OMAPDSS: HDMI: Remove __exit macro from hdmi_uninit_display
Date: Tue, 6 Nov 2012 21:37:14 -0600
Message-ID: <1352259434-21196-1-git-send-email-ricardo.neri@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:40205 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752619Ab2KGCjn (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 6 Nov 2012 21:39:43 -0500
Received: from dlelxv30.itg.ti.com ([172.17.2.17])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id qA72dhOw013263
	for <linux-omap@vger.kernel.org>; Tue, 6 Nov 2012 20:39:43 -0600
Received: from DFLE73.ent.ti.com (dfle73.ent.ti.com [128.247.5.110])
	by dlelxv30.itg.ti.com (8.13.8/8.13.8) with ESMTP id qA72dhVA008219
	for <linux-omap@vger.kernel.org>; Tue, 6 Nov 2012 20:39:43 -0600
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, Ricardo Neri <ricardo.neri@ti.com>

This function is now used in the driver init path to handle
probe errors properly. Thus, it may be possible to use this function
outside the exit path.

Reported-by: Fengguang Wu <fengguang.wu@intel.com>
Reported-by: Yuanhan Liu <yuanhan.liu@linux.intel.com>
Signed-off-by: Ricardo Neri <ricardo.neri@ti.com>
---
 drivers/video/omap2/dss/hdmi.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/hdmi.c
index 0c2f35b..6cf2fe2 100644
--- a/drivers/video/omap2/dss/hdmi.c
+++ b/drivers/video/omap2/dss/hdmi.c
@@ -365,7 +365,7 @@ static int __init hdmi_init_display(struct omap_dss_device *dssdev)
 	return 0;
 }
 
-static void __exit hdmi_uninit_display(struct omap_dss_device *dssdev)
+static void hdmi_uninit_display(struct omap_dss_device *dssdev)
 {
 	DSSDBG("uninit_display\n");
 
-- 
1.7.5.4

