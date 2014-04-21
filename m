From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 09/10] usb: phy: generic: allow multiples calls to usb_phy_generic_register()
Date: Mon, 21 Apr 2014 10:56:51 -0500
Message-ID: <1398095812-14222-10-git-send-email-balbi@ti.com>
References: <1398095812-14222-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1398095812-14222-1-git-send-email-balbi-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux USB Mailing List <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, leigh-0TD6cqJ6btAqdlJmJB21zg@public.gmane.org, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

it's now very easy to return a platform_device pointer
and have the caller pass it as argument when calling
usb_phy_generic_unregister().

Signed-off-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
---
 drivers/usb/musb/am35x.c            | 12 +++++++++---
 drivers/usb/musb/blackfin.c         | 10 ++++++++--
 drivers/usb/musb/da8xx.c            | 14 +++++++++++---
 drivers/usb/musb/tusb6010.c         |  3 ++-
 drivers/usb/phy/phy-generic.c       | 19 +++++--------------
 include/linux/usb/usb_phy_generic.h |  9 +++++----
 6 files changed, 40 insertions(+), 27 deletions(-)

diff --git a/drivers/usb/musb/am35x.c b/drivers/usb/musb/am35x.c
index 05459b5..0a34dd8 100644
--- a/drivers/usb/musb/am35x.c
+++ b/drivers/usb/musb/am35x.c
@@ -85,6 +85,7 @@
 struct am35x_glue {
 	struct device		*dev;
 	struct platform_device	*musb;
+	struct platform_device	*phy;
 	struct clk		*phy_clk;
 	struct clk		*clk;
 };
@@ -503,7 +504,9 @@ static int am35x_probe(struct platform_device *pdev)
 
 	pdata->platform_ops		= &am35x_ops;
 
-	usb_phy_generic_register();
+	glue->phy = usb_phy_generic_register();
+	if (IS_ERR(glue->phy))
+		goto err7;
 	platform_set_drvdata(pdev, glue);
 
 	pinfo = am35x_dev_info;
@@ -517,11 +520,14 @@ static int am35x_probe(struct platform_device *pdev)
 	if (IS_ERR(musb)) {
 		ret = PTR_ERR(musb);
 		dev_err(&pdev->dev, "failed to register musb device: %d\n", ret);
-		goto err7;
+		goto err8;
 	}
 
 	return 0;
 
+err8:
+	usb_phy_generic_unregister(glue->phy);
+
 err7:
 	clk_disable(clk);
 
@@ -546,7 +552,7 @@ static int am35x_remove(struct platform_device *pdev)
 	struct am35x_glue	*glue = platform_get_drvdata(pdev);
 
 	platform_device_unregister(glue->musb);
-	usb_phy_generic_unregister();
+	usb_phy_generic_unregister(glue->phy);
 	clk_disable(glue->clk);
 	clk_disable(glue->phy_clk);
 	clk_put(glue->clk);
diff --git a/drivers/usb/musb/blackfin.c b/drivers/usb/musb/blackfin.c
index 53acffe..d40d5f0 100644
--- a/drivers/usb/musb/blackfin.c
+++ b/drivers/usb/musb/blackfin.c
@@ -29,6 +29,7 @@
 struct bfin_glue {
 	struct device		*dev;
 	struct platform_device	*musb;
+	struct platform_device	*phy;
 };
 #define glue_to_musb(g)		platform_get_drvdata(g->musb)
 
@@ -475,7 +476,9 @@ static int bfin_probe(struct platform_device *pdev)
 
 	pdata->platform_ops		= &bfin_ops;
 
-	usb_phy_generic_register();
+	glue->phy = usb_phy_generic_register();
+	if (IS_ERR(glue->phy))
+		goto err2;
 	platform_set_drvdata(pdev, glue);
 
 	memset(musb_resources, 0x00, sizeof(*musb_resources) *
@@ -513,6 +516,9 @@ static int bfin_probe(struct platform_device *pdev)
 	return 0;
 
 err3:
+	usb_phy_generic_unregister(glue->phy);
+
+err2:
 	platform_device_put(musb);
 
 err1:
@@ -527,7 +533,7 @@ static int bfin_remove(struct platform_device *pdev)
 	struct bfin_glue		*glue = platform_get_drvdata(pdev);
 
 	platform_device_unregister(glue->musb);
-	usb_phy_generic_unregister();
+	usb_phy_generic_unregister(glue->phy);
 	kfree(glue);
 
 	return 0;
diff --git a/drivers/usb/musb/da8xx.c b/drivers/usb/musb/da8xx.c
index 024751f..058775e 100644
--- a/drivers/usb/musb/da8xx.c
+++ b/drivers/usb/musb/da8xx.c
@@ -85,6 +85,7 @@
 struct da8xx_glue {
 	struct device		*dev;
 	struct platform_device	*musb;
+	struct platform_device	*phy;
 	struct clk		*clk;
 };
 
@@ -510,7 +511,11 @@ static int da8xx_probe(struct platform_device *pdev)
 
 	pdata->platform_ops		= &da8xx_ops;
 
-	usb_phy_generic_register();
+	glue->phy = usb_phy_generic_register();
+	if (IS_ERR(glue->phy)) {
+		ret = PTR_ERR(glue->phy);
+		goto err5;
+	}
 	platform_set_drvdata(pdev, glue);
 
 	memset(musb_resources, 0x00, sizeof(*musb_resources) *
@@ -537,11 +542,14 @@ static int da8xx_probe(struct platform_device *pdev)
 	if (IS_ERR(musb)) {
 		ret = PTR_ERR(musb);
 		dev_err(&pdev->dev, "failed to register musb device: %d\n", ret);
-		goto err5;
+		goto err6;
 	}
 
 	return 0;
 
+err6:
+	usb_phy_generic_unregister(glue->phy);
+
 err5:
 	clk_disable(clk);
 
@@ -560,7 +568,7 @@ static int da8xx_remove(struct platform_device *pdev)
 	struct da8xx_glue		*glue = platform_get_drvdata(pdev);
 
 	platform_device_unregister(glue->musb);
-	usb_phy_generic_unregister();
+	usb_phy_generic_unregister(glue->phy);
 	clk_disable(glue->clk);
 	clk_put(glue->clk);
 	kfree(glue);
diff --git a/drivers/usb/musb/tusb6010.c b/drivers/usb/musb/tusb6010.c
index e1da199..f38a8db 100644
--- a/drivers/usb/musb/tusb6010.c
+++ b/drivers/usb/musb/tusb6010.c
@@ -31,6 +31,7 @@
 struct tusb6010_glue {
 	struct device		*dev;
 	struct platform_device	*musb;
+	struct platform_device	*phy;
 };
 
 static void tusb_musb_set_vbus(struct musb *musb, int is_on);
@@ -1222,7 +1223,7 @@ static int tusb_remove(struct platform_device *pdev)
 	struct tusb6010_glue		*glue = platform_get_drvdata(pdev);
 
 	platform_device_unregister(glue->musb);
-	usb_phy_generic_unregister();
+	usb_phy_generic_unregister(glue->phy);
 	kfree(glue);
 
 	return 0;
diff --git a/drivers/usb/phy/phy-generic.c b/drivers/usb/phy/phy-generic.c
index 2c49cd8..7594e50 100644
--- a/drivers/usb/phy/phy-generic.c
+++ b/drivers/usb/phy/phy-generic.c
@@ -41,25 +41,16 @@
 
 #include "phy-generic.h"
 
-static struct platform_device *pd;
-
-void usb_phy_generic_register(void)
+struct platform_device *usb_phy_generic_register(void)
 {
-	if (pd)
-		return;
-	pd = platform_device_register_simple("usb_phy_generic", -1, NULL, 0);
-	if (IS_ERR(pd)) {
-		pr_err("Unable to register generic usb transceiver\n");
-		pd = NULL;
-		return;
-	}
+	return platform_device_register_simple("usb_phy_generic",
+			PLATFORM_DEVID_AUTO, NULL, 0);
 }
 EXPORT_SYMBOL_GPL(usb_phy_generic_register);
 
-void usb_phy_generic_unregister(void)
+void usb_phy_generic_unregister(struct platform_device *pdev)
 {
-	platform_device_unregister(pd);
-	pd = NULL;
+	platform_device_unregister(pdev);
 }
 EXPORT_SYMBOL_GPL(usb_phy_generic_unregister);
 
diff --git a/include/linux/usb/usb_phy_generic.h b/include/linux/usb/usb_phy_generic.h
index c00176d..8346bcc 100644
--- a/include/linux/usb/usb_phy_generic.h
+++ b/include/linux/usb/usb_phy_generic.h
@@ -15,14 +15,15 @@ struct usb_phy_generic_platform_data {
 
 #if defined(CONFIG_NOP_USB_XCEIV) || (defined(CONFIG_NOP_USB_XCEIV_MODULE) && defined(MODULE))
 /* sometimes transceivers are accessed only through e.g. ULPI */
-extern void usb_phy_generic_register(void);
-extern void usb_phy_generic_unregister(void);
+extern struct platform_device *usb_phy_generic_register(void);
+extern void usb_phy_generic_unregister(struct platform_device *);
 #else
-static inline void usb_phy_generic_register(void)
+static inline struct platform_device *usb_phy_generic_register(void)
 {
+	return NULL;
 }
 
-static inline void usb_phy_generic_unregister(void)
+static inline void usb_phy_generic_unregister(struct platform_device *pdev)
 {
 }
 #endif
-- 
1.9.2.459.g68773ac

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
