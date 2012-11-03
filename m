From: Ricardo Neri <ricardo.neri@ti.com>
Subject: [PATCH v2 5/7] OMAPDSS: HDMI: Uninit display on device add error
Date: Fri, 2 Nov 2012 18:31:46 -0600
Message-ID: <1351902708-866-6-git-send-email-ricardo.neri@ti.com>
References: <1351902708-866-1-git-send-email-ricardo.neri@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:39760 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750928Ab2KBXeO (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 2 Nov 2012 19:34:14 -0400
Received: from dlelxv30.itg.ti.com ([172.17.2.17])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id qA2NYDB4031810
	for <linux-omap@vger.kernel.org>; Fri, 2 Nov 2012 18:34:13 -0500
Received: from DLEE74.ent.ti.com (dlee74.ent.ti.com [157.170.170.8])
	by dlelxv30.itg.ti.com (8.13.8/8.13.8) with ESMTP id qA2NYDuS013397
	for <linux-omap@vger.kernel.org>; Fri, 2 Nov 2012 18:34:13 -0500
In-Reply-To: <1351902708-866-1-git-send-email-ricardo.neri@ti.com>
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

