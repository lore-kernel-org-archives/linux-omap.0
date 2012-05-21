From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 8/8] OMAPDSS: Apply VENC timings even if panel is disabled
Date: Mon, 21 May 2012 12:28:06 +0300
Message-ID: <1337592486-13040-9-git-send-email-tomi.valkeinen@ti.com>
References: <1337592486-13040-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:38302 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932508Ab2EUJ2j (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 21 May 2012 05:28:39 -0400
Received: by lban1 with SMTP id n1so3204891lba.10
        for <linux-omap@vger.kernel.org>; Mon, 21 May 2012 02:28:36 -0700 (PDT)
In-Reply-To: <1337592486-13040-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: archit@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

From: Archit Taneja <archit@ti.com>

The VENC interfaces uses it's venc_set_timing() function to take in a new set
of timings. If the panel is disabled, it does not disable and re-enable the
interface. Currently, the manager timings are applied in venc_power_on(), these
are not called by set_timings if the panel is disabled. When checking overlay
and manager data, the DSS driver uses the last applied manager timings, and not
the timings held by omap_dss_device struct. Hence, there is a need to apply the
new manager timings even if the panel is disabled.

Apply the manager timings if the VENC panel is disabled.

This is similar to the commit below which fixed the same issue for HDMI/DPI
interfaces:

fcc36619901064a76e15a545ea36d38ba0e54192

Signed-off-by: Archit Taneja <archit@ti.com>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/venc.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/video/omap2/dss/venc.c b/drivers/video/omap2/dss/venc.c
index 09be43d..2b89739 100644
--- a/drivers/video/omap2/dss/venc.c
+++ b/drivers/video/omap2/dss/venc.c
@@ -645,6 +645,8 @@ static void venc_set_timings(struct omap_dss_device *dssdev,
 		/* turn the venc off and on to get new timings to use */
 		venc_panel_disable(dssdev);
 		venc_panel_enable(dssdev);
+	} else {
+		dss_mgr_set_timings(dssdev->manager, timings);
 	}
 }
 
-- 
1.7.9.5

