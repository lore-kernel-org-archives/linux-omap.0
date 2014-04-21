From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 07/10] usb: phy: rename <linux/usb/usb_phy_gen_xceiv.h> to <linux/usb/usb_phy_generic.h>
Date: Mon, 21 Apr 2014 10:56:49 -0500
Message-ID: <1398095812-14222-8-git-send-email-balbi@ti.com>
References: <1398095812-14222-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:43408 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751646AbaDUP7W (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 21 Apr 2014 11:59:22 -0400
In-Reply-To: <1398095812-14222-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux USB Mailing List <linux-usb@vger.kernel.org>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, leigh@solinno.co.uk, Tony Lindgren <tony@atomide.com>, Felipe Balbi <balbi@ti.com>

now that all functions match the driver name,
the only missing piece is to rename the header
file itself.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/mach-omap2/board-omap3beagle.c                      | 1 -
 arch/arm/mach-omap2/usb-host.c                               | 2 +-
 drivers/usb/dwc3/dwc3-exynos.c                               | 2 +-
 drivers/usb/dwc3/dwc3-pci.c                                  | 2 +-
 drivers/usb/musb/am35x.c                                     | 2 +-
 drivers/usb/musb/blackfin.c                                  | 2 +-
 drivers/usb/musb/da8xx.c                                     | 2 +-
 drivers/usb/musb/davinci.c                                   | 2 +-
 drivers/usb/musb/musb_dsps.c                                 | 2 +-
 drivers/usb/musb/tusb6010.c                                  | 2 +-
 drivers/usb/phy/phy-am335x.c                                 | 2 +-
 drivers/usb/phy/phy-generic.c                                | 2 +-
 drivers/usb/phy/phy-generic.h                                | 2 +-
 drivers/usb/phy/phy-keystone.c                               | 2 +-
 include/linux/usb/{usb_phy_gen_xceiv.h => usb_phy_generic.h} | 0
 15 files changed, 13 insertions(+), 14 deletions(-)
 rename include/linux/usb/{usb_phy_gen_xceiv.h => usb_phy_generic.h} (100%)

diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index d6ed819..660bfc5 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -33,7 +33,6 @@
 #include <linux/mtd/nand.h>
 #include <linux/mmc/host.h>
 #include <linux/usb/phy.h>
-#include <linux/usb/usb_phy_gen_xceiv.h>
 
 #include <linux/regulator/machine.h>
 #include <linux/i2c/twl.h>
diff --git a/arch/arm/mach-omap2/usb-host.c b/arch/arm/mach-omap2/usb-host.c
index ab983cd..745367c 100644
--- a/arch/arm/mach-omap2/usb-host.c
+++ b/arch/arm/mach-omap2/usb-host.c
@@ -28,7 +28,7 @@
 #include <linux/io.h>
 #include <linux/gpio.h>
 #include <linux/usb/phy.h>
-#include <linux/usb/usb_phy_gen_xceiv.h>
+#include <linux/usb/usb_phy_generic.h>
 
 #include "soc.h"
 #include "omap_device.h"
diff --git a/drivers/usb/dwc3/dwc3-exynos.c b/drivers/usb/dwc3/dwc3-exynos.c
index 821cc59..ed22d72 100644
--- a/drivers/usb/dwc3/dwc3-exynos.c
+++ b/drivers/usb/dwc3/dwc3-exynos.c
@@ -24,7 +24,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/clk.h>
 #include <linux/usb/otg.h>
-#include <linux/usb/usb_phy_gen_xceiv.h>
+#include <linux/usb/usb_phy_generic.h>
 #include <linux/of.h>
 #include <linux/of_platform.h>
 
diff --git a/drivers/usb/dwc3/dwc3-pci.c b/drivers/usb/dwc3/dwc3-pci.c
index 8b162f0..1ed95e0 100644
--- a/drivers/usb/dwc3/dwc3-pci.c
+++ b/drivers/usb/dwc3/dwc3-pci.c
@@ -23,7 +23,7 @@
 #include <linux/platform_device.h>
 
 #include <linux/usb/otg.h>
-#include <linux/usb/usb_phy_gen_xceiv.h>
+#include <linux/usb/usb_phy_generic.h>
 
 /* FIXME define these in <linux/pci_ids.h> */
 #define PCI_VENDOR_ID_SYNOPSYS		0x16c3
diff --git a/drivers/usb/musb/am35x.c b/drivers/usb/musb/am35x.c
index 77ed664..044cd82 100644
--- a/drivers/usb/musb/am35x.c
+++ b/drivers/usb/musb/am35x.c
@@ -32,7 +32,7 @@
 #include <linux/io.h>
 #include <linux/platform_device.h>
 #include <linux/dma-mapping.h>
-#include <linux/usb/usb_phy_gen_xceiv.h>
+#include <linux/usb/usb_phy_generic.h>
 #include <linux/platform_data/usb-omap.h>
 
 #include "musb_core.h"
diff --git a/drivers/usb/musb/blackfin.c b/drivers/usb/musb/blackfin.c
index 607f3ae..c9992a2 100644
--- a/drivers/usb/musb/blackfin.c
+++ b/drivers/usb/musb/blackfin.c
@@ -18,7 +18,7 @@
 #include <linux/platform_device.h>
 #include <linux/dma-mapping.h>
 #include <linux/prefetch.h>
-#include <linux/usb/usb_phy_gen_xceiv.h>
+#include <linux/usb/usb_phy_generic.h>
 
 #include <asm/cacheflush.h>
 
diff --git a/drivers/usb/musb/da8xx.c b/drivers/usb/musb/da8xx.c
index bcdce8e..a0dabb0 100644
--- a/drivers/usb/musb/da8xx.c
+++ b/drivers/usb/musb/da8xx.c
@@ -32,7 +32,7 @@
 #include <linux/io.h>
 #include <linux/platform_device.h>
 #include <linux/dma-mapping.h>
-#include <linux/usb/usb_phy_gen_xceiv.h>
+#include <linux/usb/usb_phy_generic.h>
 
 #include <mach/da8xx.h>
 #include <linux/platform_data/usb-davinci.h>
diff --git a/drivers/usb/musb/davinci.c b/drivers/usb/musb/davinci.c
index c0e07ed..7370354 100644
--- a/drivers/usb/musb/davinci.c
+++ b/drivers/usb/musb/davinci.c
@@ -32,7 +32,7 @@
 #include <linux/gpio.h>
 #include <linux/platform_device.h>
 #include <linux/dma-mapping.h>
-#include <linux/usb/usb_phy_gen_xceiv.h>
+#include <linux/usb/usb_phy_generic.h>
 
 #include <mach/cputype.h>
 #include <mach/hardware.h>
diff --git a/drivers/usb/musb/musb_dsps.c b/drivers/usb/musb/musb_dsps.c
index 3372ded..1888292 100644
--- a/drivers/usb/musb/musb_dsps.c
+++ b/drivers/usb/musb/musb_dsps.c
@@ -35,7 +35,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/pm_runtime.h>
 #include <linux/module.h>
-#include <linux/usb/usb_phy_gen_xceiv.h>
+#include <linux/usb/usb_phy_generic.h>
 #include <linux/platform_data/usb-omap.h>
 #include <linux/sizes.h>
 
diff --git a/drivers/usb/musb/tusb6010.c b/drivers/usb/musb/tusb6010.c
index 0c0f5ee..8d4a819 100644
--- a/drivers/usb/musb/tusb6010.c
+++ b/drivers/usb/musb/tusb6010.c
@@ -24,7 +24,7 @@
 #include <linux/io.h>
 #include <linux/platform_device.h>
 #include <linux/dma-mapping.h>
-#include <linux/usb/usb_phy_gen_xceiv.h>
+#include <linux/usb/usb_phy_generic.h>
 
 #include "musb_core.h"
 
diff --git a/drivers/usb/phy/phy-am335x.c b/drivers/usb/phy/phy-am335x.c
index bb866e4..585e50c 100644
--- a/drivers/usb/phy/phy-am335x.c
+++ b/drivers/usb/phy/phy-am335x.c
@@ -2,7 +2,7 @@
 #include <linux/platform_device.h>
 #include <linux/dma-mapping.h>
 #include <linux/usb/otg.h>
-#include <linux/usb/usb_phy_gen_xceiv.h>
+#include <linux/usb/usb_phy_generic.h>
 #include <linux/slab.h>
 #include <linux/clk.h>
 #include <linux/regulator/consumer.h>
diff --git a/drivers/usb/phy/phy-generic.c b/drivers/usb/phy/phy-generic.c
index e76ca4c..2c49cd8 100644
--- a/drivers/usb/phy/phy-generic.c
+++ b/drivers/usb/phy/phy-generic.c
@@ -30,7 +30,7 @@
 #include <linux/platform_device.h>
 #include <linux/dma-mapping.h>
 #include <linux/usb/otg.h>
-#include <linux/usb/usb_phy_gen_xceiv.h>
+#include <linux/usb/usb_phy_generic.h>
 #include <linux/slab.h>
 #include <linux/clk.h>
 #include <linux/regulator/consumer.h>
diff --git a/drivers/usb/phy/phy-generic.h b/drivers/usb/phy/phy-generic.h
index f32450a..d8feacc 100644
--- a/drivers/usb/phy/phy-generic.h
+++ b/drivers/usb/phy/phy-generic.h
@@ -1,7 +1,7 @@
 #ifndef _PHY_GENERIC_H_
 #define _PHY_GENERIC_H_
 
-#include <linux/usb/usb_phy_gen_xceiv.h>
+#include <linux/usb/usb_phy_generic.h>
 
 struct usb_phy_generic {
 	struct usb_phy phy;
diff --git a/drivers/usb/phy/phy-keystone.c b/drivers/usb/phy/phy-keystone.c
index 2404c44..f4d722d 100644
--- a/drivers/usb/phy/phy-keystone.c
+++ b/drivers/usb/phy/phy-keystone.c
@@ -18,7 +18,7 @@
 
 #include <linux/module.h>
 #include <linux/platform_device.h>
-#include <linux/usb/usb_phy_gen_xceiv.h>
+#include <linux/usb/usb_phy_generic.h>
 #include <linux/io.h>
 #include <linux/of.h>
 
diff --git a/include/linux/usb/usb_phy_gen_xceiv.h b/include/linux/usb/usb_phy_generic.h
similarity index 100%
rename from include/linux/usb/usb_phy_gen_xceiv.h
rename to include/linux/usb/usb_phy_generic.h
-- 
1.9.2.459.g68773ac

