From: Merlijn Wajer <merlijn@wizzup.org>
Subject: [PATCH v2] usb: musb: Fix external abort in musb_remove on omap2430
Date: Thu,  8 Mar 2018 23:19:48 +0100
Message-ID: <20180308221949.12054-1-merlijn@wizzup.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: b-liu@ti.com
Cc: merlijn@wizzup.org, ivo.g.dimitrov.75@gmail.com, linux-omap@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

This fixes an oops on unbind / module unload (on the musb omap2430
platform).

musb_remove function now calls musb_platform_exit before disabling
runtime pm.

Signed-off-by: Merlijn Wajer <merlijn@wizzup.org>
---
 drivers/usb/musb/musb_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
index e2e95071328a..fb1d88183ea1 100644
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -2474,11 +2474,11 @@ static int musb_remove(struct platform_device *pdev)
 	musb_disable_interrupts(musb);
 	musb_writeb(musb->mregs, MUSB_DEVCTL, 0);
 	spin_unlock_irqrestore(&musb->lock, flags);
+	musb_platform_exit(musb);
 
 	pm_runtime_dont_use_autosuspend(musb->controller);
 	pm_runtime_put_sync(musb->controller);
 	pm_runtime_disable(musb->controller);
-	musb_platform_exit(musb);
 	musb_phy_callback = NULL;
 	if (musb->dma_controller)
 		musb_dma_controller_destroy(musb->dma_controller);
-- 
2.16.2
