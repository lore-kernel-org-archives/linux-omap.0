From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [RFT/RFC/PATCH 10/10] cbus: add platform_data to pass gpios
Date: Thu,  3 Dec 2009 00:35:52 +0200
Message-ID: <1259793352-29864-11-git-send-email-felipe.balbi@nokia.com>
References: <1259793352-29864-1-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:60615 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755905AbZLBWgR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Dec 2009 17:36:17 -0500
In-Reply-To: <1259793352-29864-1-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Felipe Balbi <felipe.balbi@nokia.com>

also add the platform_data to the related
board files.

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 arch/arm/mach-omap1/board-nokia770.c   |   10 ++++++++++
 arch/arm/mach-omap2/board-n8x0.c       |   10 ++++++++++
 arch/arm/plat-omap/include/plat/cbus.h |   31 +++++++++++++++++++++++++++++++
 drivers/cbus/cbus.c                    |   30 +++++-------------------------
 4 files changed, 56 insertions(+), 25 deletions(-)
 create mode 100644 arch/arm/plat-omap/include/plat/cbus.h

diff --git a/arch/arm/mach-omap1/board-nokia770.c b/arch/arm/mach-omap1/board-nokia770.c
index a8debf3..95a3a82 100644
--- a/arch/arm/mach-omap1/board-nokia770.c
+++ b/arch/arm/mach-omap1/board-nokia770.c
@@ -38,6 +38,7 @@
 #include <plat/lcd_mipid.h>
 #include <plat/mmc.h>
 #include <plat/clock.h>
+#include <plat/cbus.h>
 
 #define ADS7846_PENDOWN_GPIO	15
 
@@ -97,9 +98,18 @@ static struct platform_device nokia770_kp_device = {
 	.resource	= nokia770_kp_resources,
 };
 
+static struct cbus_host_platform_data nokia770_cbus_data = {
+	.clk_gpio	= OMAP_MPUIO(11),
+	.dat_gpio	= OMAP_MPUIO(10),
+	.sel_gpio	= OMAP_MPUIO(9),
+};
+
 static struct platform_device nokia770_cbus_device = {
 	.name		= "cbus",
 	.id		= -1,
+	.dev		= {
+		.platform_data = &nokia770_cbus_data,
+	},
 };
 
 static struct platform_device *nokia770_devices[] __initdata = {
diff --git a/arch/arm/mach-omap2/board-n8x0.c b/arch/arm/mach-omap2/board-n8x0.c
index 068949a..84004bc 100644
--- a/arch/arm/mach-omap2/board-n8x0.c
+++ b/arch/arm/mach-omap2/board-n8x0.c
@@ -30,6 +30,7 @@
 #include <plat/mcspi.h>
 #include <plat/onenand.h>
 #include <plat/serial.h>
+#include <plat/cbus.h>
 
 static struct omap2_mcspi_device_config p54spi_mcspi_config = {
 	.turbo_mode	= 0,
@@ -78,9 +79,18 @@ static struct mtd_partition onenand_partitions[] = {
 	},
 };
 
+static struct cbus_host_platform_data n8x0_cbus_data = {
+	.clk_gpio	= 66,
+	.dat_gpio	= 65,
+	.sel_gpio	= 64,
+};
+
 static struct platform_device n8x0_cbus_device = {
 	.name		= "cbus",
 	.id		= -1,
+	.dev		= {
+		.platform_data = &n8x0_cbus_data,
+	},
 };
 
 static struct omap_onenand_platform_data board_onenand_data = {
diff --git a/arch/arm/plat-omap/include/plat/cbus.h b/arch/arm/plat-omap/include/plat/cbus.h
new file mode 100644
index 0000000..d938e23
--- /dev/null
+++ b/arch/arm/plat-omap/include/plat/cbus.h
@@ -0,0 +1,31 @@
+/*
+ * cbus.h - CBUS platform_data definition
+ *
+ * Copyright (C) 2004 - 2009 Nokia Corporation
+ *
+ * Written by Felipe Balbi <felipe.balbi@nokia.com>
+ *
+ * This file is subject to the terms and conditions of the GNU General
+ * Public License. See the file "COPYING" in the main directory of this
+ * archive for more details.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+#ifndef __PLAT_CBUS_H
+#define __PLAT_CBUS_H
+
+struct cbus_host_platform_data {
+	int	dat_gpio;
+	int	clk_gpio;
+	int	sel_gpio;
+};
+
+#endif /* __PLAT_CBUS_H */
diff --git a/drivers/cbus/cbus.c b/drivers/cbus/cbus.c
index a35941e..00c3c32 100644
--- a/drivers/cbus/cbus.c
+++ b/drivers/cbus/cbus.c
@@ -35,6 +35,7 @@
 #include <asm/mach-types.h>
 
 #include <plat/board.h>
+#include <plat/cbus.h>
 
 #include "cbus.h"
 
@@ -226,6 +227,7 @@ EXPORT_SYMBOL(cbus_write_reg);
 static int __init cbus_bus_probe(struct platform_device *pdev)
 {
 	struct cbus_host *chost;
+	struct cbus_host_platform_data *pdata = pdev->dev.platform_data;
 	int ret;
 
 	chost = kzalloc(sizeof (*chost), GFP_KERNEL);
@@ -234,31 +236,9 @@ static int __init cbus_bus_probe(struct platform_device *pdev)
 
 	spin_lock_init(&chost->lock);
 
-	/* REVISIT: Pass these from board-*.c files in platform_data */
-	if (machine_is_nokia770()) {
-		chost->clk_gpio = OMAP_MPUIO(11);
-		chost->dat_gpio = OMAP_MPUIO(10);
-		chost->sel_gpio = OMAP_MPUIO(9);
-	} else if (machine_is_nokia_n800() || machine_is_nokia_n810() ||
-			machine_is_nokia_n810_wimax()) {
-		chost->clk_gpio = 66;
-		chost->dat_gpio = 65;
-		chost->sel_gpio = 64;
-	} else {
-		printk(KERN_ERR "cbus: Unsupported board\n");
-		ret = -ENODEV;
-		goto exit1;
-	}
-
-#ifdef CONFIG_ARCH_OMAP1
-	if (!OMAP_GPIO_IS_MPUIO(chost->clk_gpio) ||
-	    !OMAP_GPIO_IS_MPUIO(chost->dat_gpio) ||
-	    !OMAP_GPIO_IS_MPUIO(chost->sel_gpio)) {
-		printk(KERN_ERR "cbus: Only MPUIO pins supported\n");
-		ret = -ENODEV;
-		goto exit1;
-	}
-#endif
+	chost->clk_gpio = pdata->clk_gpio;
+	chost->dat_gpio = pdata->dat_gpio;
+	chost->sel_gpio = pdata->sel_gpio;
 
 	if ((ret = gpio_request(chost->clk_gpio, "CBUS clk")) < 0)
 		goto exit1;
-- 
1.6.6.rc0

