From: Merlijn Wajer <merlijn@wizzup.org>
Subject: [PATCH] usb: musb: Fix external abort in musb_remove
Date: Thu,  8 Mar 2018 21:40:47 +0100
Message-ID: <20180308204049.29474-1-merlijn@wizzup.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: b-liu@ti.com
Cc: merlijn@wizzup.org, ivo.g.dimitrov.75@gmail.com, linux-omap@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

This fixes an oops on unbind / module unload.

musb_remove function now calls musb_platform_exit before disabling
runtime pm.

Signed-off-by: Merlijn Wajer <merlijn@wizzup.org>
---
 drivers/usb/musb/musb_core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
index e2e95071328a..cf90d34f7199 100644
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -2472,13 +2472,14 @@ static int musb_remove(struct platform_device *pdev)
 	musb_platform_disable(musb);
 	spin_lock_irqsave(&musb->lock, flags);
 	musb_disable_interrupts(musb);
-	musb_writeb(musb->mregs, MUSB_DEVCTL, 0);
 	spin_unlock_irqrestore(&musb->lock, flags);
 
+	musb_writeb(musb->mregs, MUSB_DEVCTL, 0);
+	musb_platform_exit(musb);
+
 	pm_runtime_dont_use_autosuspend(musb->controller);
 	pm_runtime_put_sync(musb->controller);
 	pm_runtime_disable(musb->controller);
-	musb_platform_exit(musb);
 	musb_phy_callback = NULL;
 	if (musb->dma_controller)
 		musb_dma_controller_destroy(musb->dma_controller);
-- 
2.16.2
