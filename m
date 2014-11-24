From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 6/8] usb: musb: Pass fifo_mode in platform data
Date: Mon, 24 Nov 2014 11:05:04 -0800
Message-ID: <1416855906-13931-7-git-send-email-tony@atomide.com>
References: <1416855906-13931-1-git-send-email-tony@atomide.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1416855906-13931-1-git-send-email-tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Fabio Baltieri <fabio.baltieri-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Apelete Seketeli <apelete-fIDRvF7C5ezk1uMJSBkQmQ@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

This allows setting the correct fifo_mode when multiple
MUSB glue layers are built-in.

Cc: Fabio Baltieri <fabio.baltieri-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Apelete Seketeli <apelete-fIDRvF7C5ezk1uMJSBkQmQ@public.gmane.org>
Cc: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
---
 drivers/usb/musb/blackfin.c  |  1 +
 drivers/usb/musb/da8xx.c     |  1 +
 drivers/usb/musb/jz4740.c    |  1 +
 drivers/usb/musb/musb_core.c | 21 ++++++---------------
 drivers/usb/musb/ux500.c     |  1 +
 5 files changed, 10 insertions(+), 15 deletions(-)

diff --git a/drivers/usb/musb/blackfin.c b/drivers/usb/musb/blackfin.c
index c55fcfd..b8442b9 100644
--- a/drivers/usb/musb/blackfin.c
+++ b/drivers/usb/musb/blackfin.c
@@ -474,6 +474,7 @@ static const struct musb_platform_ops bfin_ops = {
 	.writew		= bfin_writew,
 	.readl		= bfin_readl,
 	.writel		= bfin_writel,
+	.fifo_mode	= 2,
 	.read_fifo	= bfin_read_fifo,
 	.write_fifo	= bfin_write_fifo,
 	.enable		= bfin_musb_enable,
diff --git a/drivers/usb/musb/da8xx.c b/drivers/usb/musb/da8xx.c
index c9079c8..5f9b486 100644
--- a/drivers/usb/musb/da8xx.c
+++ b/drivers/usb/musb/da8xx.c
@@ -462,6 +462,7 @@ static const struct musb_platform_ops da8xx_ops = {
 	.init		= da8xx_musb_init,
 	.exit		= da8xx_musb_exit,
 
+	.fifo_mode	= 2,
 	.enable		= da8xx_musb_enable,
 	.disable	= da8xx_musb_disable,
 
diff --git a/drivers/usb/musb/jz4740.c b/drivers/usb/musb/jz4740.c
index 40e9874..bb7b263 100644
--- a/drivers/usb/musb/jz4740.c
+++ b/drivers/usb/musb/jz4740.c
@@ -107,6 +107,7 @@ static int jz4740_musb_exit(struct musb *musb)
 
 static const struct musb_platform_ops jz4740_musb_ops = {
 	.quirks		= MUSB_INDEXED_EP,
+	.fifo_mode	= 2,
 	.init		= jz4740_musb_init,
 	.exit		= jz4740_musb_exit,
 };
diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
index 48ddc82..0875365 100644
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -1116,21 +1116,7 @@ static void musb_shutdown(struct platform_device *pdev)
  * We don't currently use dynamic fifo setup capability to do anything
  * more than selecting one of a bunch of predefined configurations.
  */
-#if defined(CONFIG_USB_MUSB_TUSB6010)			\
-	|| defined(CONFIG_USB_MUSB_TUSB6010_MODULE)	\
-	|| defined(CONFIG_USB_MUSB_OMAP2PLUS)		\
-	|| defined(CONFIG_USB_MUSB_OMAP2PLUS_MODULE)	\
-	|| defined(CONFIG_USB_MUSB_AM35X)		\
-	|| defined(CONFIG_USB_MUSB_AM35X_MODULE)	\
-	|| defined(CONFIG_USB_MUSB_DSPS)		\
-	|| defined(CONFIG_USB_MUSB_DSPS_MODULE)
-static ushort fifo_mode = 4;
-#elif defined(CONFIG_USB_MUSB_UX500)			\
-	|| defined(CONFIG_USB_MUSB_UX500_MODULE)
-static ushort fifo_mode = 5;
-#else
-static ushort fifo_mode = 2;
-#endif
+static ushort fifo_mode;
 
 /* "modprobe ... fifo_mode=1" etc */
 module_param(fifo_mode, ushort, 0);
@@ -2040,6 +2026,11 @@ musb_init_controller(struct device *dev, int nIrq, void __iomem *ctrl)
 		musb->io.ep_select = musb_flat_ep_select;
 	}
 
+	if (musb->ops->fifo_mode)
+		fifo_mode = musb->ops->fifo_mode;
+	else
+		fifo_mode = 4;
+
 	if (musb->ops->fifo_offset)
 		musb->io.fifo_offset = musb->ops->fifo_offset;
 	else
diff --git a/drivers/usb/musb/ux500.c b/drivers/usb/musb/ux500.c
index c170501..c372518 100644
--- a/drivers/usb/musb/ux500.c
+++ b/drivers/usb/musb/ux500.c
@@ -191,6 +191,7 @@ static const struct musb_platform_ops ux500_ops = {
 	.quirks		= MUSB_INDEXED_EP,
 	.init		= ux500_musb_init,
 	.exit		= ux500_musb_exit,
+	.fifo_mode	= 5,
 
 	.set_vbus	= ux500_musb_set_vbus,
 };
-- 
2.1.3

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
