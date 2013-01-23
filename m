From: Afzal Mohammed <afzal-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v4 06/12] video: da8xx-fb: reorganize panel detection
Date: Wed, 23 Jan 2013 17:18:24 +0530
Message-ID: <47095b1c5196d6ca1de19899274bcd0f79bcc269.1358937685.git.afzal@ti.com>
References: <cover.1358937685.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <cover.1358937685.git.afzal-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Florian Tobias Schandinat <FlorianSchandinat-Mmb7MZpHnFY@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Move panel detection to a separate function, this helps in readability
as well as makes DT support cleaner.

Signed-off-by: Afzal Mohammed <afzal-l0cyMroinI0@public.gmane.org>
---
 drivers/video/da8xx-fb.c | 42 ++++++++++++++++++++++++++----------------
 1 file changed, 26 insertions(+), 16 deletions(-)

diff --git a/drivers/video/da8xx-fb.c b/drivers/video/da8xx-fb.c
index 3b146bc..b6ea5e9 100644
--- a/drivers/video/da8xx-fb.c
+++ b/drivers/video/da8xx-fb.c
@@ -1253,6 +1253,27 @@ static struct fb_ops da8xx_fb_ops = {
 	.fb_blank = cfb_blank,
 };
 
+static struct fb_videomode *da8xx_fb_get_videomode(struct platform_device *dev)
+{
+	struct da8xx_lcdc_platform_data *fb_pdata = dev->dev.platform_data;
+	struct fb_videomode *lcdc_info;
+	int i;
+
+	for (i = 0, lcdc_info = known_lcd_panels;
+		i < ARRAY_SIZE(known_lcd_panels); i++, lcdc_info++) {
+		if (strcmp(fb_pdata->type, lcdc_info->name) == 0)
+			break;
+	}
+
+	if (i == ARRAY_SIZE(known_lcd_panels)) {
+		dev_err(&dev->dev, "no panel found\n");
+		return NULL;
+	}
+	dev_info(&dev->dev, "found %s panel\n", lcdc_info->name);
+
+	return lcdc_info;
+}
+
 static int fb_probe(struct platform_device *device)
 {
 	struct da8xx_lcdc_platform_data *fb_pdata =
@@ -1262,7 +1283,7 @@ static int fb_probe(struct platform_device *device)
 	struct fb_info *da8xx_fb_info;
 	struct clk *fb_clk = NULL;
 	struct da8xx_fb_par *par;
-	int ret, i;
+	int ret;
 	unsigned long ulcm;
 
 	if (fb_pdata == NULL) {
@@ -1270,6 +1291,10 @@ static int fb_probe(struct platform_device *device)
 		return -ENOENT;
 	}
 
+	lcdc_info = da8xx_fb_get_videomode(device);
+	if (lcdc_info == NULL)
+		return -ENODEV;
+
 	lcdc_regs = platform_get_resource(device, IORESOURCE_MEM, 0);
 	da8xx_fb_reg_base = devm_request_and_ioremap(&device->dev, lcdc_regs);
 	if (!da8xx_fb_reg_base) {
@@ -1303,21 +1328,6 @@ static int fb_probe(struct platform_device *device)
 		break;
 	}
 
-	for (i = 0, lcdc_info = known_lcd_panels;
-		i < ARRAY_SIZE(known_lcd_panels);
-		i++, lcdc_info++) {
-		if (strcmp(fb_pdata->type, lcdc_info->name) == 0)
-			break;
-	}
-
-	if (i == ARRAY_SIZE(known_lcd_panels)) {
-		dev_err(&device->dev, "GLCD: No valid panel found\n");
-		ret = -ENODEV;
-		goto err_pm_runtime_disable;
-	} else
-		dev_info(&device->dev, "GLCD: Found %s panel\n",
-					fb_pdata->type);
-
 	lcd_cfg = (struct lcd_ctrl_config *)fb_pdata->controller_data;
 
 	if (!lcd_cfg) {
-- 
1.7.12
