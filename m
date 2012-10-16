From: Ricardo Neri <ricardo.neri@ti.com>
Subject: [PATCH 4/6] OMAPDSS: HDMI: Uninit display if unable to register device
Date: Mon, 15 Oct 2012 20:27:17 -0500
Message-ID: <1350350839-30408-5-git-send-email-ricardo.neri@ti.com>
References: <1350350839-30408-1-git-send-email-ricardo.neri@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:52190 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755501Ab2JPB3o (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Oct 2012 21:29:44 -0400
Received: from dlelxv30.itg.ti.com ([172.17.2.17])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id q9G1TheN009338
	for <linux-omap@vger.kernel.org>; Mon, 15 Oct 2012 20:29:43 -0500
Received: from DFLE72.ent.ti.com (dfle72.ent.ti.com [128.247.5.109])
	by dlelxv30.itg.ti.com (8.13.8/8.13.8) with ESMTP id q9G1Th1M015145
	for <linux-omap@vger.kernel.org>; Mon, 15 Oct 2012 20:29:43 -0500
In-Reply-To: <1350350839-30408-1-git-send-email-ricardo.neri@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: s-guiriec@ti.com, peter.ujfalusi@ti.com, b-cousson@ti.com, linux-omap@vger.kernel.org, Ricardo Neri <ricardo.neri@ti.com>

The display must be uninit'ed in order to free the requested GPIOs.

Signed-off-by: Ricardo Neri <ricardo.neri@ti.com>
---
 drivers/video/omap2/dss/hdmi.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/hdmi.c
index 6773e2c..bea42f4 100644
--- a/drivers/video/omap2/dss/hdmi.c
+++ b/drivers/video/omap2/dss/hdmi.c
@@ -971,6 +971,7 @@ static void __init hdmi_probe_pdata(struct platform_device *pdev)
 	r = dss_add_device(dssdev);
 	if (r) {
 		DSSERR("device %s register failed: %d\n", dssdev->name, r);
+		hdmi_uninit_display(dssdev);
 		dss_put_device(dssdev);
 		return;
 	}
-- 
1.7.5.4

