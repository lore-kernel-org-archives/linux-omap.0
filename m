From: Afzal Mohammed <afzal@ti.com>
Subject: [PATCH v2 05/10] ARM: OMAP2+: gpmc-onenand: provide memory as resource
Date: Wed, 13 Jun 2012 17:03:27 +0530
Message-ID: <0f8bcea7d8fdf0a7b85cfc5a8856bb7bad28826b.1339586624.git.afzal@ti.com>
References: <cover.1339586624.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:45384 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753726Ab2FMLtE (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 13 Jun 2012 07:49:04 -0400
In-Reply-To: <cover.1339586624.git.afzal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, artem.bityutskiy@linux.intel.com, linux-omap@vger.kernel.org, linux-mtd@lists.infradead.org
Cc: ivan.djelic@parrot.com, Afzal Mohammed <afzal@ti.com>

Currently omap onenand driver invokes gpmc_cs_request, obtains address
space allocated by gpmc to onenand. Remove this, instead use resource
structure; this is now updated with address space for onenand by gpmc
initialization with the help of gpmc_cs_request. And remove usage of
gpmc_cs_request in onenand driver.

This helps in smooth migration of gpmc to driver.

Signed-off-by: Afzal Mohammed <afzal@ti.com>
---
 arch/arm/mach-omap2/gpmc-onenand.c |   23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/gpmc-onenand.c b/arch/arm/mach-omap2/gpmc-onenand.c
index a0fa9bb..71d7c07 100644
--- a/arch/arm/mach-omap2/gpmc-onenand.c
+++ b/arch/arm/mach-omap2/gpmc-onenand.c
@@ -23,11 +23,19 @@
 #include <plat/board.h>
 #include <plat/gpmc.h>
 
+#define	ONENAND_IO_SIZE	SZ_128K
+
 static struct omap_onenand_platform_data *gpmc_onenand_data;
 
+static struct resource gpmc_onenand_resource = {
+	.flags		= IORESOURCE_MEM,
+};
+
 static struct platform_device gpmc_onenand_device = {
 	.name		= "omap2-onenand",
 	.id		= -1,
+	.num_resources	= 1,
+	.resource	= &gpmc_onenand_resource,
 };
 
 static int omap2_onenand_set_async_mode(int cs, void __iomem *onenand_base)
@@ -390,6 +398,8 @@ static int gpmc_onenand_setup(void __iomem *onenand_base, int *freq_ptr)
 
 void __init gpmc_onenand_init(struct omap_onenand_platform_data *_onenand_data)
 {
+	int err;
+
 	gpmc_onenand_data = _onenand_data;
 	gpmc_onenand_data->onenand_setup = gpmc_onenand_setup;
 	gpmc_onenand_device.dev.platform_data = gpmc_onenand_data;
@@ -401,8 +411,19 @@ void __init gpmc_onenand_init(struct omap_onenand_platform_data *_onenand_data)
 		gpmc_onenand_data->flags |= ONENAND_SYNC_READ;
 	}
 
+	err = gpmc_cs_request(gpmc_onenand_data->cs, ONENAND_IO_SIZE,
+				(unsigned long *)&gpmc_onenand_resource.start);
+	if (err < 0) {
+		pr_err("%s: Cannot request GPMC CS\n", __func__);
+		return;
+	}
+
+	gpmc_onenand_resource.end = gpmc_onenand_resource.start +
+							ONENAND_IO_SIZE - 1;
+
 	if (platform_device_register(&gpmc_onenand_device) < 0) {
-		printk(KERN_ERR "Unable to register OneNAND device\n");
+		pr_err("%s: Unable to register OneNAND device\n", __func__);
+		gpmc_cs_free(gpmc_onenand_data->cs);
 		return;
 	}
 }
-- 
1.7.10.2

