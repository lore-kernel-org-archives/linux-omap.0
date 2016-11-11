From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 13/14] ARM: OMAP2+: Drop legacy ads7846 init
Date: Fri, 11 Nov 2016 11:17:10 -0800
Message-ID: <20161111191711.5079-14-tony@atomide.com>
References: <20161111191711.5079-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20161111191711.5079-1-tony@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org
Cc: Paul Walmsley <paul@pwsan.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

---
 arch/arm/mach-omap2/Makefile               |   3 -
 arch/arm/mach-omap2/common-board-devices.c | 102 -----------------------------
 arch/arm/mach-omap2/common-board-devices.h |   7 --
 arch/arm/mach-omap2/dss-common.c           |  36 ----------
 arch/arm/mach-omap2/dss-common.h           |  13 ----
 arch/arm/mach-omap2/pdata-quirks.c         |   1 -
 6 files changed, 162 deletions(-)
 delete mode 100644 arch/arm/mach-omap2/common-board-devices.c
 delete mode 100644 arch/arm/mach-omap2/dss-common.c
 delete mode 100644 arch/arm/mach-omap2/dss-common.h

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -244,6 +244,3 @@ obj-y					+= $(onenand-m) $(onenand-y)
 
 nand-$(CONFIG_MTD_NAND_OMAP2)		:= gpmc-nand.o
 obj-y					+= $(nand-m) $(nand-y)
-
-
-obj-y					+= common-board-devices.o dss-common.o
diff --git a/arch/arm/mach-omap2/common-board-devices.c b/arch/arm/mach-omap2/common-board-devices.c
deleted file mode 100644
--- a/arch/arm/mach-omap2/common-board-devices.c
+++ /dev/null
@@ -1,102 +0,0 @@
-/*
- * common-board-devices.c
- *
- * Copyright (C) 2011 CompuLab, Ltd.
- * Author: Mike Rapoport <mike@compulab.co.il>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * version 2 as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
- * 02110-1301 USA
- *
- */
-
-#include <linux/gpio.h>
-#include <linux/spi/spi.h>
-#include <linux/spi/ads7846.h>
-
-#include <linux/platform_data/spi-omap2-mcspi.h>
-
-#include "common.h"
-#include "common-board-devices.h"
-
-#if IS_ENABLED(CONFIG_TOUCHSCREEN_ADS7846)
-static struct omap2_mcspi_device_config ads7846_mcspi_config = {
-	.turbo_mode	= 0,
-};
-
-static struct ads7846_platform_data ads7846_config = {
-	.x_max			= 0x0fff,
-	.y_max			= 0x0fff,
-	.x_plate_ohms		= 180,
-	.pressure_max		= 255,
-	.debounce_max		= 10,
-	.debounce_tol		= 3,
-	.debounce_rep		= 1,
-	.gpio_pendown		= -EINVAL,
-	.keep_vref_on		= 1,
-};
-
-static struct spi_board_info ads7846_spi_board_info __initdata = {
-	.modalias		= "ads7846",
-	.bus_num		= -EINVAL,
-	.chip_select		= 0,
-	.max_speed_hz		= 1500000,
-	.controller_data	= &ads7846_mcspi_config,
-	.irq			= -EINVAL,
-	.platform_data		= &ads7846_config,
-};
-
-void __init omap_ads7846_init(int bus_num, int gpio_pendown, int gpio_debounce,
-			      struct ads7846_platform_data *board_pdata)
-{
-	struct spi_board_info *spi_bi = &ads7846_spi_board_info;
-	int err;
-
-	/*
-	 * If a board defines get_pendown_state() function, request the pendown
-	 * GPIO and set the GPIO debounce time.
-	 * If a board does not define the get_pendown_state() function, then
-	 * the ads7846 driver will setup the pendown GPIO itself.
-	 */
-	if (board_pdata && board_pdata->get_pendown_state) {
-		err = gpio_request_one(gpio_pendown, GPIOF_IN, "TSPenDown");
-		if (err) {
-			pr_err("Couldn't obtain gpio for TSPenDown: %d\n", err);
-			return;
-		}
-
-		if (gpio_debounce)
-			gpio_set_debounce(gpio_pendown, gpio_debounce);
-
-		gpio_export(gpio_pendown, 0);
-	}
-
-	spi_bi->bus_num	= bus_num;
-	spi_bi->irq	= gpio_to_irq(gpio_pendown);
-
-	ads7846_config.gpio_pendown = gpio_pendown;
-
-	if (board_pdata) {
-		board_pdata->gpio_pendown = gpio_pendown;
-		board_pdata->gpio_pendown_debounce = gpio_debounce;
-		spi_bi->platform_data = board_pdata;
-	}
-
-	spi_register_board_info(&ads7846_spi_board_info, 1);
-}
-#else
-void __init omap_ads7846_init(int bus_num, int gpio_pendown, int gpio_debounce,
-			      struct ads7846_platform_data *board_pdata)
-{
-}
-#endif
diff --git a/arch/arm/mach-omap2/common-board-devices.h b/arch/arm/mach-omap2/common-board-devices.h
--- a/arch/arm/mach-omap2/common-board-devices.h
+++ b/arch/arm/mach-omap2/common-board-devices.h
@@ -4,13 +4,6 @@
 #include <sound/tlv320aic3x.h>
 #include <linux/mfd/menelaus.h>
 
-#define NAND_BLOCK_SIZE	SZ_128K
-
-struct mtd_partition;
-struct ads7846_platform_data;
-
-void omap_ads7846_init(int bus_num, int gpio_pendown, int gpio_debounce,
-		       struct ads7846_platform_data *board_pdata);
 void *n8x0_legacy_init(void);
 
 extern struct menelaus_platform_data n8x0_menelaus_platform_data;
diff --git a/arch/arm/mach-omap2/dss-common.c b/arch/arm/mach-omap2/dss-common.c
deleted file mode 100644
--- a/arch/arm/mach-omap2/dss-common.c
+++ /dev/null
@@ -1,36 +0,0 @@
-/*
- * Copyright (C) 2012 Texas Instruments, Inc..
- * Author: Tomi Valkeinen <tomi.valkeinen@ti.com>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * version 2 as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
- * 02110-1301 USA
- *
- */
-
-/*
- * NOTE: this is a transitional file to help with DT adaptation.
- * This file will be removed when DSS supports DT.
- */
-
-#include <linux/kernel.h>
-#include <linux/gpio.h>
-#include <linux/platform_device.h>
-
-#include <linux/platform_data/omapdss.h>
-#include <video/omap-panel-data.h>
-
-#include "soc.h"
-#include "dss-common.h"
-#include "display.h"
-
diff --git a/arch/arm/mach-omap2/dss-common.h b/arch/arm/mach-omap2/dss-common.h
deleted file mode 100644
--- a/arch/arm/mach-omap2/dss-common.h
+++ /dev/null
@@ -1,13 +0,0 @@
-#ifndef __OMAP_DSS_COMMON__
-#define __OMAP_DSS_COMMON__
-
-/*
- * NOTE: this is a transitional file to help with DT adaptation.
- * This file will be removed when DSS supports DT.
- */
-
-void __init omap4_panda_display_init_of(void);
-void __init omap_4430sdp_display_init_of(void);
-void __init omap3_igep2_display_init_of(void);
-
-#endif
diff --git a/arch/arm/mach-omap2/pdata-quirks.c b/arch/arm/mach-omap2/pdata-quirks.c
--- a/arch/arm/mach-omap2/pdata-quirks.c
+++ b/arch/arm/mach-omap2/pdata-quirks.c
@@ -31,7 +31,6 @@
 
 #include "common.h"
 #include "common-board-devices.h"
-#include "dss-common.h"
 #include "control.h"
 #include "omap_device.h"
 #include "omap-pm.h"
-- 
2.10.2
