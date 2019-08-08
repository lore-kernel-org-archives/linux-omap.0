From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 10/22] usb: omap: avoid mach/*.h headers
Date: Thu,  8 Aug 2019 23:22:19 +0200
Message-ID: <20190808212234.2213262-11-arnd@arndb.de>
References: <20190808212234.2213262-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190808212234.2213262-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Felipe Balbi <balbi@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Stern <stern@rowland.harvard.edu>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Linus Walleij <linus.walleij@linaro.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Arnd Bergmann <arnd@arndb.de>, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

The omap usb drivers still rely on mach/*.h headers that
are explicitly or implicitly included, but all the required
definitions are now in include/linux/soc/ti/, so use those
instead and allow compile-testing on other architectures.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/usb/gadget/udc/Kconfig     | 2 +-
 drivers/usb/gadget/udc/omap_udc.c  | 2 ++
 drivers/usb/host/Kconfig           | 2 +-
 drivers/usb/host/ohci-omap.c       | 7 +++----
 drivers/usb/phy/Kconfig            | 3 ++-
 drivers/usb/phy/phy-isp1301-omap.c | 4 ++--
 6 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/usb/gadget/udc/Kconfig b/drivers/usb/gadget/udc/Kconfig
index d354036ff6c8..ac0891a3dbf2 100644
--- a/drivers/usb/gadget/udc/Kconfig
+++ b/drivers/usb/gadget/udc/Kconfig
@@ -128,7 +128,7 @@ config USB_GR_UDC
 
 config USB_OMAP
 	tristate "OMAP USB Device Controller"
-	depends on ARCH_OMAP1
+	depends on ARCH_OMAP1 || (ARCH_OMAP && COMPILE_TEST)
 	depends on ISP1301_OMAP || !(MACH_OMAP_H2 || MACH_OMAP_H3)
 	help
 	   Many Texas Instruments OMAP processors have flexible full
diff --git a/drivers/usb/gadget/udc/omap_udc.c b/drivers/usb/gadget/udc/omap_udc.c
index 721c9c3fe5a7..27b6142ea803 100644
--- a/drivers/usb/gadget/udc/omap_udc.c
+++ b/drivers/usb/gadget/udc/omap_udc.c
@@ -43,6 +43,8 @@
 #include <linux/platform_data/usb-omap1.h>
 
 #include <linux/soc/ti/omap1-usb.h>
+#include <linux/soc/ti/omap1-soc.h>
+#include <linux/soc/ti/omap1-io.h>
 
 #include "omap_udc.h"
 
diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
index 79bbce685583..e566a99bc8c9 100644
--- a/drivers/usb/host/Kconfig
+++ b/drivers/usb/host/Kconfig
@@ -201,7 +201,7 @@ config USB_EHCI_HCD_NPCM7XX
 
 config USB_EHCI_HCD_OMAP
 	tristate "EHCI support for OMAP3 and later chips"
-	depends on ARCH_OMAP
+	depends on ARCH_OMAP || COMPILE_TEST
 	depends on NOP_USB_XCEIV
 	default y
 	---help---
diff --git a/drivers/usb/host/ohci-omap.c b/drivers/usb/host/ohci-omap.c
index 841563fba20d..be3571778b60 100644
--- a/drivers/usb/host/ohci-omap.c
+++ b/drivers/usb/host/ohci-omap.c
@@ -27,6 +27,9 @@
 #include <linux/platform_device.h>
 #include <linux/platform_data/usb-omap1.h>
 #include <linux/soc/ti/omap1-usb.h>
+#include <linux/soc/ti/omap1-mux.h>
+#include <linux/soc/ti/omap1-soc.h>
+#include <linux/soc/ti/omap1-io.h>
 #include <linux/signal.h>
 #include <linux/usb.h>
 #include <linux/usb/hcd.h>
@@ -36,10 +39,6 @@
 #include <asm/io.h>
 #include <asm/mach-types.h>
 
-#include <mach/mux.h>
-
-#include <mach/hardware.h>
-
 #define DRIVER_DESC "OHCI OMAP driver"
 
 #ifdef CONFIG_TPS65010
diff --git a/drivers/usb/phy/Kconfig b/drivers/usb/phy/Kconfig
index 24b4f091acb8..c6b2559fd334 100644
--- a/drivers/usb/phy/Kconfig
+++ b/drivers/usb/phy/Kconfig
@@ -30,7 +30,8 @@ config FSL_USB2_OTG
 
 config ISP1301_OMAP
 	tristate "Philips ISP1301 with OMAP OTG"
-	depends on I2C && ARCH_OMAP_OTG
+	depends on I2C
+	depends on ARCH_OMAP_OTG || (ARM && COMPILE_TEST)
 	depends on USB
 	depends on USB_GADGET || !USB_GADGET # if USB_GADGET=m, this can't be 'y'
 	select USB_PHY
diff --git a/drivers/usb/phy/phy-isp1301-omap.c b/drivers/usb/phy/phy-isp1301-omap.c
index 18cf87dcc21f..0f3475e91403 100644
--- a/drivers/usb/phy/phy-isp1301-omap.c
+++ b/drivers/usb/phy/phy-isp1301-omap.c
@@ -23,9 +23,9 @@
 #include <asm/irq.h>
 #include <asm/mach-types.h>
 
-#include <mach/mux.h>
-
+#include <linux/soc/ti/omap1-mux.h>
 #include <linux/soc/ti/omap1-usb.h>
+#include <linux/soc/ti/omap1-io.h>
 
 #undef VERBOSE
 
-- 
2.20.0
