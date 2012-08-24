From: Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH v2] usb otg: TWL4030_USB to depend on USB_MUSB_OMAP2PLUS in Kconfig
Date: Fri, 24 Aug 2012 11:09:23 +0200
Message-ID: <1345799363-28199-1-git-send-email-pmeerw@pmeerw.net>
References: <20120824072729.GE3334@arwen.pp.htv.fi>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:34229 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757906Ab2HXJJx (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 24 Aug 2012 05:09:53 -0400
In-Reply-To: <20120824072729.GE3334@arwen.pp.htv.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, kishon@ti.com, Peter Meerwald <pmeerw@pmeerw.net>

3.6-rc2 fails to compile with
CONFIG_USB_MUSB_HDRC=m
CONFIG_USB_MUSB_OMAP2PLUS=m
CONFIG_TWL4030_USB=y

LD      init/built-in.o
drivers/built-in.o: In function `twl4030_usb_irq':
/home/pmeerw/linux-3.6-rc2/drivers/usb/otg/twl4030-usb.c:518: undefined reference to `omap_musb_mailbox'
drivers/built-in.o: In function `twl4030_usb_phy_init':
/home/pmeerw/linux-3.6-rc2/drivers/usb/otg/twl4030-usb.c:540: undefined reference to `omap_musb_mailbox'

twl4030-usb uses a symbol from omap2430, hence it should depend on it

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
---
 drivers/usb/otg/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/otg/Kconfig b/drivers/usb/otg/Kconfig
index 13fd1ddf..fefca18 100644
--- a/drivers/usb/otg/Kconfig
+++ b/drivers/usb/otg/Kconfig
@@ -58,7 +58,7 @@ config USB_ULPI_VIEWPORT
 
 config TWL4030_USB
 	tristate "TWL4030 USB Transceiver Driver"
-	depends on TWL4030_CORE && REGULATOR_TWL4030
+	depends on TWL4030_CORE && REGULATOR_TWL4030 && USB_MUSB_OMAP2PLUS
 	select USB_OTG_UTILS
 	help
 	  Enable this to support the USB OTG transceiver on TWL4030
-- 
1.7.9.5

