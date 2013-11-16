From: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Subject: [PATCH 11/11] OMAPDSS: DPI: use VPLL2 regulator if VDDS_DSI is not found
Date: Sat, 16 Nov 2013 14:23:44 +0100
Message-ID: <1384608224-9452-12-git-send-email-javier.martinez@collabora.co.uk>
References: <1384608224-9452-1-git-send-email-javier.martinez@collabora.co.uk>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([93.93.135.160]:60397 "EHLO
	bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752158Ab3KPNZH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 16 Nov 2013 08:25:07 -0500
In-Reply-To: <1384608224-9452-1-git-send-email-javier.martinez@collabora.co.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Enric Balletbo i Serra <eballetbo@gmail.com>, bcousson@baylibre.com, tomi.valkeinen@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Javier Martinez Canillas <javier.martinez@collabora.co.uk>

On Device Tree boot the VDDS_DSI regulator is not linked to
the DPI device so omapfb driver probing fails with:

[    3.186035] OMAPFB: omapfb_probe
[    3.190704] omapdss DPI error: can't get VDDS_DSI regulator
[    3.196594] omapfb omapfb: failed to connect default display
[    3.202667] omapfb omapfb: failed to init overlay connections
[    3.208892] OMAPFB: free_resources
[    3.212493] OMAPFB: free all fbmem
[    3.216735] omapfb omapfb: failed to setup omapfb

As a workaround try to use the VPLL2 regulator from twl4030 in
dpi_init_regulator() if getting the VDDS_DSI regulator fails.

Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
---
 drivers/video/omap2/dss/dpi.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/video/omap2/dss/dpi.c b/drivers/video/omap2/dss/dpi.c
index bd48cde..e328f0b 100644
--- a/drivers/video/omap2/dss/dpi.c
+++ b/drivers/video/omap2/dss/dpi.c
@@ -550,6 +550,11 @@ static int dpi_init_regulator(void)
 		return 0;
 
 	vdds_dsi = devm_regulator_get(&dpi.pdev->dev, "vdds_dsi");
+
+        /* DT HACK: try VPLL2 to make omapdss work for OMAP3 IGEPv2 */
+        if (IS_ERR(vdds_dsi))
+                vdds_dsi = devm_regulator_get(&dpi.pdev->dev, "VPLL2");
+
 	if (IS_ERR(vdds_dsi)) {
 		DSSERR("can't get VDDS_DSI regulator\n");
 		return PTR_ERR(vdds_dsi);
-- 
1.8.4.2

