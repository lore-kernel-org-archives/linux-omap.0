From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] usb: phy/isp1301: work around tps65010 dependency
Date: Sat, 11 Apr 2015 00:06:10 +0200
Message-ID: <2600460.1JNcCgKyuI@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: gregkh@linuxfoundation.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

The isp1301-omap driver contains special hooks for the TPS65010
power management controller. It provides its own 'tps65010_set_vbus_draw'
wrapper in case that driver is not enabled through Kconfig, but
fails to handle the case where isp1301-omap is built-in but TPS65010
is a loadable module, which currently results in a link error:

drivers/built-in.o: In function `isp1301_set_power':
:(.text+0x14e188): undefined reference to `tps65010_set_vbus_draw'

This is a workaround to use the same trick as before also when
tps65010 is a module. Doing a proper fix would require much larger
changes to the driver that is not really worth it when the usb-phy
drivers are going to eventually get replaced with generic-phy
drivers.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/drivers/usb/phy/phy-isp1301-omap.c b/drivers/usb/phy/phy-isp1301-omap.c
index 1e0e10dd6ba5..3af263cc0caa 100644
--- a/drivers/usb/phy/phy-isp1301-omap.c
+++ b/drivers/usb/phy/phy-isp1301-omap.c
@@ -94,7 +94,7 @@ struct isp1301 {
 
 #if defined(CONFIG_MACH_OMAP_H2) || defined(CONFIG_MACH_OMAP_H3)
 
-#if	defined(CONFIG_TPS65010) || defined(CONFIG_TPS65010_MODULE)
+#if	defined(CONFIG_TPS65010) || (defined(CONFIG_TPS65010_MODULE) && defined(MODULE))
 
 #include <linux/i2c/tps65010.h>
 
