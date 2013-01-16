From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 1/3] OMAPDSS: Panel NEC: Set backlight type to remove boot time warning
Date: Wed, 16 Jan 2013 13:45:07 +0100
Message-ID: <1358340309-8774-2-git-send-email-peter.ujfalusi@ti.com>
References: <1358340309-8774-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1358340309-8774-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Cc: Archit Taneja <archit@ti.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-omap@vger.kernel.org

Fixes the following boot time warning:
[    2.230865] WARNING: at drivers/video/backlight/backlight.c:315 backlight_device_register+0x184/0x1f4()
[    2.240386] nec-8048: invalid backlight type

We need to pass valid backlight type when the device is registered.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/video/omap2/displays/panel-nec-nl8048hl11-01b.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/omap2/displays/panel-nec-nl8048hl11-01b.c b/drivers/video/omap2/displays/panel-nec-nl8048hl11-01b.c
index c4e9c2b..f43a343 100644
--- a/drivers/video/omap2/displays/panel-nec-nl8048hl11-01b.c
+++ b/drivers/video/omap2/displays/panel-nec-nl8048hl11-01b.c
@@ -132,6 +132,7 @@ static int nec_8048_panel_probe(struct omap_dss_device *dssdev)
 
 	memset(&props, 0, sizeof(struct backlight_properties));
 	props.max_brightness = 255;
+	props.type = BACKLIGHT_RAW;
 
 	bl = backlight_device_register("nec-8048", &dssdev->dev, dssdev,
 			&nec_8048_bl_ops, &props);
-- 
1.8.1
