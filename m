From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH] ARM: OMAPFB: panel-sony-acx565akm: fix bad unlock balance
Date: Wed,  6 Nov 2013 23:24:30 +0200
Message-ID: <1383773070-15114-1-git-send-email-aaro.koskinen@iki.fi>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Eduardo Valentin <eduardo.valentin@ti.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, stable@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

When booting Nokia N900 smartphone with v3.12 + omap2plus_defconfig
(LOCKDEP enabled) and CONFIG_DISPLAY_PANEL_SONY_ACX565AKM enabled,
the following BUG is seen during the boot:

[    7.302154] =====================================
[    7.307128] [ BUG: bad unlock balance detected! ]
[    7.312103] 3.12.0-los.git-2093492-00120-g5e01dc7 #3 Not tainted
[    7.318450] -------------------------------------
[    7.323425] kworker/u2:1/12 is trying to release lock (&ddata->mutex) at:
[    7.330657] [<c031b760>] acx565akm_enable+0x12c/0x18c
[    7.335998] but there are no more locks to release!

Fix by removing the extra mutex_unlock().

Reported-by: Eduardo Valentin <eduardo.valentin@ti.com>
Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: stable@vger.kernel.org
---
 drivers/video/omap2/displays-new/panel-sony-acx565akm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/omap2/displays-new/panel-sony-acx565akm.c b/drivers/video/omap2/displays-new/panel-sony-acx565akm.c
index e6d56f7..72fe2a8 100644
--- a/drivers/video/omap2/displays-new/panel-sony-acx565akm.c
+++ b/drivers/video/omap2/displays-new/panel-sony-acx565akm.c
@@ -616,7 +616,7 @@ static int acx565akm_enable(struct omap_dss_device *dssdev)
 
 	mutex_lock(&ddata->mutex);
 	r = acx565akm_panel_power_on(dssdev);
-	mutex_unlock(&ddata->mutex);
+	/* NOTE: acx565akm_panel_power_on() will unlock the mutex. */
 
 	if (r)
 		return r;
-- 
1.8.4.2
