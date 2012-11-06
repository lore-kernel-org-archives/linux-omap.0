From: Ricardo Neri <ricardo.neri@ti.com>
Subject: [PATCH v3 5/7] OMAPDSS: HDMI: Uninit display on device add error
Date: Tue, 6 Nov 2012 00:19:15 -0600
Message-ID: <1352182757-1216-6-git-send-email-ricardo.neri@ti.com>
References: <1352182757-1216-1-git-send-email-ricardo.neri@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:54619 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751467Ab2KFFVw (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 6 Nov 2012 00:21:52 -0500
Received: from dlelxv30.itg.ti.com ([172.17.2.17])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id qA65LpL9001775
	for <linux-omap@vger.kernel.org>; Mon, 5 Nov 2012 23:21:51 -0600
Received: from DFLE73.ent.ti.com (dfle73.ent.ti.com [128.247.5.110])
	by dlelxv30.itg.ti.com (8.13.8/8.13.8) with ESMTP id qA65Lpe3016120
	for <linux-omap@vger.kernel.org>; Mon, 5 Nov 2012 23:21:51 -0600
In-Reply-To: <1352182757-1216-1-git-send-email-ricardo.neri@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: peter.ujfalusi@ti.com, s-guiriec@ti.com, b-cousson@ti.com, linux-omap@vger.kernel.org, Ricardo Neri <ricardo.neri@ti.com>

The display must be uninitialized in order to free the requested GPIOs.

Signed-off-by: Ricardo Neri <ricardo.neri@ti.com>
---
 drivers/video/omap2/dss/hdmi.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/hdmi.c
index 696386c..4adf830 100644
--- a/drivers/video/omap2/dss/hdmi.c
+++ b/drivers/video/omap2/dss/hdmi.c
@@ -973,6 +973,7 @@ static void __init hdmi_probe_pdata(struct platform_device *pdev)
 	r = dss_add_device(dssdev);
 	if (r) {
 		DSSERR("device %s register failed: %d\n", dssdev->name, r);
+		hdmi_uninit_display(dssdev);
 		dss_put_device(dssdev);
 		return;
 	}
-- 
1.7.5.4

