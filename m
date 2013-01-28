From: Afzal Mohammed <afzal@ti.com>
Subject: [PATCH v5 08/12] video: da8xx-fb: invoke platform callback safely
Date: Mon, 28 Jan 2013 14:51:25 +0530
Message-ID: <0982f52598fdfc5140af251f998a43146fdf42dc.1359356015.git.afzal@ti.com>
References: <cover.1359356015.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1359356015.git.afzal@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>, Rob Landley <rob@landley.net>, Mike Turquette <mturquette@linaro.org>
List-Id: linux-omap@vger.kernel.org

Ensure that platform data is present before checking whether platform
callback is present (the one used to control backlight). So far this
was not an issue as driver was purely non-DT triggered, but now DT
support has been added.

Signed-off-by: Afzal Mohammed <afzal@ti.com>
---
 drivers/video/da8xx-fb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/da8xx-fb.c b/drivers/video/da8xx-fb.c
index 08ee8eb..0beed20 100644
--- a/drivers/video/da8xx-fb.c
+++ b/drivers/video/da8xx-fb.c
@@ -1347,7 +1347,7 @@ static int fb_probe(struct platform_device *device)
 	par->dev = &device->dev;
 	par->lcdc_clk = fb_clk;
 	par->lcd_fck_rate = clk_get_rate(fb_clk);
-	if (fb_pdata->panel_power_ctrl) {
+	if (fb_pdata && fb_pdata->panel_power_ctrl) {
 		par->panel_power_ctrl = fb_pdata->panel_power_ctrl;
 		par->panel_power_ctrl(1);
 	}
-- 
1.7.12
