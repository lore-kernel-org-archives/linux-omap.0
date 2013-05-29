From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH 4/5] USB: lpc32xx: USB_LPC32XX need not depend on USB_PHY
Date: Wed, 29 May 2013 14:43:30 +0300
Message-ID: <1369827811-534-5-git-send-email-rogerq@ti.com>
References: <1369827811-534-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1369827811-534-1-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: balbi@ti.com, stern@rowland.harvard.edu, kishon@ti.com, arnd@arndb.de, adrienverge@gmail.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Roger Quadros <rogerq@ti.com>, Roland Stigge <stigge@antcom.de>
List-Id: linux-omap@vger.kernel.org

As the USB PHY drivers no longer depend on USB_PHY but
select it if needed, the controller drivers need not
depend on USB_PHY. They can safely select the necessary
PHY driver i.e. USB_ISP1301 in this case.

Signed-off-by: Roger Quadros <rogerq@ti.com>
CC: Roland Stigge <stigge@antcom.de>
---
 drivers/usb/gadget/Kconfig |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/usb/gadget/Kconfig b/drivers/usb/gadget/Kconfig
index f41aa0d..2b98bce 100644
--- a/drivers/usb/gadget/Kconfig
+++ b/drivers/usb/gadget/Kconfig
@@ -144,7 +144,6 @@ config USB_AT91
 config USB_LPC32XX
 	tristate "LPC32XX USB Peripheral Controller"
 	depends on ARCH_LPC32XX
-	depends on USB_PHY
 	select USB_ISP1301
 	help
 	   This option selects the USB device controller in the LPC32xx SoC.
-- 
1.7.4.1
