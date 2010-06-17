From: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 7/8] musb: Kill board specific pinmux from driver file
Date: Thu, 17 Jun 2010 16:10:40 +0530
Message-ID: <1276771242-5201-8-git-send-email-ajay.gupta@ti.com>
References: <1276771242-5201-1-git-send-email-ajay.gupta@ti.com>
 <1276771242-5201-2-git-send-email-ajay.gupta@ti.com>
 <1276771242-5201-3-git-send-email-ajay.gupta@ti.com>
 <1276771242-5201-4-git-send-email-ajay.gupta@ti.com>
 <1276771242-5201-5-git-send-email-ajay.gupta@ti.com>
 <1276771242-5201-6-git-send-email-ajay.gupta@ti.com>
 <1276771242-5201-7-git-send-email-ajay.gupta@ti.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1276771242-5201-7-git-send-email-ajay.gupta-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org, gregkh-l3A5Bk7waGM@public.gmane.org, Anand Gadiyar <gadiyar-l0cyMroinI0@public.gmane.org>, Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

From: Anand Gadiyar <gadiyar-l0cyMroinI0@public.gmane.org>

This pin-muxing is best done in the board files. The driver should
not do this explicitly.

Also, this code causes a warning to be thrown when OMAP2430 and OMAP3/4
support are enabled in the same kernel.

Signed-off-by: Anand Gadiyar <gadiyar-l0cyMroinI0@public.gmane.org>
Signed-off-by: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
---
 drivers/usb/musb/omap2430.c |    6 ------
 1 files changed, 0 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
index e06d65e..2111a24 100644
--- a/drivers/usb/musb/omap2430.c
+++ b/drivers/usb/musb/omap2430.c
@@ -32,8 +32,6 @@
 #include <linux/clk.h>
 #include <linux/io.h>
 
-#include <plat/mux.h>
-
 #include "musb_core.h"
 #include "omap2430.h"
 
@@ -194,10 +192,6 @@ int __init musb_platform_init(struct musb *musb, void *board_data)
 	u32 l;
 	struct omap_musb_board_data *data = board_data;
 
-#if defined(CONFIG_ARCH_OMAP2430)
-	omap_cfg_reg(AE5_2430_USB0HS_STP);
-#endif
