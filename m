From: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 2/3] musb: populate board_data within musb structure
Date: Thu, 27 May 2010 12:34:47 +0530
Message-ID: <1274943888-17615-2-git-send-email-ajay.gupta@ti.com>
References: <1274943888-17615-1-git-send-email-ajay.gupta@ti.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1274943888-17615-1-git-send-email-ajay.gupta-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org, amit.kucheria-LY4KaoCqKrnby3iVrkZq2A@public.gmane.org, khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org, Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Added board_data within musb as it would be required in
musb_platform_exit() also to unregister the nop transceiver.

Also changed the signature of musb_platform_init() as now
board_data can be taken from musb itself.

Signed-off-by: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
---
 drivers/usb/musb/blackfin.c  |    2 +-
 drivers/usb/musb/davinci.c   |    2 +-
 drivers/usb/musb/musb_core.c |    3 ++-
 drivers/usb/musb/musb_core.h |    3 ++-
 drivers/usb/musb/omap2430.c  |    4 ++--
 drivers/usb/musb/tusb6010.c  |    2 +-
 6 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/musb/blackfin.c b/drivers/usb/musb/blackfin.c
index b611420..0bef011 100644
--- a/drivers/usb/musb/blackfin.c
+++ b/drivers/usb/musb/blackfin.c
@@ -323,7 +323,7 @@ int musb_platform_set_mode(struct musb *musb, u8 musb_mode)
 	return -EIO;
 }
 
-int __init musb_platform_init(struct musb *musb, void *board_data)
+int __init musb_platform_init(struct musb *musb)
 {
 
 	/*
diff --git a/drivers/usb/musb/davinci.c b/drivers/usb/musb/davinci.c
index 5762436..ce2e16f 100644
--- a/drivers/usb/musb/davinci.c
+++ b/drivers/usb/musb/davinci.c
@@ -376,7 +376,7 @@ int musb_platform_set_mode(struct musb *musb, u8 mode)
 	return -EIO;
 }
 
-int __init musb_platform_init(struct musb *musb, void *board_data)
+int __init musb_platform_init(struct musb *musb)
 {
 	void __iomem	*tibase = musb->ctrl_base;
 	u32		revision;
diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
index d3911ab..1ccc4d7 100644
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -1961,6 +1961,7 @@ bad_config:
 	}
 
 	spin_lock_init(&musb->lock);
+	musb->board_data = plat->board_data;
 	musb->board_mode = plat->mode;
 	musb->board_set_power = plat->set_power;
 	musb->set_clock = plat->set_clock;
@@ -1995,7 +1996,7 @@ bad_config:
 	 * isp1504, non-OTG, etc) mostly hooking up through ULPI.
 	 */
 	musb->isr = generic_interrupt;
-	status = musb_platform_init(musb, plat->board_data);
+	status = musb_platform_init(musb);
 	if (status < 0)
 		goto fail2;
 
diff --git a/drivers/usb/musb/musb_core.h b/drivers/usb/musb/musb_core.h
index 7cef2b7..9dddaa4 100644
--- a/drivers/usb/musb/musb_core.h
+++ b/drivers/usb/musb/musb_core.h
@@ -393,6 +393,7 @@ struct musb {
 	int			(*board_set_power)(int state);
 
 	int			(*set_clock)(struct clk *clk, int is_active);
+	void			*board_data;	/* board specific data */
 
 	u8			min_power;	/* vbus for periph, in mA/2 */
 
@@ -604,7 +605,7 @@ extern int musb_platform_get_vbus_status(struct musb *musb);
 #define musb_platform_get_vbus_status(x)	0
 #endif
 
-extern int __init musb_platform_init(struct musb *musb, void *board_data);
+extern int __init musb_platform_init(struct musb *musb);
 extern int musb_platform_exit(struct musb *musb);
 
 #endif	/* __MUSB_CORE_H__ */
diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
index e06d65e..50591e7 100644
--- a/drivers/usb/musb/omap2430.c
+++ b/drivers/usb/musb/omap2430.c
@@ -189,10 +189,10 @@ int musb_platform_set_mode(struct musb *musb, u8 musb_mode)
 	return 0;
 }
 
-int __init musb_platform_init(struct musb *musb, void *board_data)
+int __init musb_platform_init(struct musb *musb)
 {
 	u32 l;
-	struct omap_musb_board_data *data = board_data;
+	struct omap_musb_board_data *data = musb->board_data;
 
 #if defined(CONFIG_ARCH_OMAP2430)
 	omap_cfg_reg(AE5_2430_USB0HS_STP);
diff --git a/drivers/usb/musb/tusb6010.c b/drivers/usb/musb/tusb6010.c
index 05c077f..60d3938 100644
--- a/drivers/usb/musb/tusb6010.c
+++ b/drivers/usb/musb/tusb6010.c
@@ -1104,7 +1104,7 @@ err:
 	return -ENODEV;
 }
 
-int __init musb_platform_init(struct musb *musb, void *board_data)
+int __init musb_platform_init(struct musb *musb)
 {
 	struct platform_device	*pdev;
 	struct resource		*mem;
-- 
1.6.2.4

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
