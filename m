From: Afzal Mohammed <afzal@ti.com>
Subject: [PATCH v2 05/12] video: da8xx-fb: ensure non-null cfg in pdata
Date: Tue, 15 Jan 2013 19:12:28 +0530
Message-ID: <ab0823c900a07d8d7644655aaf00185ed37856ba.1358251447.git.afzal@ti.com>
References: <cover.1358251447.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1358251447.git.afzal@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>, Rob Landley <rob@landley.net>, Sekhar Nori <nsekhar@ti.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Ensure that platform data contains pointer for lcd_ctrl_config.

Signed-off-by: Afzal Mohammed <afzal@ti.com>
---
 drivers/video/da8xx-fb.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/video/da8xx-fb.c b/drivers/video/da8xx-fb.c
index 7a32e83..3b146bc 100644
--- a/drivers/video/da8xx-fb.c
+++ b/drivers/video/da8xx-fb.c
@@ -1320,6 +1320,11 @@ static int fb_probe(struct platform_device *device)
 
 	lcd_cfg = (struct lcd_ctrl_config *)fb_pdata->controller_data;
 
+	if (!lcd_cfg) {
+		ret = -EINVAL;
+		goto err_pm_runtime_disable;
+	}
+
 	da8xx_fb_info = framebuffer_alloc(sizeof(struct da8xx_fb_par),
 					&device->dev);
 	if (!da8xx_fb_info) {
-- 
1.7.9.5
