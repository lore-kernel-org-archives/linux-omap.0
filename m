From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 12/23] omap3: Add support for flash on IGEP v2 board
Date: Wed, 17 Feb 2010 17:32:21 -0800
Message-ID: <20100218013220.32075.94439.stgit@baageli.muru.com>
References: <20100218013012.32075.43788.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:63343 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754414Ab0BRBba (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 17 Feb 2010 20:31:30 -0500
In-Reply-To: <20100218013012.32075.43788.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Enric Balletbo i Serra <eballetbo@iseebcn.com>, linux-omap@vger.kernel.org

From: Enric Balletbo i Serra <eballetbo@iseebcn.com>

This patch adds support for flashes on IGEP v2 boards. For now
only OneNAND is supported.

Signed-off-by: Enric Balletbo i Serra <eballetbo@iseebcn.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-igep0020.c |  101 ++++++++++++++++++++++++++++++++++
 1 files changed, 101 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-igep0020.c b/arch/arm/mach-omap2/board-igep0020.c
index f6899f9..8ed935c 100644
--- a/arch/arm/mach-omap2/board-igep0020.c
+++ b/arch/arm/mach-omap2/board-igep0020.c
@@ -29,6 +29,7 @@
 #include <plat/gpmc.h>
 #include <plat/usb.h>
 #include <plat/display.h>
+#include <plat/onenand.h>
 
 #include "mux.h"
 #include "hsmmc.h"
@@ -41,6 +42,105 @@
 #define IGEP2_GPIO_LED1_RED   	28
 #define IGEP2_GPIO_DVI_PUP	170
 
+#if defined(CONFIG_MTD_ONENAND_OMAP2) || \
+	defined(CONFIG_MTD_ONENAND_OMAP2_MODULE)
+
+#define ONENAND_MAP             0x20000000
+
+/* NAND04GR4E1A ( x2 Flash built-in COMBO POP MEMORY )
+ * Since the device is equipped with two DataRAMs, and two-plane NAND
+ * Flash memory array, these two component enables simultaneous program
+ * of 4KiB. Plane1 has only even blocks such as block0, block2, block4
+ * while Plane2 has only odd blocks such as block1, block3, block5.
+ * So MTD regards it as 4KiB page size and 256KiB block size 64*(2*2048)
+ */
+
+static struct mtd_partition igep2_onenand_partitions[] = {
+	{
+		.name           = "X-Loader",
+		.offset         = 0,
+		.size           = 2 * (64*(2*2048))
+	},
+	{
+		.name           = "U-Boot",
+		.offset         = MTDPART_OFS_APPEND,
+		.size           = 6 * (64*(2*2048)),
+	},
+	{
+		.name           = "Environment",
+		.offset         = MTDPART_OFS_APPEND,
+		.size           = 2 * (64*(2*2048)),
+	},
+	{
+		.name           = "Kernel",
+		.offset         = MTDPART_OFS_APPEND,
+		.size           = 12 * (64*(2*2048)),
+	},
+	{
+		.name           = "File System",
+		.offset         = MTDPART_OFS_APPEND,
+		.size           = MTDPART_SIZ_FULL,
+	},
+};
+
+static int igep2_onenand_setup(void __iomem *onenand_base, int freq)
+{
+       /* nothing is required to be setup for onenand as of now */
+       return 0;
+}
+
+static struct omap_onenand_platform_data igep2_onenand_data = {
+	.parts = igep2_onenand_partitions,
+	.nr_parts = ARRAY_SIZE(igep2_onenand_partitions),
+	.onenand_setup = igep2_onenand_setup,
+	.dma_channel	= -1,	/* disable DMA in OMAP OneNAND driver */
+};
+
+static struct platform_device igep2_onenand_device = {
+	.name		= "omap2-onenand",
+	.id		= -1,
+	.dev = {
+		.platform_data = &igep2_onenand_data,
+	},
+};
+
+void __init igep2_flash_init(void)
+{
+	u8		cs = 0;
+	u8		onenandcs = GPMC_CS_NUM + 1;
+
+	while (cs < GPMC_CS_NUM) {
+		u32 ret = 0;
+		ret = gpmc_cs_read_reg(cs, GPMC_CS_CONFIG1);
+
+		/* Check if NAND/oneNAND is configured */
+		if ((ret & 0xC00) == 0x800)
+			/* NAND found */
+			pr_err("IGEP v2: Unsupported NAND found\n");
+		else {
+			ret = gpmc_cs_read_reg(cs, GPMC_CS_CONFIG7);
+			if ((ret & 0x3F) == (ONENAND_MAP >> 24))
+				/* ONENAND found */
+				onenandcs = cs;
+		}
+		cs++;
+	}
+	if (onenandcs > GPMC_CS_NUM) {
+		pr_err("IGEP v2: Unable to find configuration in GPMC\n");
+		return;
+	}
+
+	if (onenandcs < GPMC_CS_NUM) {
+		igep2_onenand_data.cs = onenandcs;
+		if (platform_device_register(&igep2_onenand_device) < 0)
+			pr_err("IGEP v2: Unable to register OneNAND device\n");
+	}
+}
+
+#else
+void __init igep2_flash_init(void) {}
+#endif
+
 #if defined(CONFIG_SMSC911X) || defined(CONFIG_SMSC911X_MODULE)
 
 #include <linux/smsc911x.h>
@@ -314,6 +414,7 @@ static void __init igep2_init(void)
 	usb_musb_init();
 	usb_ehci_init(&ehci_pdata);
 
+	igep2_flash_init();
 	igep2_display_init();
 	igep2_init_smsc911x();
 

