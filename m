From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH v2 2/2] USB: ehci-omap: select NOP_USB_XCEIV PHY driver
Date: Fri, 31 May 2013 14:29:03 +0300
Message-ID: <1369999743-11758-3-git-send-email-rogerq@ti.com>
References: <1369999743-11758-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:55757 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755340Ab3EaL3h (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 31 May 2013 07:29:37 -0400
In-Reply-To: <1369999743-11758-1-git-send-email-rogerq@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: stern@rowland.harvard.edu, balbi@ti.com, arnd@arndb.de, adrienverge@gmail.com, kishon@ti.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Roger Quadros <rogerq@ti.com>

ehci-omap needs NOP_USB_XCEIV PHY driver to function
properly, so select it. As the USB PHY drivers no longer
depend on USB_PHY, it is safe to select the PHY drivers.

Signed-off-by: Roger Quadros <rogerq@ti.com>
Tested-by: Adrien Verg=C3=A9 <adrienverge@gmail.com>
---
 drivers/usb/host/Kconfig |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
index 7ded784..48e1b70 100644
--- a/drivers/usb/host/Kconfig
+++ b/drivers/usb/host/Kconfig
@@ -150,13 +150,11 @@ config USB_EHCI_MXC
 config USB_EHCI_HCD_OMAP
 	tristate "EHCI support for OMAP3 and later chips"
 	depends on ARCH_OMAP
+	select NOP_USB_XCEIV
 	default y
 	---help---
 	  Enables support for the on-chip EHCI controller on
 	  OMAP3 and later chips.
-	  If your system uses a PHY on the USB port, you will need to
-	  enable USB_PHY and the appropriate PHY driver as well. Most
-	  boards need the NOP_USB_XCEIV PHY driver.
=20
 config USB_EHCI_HCD_ORION
 	tristate  "Support for Marvell EBU on-chip EHCI USB controller"
--=20
1.7.4.1

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
