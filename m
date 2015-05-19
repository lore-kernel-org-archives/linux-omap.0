From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] phy: add dm816x dependency on USB_PHY
Date: Tue, 19 May 2015 15:02:28 +0200
Message-ID: <3934365.TiRUES6WLp@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: linux-kernel@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Bin Liu <binmlist@gmail.com>, Brian Hutchinson <b.hutchman@gmail.com>, Felipe Balbi <balbi@ti.com>, Matthijs van Duin <matthijsvanduin@gmail.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

The newly added phy-dm816x-usb driver depends on the
usb phy API and fails to link if that is disabled:

drivers/built-in.o: In function `dm816x_usb_phy_remove':
:(.text+0x3a28): undefined reference to `usb_remove_phy'
drivers/built-in.o: In function `dm816x_usb_phy_probe':
:(.text+0x3c18): undefined reference to `usb_add_phy_dev'

This adds an explicit dependency in Kconfig to avoid the
build error in randconfig tests.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 609adde838f4 ("phy: Add a driver for dm816x USB PHY")

diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
index fceac96c2a31..1b5c235562c9 100644
--- a/drivers/phy/Kconfig
+++ b/drivers/phy/Kconfig
@@ -37,7 +37,7 @@ config ARMADA375_USBCLUSTER_PHY
 
 config PHY_DM816X_USB
 	tristate "TI dm816x USB PHY driver"
-	depends on ARCH_OMAP2PLUS
+	depends on ARCH_OMAP2PLUS && USB_PHY
 	select GENERIC_PHY
 	help
 	  Enable this for dm816x USB to work.
