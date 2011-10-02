From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 18/30] omap-usb: automatically select MFD_OMAP_USB_HOST
Date: Sun,  2 Oct 2011 16:45:48 +0200
Message-ID: <1317566760-25681-19-git-send-email-arnd@arndb.de>
References: <1317566760-25681-1-git-send-email-arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1317566760-25681-1-git-send-email-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Keshava Munegowda <keshava_mgowda@ti.com>, Samuel Ortiz <sameo@linux.intel.com>
List-Id: linux-omap@vger.kernel.org

The ehci-omap and ohci-omap3 drivers both depend on the
omap-usb-host MFD support driver. By default, this is
automatically turned on, but it is possible to disable
the driver, which results in a link error.

This patch makes the option invisible so we always do
the right thing.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Keshava Munegowda <keshava_mgowda@ti.com>
Cc: Samuel Ortiz <sameo@linux.intel.com>
---
 drivers/mfd/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 21574bd..48cce35 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -721,7 +721,7 @@ config MFD_WL1273_CORE
 	  audio codec.
 
 config MFD_OMAP_USB_HOST
-	bool "Support OMAP USBHS core driver"
+	bool
 	depends on USB_EHCI_HCD_OMAP || USB_OHCI_HCD_OMAP3
 	default y
 	help
-- 
1.7.5.4
