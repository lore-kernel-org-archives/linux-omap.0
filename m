From: Sebastian Reichel <sre@kernel.org>
Subject: [PATCH 03/23] drm: omapdrm: dss: reset dsi module during initialization
Date: Tue,  8 Mar 2016 17:39:35 +0100
Message-ID: <1457455195-1938-4-git-send-email-sre@kernel.org>
References: <1457455195-1938-1-git-send-email-sre@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1457455195-1938-1-git-send-email-sre@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, David Airlie <airlied@linux.ie>, linux-omap@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

From: Tomi Valkeinen <tomi.valkeinen@ti.com>

The Nokia N950's bootloader leaves the DSI module
in a non-working state. Work around this by resetting
the DSI module before using it.

Signed-off-By: Tomi Valkeinen <tomi.valkeinen@ti.com>
Reviewed-By: Sebastian Reichel <sre@kernel.org>
Tested-By: Sebastian Reichel <sre@kernel.org>
---
 drivers/gpu/drm/omapdrm/dss/dsi.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/gpu/drm/omapdrm/dss/dsi.c b/drivers/gpu/drm/omapdrm/dss/dsi.c
index 43be4b2a7b05..363a61e6aca7 100644
--- a/drivers/gpu/drm/omapdrm/dss/dsi.c
+++ b/drivers/gpu/drm/omapdrm/dss/dsi.c
@@ -5274,6 +5274,28 @@ static int dsi_init_pll_data(struct platform_device *dsidev)
 	return 0;
 }
 
+static int _dsi_wait_reset(struct platform_device *dsidev)
+{
+	int t = 0;
+
+	while (REG_GET(dsidev, DSI_SYSSTATUS, 0, 0) == 0) {
+		 if (++t > 5) {
+		DSSERR("soft reset failed\n");
+			return -ENODEV;
+		 }
+		 udelay(1);
+	}
+
+	return 0;
+}
+
+static int _dsi_reset(struct platform_device *dsidev)
+{
+	/* Soft reset */
+	dsi_write_reg(dsidev, DSI_SYSCONFIG, 0x2);
+	return _dsi_wait_reset(dsidev);
+}
+
 /* DSI1 HW IP initialisation */
 static int dsi_bind(struct device *dev, struct device *master, void *data)
 {
@@ -5432,6 +5454,8 @@ static int dsi_bind(struct device *dev, struct device *master, void *data)
 	if (r)
 		goto err_runtime_get;
 
+	_dsi_reset(dsidev);
+
 	rev = dsi_read_reg(dsidev, DSI_REVISION);
 	dev_dbg(&dsidev->dev, "OMAP DSI rev %d.%d\n",
 	       FLD_GET(rev, 7, 4), FLD_GET(rev, 3, 0));
-- 
2.7.0
