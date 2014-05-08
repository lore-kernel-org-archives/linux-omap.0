From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 4/8] usb: phy: fix isp1301-omap dependency on tps65010
Date: Thu,  8 May 2014 15:52:17 +0200
Message-ID: <1399557141-1346645-5-git-send-email-arnd@arndb.de>
References: <1399557141-1346645-1-git-send-email-arnd@arndb.de>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.13]:49995 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752535AbaEHNwk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 May 2014 09:52:40 -0400
In-Reply-To: <1399557141-1346645-1-git-send-email-arnd@arndb.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Felipe Balbi <balbi@ti.com>, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>, linux-omap@vger.kernel.org

The isp1301-omap driver cannot be built-in if the tps65010 driver
is a module, otherwise we get a link error from the reference to
the tps65010_set_vbus_draw function.

There is already a hack in the driver to work around the problem
of tps65010 being not available at all. This patch extends that
hack to ensure that the real tps65010_set_vbus_draw() function
is only called when it's avaiable.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: linux-omap@vger.kernel.org
---
 drivers/usb/phy/phy-isp1301-omap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/phy/phy-isp1301-omap.c b/drivers/usb/phy/phy-isp1301-omap.c
index 6e146d7..35a0dd2 100644
--- a/drivers/usb/phy/phy-isp1301-omap.c
+++ b/drivers/usb/phy/phy-isp1301-omap.c
@@ -94,7 +94,7 @@ struct isp1301 {
 
 #if defined(CONFIG_MACH_OMAP_H2) || defined(CONFIG_MACH_OMAP_H3)
 
-#if	defined(CONFIG_TPS65010) || defined(CONFIG_TPS65010_MODULE)
+#if	defined(CONFIG_TPS65010) || (defined(CONFIG_TPS65010_MODULE) && defined(MODULE))
 
 #include <linux/i2c/tps65010.h>
 
-- 
1.8.3.2

