From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH 2/2] ARM: OMAP2: Fix GPMC memory initialisation
Date: Mon, 4 Feb 2013 16:12:23 -0600
Message-ID: <51103247.2030906@ti.com>
References: <1359736726-10193-1-git-send-email-jon-hunter@ti.com> <1359736726-10193-3-git-send-email-jon-hunter@ti.com> <20130201215154.GV22517@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:42655 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755185Ab3BDWMf (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 4 Feb 2013 17:12:35 -0500
In-Reply-To: <20130201215154.GV22517@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Afzal Mohammed <afzal@ti.com>


On 02/01/2013 03:51 PM, Tony Lindgren wrote:

> How about let's fix this properly to start with so we don't add
> more blockers moving this code to drivers/bus?
> 
> Looks like gpmc_mem_init() gets called from gpmc_probe() so
> we can pass that information in pdev.

I have re-worked this a bit to use platform data. I have also updated
the logic for testing internal/external boot on omap2430 which is
different from omap2420 (according to the TRM). However, I have only
boot tested on omap2420. 

Do you know why this was changed in the first place? See below ...

http://permalink.gmane.org/gmane.linux.kernel.commits.head/95931

Heres what I have now ...


>From df2eebd3580f478f569241d294c2f810359fab6a Mon Sep 17 00:00:00 2001
From: Jon Hunter <jon-hunter@ti.com>
Date: Thu, 31 Jan 2013 15:56:08 -0600
Subject: [PATCH] ARM: OMAP2: Fix GPMC memory initialisation

OMAP2+ devices have an internal ROM that by default is typically mapped
to the first 1MB of the GPMC address space (0x0).

For OMAP24xx devices, GPMC chip-select 0 (CS0) may be mapped to address
0x0 instead of the internal ROM if configured for an external boot mode.
If configured for an internal boot mode then the internal ROM is mapped
to 0x0.

Currently, the function gpmc_mem_init() function reserves the first 1MB
of GPMC address space for the internal OMAP ROM. This prevents any
device (ethernet chip, flash memories, etc) from using this address
range. This causes the GPMC probe to fail on the OMAP2420 H4 when NOR
flash is mapped to address 0x0. Fix this by checking the SYS_BOOT pin
setting for OMAP24xx devices, to see the device is configured for
an internal or external boot and pass the amount of ROM mapped to
address 0x0 to the GPMC driver via platform data.

Please note that for OMAP3-5 devices, when booting from NOR or NAND
memories connected to CS0, these memories are always mapped to address
0x08000000 and so reserving this memory range does not present any
problems for these devices.

Signed-off-by: Jon Hunter <jon-hunter@ti.com>
---
 arch/arm/mach-omap2/gpmc.c |   53 +++++++++++++++++++++++++++++++++++---------
 arch/arm/mach-omap2/gpmc.h |    5 +++++
 2 files changed, 48 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
index a124849..71c0134 100644
--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -20,6 +20,7 @@
 #include <linux/err.h>
 #include <linux/clk.h>
 #include <linux/ioport.h>
+#include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <linux/io.h>
 #include <linux/module.h>
@@ -32,6 +33,7 @@
 
 #include "soc.h"
 #include "common.h"
+#include "control.h"
 #include "omap_device.h"
 #include "gpmc.h"
 
@@ -87,7 +89,6 @@
 
 #define GPMC_MEM_START		0x00000000
 #define GPMC_MEM_END		0x3FFFFFFF
-#define BOOT_ROM_SPACE		0x100000	/* 1MB */
 
 #define GPMC_CHUNK_SHIFT	24		/* 16 MB */
 #define GPMC_SECTION_SHIFT	28		/* 128 MB */
@@ -775,16 +776,11 @@ static void gpmc_mem_exit(void)
 
 }
 
-static int gpmc_mem_init(void)
+static int gpmc_mem_init(u32 offset)
 {
 	int cs, rc;
-	unsigned long boot_rom_space = 0;
 
-	/* never allocate the first page, to facilitate bug detection;
-	 * even if we didn't boot from ROM.
-	 */
-	boot_rom_space = BOOT_ROM_SPACE;
-	gpmc_mem_root.start = GPMC_MEM_START + boot_rom_space;
+	gpmc_mem_root.start = GPMC_MEM_START + offset;
 	gpmc_mem_root.end = GPMC_MEM_END;
 
 	/* Reserve all regions that has been set up by bootloader */
@@ -1124,6 +1120,12 @@ static int gpmc_probe(struct platform_device *pdev)
 	int rc;
 	u32 l;
 	struct resource *res;
+	struct gpmc_platform_data *pdata = pdev->dev.platform_data;
+
+	if (!pdata) {
+		dev_err(&pdev->dev, "%s: no platform data.\n", __func__);
+		return -ENODEV;
+	}
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (res == NULL)
@@ -1161,7 +1163,7 @@ static int gpmc_probe(struct platform_device *pdev)
 	dev_info(gpmc_dev, "GPMC revision %d.%d\n", GPMC_REVISION_MAJOR(l),
 		 GPMC_REVISION_MINOR(l));
 
-	rc = gpmc_mem_init();
+	rc = gpmc_mem_init(pdata->gpmc_rom_space);
 	if (IS_ERR_VALUE(rc)) {
 		clk_disable_unprepare(gpmc_l3_clk);
 		clk_put(gpmc_l3_clk);
@@ -1213,15 +1215,46 @@ static int __init omap_gpmc_init(void)
 {
 	struct omap_hwmod *oh;
 	struct platform_device *pdev;
+	struct gpmc_platform_data *pdata;
 	char *oh_name = "gpmc";
 
+	pdata = kzalloc(sizeof(*pdata), GFP_KERNEL);
+	if (!pdata) {
+		pr_err("%s: No memory for gpmc\n", __func__);
+		return -ENOMEM;
+	}
+
+	/*
+	 * The first 1MB of GPMC address space is mapped to the internal
+	 * ROM. OMAP2 devices are an exception to this where the first
+	 * 1MB may be mapped to the GPMC. OMAP2 devices that boot from
+	 * external memory devices, will map CS0 to the start of the
+	 * GPMC address space (0x0). We can test this by checking the
+	 * SYS_BOOT pins.
+	 *
+	 * OMAP2420 SYS_BOOT[3] = 1b, then GPMC CS0 is mapped to 0x0.
+	 * OMAP2430 SYS_BOOT[2:1] = 00b, then GPMC CS0 is mapped to 0x0.
+	 */
+	pdata->gpmc_rom_space = SZ_1M;
+
+	if (cpu_is_omap242x()) {
+		if (!(omap_ctrl_readl(OMAP24XX_CONTROL_STATUS) &
+		      OMAP2_SYSBOOT_3_MASK))
+			pdata->gpmc_rom_space = 0;
+	} else if (cpu_is_omap243x()) {
+		if (!(omap_ctrl_readl(OMAP24XX_CONTROL_STATUS) &
+		      (OMAP2_SYSBOOT_2_MASK | OMAP2_SYSBOOT_1_MASK)))
+			pdata->gpmc_rom_space = 0;
+	}
+
 	oh = omap_hwmod_lookup(oh_name);
 	if (!oh) {
 		pr_err("Could not look up %s\n", oh_name);
 		return -ENODEV;
 	}
 
-	pdev = omap_device_build(DEVICE_NAME, -1, oh, NULL, 0, NULL, 0, 0);
+	pdev = omap_device_build(DEVICE_NAME, -1, oh, pdata, sizeof(*pdata),
+				 NULL, 0, 0);
 	WARN(IS_ERR(pdev), "could not build omap_device for %s\n", oh_name);
 
 	return IS_ERR(pdev) ? PTR_ERR(pdev) : 0;
diff --git a/arch/arm/mach-omap2/gpmc.h b/arch/arm/mach-omap2/gpmc.h
index fe0a844..b33ef26 100644
--- a/arch/arm/mach-omap2/gpmc.h
+++ b/arch/arm/mach-omap2/gpmc.h
@@ -189,6 +189,11 @@ struct gpmc_device_timings {
 	bool we_xdelay;
 };
 
+/* GPMC platform data */
+struct gpmc_platform_data {
+	u32 gpmc_rom_space;
+};
+
 extern int gpmc_calc_timings(struct gpmc_timings *gpmc_t,
 				struct gpmc_device_timings *dev_t);
 
-- 
1.7.10.4

