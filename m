From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] OMAPDSS: VENC: Check for errors from regulator_enable()
Date: Mon, 19 Mar 2012 14:56:39 +0000
Message-ID: <1332168999-4600-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:35599 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1030838Ab2CSO4p (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 19 Mar 2012 10:56:45 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Mark Brown <broonie@opensource.wolfsonmicro.com>

It is possible for regulator_enable() to fail and if it does fail that's
generally a bad sign for anything we try to do with the hardware afterwards
so check for and immediately return an error if regulator_enable() fails.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 drivers/video/omap2/dss/venc.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/video/omap2/dss/venc.c b/drivers/video/omap2/dss/venc.c
index 9c3daf7..abfbd4a 100644
--- a/drivers/video/omap2/dss/venc.c
+++ b/drivers/video/omap2/dss/venc.c
@@ -443,7 +443,9 @@ static int venc_power_on(struct omap_dss_device *dssdev)
 	dispc_set_digit_size(dssdev->panel.timings.x_res,
 			dssdev->panel.timings.y_res/2);
 
-	regulator_enable(venc.vdda_dac_reg);
+	r = regulator_enable(venc.vdda_dac_reg);
+	if (r)
+		goto err;
 
 	if (dssdev->platform_enable)
 		dssdev->platform_enable(dssdev);
-- 
1.7.9.1

