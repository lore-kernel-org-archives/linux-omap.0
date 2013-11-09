From: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Subject: [PATCH 2/2] ARM: OMAP2+: move gpmc headers to include/linux/platform_data
Date: Sat,  9 Nov 2013 17:34:02 +0100
Message-ID: <1384014842-4288-2-git-send-email-javier.martinez@collabora.co.uk>
References: <1384014842-4288-1-git-send-email-javier.martinez@collabora.co.uk>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([93.93.135.160]:56020 "EHLO
	bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753700Ab3KIQfQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 9 Nov 2013 11:35:16 -0500
In-Reply-To: <1384014842-4288-1-git-send-email-javier.martinez@collabora.co.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Javier Martinez Canillas <javier.martinez@collabora.co.uk>

The OMAP2+ General-Purpose Memory Controller (GPMC) driver
should eventually be moved from arch/arm/mach-omap2 to
drivers/memory. Unfortunately this is not trivial since it
includes headers files that still resides under mach-omap2
and can't be moved easilly.

This patch is the first step for taking the gpmc driver
outside arch/arm/mach-omap2 by moving its related headers
files to include/linux/platform_data.

Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
---

Hi Tony,

I wonder what's your plan to move drivers outside of mach-omap2.
Currently this driver still includes soc.h and omap_device.h
that are on mach-omap2.

If we want to move out these two headers files then also omap
hwmod and per SoC family headers have to be moved out mach-omap2.

Do you want me to do a follow-up patch-set to move all these
headers out of mach-omap2 so the gpmc and other drivers can
be moved to drivers/? 

Is include/linux/platform_data the right place to put these
headers or there is a better place for them?

Thanks a lot and best regards,
Javier

 arch/arm/mach-omap2/board-2430sdp.c              |   5 +-
 arch/arm/mach-omap2/board-3430sdp.c              |   4 +-
 arch/arm/mach-omap2/board-cm-t35.c               |   6 +-
 arch/arm/mach-omap2/board-cm-t3517.c             |   4 +-
 arch/arm/mach-omap2/board-devkit8000.c           |   2 +-
 arch/arm/mach-omap2/board-flash.c                |   6 +-
 arch/arm/mach-omap2/board-flash.h                |   2 +-
 arch/arm/mach-omap2/board-h4.c                   |   5 +-
 arch/arm/mach-omap2/board-ldp.c                  |   4 +-
 arch/arm/mach-omap2/board-n8x0.c                 |   3 +-
 arch/arm/mach-omap2/board-omap3beagle.c          |   2 +-
 arch/arm/mach-omap2/board-omap3logic.c           |   5 +-
 arch/arm/mach-omap2/board-omap3pandora.c         |   3 +-
 arch/arm/mach-omap2/board-omap3stalker.c         |   4 +-
 arch/arm/mach-omap2/board-omap3touchbook.c       |   2 +-
 arch/arm/mach-omap2/board-overo.c                |   4 +-
 arch/arm/mach-omap2/board-rx51-peripherals.c     |   6 +-
 arch/arm/mach-omap2/board-rx51.c                 |   2 +-
 arch/arm/mach-omap2/gpmc-nand.c                  |   4 +-
 arch/arm/mach-omap2/gpmc-nand.h                  |  27 ---
 arch/arm/mach-omap2/gpmc-onenand.c               |   4 +-
 arch/arm/mach-omap2/gpmc-onenand.h               |  24 ---
 arch/arm/mach-omap2/gpmc-smc91x.c                |   4 +-
 arch/arm/mach-omap2/gpmc-smc91x.h                |  42 -----
 arch/arm/mach-omap2/gpmc-smsc911x.c              |   4 +-
 arch/arm/mach-omap2/gpmc-smsc911x.h              |  35 ----
 arch/arm/mach-omap2/gpmc.c                       |   7 +-
 arch/arm/mach-omap2/gpmc.h                       | 231 -----------------------
 arch/arm/mach-omap2/pm34xx.c                     |   2 +-
 arch/arm/mach-omap2/usb-tusb6010.c               |   3 +-
 include/linux/platform_data/gpmc-nand-omap.h     |  27 +++
 include/linux/platform_data/gpmc-omap.h          | 231 +++++++++++++++++++++++
 include/linux/platform_data/gpmc-onenand-omap.h  |  25 +++
 include/linux/platform_data/gpmc-smc91x-omap.h   |  42 +++++
 include/linux/platform_data/gpmc-smsc911x-omap.h |  35 ++++
 35 files changed, 403 insertions(+), 413 deletions(-)
 delete mode 100644 arch/arm/mach-omap2/gpmc-nand.h
 delete mode 100644 arch/arm/mach-omap2/gpmc-onenand.h
 delete mode 100644 arch/arm/mach-omap2/gpmc-smc91x.h
 delete mode 100644 arch/arm/mach-omap2/gpmc-smsc911x.h
 delete mode 100644 arch/arm/mach-omap2/gpmc.h
 create mode 100644 include/linux/platform_data/gpmc-nand-omap.h
 create mode 100644 include/linux/platform_data/gpmc-omap.h
 create mode 100644 include/linux/platform_data/gpmc-onenand-omap.h
 create mode 100644 include/linux/platform_data/gpmc-smc91x-omap.h
 create mode 100644 include/linux/platform_data/gpmc-smsc911x-omap.h

diff --git a/arch/arm/mach-omap2/board-2430sdp.c b/arch/arm/mach-omap2/board-2430sdp.c
index c711ad6..1e563d0 100644
--- a/arch/arm/mach-omap2/board-2430sdp.c
+++ b/arch/arm/mach-omap2/board-2430sdp.c
@@ -34,8 +34,9 @@
 #include <asm/mach/map.h>
 
 #include "common.h"
-#include "gpmc.h"
-#include "gpmc-smc91x.h"
+
+#include <linux/platform_data/gpmc-omap.h>
+#include <linux/platform_data/gpmc-smc91x-omap.h>
 
 #include <video/omapdss.h>
 #include <video/omap-panel-data.h>
diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index d95d0ef..a300395 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -37,8 +37,8 @@
 #include <video/omapdss.h>
 #include <video/omap-panel-data.h>
 
-#include "gpmc.h"
-#include "gpmc-smc91x.h"
+#include <linux/platform_data/gpmc-omap.h>
+#include <linux/platform_data/gpmc-smc91x-omap.h>
 
 #include "soc.h"
 #include "board-flash.h"
diff --git a/arch/arm/mach-omap2/board-cm-t35.c b/arch/arm/mach-omap2/board-cm-t35.c
index 33d159e..17a9164 100644
--- a/arch/arm/mach-omap2/board-cm-t35.c
+++ b/arch/arm/mach-omap2/board-cm-t35.c
@@ -49,8 +49,8 @@
 #include "sdram-micron-mt46h32m32lf-6.h"
 #include "hsmmc.h"
 #include "common-board-devices.h"
-#include "gpmc.h"
-#include "gpmc-nand.h"
+#include <linux/platform_data/gpmc-omap.h>
+#include <linux/platform_data/gpmc-nand-omap.h>
 
 #define CM_T35_GPIO_PENDOWN		57
 #define SB_T35_USB_HUB_RESET_GPIO	167
@@ -62,7 +62,7 @@
 
 #if defined(CONFIG_SMSC911X) || defined(CONFIG_SMSC911X_MODULE)
 #include <linux/smsc911x.h>
-#include "gpmc-smsc911x.h"
+#include <linux/platform_data/gpmc-smsc911x-omap.h>
 
 static struct omap_smsc911x_platform_data cm_t35_smsc911x_cfg = {
 	.id		= 0,
diff --git a/arch/arm/mach-omap2/board-cm-t3517.c b/arch/arm/mach-omap2/board-cm-t3517.c
index 4eb5e6f..a3f2071 100644
--- a/arch/arm/mach-omap2/board-cm-t3517.c
+++ b/arch/arm/mach-omap2/board-cm-t3517.c
@@ -40,8 +40,7 @@
 #include <asm/mach/map.h>
 
 #include "common.h"
-#include <linux/platform_data/mtd-nand-omap2.h>
-#include "gpmc.h"
+#include <linux/platform_data/gpmc-nand-omap.h>
 
 #include "am35xx.h"
 
@@ -50,7 +49,6 @@
 #include "hsmmc.h"
 #include "common-board-devices.h"
 #include "am35xx-emac.h"
-#include "gpmc-nand.h"
 
 #if defined(CONFIG_LEDS_GPIO) || defined(CONFIG_LEDS_GPIO_MODULE)
 static struct gpio_led cm_t3517_leds[] = {
diff --git a/arch/arm/mach-omap2/board-devkit8000.c b/arch/arm/mach-omap2/board-devkit8000.c
index cdc4fb9..bb8373a 100644
--- a/arch/arm/mach-omap2/board-devkit8000.c
+++ b/arch/arm/mach-omap2/board-devkit8000.c
@@ -40,7 +40,7 @@
 #include <asm/mach/flash.h>
 
 #include "common.h"
-#include "gpmc.h"
+#include <linux/platform_data/gpmc-omap.h>
 #include <linux/platform_data/mtd-nand-omap2.h>
 #include <video/omapdss.h>
 #include <video/omap-panel-data.h>
diff --git a/arch/arm/mach-omap2/board-flash.c b/arch/arm/mach-omap2/board-flash.c
index fc20a61..d70fe9b 100644
--- a/arch/arm/mach-omap2/board-flash.c
+++ b/arch/arm/mach-omap2/board-flash.c
@@ -17,14 +17,12 @@
 #include <linux/mtd/physmap.h>
 #include <linux/io.h>
 
-#include <linux/platform_data/mtd-nand-omap2.h>
-#include <linux/platform_data/mtd-onenand-omap2.h>
+#include <linux/platform_data/gpmc-nand-omap.h>
+#include <linux/platform_data/gpmc-onenand-omap.h>
 
 #include "soc.h"
 #include "common.h"
 #include "board-flash.h"
-#include "gpmc-onenand.h"
-#include "gpmc-nand.h"
 
 #define REG_FPGA_REV			0x10
 #define REG_FPGA_DIP_SWITCH_INPUT2	0x60
diff --git a/arch/arm/mach-omap2/board-flash.h b/arch/arm/mach-omap2/board-flash.h
index 2fb5d41..734e831 100644
--- a/arch/arm/mach-omap2/board-flash.h
+++ b/arch/arm/mach-omap2/board-flash.h
@@ -12,7 +12,7 @@
  */
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/partitions.h>
-#include "gpmc.h"
+#include <linux/platform_data/gpmc-omap.h>
 
 #define PDC_NOR		1
 #define PDC_NAND	2
diff --git a/arch/arm/mach-omap2/board-h4.c b/arch/arm/mach-omap2/board-h4.c
index 87e41a8..9615ad6 100644
--- a/arch/arm/mach-omap2/board-h4.c
+++ b/arch/arm/mach-omap2/board-h4.c
@@ -36,11 +36,12 @@
 #include <video/omapdss.h>
 #include <video/omap-panel-data.h>
 
+#include <linux/platform_data/gpmc-omap.h>
+#include <linux/platform_data/gpmc-smc91x-omap.h>
+
 #include "common.h"
 #include "mux.h"
 #include "control.h"
-#include "gpmc.h"
-#include "gpmc-smc91x.h"
 
 #define H4_FLASH_CS	0
 
diff --git a/arch/arm/mach-omap2/board-ldp.c b/arch/arm/mach-omap2/board-ldp.c
index 4ec8d82..0b0115a 100644
--- a/arch/arm/mach-omap2/board-ldp.c
+++ b/arch/arm/mach-omap2/board-ldp.c
@@ -36,8 +36,8 @@
 #include <asm/mach/map.h>
 
 #include "common.h"
-#include "gpmc.h"
-#include "gpmc-smsc911x.h"
+#include <linux/platform_data/gpmc-omap.h>
+#include <linux/platform_data/gpmc-smsc911x-omap.h>
 
 #include <video/omapdss.h>
 #include <video/omap-panel-data.h>
diff --git a/arch/arm/mach-omap2/board-n8x0.c b/arch/arm/mach-omap2/board-n8x0.c
index 827d150..b2d2553 100644
--- a/arch/arm/mach-omap2/board-n8x0.c
+++ b/arch/arm/mach-omap2/board-n8x0.c
@@ -23,7 +23,7 @@
 #include <linux/usb/musb.h>
 #include <linux/platform_data/i2c-cbus-gpio.h>
 #include <linux/platform_data/spi-omap2-mcspi.h>
-#include <linux/platform_data/mtd-onenand-omap2.h>
+#include <linux/platform_data/gpmc-onenand-omap.h>
 #include <linux/mfd/menelaus.h>
 #include <sound/tlv320aic3x.h>
 
@@ -34,7 +34,6 @@
 #include "mmc.h"
 
 #include "mux.h"
-#include "gpmc-onenand.h"
 
 #define TUSB6010_ASYNC_CS	1
 #define TUSB6010_SYNC_CS	4
diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index f269184..6e4e029 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -46,10 +46,10 @@
 #include <video/omapdss.h>
 #include <video/omap-panel-data.h>
 #include <linux/platform_data/mtd-nand-omap2.h>
+#include <linux/platform_data/gpmc-omap.h>
 
 #include "common.h"
 #include "omap_device.h"
-#include "gpmc.h"
 #include "soc.h"
 #include "mux.h"
 #include "hsmmc.h"
diff --git a/arch/arm/mach-omap2/board-omap3logic.c b/arch/arm/mach-omap2/board-omap3logic.c
index bab51e6..6e894e4 100644
--- a/arch/arm/mach-omap2/board-omap3logic.c
+++ b/arch/arm/mach-omap2/board-omap3logic.c
@@ -35,13 +35,14 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 
+#include <linux/platform_data/gpmc-omap.h>
+#include <linux/platform_data/gpmc-smsc911x-omap.h>
+
 #include "common.h"
 #include "mux.h"
 #include "hsmmc.h"
 #include "control.h"
 #include "common-board-devices.h"
-#include "gpmc.h"
-#include "gpmc-smsc911x.h"
 
 #define OMAP3LOGIC_SMSC911X_CS			1
 
diff --git a/arch/arm/mach-omap2/board-omap3pandora.c b/arch/arm/mach-omap2/board-omap3pandora.c
index de1bc6b..b2736b7 100644
--- a/arch/arm/mach-omap2/board-omap3pandora.c
+++ b/arch/arm/mach-omap2/board-omap3pandora.c
@@ -45,13 +45,12 @@
 #include "common.h"
 #include <video/omapdss.h>
 #include <video/omap-panel-data.h>
-#include <linux/platform_data/mtd-nand-omap2.h>
+#include <linux/platform_data/gpmc-nand-omap.h>
 
 #include "mux.h"
 #include "sdram-micron-mt46h32m32lf-6.h"
 #include "hsmmc.h"
 #include "common-board-devices.h"
-#include "gpmc-nand.h"
 
 #define PANDORA_WIFI_IRQ_GPIO		21
 #define PANDORA_WIFI_NRESET_GPIO	23
diff --git a/arch/arm/mach-omap2/board-omap3stalker.c b/arch/arm/mach-omap2/board-omap3stalker.c
index ba8342f..84da831 100644
--- a/arch/arm/mach-omap2/board-omap3stalker.c
+++ b/arch/arm/mach-omap2/board-omap3stalker.c
@@ -41,7 +41,7 @@
 #include <asm/mach/flash.h>
 
 #include "common.h"
-#include "gpmc.h"
+#include <linux/platform_data/gpmc-omap.h>
 #include <linux/platform_data/mtd-nand-omap2.h>
 #include <video/omapdss.h>
 #include <video/omap-panel-data.h>
@@ -54,7 +54,7 @@
 #include "common-board-devices.h"
 
 #if defined(CONFIG_SMSC911X) || defined(CONFIG_SMSC911X_MODULE)
-#include "gpmc-smsc911x.h"
+#include <linux/platform_data/gpmc-smsc911x-omap.h>
 
 #define OMAP3STALKER_ETHR_START	0x2c000000
 #define OMAP3STALKER_ETHR_SIZE	1024
diff --git a/arch/arm/mach-omap2/board-omap3touchbook.c b/arch/arm/mach-omap2/board-omap3touchbook.c
index 7da48bc..eeac1d7 100644
--- a/arch/arm/mach-omap2/board-omap3touchbook.c
+++ b/arch/arm/mach-omap2/board-omap3touchbook.c
@@ -45,7 +45,7 @@
 #include <asm/system_info.h>
 
 #include "common.h"
-#include "gpmc.h"
+#include <linux/platform_data/gpmc-omap.h>
 #include <linux/platform_data/mtd-nand-omap2.h>
 
 #include "mux.h"
diff --git a/arch/arm/mach-omap2/board-overo.c b/arch/arm/mach-omap2/board-overo.c
index f6d3841..7c84295 100644
--- a/arch/arm/mach-omap2/board-overo.c
+++ b/arch/arm/mach-omap2/board-overo.c
@@ -40,6 +40,7 @@
 
 #include <linux/platform_data/mtd-nand-omap2.h>
 #include <linux/platform_data/spi-omap2-mcspi.h>
+#include <linux/platform_data/gpmc-omap.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -52,7 +53,6 @@
 #include "common.h"
 #include "mux.h"
 #include "sdram-micron-mt46h32m32lf-6.h"
-#include "gpmc.h"
 #include "hsmmc.h"
 #include "board-flash.h"
 #include "common-board-devices.h"
@@ -120,7 +120,7 @@ static inline void __init overo_ads7846_init(void) { return; }
 #if defined(CONFIG_SMSC911X) || defined(CONFIG_SMSC911X_MODULE)
 
 #include <linux/smsc911x.h>
-#include "gpmc-smsc911x.h"
+#include <linux/platform_data/gpmc-smsc911x-omap.h>
 
 static struct omap_smsc911x_platform_data smsc911x_cfg = {
 	.id		= 0,
diff --git a/arch/arm/mach-omap2/board-rx51-peripherals.c b/arch/arm/mach-omap2/board-rx51-peripherals.c
index f6fe388..327efff 100644
--- a/arch/arm/mach-omap2/board-rx51-peripherals.c
+++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
@@ -26,13 +26,13 @@
 #include <linux/mmc/host.h>
 #include <linux/power/isp1704_charger.h>
 #include <linux/platform_data/spi-omap2-mcspi.h>
-#include <linux/platform_data/mtd-onenand-omap2.h>
+#include <linux/platform_data/gpmc-onenand-omap.h>
+#include <linux/platform_data/gpmc-smc91x-omap.h>
 
 #include <asm/system_info.h>
 
 #include "common.h"
 #include <linux/omap-dma.h>
-#include "gpmc-smc91x.h"
 
 #include "board-rx51.h"
 
@@ -55,8 +55,6 @@
 #include "omap-pm.h"
 #include "hsmmc.h"
 #include "common-board-devices.h"
-#include "gpmc.h"
-#include "gpmc-onenand.h"
 
 #define SYSTEM_REV_B_USES_VAUX3	0x1699
 #define SYSTEM_REV_S_USES_VAUX3 0x8
diff --git a/arch/arm/mach-omap2/board-rx51.c b/arch/arm/mach-omap2/board-rx51.c
index 773510556..60004c5 100644
--- a/arch/arm/mach-omap2/board-rx51.c
+++ b/arch/arm/mach-omap2/board-rx51.c
@@ -20,6 +20,7 @@
 #include <linux/usb/phy.h>
 #include <linux/usb/musb.h>
 #include <linux/platform_data/spi-omap2-mcspi.h>
+#include <linux/platform_data/gpmc-omap.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -29,7 +30,6 @@
 
 #include "common.h"
 #include "mux.h"
-#include "gpmc.h"
 #include "pm.h"
 #include "sdram-nokia.h"
 
diff --git a/arch/arm/mach-omap2/gpmc-nand.c b/arch/arm/mach-omap2/gpmc-nand.c
index 662c7fd..41d756d 100644
--- a/arch/arm/mach-omap2/gpmc-nand.c
+++ b/arch/arm/mach-omap2/gpmc-nand.c
@@ -13,13 +13,11 @@
 #include <linux/platform_device.h>
 #include <linux/io.h>
 #include <linux/mtd/nand.h>
-#include <linux/platform_data/mtd-nand-omap2.h>
+#include <linux/platform_data/gpmc-nand-omap.h>
 
 #include <asm/mach/flash.h>
 
-#include "gpmc.h"
 #include "soc.h"
-#include "gpmc-nand.h"
 
 /* minimum size for IO mapping */
 #define	NAND_IO_SIZE	4
diff --git a/arch/arm/mach-omap2/gpmc-nand.h b/arch/arm/mach-omap2/gpmc-nand.h
deleted file mode 100644
index d59e128..0000000
--- a/arch/arm/mach-omap2/gpmc-nand.h
+++ /dev/null
@@ -1,27 +0,0 @@
-/*
- *  arch/arm/mach-omap2/gpmc-nand.h
- *
- *  This program is free software; you can redistribute  it and/or modify it
- *  under  the terms of  the GNU General  Public License as published by the
- *  Free Software Foundation;  either version 2 of the  License, or (at your
- *  option) any later version.
- */
-
-#ifndef	__OMAP2_GPMC_NAND_H
-#define	__OMAP2_GPMC_NAND_H
-
-#include "gpmc.h"
-#include <linux/platform_data/mtd-nand-omap2.h>
-
-#if IS_ENABLED(CONFIG_MTD_NAND_OMAP2)
-extern int gpmc_nand_init(struct omap_nand_platform_data *d,
-			  struct gpmc_timings *gpmc_t);
-#else
-static inline int gpmc_nand_init(struct omap_nand_platform_data *d,
-				 struct gpmc_timings *gpmc_t)
-{
-	return 0;
-}
-#endif
-
-#endif
diff --git a/arch/arm/mach-omap2/gpmc-onenand.c b/arch/arm/mach-omap2/gpmc-onenand.c
index 8b6876c..08c8831 100644
--- a/arch/arm/mach-omap2/gpmc-onenand.c
+++ b/arch/arm/mach-omap2/gpmc-onenand.c
@@ -15,14 +15,12 @@
 #include <linux/platform_device.h>
 #include <linux/mtd/onenand_regs.h>
 #include <linux/io.h>
-#include <linux/platform_data/mtd-onenand-omap2.h>
+#include <linux/platform_data/gpmc-onenand-omap.h>
 #include <linux/err.h>
 
 #include <asm/mach/flash.h>
 
-#include "gpmc.h"
 #include "soc.h"
-#include "gpmc-onenand.h"
 
 #define	ONENAND_IO_SIZE	SZ_128K
 
diff --git a/arch/arm/mach-omap2/gpmc-onenand.h b/arch/arm/mach-omap2/gpmc-onenand.h
deleted file mode 100644
index 216f23a..0000000
--- a/arch/arm/mach-omap2/gpmc-onenand.h
+++ /dev/null
@@ -1,24 +0,0 @@
-/*
- *  arch/arm/mach-omap2/gpmc-onenand.h
- *
- *  This program is free software; you can redistribute  it and/or modify it
- *  under  the terms of  the GNU General  Public License as published by the
- *  Free Software Foundation;  either version 2 of the  License, or (at your
- *  option) any later version.
- */
-
-#ifndef	__OMAP2_GPMC_ONENAND_H
-#define	__OMAP2_GPMC_ONENAND_H
-
-#include <linux/platform_data/mtd-onenand-omap2.h>
-
-#if IS_ENABLED(CONFIG_MTD_ONENAND_OMAP2)
-extern void gpmc_onenand_init(struct omap_onenand_platform_data *d);
-#else
-#define board_onenand_data	NULL
-static inline void gpmc_onenand_init(struct omap_onenand_platform_data *d)
-{
-}
-#endif
-
-#endif
diff --git a/arch/arm/mach-omap2/gpmc-smc91x.c b/arch/arm/mach-omap2/gpmc-smc91x.c
index 61a0635..2684360 100644
--- a/arch/arm/mach-omap2/gpmc-smc91x.c
+++ b/arch/arm/mach-omap2/gpmc-smc91x.c
@@ -17,8 +17,8 @@
 #include <linux/io.h>
 #include <linux/smc91x.h>
 
-#include "gpmc.h"
-#include "gpmc-smc91x.h"
+#include <linux/platform_data/gpmc-omap.h>
+#include <linux/platform_data/gpmc-smc91x-omap.h>
 
 #include "soc.h"
 
diff --git a/arch/arm/mach-omap2/gpmc-smc91x.h b/arch/arm/mach-omap2/gpmc-smc91x.h
deleted file mode 100644
index b64fbee..0000000
--- a/arch/arm/mach-omap2/gpmc-smc91x.h
+++ /dev/null
@@ -1,42 +0,0 @@
-/*
- * arch/arm/plat-omap/include/mach/gpmc-smc91x.h
- *
- * Copyright (C) 2009 Nokia Corporation
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#ifndef __ASM_ARCH_OMAP_GPMC_SMC91X_H__
-
-#define GPMC_TIMINGS_SMC91C96	(1 << 4)
-#define GPMC_MUX_ADD_DATA	(1 << 5) /* GPMC_CONFIG1_MUXADDDATA */
-#define GPMC_READ_MON		(1 << 6) /* GPMC_CONFIG1_WAIT_READ_MON */
-#define GPMC_WRITE_MON		(1 << 7) /* GPMC_CONFIG1_WAIT_WRITE_MON */
-
-struct omap_smc91x_platform_data {
-	int	cs;
-	int	gpio_irq;
-	int	gpio_pwrdwn;
-	int	gpio_reset;
-	int	wait_pin;	/* Optional GPMC_CONFIG1_WAITPINSELECT */
-	u32	flags;
-	int	(*retime)(void);
-};
-
-#if defined(CONFIG_SMC91X) || \
-	defined(CONFIG_SMC91X_MODULE)
-
-extern void gpmc_smc91x_init(struct omap_smc91x_platform_data *d);
-
-#else
-
-#define board_smc91x_data	NULL
-
-static inline void gpmc_smc91x_init(struct omap_smc91x_platform_data *d)
-{
-}
-
-#endif
-#endif
diff --git a/arch/arm/mach-omap2/gpmc-smsc911x.c b/arch/arm/mach-omap2/gpmc-smsc911x.c
index ef99011..7df3268 100644
--- a/arch/arm/mach-omap2/gpmc-smsc911x.c
+++ b/arch/arm/mach-omap2/gpmc-smsc911x.c
@@ -20,8 +20,8 @@
 #include <linux/io.h>
 #include <linux/smsc911x.h>
 
-#include "gpmc.h"
-#include "gpmc-smsc911x.h"
+#include <linux/platform_data/gpmc-omap.h>
+#include <linux/platform_data/gpmc-smsc911x-omap.h>
 
 static struct resource gpmc_smsc911x_resources[] = {
 	[0] = {
diff --git a/arch/arm/mach-omap2/gpmc-smsc911x.h b/arch/arm/mach-omap2/gpmc-smsc911x.h
deleted file mode 100644
index ea6c9c8..0000000
--- a/arch/arm/mach-omap2/gpmc-smsc911x.h
+++ /dev/null
@@ -1,35 +0,0 @@
-/*
- * arch/arm/plat-omap/include/plat/gpmc-smsc911x.h
- *
- * Copyright (C) 2009 Li-Pro.Net
- * Stephan Linz <linz@li-pro.net>
- *
- * Modified from arch/arm/plat-omap/include/plat/gpmc-smc91x.h
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#ifndef __ASM_ARCH_OMAP_GPMC_SMSC911X_H__
-
-struct omap_smsc911x_platform_data {
-	int	id;
-	int	cs;
-	int	gpio_irq;
-	int	gpio_reset;
-	u32	flags;
-};
-
-#if defined(CONFIG_SMSC911X) || defined(CONFIG_SMSC911X_MODULE)
-
-extern void gpmc_smsc911x_init(struct omap_smsc911x_platform_data *d);
-
-#else
-
-static inline void gpmc_smsc911x_init(struct omap_smsc911x_platform_data *d)
-{
-}
-
-#endif
-#endif
diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
index bb2c58a..176ecda 100644
--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -32,15 +32,14 @@
 #include <linux/mtd/nand.h>
 #include <linux/pm_runtime.h>
 
-#include <linux/platform_data/mtd-nand-omap2.h>
+#include <linux/platform_data/gpmc-omap.h>
+#include <linux/platform_data/gpmc-nand-omap.h>
+#include <linux/platform_data/gpmc-onenand-omap.h>
 
 #include <asm/mach-types.h>
 
 #include "soc.h"
 #include "omap_device.h"
-#include "gpmc.h"
-#include "gpmc-nand.h"
-#include "gpmc-onenand.h"
 
 #define	DEVICE_NAME		"omap-gpmc"
 
diff --git a/arch/arm/mach-omap2/gpmc.h b/arch/arm/mach-omap2/gpmc.h
deleted file mode 100644
index 707f6d5..0000000
--- a/arch/arm/mach-omap2/gpmc.h
+++ /dev/null
@@ -1,231 +0,0 @@
-/*
- * General-Purpose Memory Controller for OMAP2
- *
- * Copyright (C) 2005-2006 Nokia Corporation
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#ifndef __OMAP2_GPMC_H
-#define __OMAP2_GPMC_H
-
-#include <linux/platform_data/mtd-nand-omap2.h>
-
-/* Maximum Number of Chip Selects */
-#define GPMC_CS_NUM		8
-
-#define GPMC_CS_CONFIG1		0x00
-#define GPMC_CS_CONFIG2		0x04
-#define GPMC_CS_CONFIG3		0x08
-#define GPMC_CS_CONFIG4		0x0c
-#define GPMC_CS_CONFIG5		0x10
-#define GPMC_CS_CONFIG6		0x14
-#define GPMC_CS_CONFIG7		0x18
-#define GPMC_CS_NAND_COMMAND	0x1c
-#define GPMC_CS_NAND_ADDRESS	0x20
-#define GPMC_CS_NAND_DATA	0x24
-
-/* Control Commands */
-#define GPMC_CONFIG_RDY_BSY	0x00000001
-#define GPMC_CONFIG_DEV_SIZE	0x00000002
-#define GPMC_CONFIG_DEV_TYPE	0x00000003
-#define GPMC_SET_IRQ_STATUS	0x00000004
-#define GPMC_CONFIG_WP		0x00000005
-
-#define GPMC_ENABLE_IRQ		0x0000000d
-
-/* ECC commands */
-#define GPMC_ECC_READ		0 /* Reset Hardware ECC for read */
-#define GPMC_ECC_WRITE		1 /* Reset Hardware ECC for write */
-#define GPMC_ECC_READSYN	2 /* Reset before syndrom is read back */
-
-#define GPMC_CONFIG1_WRAPBURST_SUPP     (1 << 31)
-#define GPMC_CONFIG1_READMULTIPLE_SUPP  (1 << 30)
-#define GPMC_CONFIG1_READTYPE_ASYNC     (0 << 29)
-#define GPMC_CONFIG1_READTYPE_SYNC      (1 << 29)
-#define GPMC_CONFIG1_WRITEMULTIPLE_SUPP (1 << 28)
-#define GPMC_CONFIG1_WRITETYPE_ASYNC    (0 << 27)
-#define GPMC_CONFIG1_WRITETYPE_SYNC     (1 << 27)
-#define GPMC_CONFIG1_CLKACTIVATIONTIME(val) ((val & 3) << 25)
-#define GPMC_CONFIG1_PAGE_LEN(val)      ((val & 3) << 23)
-#define GPMC_CONFIG1_WAIT_READ_MON      (1 << 22)
-#define GPMC_CONFIG1_WAIT_WRITE_MON     (1 << 21)
-#define GPMC_CONFIG1_WAIT_MON_IIME(val) ((val & 3) << 18)
-#define GPMC_CONFIG1_WAIT_PIN_SEL(val)  ((val & 3) << 16)
-#define GPMC_CONFIG1_DEVICESIZE(val)    ((val & 3) << 12)
-#define GPMC_CONFIG1_DEVICESIZE_16      GPMC_CONFIG1_DEVICESIZE(1)
-#define GPMC_CONFIG1_DEVICETYPE(val)    ((val & 3) << 10)
-#define GPMC_CONFIG1_DEVICETYPE_NOR     GPMC_CONFIG1_DEVICETYPE(0)
-#define GPMC_CONFIG1_MUXTYPE(val)       ((val & 3) << 8)
-#define GPMC_CONFIG1_TIME_PARA_GRAN     (1 << 4)
-#define GPMC_CONFIG1_FCLK_DIV(val)      (val & 3)
-#define GPMC_CONFIG1_FCLK_DIV2          (GPMC_CONFIG1_FCLK_DIV(1))
-#define GPMC_CONFIG1_FCLK_DIV3          (GPMC_CONFIG1_FCLK_DIV(2))
-#define GPMC_CONFIG1_FCLK_DIV4          (GPMC_CONFIG1_FCLK_DIV(3))
-#define GPMC_CONFIG7_CSVALID		(1 << 6)
-
-#define GPMC_DEVICETYPE_NOR		0
-#define GPMC_DEVICETYPE_NAND		2
-#define GPMC_CONFIG_WRITEPROTECT	0x00000010
-#define WR_RD_PIN_MONITORING		0x00600000
-#define GPMC_IRQ_FIFOEVENTENABLE	0x01
-#define GPMC_IRQ_COUNT_EVENT		0x02
-
-#define GPMC_BURST_4			4	/* 4 word burst */
-#define GPMC_BURST_8			8	/* 8 word burst */
-#define GPMC_BURST_16			16	/* 16 word burst */
-#define GPMC_DEVWIDTH_8BIT		1	/* 8-bit device width */
-#define GPMC_DEVWIDTH_16BIT		2	/* 16-bit device width */
-#define GPMC_MUX_AAD			1	/* Addr-Addr-Data multiplex */
-#define GPMC_MUX_AD			2	/* Addr-Data multiplex */
-
-/* bool type time settings */
-struct gpmc_bool_timings {
-	bool cycle2cyclediffcsen;
-	bool cycle2cyclesamecsen;
-	bool we_extra_delay;
-	bool oe_extra_delay;
-	bool adv_extra_delay;
-	bool cs_extra_delay;
-	bool time_para_granularity;
-};
-
-/*
- * Note that all values in this struct are in nanoseconds except sync_clk
- * (which is in picoseconds), while the register values are in gpmc_fck cycles.
- */
-struct gpmc_timings {
-	/* Minimum clock period for synchronous mode (in picoseconds) */
-	u32 sync_clk;
-
-	/* Chip-select signal timings corresponding to GPMC_CS_CONFIG2 */
-	u32 cs_on;		/* Assertion time */
-	u32 cs_rd_off;		/* Read deassertion time */
-	u32 cs_wr_off;		/* Write deassertion time */
-
-	/* ADV signal timings corresponding to GPMC_CONFIG3 */
-	u32 adv_on;		/* Assertion time */
-	u32 adv_rd_off;		/* Read deassertion time */
-	u32 adv_wr_off;		/* Write deassertion time */
-
-	/* WE signals timings corresponding to GPMC_CONFIG4 */
-	u32 we_on;		/* WE assertion time */
-	u32 we_off;		/* WE deassertion time */
-
-	/* OE signals timings corresponding to GPMC_CONFIG4 */
-	u32 oe_on;		/* OE assertion time */
-	u32 oe_off;		/* OE deassertion time */
-
-	/* Access time and cycle time timings corresponding to GPMC_CONFIG5 */
-	u32 page_burst_access;	/* Multiple access word delay */
-	u32 access;		/* Start-cycle to first data valid delay */
-	u32 rd_cycle;		/* Total read cycle time */
-	u32 wr_cycle;		/* Total write cycle time */
-
-	u32 bus_turnaround;
-	u32 cycle2cycle_delay;
-
-	u32 wait_monitoring;
-	u32 clk_activation;
-
-	/* The following are only on OMAP3430 */
-	u32 wr_access;		/* WRACCESSTIME */
-	u32 wr_data_mux_bus;	/* WRDATAONADMUXBUS */
-
-	struct gpmc_bool_timings bool_timings;
-};
-
-/* Device timings in picoseconds */
-struct gpmc_device_timings {
-	u32 t_ceasu;	/* address setup to CS valid */
-	u32 t_avdasu;	/* address setup to ADV valid */
-	/* XXX: try to combine t_avdp_r & t_avdp_w. Issue is
-	 * of tusb using these timings even for sync whilst
-	 * ideally for adv_rd/(wr)_off it should have considered
-	 * t_avdh instead. This indirectly necessitates r/w
-	 * variations of t_avdp as it is possible to have one
-	 * sync & other async
-	 */
-	u32 t_avdp_r;	/* ADV low time (what about t_cer ?) */
-	u32 t_avdp_w;
-	u32 t_aavdh;	/* address hold time */
-	u32 t_oeasu;	/* address setup to OE valid */
-	u32 t_aa;	/* access time from ADV assertion */
-	u32 t_iaa;	/* initial access time */
-	u32 t_oe;	/* access time from OE assertion */
-	u32 t_ce;	/* access time from CS asertion */
-	u32 t_rd_cycle;	/* read cycle time */
-	u32 t_cez_r;	/* read CS deassertion to high Z */
-	u32 t_cez_w;	/* write CS deassertion to high Z */
-	u32 t_oez;	/* OE deassertion to high Z */
-	u32 t_weasu;	/* address setup to WE valid */
-	u32 t_wpl;	/* write assertion time */
-	u32 t_wph;	/* write deassertion time */
-	u32 t_wr_cycle;	/* write cycle time */
-
-	u32 clk;
-	u32 t_bacc;	/* burst access valid clock to output delay */
-	u32 t_ces;	/* CS setup time to clk */
-	u32 t_avds;	/* ADV setup time to clk */
-	u32 t_avdh;	/* ADV hold time from clk */
-	u32 t_ach;	/* address hold time from clk */
-	u32 t_rdyo;	/* clk to ready valid */
-
-	u32 t_ce_rdyz;	/* XXX: description ?, or use t_cez instead */
-	u32 t_ce_avd;	/* CS on to ADV on delay */
-
-	/* XXX: check the possibility of combining
-	 * cyc_aavhd_oe & cyc_aavdh_we
-	 */
-	u8 cyc_aavdh_oe;/* read address hold time in cycles */
-	u8 cyc_aavdh_we;/* write address hold time in cycles */
-	u8 cyc_oe;	/* access time from OE assertion in cycles */
-	u8 cyc_wpl;	/* write deassertion time in cycles */
-	u32 cyc_iaa;	/* initial access time in cycles */
-
-	/* extra delays */
-	bool ce_xdelay;
-	bool avd_xdelay;
-	bool oe_xdelay;
-	bool we_xdelay;
-};
-
-struct gpmc_settings {
-	bool burst_wrap;	/* enables wrap bursting */
-	bool burst_read;	/* enables read page/burst mode */
-	bool burst_write;	/* enables write page/burst mode */
-	bool device_nand;	/* device is NAND */
-	bool sync_read;		/* enables synchronous reads */
-	bool sync_write;	/* enables synchronous writes */
-	bool wait_on_read;	/* monitor wait on reads */
-	bool wait_on_write;	/* monitor wait on writes */
-	u32 burst_len;		/* page/burst length */
-	u32 device_width;	/* device bus width (8 or 16 bit) */
-	u32 mux_add_data;	/* multiplex address & data */
-	u32 wait_pin;		/* wait-pin to be used */
-};
-
-extern int gpmc_calc_timings(struct gpmc_timings *gpmc_t,
-			     struct gpmc_settings *gpmc_s,
-			     struct gpmc_device_timings *dev_t);
-
-extern void gpmc_update_nand_reg(struct gpmc_nand_regs *reg, int cs);
-extern int gpmc_get_client_irq(unsigned irq_config);
-
-extern unsigned int gpmc_ticks_to_ns(unsigned int ticks);
-
-extern void gpmc_cs_write_reg(int cs, int idx, u32 val);
-extern int gpmc_calc_divider(unsigned int sync_clk);
-extern int gpmc_cs_set_timings(int cs, const struct gpmc_timings *t);
-extern int gpmc_cs_program_settings(int cs, struct gpmc_settings *p);
-extern int gpmc_cs_request(int cs, unsigned long size, unsigned long *base);
-extern void gpmc_cs_free(int cs);
-extern void omap3_gpmc_save_context(void);
-extern void omap3_gpmc_restore_context(void);
-extern int gpmc_configure(int cmd, int wval);
-extern void gpmc_read_settings_dt(struct device_node *np,
-				  struct gpmc_settings *p);
-
-#endif
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 5a2d803..fbe49f8 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -30,6 +30,7 @@
 #include <linux/slab.h>
 #include <linux/omap-dma.h>
 #include <linux/platform_data/gpio-omap.h>
+#include <linux/platform_data/gpmc-omap.h>
 
 #include <trace/events/power.h>
 
@@ -43,7 +44,6 @@
 #include "common.h"
 #include "cm3xxx.h"
 #include "cm-regbits-34xx.h"
-#include "gpmc.h"
 #include "prm-regbits-34xx.h"
 #include "prm3xxx.h"
 #include "pm.h"
diff --git a/arch/arm/mach-omap2/usb-tusb6010.c b/arch/arm/mach-omap2/usb-tusb6010.c
index e832bc7..8161054 100644
--- a/arch/arm/mach-omap2/usb-tusb6010.c
+++ b/arch/arm/mach-omap2/usb-tusb6010.c
@@ -17,11 +17,10 @@
 #include <linux/gpio.h>
 #include <linux/export.h>
 #include <linux/platform_data/usb-omap.h>
+#include <linux/platform_data/gpmc-omap.h>
 
 #include <linux/usb/musb.h>
 
-#include "gpmc.h"
-
 #include "mux.h"
 
 static u8		async_cs, sync_cs;
diff --git a/include/linux/platform_data/gpmc-nand-omap.h b/include/linux/platform_data/gpmc-nand-omap.h
new file mode 100644
index 0000000..1321c71
--- /dev/null
+++ b/include/linux/platform_data/gpmc-nand-omap.h
@@ -0,0 +1,27 @@
+/*
+ *  arch/arm/mach-omap2/gpmc-nand.h
+ *
+ *  This program is free software; you can redistribute  it and/or modify it
+ *  under  the terms of  the GNU General  Public License as published by the
+ *  Free Software Foundation;  either version 2 of the  License, or (at your
+ *  option) any later version.
+ */
+
+#ifndef	__OMAP2_GPMC_NAND_H
+#define	__OMAP2_GPMC_NAND_H
+
+#include <linux/platform_data/gpmc-omap.h>
+#include <linux/platform_data/mtd-nand-omap2.h>
+
+#if IS_ENABLED(CONFIG_MTD_NAND_OMAP2)
+extern int gpmc_nand_init(struct omap_nand_platform_data *d,
+			  struct gpmc_timings *gpmc_t);
+#else
+static inline int gpmc_nand_init(struct omap_nand_platform_data *d,
+				 struct gpmc_timings *gpmc_t)
+{
+	return 0;
+}
+#endif
+
+#endif
diff --git a/include/linux/platform_data/gpmc-omap.h b/include/linux/platform_data/gpmc-omap.h
new file mode 100644
index 0000000..707f6d5
--- /dev/null
+++ b/include/linux/platform_data/gpmc-omap.h
@@ -0,0 +1,231 @@
+/*
+ * General-Purpose Memory Controller for OMAP2
+ *
+ * Copyright (C) 2005-2006 Nokia Corporation
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __OMAP2_GPMC_H
+#define __OMAP2_GPMC_H
+
+#include <linux/platform_data/mtd-nand-omap2.h>
+
+/* Maximum Number of Chip Selects */
+#define GPMC_CS_NUM		8
+
+#define GPMC_CS_CONFIG1		0x00
+#define GPMC_CS_CONFIG2		0x04
+#define GPMC_CS_CONFIG3		0x08
+#define GPMC_CS_CONFIG4		0x0c
+#define GPMC_CS_CONFIG5		0x10
+#define GPMC_CS_CONFIG6		0x14
+#define GPMC_CS_CONFIG7		0x18
+#define GPMC_CS_NAND_COMMAND	0x1c
+#define GPMC_CS_NAND_ADDRESS	0x20
+#define GPMC_CS_NAND_DATA	0x24
+
+/* Control Commands */
+#define GPMC_CONFIG_RDY_BSY	0x00000001
+#define GPMC_CONFIG_DEV_SIZE	0x00000002
+#define GPMC_CONFIG_DEV_TYPE	0x00000003
+#define GPMC_SET_IRQ_STATUS	0x00000004
+#define GPMC_CONFIG_WP		0x00000005
+
+#define GPMC_ENABLE_IRQ		0x0000000d
+
+/* ECC commands */
+#define GPMC_ECC_READ		0 /* Reset Hardware ECC for read */
+#define GPMC_ECC_WRITE		1 /* Reset Hardware ECC for write */
+#define GPMC_ECC_READSYN	2 /* Reset before syndrom is read back */
+
+#define GPMC_CONFIG1_WRAPBURST_SUPP     (1 << 31)
+#define GPMC_CONFIG1_READMULTIPLE_SUPP  (1 << 30)
+#define GPMC_CONFIG1_READTYPE_ASYNC     (0 << 29)
+#define GPMC_CONFIG1_READTYPE_SYNC      (1 << 29)
+#define GPMC_CONFIG1_WRITEMULTIPLE_SUPP (1 << 28)
+#define GPMC_CONFIG1_WRITETYPE_ASYNC    (0 << 27)
+#define GPMC_CONFIG1_WRITETYPE_SYNC     (1 << 27)
+#define GPMC_CONFIG1_CLKACTIVATIONTIME(val) ((val & 3) << 25)
+#define GPMC_CONFIG1_PAGE_LEN(val)      ((val & 3) << 23)
+#define GPMC_CONFIG1_WAIT_READ_MON      (1 << 22)
+#define GPMC_CONFIG1_WAIT_WRITE_MON     (1 << 21)
+#define GPMC_CONFIG1_WAIT_MON_IIME(val) ((val & 3) << 18)
+#define GPMC_CONFIG1_WAIT_PIN_SEL(val)  ((val & 3) << 16)
+#define GPMC_CONFIG1_DEVICESIZE(val)    ((val & 3) << 12)
+#define GPMC_CONFIG1_DEVICESIZE_16      GPMC_CONFIG1_DEVICESIZE(1)
+#define GPMC_CONFIG1_DEVICETYPE(val)    ((val & 3) << 10)
+#define GPMC_CONFIG1_DEVICETYPE_NOR     GPMC_CONFIG1_DEVICETYPE(0)
+#define GPMC_CONFIG1_MUXTYPE(val)       ((val & 3) << 8)
+#define GPMC_CONFIG1_TIME_PARA_GRAN     (1 << 4)
+#define GPMC_CONFIG1_FCLK_DIV(val)      (val & 3)
+#define GPMC_CONFIG1_FCLK_DIV2          (GPMC_CONFIG1_FCLK_DIV(1))
+#define GPMC_CONFIG1_FCLK_DIV3          (GPMC_CONFIG1_FCLK_DIV(2))
+#define GPMC_CONFIG1_FCLK_DIV4          (GPMC_CONFIG1_FCLK_DIV(3))
+#define GPMC_CONFIG7_CSVALID		(1 << 6)
+
+#define GPMC_DEVICETYPE_NOR		0
+#define GPMC_DEVICETYPE_NAND		2
+#define GPMC_CONFIG_WRITEPROTECT	0x00000010
+#define WR_RD_PIN_MONITORING		0x00600000
+#define GPMC_IRQ_FIFOEVENTENABLE	0x01
+#define GPMC_IRQ_COUNT_EVENT		0x02
+
+#define GPMC_BURST_4			4	/* 4 word burst */
+#define GPMC_BURST_8			8	/* 8 word burst */
+#define GPMC_BURST_16			16	/* 16 word burst */
+#define GPMC_DEVWIDTH_8BIT		1	/* 8-bit device width */
+#define GPMC_DEVWIDTH_16BIT		2	/* 16-bit device width */
+#define GPMC_MUX_AAD			1	/* Addr-Addr-Data multiplex */
+#define GPMC_MUX_AD			2	/* Addr-Data multiplex */
+
+/* bool type time settings */
+struct gpmc_bool_timings {
+	bool cycle2cyclediffcsen;
+	bool cycle2cyclesamecsen;
+	bool we_extra_delay;
+	bool oe_extra_delay;
+	bool adv_extra_delay;
+	bool cs_extra_delay;
+	bool time_para_granularity;
+};
+
+/*
+ * Note that all values in this struct are in nanoseconds except sync_clk
+ * (which is in picoseconds), while the register values are in gpmc_fck cycles.
+ */
+struct gpmc_timings {
+	/* Minimum clock period for synchronous mode (in picoseconds) */
+	u32 sync_clk;
+
+	/* Chip-select signal timings corresponding to GPMC_CS_CONFIG2 */
+	u32 cs_on;		/* Assertion time */
+	u32 cs_rd_off;		/* Read deassertion time */
+	u32 cs_wr_off;		/* Write deassertion time */
+
+	/* ADV signal timings corresponding to GPMC_CONFIG3 */
+	u32 adv_on;		/* Assertion time */
+	u32 adv_rd_off;		/* Read deassertion time */
+	u32 adv_wr_off;		/* Write deassertion time */
+
+	/* WE signals timings corresponding to GPMC_CONFIG4 */
+	u32 we_on;		/* WE assertion time */
+	u32 we_off;		/* WE deassertion time */
+
+	/* OE signals timings corresponding to GPMC_CONFIG4 */
+	u32 oe_on;		/* OE assertion time */
+	u32 oe_off;		/* OE deassertion time */
+
+	/* Access time and cycle time timings corresponding to GPMC_CONFIG5 */
+	u32 page_burst_access;	/* Multiple access word delay */
+	u32 access;		/* Start-cycle to first data valid delay */
+	u32 rd_cycle;		/* Total read cycle time */
+	u32 wr_cycle;		/* Total write cycle time */
+
+	u32 bus_turnaround;
+	u32 cycle2cycle_delay;
+
+	u32 wait_monitoring;
+	u32 clk_activation;
+
+	/* The following are only on OMAP3430 */
+	u32 wr_access;		/* WRACCESSTIME */
+	u32 wr_data_mux_bus;	/* WRDATAONADMUXBUS */
+
+	struct gpmc_bool_timings bool_timings;
+};
+
+/* Device timings in picoseconds */
+struct gpmc_device_timings {
+	u32 t_ceasu;	/* address setup to CS valid */
+	u32 t_avdasu;	/* address setup to ADV valid */
+	/* XXX: try to combine t_avdp_r & t_avdp_w. Issue is
+	 * of tusb using these timings even for sync whilst
+	 * ideally for adv_rd/(wr)_off it should have considered
+	 * t_avdh instead. This indirectly necessitates r/w
+	 * variations of t_avdp as it is possible to have one
+	 * sync & other async
+	 */
+	u32 t_avdp_r;	/* ADV low time (what about t_cer ?) */
+	u32 t_avdp_w;
+	u32 t_aavdh;	/* address hold time */
+	u32 t_oeasu;	/* address setup to OE valid */
+	u32 t_aa;	/* access time from ADV assertion */
+	u32 t_iaa;	/* initial access time */
+	u32 t_oe;	/* access time from OE assertion */
+	u32 t_ce;	/* access time from CS asertion */
+	u32 t_rd_cycle;	/* read cycle time */
+	u32 t_cez_r;	/* read CS deassertion to high Z */
+	u32 t_cez_w;	/* write CS deassertion to high Z */
+	u32 t_oez;	/* OE deassertion to high Z */
+	u32 t_weasu;	/* address setup to WE valid */
+	u32 t_wpl;	/* write assertion time */
+	u32 t_wph;	/* write deassertion time */
+	u32 t_wr_cycle;	/* write cycle time */
+
+	u32 clk;
+	u32 t_bacc;	/* burst access valid clock to output delay */
+	u32 t_ces;	/* CS setup time to clk */
+	u32 t_avds;	/* ADV setup time to clk */
+	u32 t_avdh;	/* ADV hold time from clk */
+	u32 t_ach;	/* address hold time from clk */
+	u32 t_rdyo;	/* clk to ready valid */
+
+	u32 t_ce_rdyz;	/* XXX: description ?, or use t_cez instead */
+	u32 t_ce_avd;	/* CS on to ADV on delay */
+
+	/* XXX: check the possibility of combining
+	 * cyc_aavhd_oe & cyc_aavdh_we
+	 */
+	u8 cyc_aavdh_oe;/* read address hold time in cycles */
+	u8 cyc_aavdh_we;/* write address hold time in cycles */
+	u8 cyc_oe;	/* access time from OE assertion in cycles */
+	u8 cyc_wpl;	/* write deassertion time in cycles */
+	u32 cyc_iaa;	/* initial access time in cycles */
+
+	/* extra delays */
+	bool ce_xdelay;
+	bool avd_xdelay;
+	bool oe_xdelay;
+	bool we_xdelay;
+};
+
+struct gpmc_settings {
+	bool burst_wrap;	/* enables wrap bursting */
+	bool burst_read;	/* enables read page/burst mode */
+	bool burst_write;	/* enables write page/burst mode */
+	bool device_nand;	/* device is NAND */
+	bool sync_read;		/* enables synchronous reads */
+	bool sync_write;	/* enables synchronous writes */
+	bool wait_on_read;	/* monitor wait on reads */
+	bool wait_on_write;	/* monitor wait on writes */
+	u32 burst_len;		/* page/burst length */
+	u32 device_width;	/* device bus width (8 or 16 bit) */
+	u32 mux_add_data;	/* multiplex address & data */
+	u32 wait_pin;		/* wait-pin to be used */
+};
+
+extern int gpmc_calc_timings(struct gpmc_timings *gpmc_t,
+			     struct gpmc_settings *gpmc_s,
+			     struct gpmc_device_timings *dev_t);
+
+extern void gpmc_update_nand_reg(struct gpmc_nand_regs *reg, int cs);
+extern int gpmc_get_client_irq(unsigned irq_config);
+
+extern unsigned int gpmc_ticks_to_ns(unsigned int ticks);
+
+extern void gpmc_cs_write_reg(int cs, int idx, u32 val);
+extern int gpmc_calc_divider(unsigned int sync_clk);
+extern int gpmc_cs_set_timings(int cs, const struct gpmc_timings *t);
+extern int gpmc_cs_program_settings(int cs, struct gpmc_settings *p);
+extern int gpmc_cs_request(int cs, unsigned long size, unsigned long *base);
+extern void gpmc_cs_free(int cs);
+extern void omap3_gpmc_save_context(void);
+extern void omap3_gpmc_restore_context(void);
+extern int gpmc_configure(int cmd, int wval);
+extern void gpmc_read_settings_dt(struct device_node *np,
+				  struct gpmc_settings *p);
+
+#endif
diff --git a/include/linux/platform_data/gpmc-onenand-omap.h b/include/linux/platform_data/gpmc-onenand-omap.h
new file mode 100644
index 0000000..b1886ba
--- /dev/null
+++ b/include/linux/platform_data/gpmc-onenand-omap.h
@@ -0,0 +1,25 @@
+/*
+ *  arch/arm/mach-omap2/gpmc-onenand.h
+ *
+ *  This program is free software; you can redistribute  it and/or modify it
+ *  under  the terms of  the GNU General  Public License as published by the
+ *  Free Software Foundation;  either version 2 of the  License, or (at your
+ *  option) any later version.
+ */
+
+#ifndef	__OMAP2_GPMC_ONENAND_H
+#define	__OMAP2_GPMC_ONENAND_H
+
+#include <linux/platform_data/gpmc-omap.h>
+#include <linux/platform_data/mtd-onenand-omap2.h>
+
+#if IS_ENABLED(CONFIG_MTD_ONENAND_OMAP2)
+extern void gpmc_onenand_init(struct omap_onenand_platform_data *d);
+#else
+#define board_onenand_data	NULL
+static inline void gpmc_onenand_init(struct omap_onenand_platform_data *d)
+{
+}
+#endif
+
+#endif
diff --git a/include/linux/platform_data/gpmc-smc91x-omap.h b/include/linux/platform_data/gpmc-smc91x-omap.h
new file mode 100644
index 0000000..b64fbee
--- /dev/null
+++ b/include/linux/platform_data/gpmc-smc91x-omap.h
@@ -0,0 +1,42 @@
+/*
+ * arch/arm/plat-omap/include/mach/gpmc-smc91x.h
+ *
+ * Copyright (C) 2009 Nokia Corporation
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __ASM_ARCH_OMAP_GPMC_SMC91X_H__
+
+#define GPMC_TIMINGS_SMC91C96	(1 << 4)
+#define GPMC_MUX_ADD_DATA	(1 << 5) /* GPMC_CONFIG1_MUXADDDATA */
+#define GPMC_READ_MON		(1 << 6) /* GPMC_CONFIG1_WAIT_READ_MON */
+#define GPMC_WRITE_MON		(1 << 7) /* GPMC_CONFIG1_WAIT_WRITE_MON */
+
+struct omap_smc91x_platform_data {
+	int	cs;
+	int	gpio_irq;
+	int	gpio_pwrdwn;
+	int	gpio_reset;
+	int	wait_pin;	/* Optional GPMC_CONFIG1_WAITPINSELECT */
+	u32	flags;
+	int	(*retime)(void);
+};
+
+#if defined(CONFIG_SMC91X) || \
+	defined(CONFIG_SMC91X_MODULE)
+
+extern void gpmc_smc91x_init(struct omap_smc91x_platform_data *d);
+
+#else
+
+#define board_smc91x_data	NULL
+
+static inline void gpmc_smc91x_init(struct omap_smc91x_platform_data *d)
+{
+}
+
+#endif
+#endif
diff --git a/include/linux/platform_data/gpmc-smsc911x-omap.h b/include/linux/platform_data/gpmc-smsc911x-omap.h
new file mode 100644
index 0000000..ea6c9c8
--- /dev/null
+++ b/include/linux/platform_data/gpmc-smsc911x-omap.h
@@ -0,0 +1,35 @@
+/*
+ * arch/arm/plat-omap/include/plat/gpmc-smsc911x.h
+ *
+ * Copyright (C) 2009 Li-Pro.Net
+ * Stephan Linz <linz@li-pro.net>
+ *
+ * Modified from arch/arm/plat-omap/include/plat/gpmc-smc91x.h
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __ASM_ARCH_OMAP_GPMC_SMSC911X_H__
+
+struct omap_smsc911x_platform_data {
+	int	id;
+	int	cs;
+	int	gpio_irq;
+	int	gpio_reset;
+	u32	flags;
+};
+
+#if defined(CONFIG_SMSC911X) || defined(CONFIG_SMSC911X_MODULE)
+
+extern void gpmc_smsc911x_init(struct omap_smsc911x_platform_data *d);
+
+#else
+
+static inline void gpmc_smsc911x_init(struct omap_smsc911x_platform_data *d)
+{
+}
+
+#endif
+#endif
-- 
1.8.4.rc3

