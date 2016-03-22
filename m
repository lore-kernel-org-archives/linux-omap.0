From: Vladimir Zapolskiy <vz@mleia.com>
Subject: [PATCH] omapfb: panel-sharp-ls037v7dw01: fix check of gpio_to_desc() return value
Date: Wed, 23 Mar 2016 00:51:54 +0200
Message-ID: <1458687114-9390-1-git-send-email-vz@mleia.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

The change fixes a check of gpio_to_desc() return value, the function
returns either a valid pointer to struct gpio_desc or NULL, this makes
IS_ERR() check invalid and may lead to a NULL pointer dereference in
runtime.

Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
---
 .../fbdev/omap2/omapfb/displays/panel-sharp-ls037v7dw01.c    | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/video/fbdev/omap2/omapfb/displays/panel-sharp-ls037v7dw01.c b/drivers/video/fbdev/omap2/omapfb/displays/panel-sharp-ls037v7dw01.c
index abfd1f6..1954ec9 100644
--- a/drivers/video/fbdev/omap2/omapfb/displays/panel-sharp-ls037v7dw01.c
+++ b/drivers/video/fbdev/omap2/omapfb/displays/panel-sharp-ls037v7dw01.c
@@ -200,20 +200,16 @@ static struct omap_dss_driver sharp_ls_ops = {
 static int sharp_ls_get_gpio(struct device *dev, int gpio, unsigned long flags,
 		  char *desc, struct gpio_desc **gpiod)
 {
-	struct gpio_desc *gd;
 	int r;
 
-	*gpiod = NULL;
-
 	r = devm_gpio_request_one(dev, gpio, flags, desc);
-	if (r)
+	if (r) {
+		*gpiod = NULL;
 		return r == -ENOENT ? 0 : r;
+	}
 
-	gd = gpio_to_desc(gpio);
-	if (IS_ERR(gd))
-		return PTR_ERR(gd) == -ENOENT ? 0 : PTR_ERR(gd);
+	*gpiod = gpio_to_desc(gpio);
 
-	*gpiod = gd;
 	return 0;
 }
 
-- 
2.1.4
