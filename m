From: George Cherian <george.cherian@ti.com>
Subject: [PATCH] usb: host: xhci-plat: release mem region while removing module
Date: Fri, 21 Jun 2013 13:59:08 +0530
Message-ID: <1371803348-9807-1-git-send-email-george.cherian@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-usb@vger.kernel.org
Cc: balbi@ti.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org, sarah.a.sharp@linux.intel.com, George Cherian <george.cherian@ti.com>
List-Id: linux-omap@vger.kernel.org

Do a release_mem_region of the hcd resource. Without this the
subsequent insertion of module fails in request_mem_region.

Signed-off-by: George Cherian <george.cherian@ti.com>
---
 drivers/usb/host/xhci-plat.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
index df90fe5..93ad67e 100644
--- a/drivers/usb/host/xhci-plat.c
+++ b/drivers/usb/host/xhci-plat.c
@@ -179,6 +179,7 @@ static int xhci_plat_remove(struct platform_device *dev)
 
 	usb_remove_hcd(hcd);
 	iounmap(hcd->regs);
+	release_mem_region(hcd->rsrc_start, hcd->rsrc_len);
 	usb_put_hcd(hcd);
 	kfree(xhci);
 
-- 
1.8.1.4
