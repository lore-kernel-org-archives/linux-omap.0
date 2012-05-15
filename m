From: Afzal Mohammed <afzal@ti.com>
Subject: [PATCH 2/3] ARM: OMAP2+: gpmc-nand: Modify Interrupt handling
Date: Tue, 15 May 2012 20:08:40 +0530
Message-ID: <04d71e243e5896f06f048fdc5259c3257815f34d.1337090835.git.afzal@ti.com>
References: <cover.1337090835.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:39822 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756104Ab2EOOzR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 15 May 2012 10:55:17 -0400
In-Reply-To: <cover.1337090835.git.afzal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, dwmw2@infradead.org, artem.bityutskiy@linux.intel.com, dedekind1@gmail.com, linux-omap@vger.kernel.org, linux-mtd@lists.infradead.org
Cc: ivan.djelic@parrot.com, Afzal Mohammed <afzal@ti.com>

Now GPMC provides its client with interrupts that can be handled
using the standard interrupt API. Modify GPMC NAND setup to work
with it.

Also disable write protect in GPMC code, so that NAND driver can
be ignorant of GPMC configuration.

This helps in smooth migration of GPMC to driver.

Signed-off-by: Afzal Mohammed <afzal@ti.com>
---
 arch/arm/mach-omap2/gpmc-nand.c |   28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap2/gpmc-nand.c b/arch/arm/mach-omap2/gpmc-nand.c
index c0320d2..e58f450 100644
--- a/arch/arm/mach-omap2/gpmc-nand.c
+++ b/arch/arm/mach-omap2/gpmc-nand.c
@@ -21,15 +21,25 @@
 #include <plat/board.h>
 #include <plat/gpmc.h>
 
-static struct resource gpmc_nand_resource = {
-	.flags		= IORESOURCE_MEM,
+static struct resource gpmc_nand_resource[] = {
+	{
+		.flags		= IORESOURCE_MEM,
+	},
+	{
+		.name		= "fifoevent",
+		.flags		= IORESOURCE_IRQ,
+	},
+	{
+		.name		= "terminalcount",
+		.flags		= IORESOURCE_IRQ,
+	},
 };
 
 static struct platform_device gpmc_nand_device = {
 	.name		= "omap2-nand",
 	.id		= 0,
-	.num_resources	= 1,
-	.resource	= &gpmc_nand_resource,
+	.num_resources	= ARRAY_SIZE(gpmc_nand_resource),
+	.resource	= gpmc_nand_resource,
 };
 
 static int omap2_nand_gpmc_retime(struct omap_nand_platform_data *gpmc_nand_data)
@@ -75,6 +85,7 @@ static int omap2_nand_gpmc_retime(struct omap_nand_platform_data *gpmc_nand_data
 		gpmc_cs_configure(gpmc_nand_data->cs, GPMC_CONFIG_DEV_SIZE, 0);
 	gpmc_cs_configure(gpmc_nand_data->cs,
 			GPMC_CONFIG_DEV_TYPE, GPMC_DEVICETYPE_NAND);
+	gpmc_cs_configure(gpmc_nand_data->cs, GPMC_CONFIG_WP, 0);
 	err = gpmc_cs_set_timings(gpmc_nand_data->cs, &t);
 	if (err)
 		return err;
@@ -90,14 +101,19 @@ int __init gpmc_nand_init(struct omap_nand_platform_data *gpmc_nand_data)
 	gpmc_nand_device.dev.platform_data = gpmc_nand_data;
 
 	err = gpmc_cs_request(gpmc_nand_data->cs, NAND_IO_SIZE,
-				(unsigned long *)&gpmc_nand_resource.start);
+				(unsigned long *)&gpmc_nand_resource[0].start);
 	if (err < 0) {
 		dev_err(dev, "Cannot request GPMC CS\n");
 		return err;
 	}
 
-	gpmc_nand_resource.end = gpmc_nand_resource.start + NAND_IO_SIZE - 1;
+	gpmc_nand_resource[0].end = gpmc_nand_resource[0].start +
+							NAND_IO_SIZE - 1;
 
+	gpmc_nand_resource[1].start =
+				gpmc_get_client_irq(GPMC_IRQ_FIFOEVENTENABLE);
+	gpmc_nand_resource[2].start =
+				gpmc_get_client_irq(GPMC_IRQ_COUNT_EVENT);
 	 /* Set timings in GPMC */
 	err = omap2_nand_gpmc_retime(gpmc_nand_data);
 	if (err < 0) {
-- 
1.7.10

