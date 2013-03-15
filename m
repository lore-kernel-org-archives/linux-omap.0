From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 1/4] usb: Fix linker errors during build
Date: Fri, 15 Mar 2013 18:58:49 +0530
Message-ID: <1363354132-27523-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: balbi@ti.com, gregkh@linuxfoundation.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: tony@atomide.com, notasas@gmail.com, Kishon Vijay Abraham I <kishon@ti.com>
List-Id: linux-omap@vger.kernel.org

commit 63378a (usb: phy: remove CONFIG_USB_OTG_UTILS) removed
CONFIG_USB_OTG_UTILS from Kconfig but failed to removed from Makefile.
Fixed it here.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/usb/Makefile |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/Makefile b/drivers/usb/Makefile
index 860306b..c41feba 100644
--- a/drivers/usb/Makefile
+++ b/drivers/usb/Makefile
@@ -44,7 +44,7 @@ obj-$(CONFIG_USB_MICROTEK)	+= image/
 obj-$(CONFIG_USB_SERIAL)	+= serial/
 
 obj-$(CONFIG_USB)		+= misc/
-obj-$(CONFIG_USB_OTG_UTILS)	+= phy/
+obj-$(CONFIG_USB_PHY)		+= phy/
 obj-$(CONFIG_EARLY_PRINTK_DBGP)	+= early/
 
 obj-$(CONFIG_USB_ATM)		+= atm/
-- 
1.7.10.4
