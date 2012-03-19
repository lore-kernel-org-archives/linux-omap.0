From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 1/2] OMAPDSS: TPO-TD03MTEA1: Check for errors from regulator_enable()
Date: Mon, 19 Mar 2012 15:02:31 +0000
Message-ID: <1332169352-5076-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:47184 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1030838Ab2CSPCi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 19 Mar 2012 11:02:38 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Cc: Grazvydas Ignotas <notasas@gmail.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Mark Brown <broonie@opensource.wolfsonmicro.com>

It is possible for regulator_enable() to fail and if it does fail that's
generally a bad sign for anything we try to do with the hardware afterwards
so check for and immediately return an error if regulator_enable() fails.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 .../video/omap2/displays/panel-tpo-td043mtea1.c    |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/drivers/video/omap2/displays/panel-tpo-td043mtea1.c b/drivers/video/omap2/displays/panel-tpo-td043mtea1.c
index 32f3fcd..74c6b87 100644
--- a/drivers/video/omap2/displays/panel-tpo-td043mtea1.c
+++ b/drivers/video/omap2/displays/panel-tpo-td043mtea1.c
@@ -272,11 +272,14 @@ static const struct omap_video_timings tpo_td043_timings = {
 static int tpo_td043_power_on(struct tpo_td043_device *tpo_td043)
 {
 	int nreset_gpio = tpo_td043->nreset_gpio;
+	int r;
 
 	if (tpo_td043->powered_on)
 		return 0;
 
-	regulator_enable(tpo_td043->vcc_reg);
+	r = regulator_enable(tpo_td043->vcc_reg);
+	if (r != 0)
+		return r;
 
 	/* wait for regulator to stabilize */
 	msleep(160);
-- 
1.7.9.1

