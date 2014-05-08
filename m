From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 7/8] usb: ohci: sort out dependencies for lpc32xx and omap
Date: Thu,  8 May 2014 15:52:20 +0200
Message-ID: <1399557141-1346645-8-git-send-email-arnd@arndb.de>
References: <1399557141-1346645-1-git-send-email-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1399557141-1346645-1-git-send-email-arnd@arndb.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, Felipe Balbi <balbi@ti.com>, Alan Stern <stern@rowland.harvard.edu>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

The dependency on the isp1301 driver is not something that
should be in the main OHCI driver but rather the SoC specific
part of it.

This moves the dependency for LPC32xx into USB_OHCI_HCD_LPC32XX,
and changes the 'select ISP1301_OMAP' to a similar 'depends on'.
Since the same dependency exists for the client driver, do the
same change there.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: linux-omap@vger.kernel.org
Cc: Alan Stern <stern@rowland.harvard.edu>
---
 drivers/usb/gadget/Kconfig | 4 ++--
 drivers/usb/host/Kconfig   | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/gadget/Kconfig b/drivers/usb/gadget/Kconfig
index 7fca52b..ba18e9c 100644
--- a/drivers/usb/gadget/Kconfig
+++ b/drivers/usb/gadget/Kconfig
@@ -157,7 +157,7 @@ config USB_AT91
 
 config USB_LPC32XX
 	tristate "LPC32XX USB Peripheral Controller"
-	depends on ARCH_LPC32XX
+	depends on ARCH_LPC32XX && I2C
 	select USB_ISP1301
 	help
 	   This option selects the USB device controller in the LPC32xx SoC.
@@ -226,7 +226,7 @@ config USB_GR_UDC
 config USB_OMAP
 	tristate "OMAP USB Device Controller"
 	depends on ARCH_OMAP1
-	select ISP1301_OMAP if MACH_OMAP_H2 || MACH_OMAP_H3
+	depends on ISP1301_OMAP || !(MACH_OMAP_H2 || MACH_OMAP_H3)
 	help
 	   Many Texas Instruments OMAP processors have flexible full
 	   speed USB device controllers, with support for up to 30
diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
index 890fc8c..e229a47 100644
--- a/drivers/usb/host/Kconfig
+++ b/drivers/usb/host/Kconfig
@@ -345,8 +345,6 @@ config USB_FOTG210_HCD
 
 config USB_OHCI_HCD
 	tristate "OHCI HCD (USB 1.1) support"
-	select ISP1301_OMAP if MACH_OMAP_H2 || MACH_OMAP_H3
-	depends on USB_ISP1301 || !ARCH_LPC32XX
 	---help---
 	  The Open Host Controller Interface (OHCI) is a standard for accessing
 	  USB 1.1 host controller hardware.  It does more in hardware than Intel's
@@ -365,6 +363,7 @@ if USB_OHCI_HCD
 config USB_OHCI_HCD_OMAP1
 	tristate "OHCI support for OMAP1/2 chips"
 	depends on ARCH_OMAP1
+	depends on ISP1301_OMAP || !(MACH_OMAP_H2 || MACH_OMAP_H3)
 	default y
 	---help---
 	  Enables support for the OHCI controller on OMAP1/2 chips.
@@ -388,6 +387,7 @@ config USB_OHCI_HCD_S3C2410
 config USB_OHCI_HCD_LPC32XX
 	tristate "Support for LPC on-chip OHCI USB controller"
 	depends on USB_OHCI_HCD && ARCH_LPC32XX
+	depends on USB_ISP1301
 	default y
 	---help---
           Enables support for the on-chip OHCI controller on
-- 
1.8.3.2
