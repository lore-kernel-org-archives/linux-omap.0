From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 3/9] omap1: Use gen_nand
Date: Tue, 08 Dec 2009 16:50:31 -0800
Message-ID: <20091209005030.5944.87470.stgit@localhost>
References: <20091209004630.5944.40334.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:52582 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967019AbZLIAuc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Dec 2009 19:50:32 -0500
In-Reply-To: <20091209004630.5944.40334.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Imre Deak <imre.deak@nokia.com>, Brian Swetland <swetland@google.com>, Kevin Hilman <kjh@hilman.org>, linux-omap@vger.kernel.org, Ladislav Michl <ladis@linux-mips.org>

From: Ladislav Michl <ladis@linux-mips.org>

Since omapnand driver never find its way into mainline, switch to gen_nand instead.
Following patch is compile tested only, but it is based on code I wrote for
NetStar board and runtime tested it there.

Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
Cc: Imre Deak <imre.deak@nokia.com>
Cc: Brian Swetland <swetland@google.com>
Cc: Kevin Hilman <kjh@hilman.org>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap1/board-fsample.c  |   50 ++++++++++++++++++++++--------
 arch/arm/mach-omap1/board-h2.c       |   49 ++++++++++++++++++++++++------
 arch/arm/mach-omap1/board-h3.c       |   56 ++++++++++++++++++++++++----------
 arch/arm/mach-omap1/board-perseus2.c |   48 ++++++++++++++++++++++-------
 4 files changed, 152 insertions(+), 51 deletions(-)

diff --git a/arch/arm/mach-omap1/board-fsample.c b/arch/arm/mach-omap1/board-fsample.c
index 91e7b2f..7e70c3c 100644
--- a/arch/arm/mach-omap1/board-fsample.c
+++ b/arch/arm/mach-omap1/board-fsample.c
@@ -31,7 +31,6 @@
 #include <mach/gpio.h>
 #include <plat/mux.h>
 #include <plat/fpga.h>
-#include <plat/nand.h>
 #include <plat/keypad.h>
 #include <plat/common.h>
 #include <plat/board.h>
@@ -174,8 +173,40 @@ static struct platform_device nor_device = {
 	.resource	= &nor_resource,
 };
 
-static struct omap_nand_platform_data nand_data = {
-	.options	= NAND_SAMSUNG_LP_OPTIONS,
+static void nand_cmd_ctl(struct mtd_info *mtd, int cmd,	unsigned int ctrl)
+{
+	struct nand_chip *this = mtd->priv;
+	unsigned long mask;
+
+	if (cmd == NAND_CMD_NONE)
+		return;
+
+	mask = (ctrl & NAND_CLE) ? 0x02 : 0;
+	if (ctrl & NAND_ALE)
+		mask |= 0x04;
+	writeb(cmd, (unsigned long)this->IO_ADDR_W | mask);
+}
+
+#define FSAMPLE_NAND_RB_GPIO_PIN	62
+
+static int nand_dev_ready(struct mtd_info *mtd)
+{
+	return gpio_get_value(FSAMPLE_NAND_RB_GPIO_PIN);
+}
+
+static const char *part_probes[] = { "cmdlinepart", NULL };
+
+static struct platform_nand_data nand_data = {
+	.chip	= {
+		.nr_chips		= 1,
+		.chip_offset		= 0,
+		.options		= NAND_SAMSUNG_LP_OPTIONS,
+		.part_probe_types	= part_probes,
+	},
+	.ctrl	= {
+		.cmd_ctrl	= nand_cmd_ctl,
+		.dev_ready	= nand_dev_ready,
+	},
 };
 
 static struct resource nand_resource = {
@@ -185,7 +216,7 @@ static struct resource nand_resource = {
 };
 
 static struct platform_device nand_device = {
-	.name		= "omapnand",
+	.name		= "gen_nand",
 	.id		= 0,
 	.dev		= {
 		.platform_data	= &nand_data,
@@ -243,13 +274,6 @@ static struct platform_device *devices[] __initdata = {
 	&lcd_device,
 };
 
-#define P2_NAND_RB_GPIO_PIN	62
-
-static int nand_dev_ready(struct omap_nand_platform_data *data)
-{
-	return gpio_get_value(P2_NAND_RB_GPIO_PIN);
-}
-
 static struct omap_lcd_config fsample_lcd_config __initdata = {
 	.ctrl_name	= "internal",
 };
@@ -260,9 +284,9 @@ static struct omap_board_config_kernel fsample_config[] = {
 
 static void __init omap_fsample_init(void)
 {
-	if (gpio_request(P2_NAND_RB_GPIO_PIN, "NAND ready") < 0)
+	if (gpio_request(FSAMPLE_NAND_RB_GPIO_PIN, "NAND ready") < 0)
 		BUG();
-	nand_data.dev_ready = nand_dev_ready;
+	gpio_direction_input(FSAMPLE_NAND_RB_GPIO_PIN);
 
 	omap_cfg_reg(L3_1610_FLASH_CS2B_OE);
 	omap_cfg_reg(M8_1610_FLASH_CS2B_WE);
diff --git a/arch/arm/mach-omap1/board-h2.c b/arch/arm/mach-omap1/board-h2.c
index eeafe6e..fa7cece 100644
--- a/arch/arm/mach-omap1/board-h2.c
+++ b/arch/arm/mach-omap1/board-h2.c
@@ -41,7 +41,6 @@
 #include <plat/mux.h>
 #include <plat/dma.h>
 #include <plat/tc.h>
-#include <plat/nand.h>
 #include <plat/irda.h>
 #include <plat/usb.h>
 #include <plat/keypad.h>
@@ -180,11 +179,43 @@ static struct mtd_partition h2_nand_partitions[] = {
 	},
 };
 
-/* dip switches control NAND chip access:  8 bit, 16 bit, or neither */
-static struct omap_nand_platform_data h2_nand_data = {
-	.options	= NAND_SAMSUNG_LP_OPTIONS,
-	.parts		= h2_nand_partitions,
-	.nr_parts	= ARRAY_SIZE(h2_nand_partitions),
+static void h2_nand_cmd_ctl(struct mtd_info *mtd, int cmd, unsigned int ctrl)
+{
+	struct nand_chip *this = mtd->priv;
+	unsigned long mask;
+
+	if (cmd == NAND_CMD_NONE)
+		return;
+
+	mask = (ctrl & NAND_CLE) ? 0x02 : 0;
+	if (ctrl & NAND_ALE)
+		mask |= 0x04;
+	writeb(cmd, (unsigned long)this->IO_ADDR_W | mask);
+}
+
+#define H2_NAND_RB_GPIO_PIN	62
+
+static int h2_nand_dev_ready(struct mtd_info *mtd)
+{
+	return gpio_get_value(H2_NAND_RB_GPIO_PIN);
+}
+
+static const char *h2_part_probes[] = { "cmdlinepart", NULL };
+
+struct platform_nand_data h2_nand_platdata = {
+	.chip	= {
+		.nr_chips		= 1,
+		.chip_offset		= 0,
+		.nr_partitions		= ARRAY_SIZE(h2_nand_partitions),
+		.partitions		= h2_nand_partitions,
+		.options		= NAND_SAMSUNG_LP_OPTIONS,
+		.part_probe_types	= h2_part_probes,
+	},
+	.ctrl	= {
+		.cmd_ctrl	= h2_nand_cmd_ctl,
+		.dev_ready	= h2_nand_dev_ready,
+
+	},
 };
 
 static struct resource h2_nand_resource = {
@@ -192,10 +223,10 @@ static struct resource h2_nand_resource = {
 };
 
 static struct platform_device h2_nand_device = {
-	.name		= "omapnand",
+	.name		= "gen_nand",
 	.id		= 0,
 	.dev		= {
-		.platform_data	= &h2_nand_data,
+		.platform_data	= &h2_nand_platdata,
 	},
 	.num_resources	= 1,
 	.resource	= &h2_nand_resource,
@@ -378,8 +409,6 @@ static struct omap_board_config_kernel h2_config[] __initdata = {
 	{ OMAP_TAG_LCD,		&h2_lcd_config },
 };
 
-#define H2_NAND_RB_GPIO_PIN	62
-
 static void __init h2_init(void)
 {
 	/* Here we assume the NOR boot config:  NOR on CS3 (possibly swapped
diff --git a/arch/arm/mach-omap1/board-h3.c b/arch/arm/mach-omap1/board-h3.c
index e0aee66..6a7f9c3 100644
--- a/arch/arm/mach-omap1/board-h3.c
+++ b/arch/arm/mach-omap1/board-h3.c
@@ -43,7 +43,6 @@
 #include <mach/irqs.h>
 #include <plat/mux.h>
 #include <plat/tc.h>
-#include <plat/nand.h>
 #include <plat/usb.h>
 #include <plat/keypad.h>
 #include <plat/dma.h>
@@ -182,11 +181,43 @@ static struct mtd_partition nand_partitions[] = {
 	},
 };
 
-/* dip switches control NAND chip access:  8 bit, 16 bit, or neither */
-static struct omap_nand_platform_data nand_data = {
-	.options	= NAND_SAMSUNG_LP_OPTIONS,
-	.parts		= nand_partitions,
-	.nr_parts	= ARRAY_SIZE(nand_partitions),
+static void nand_cmd_ctl(struct mtd_info *mtd, int cmd, unsigned int ctrl)
+{
+	struct nand_chip *this = mtd->priv;
+	unsigned long mask;
+
+	if (cmd == NAND_CMD_NONE)
+		return;
+
+	mask = (ctrl & NAND_CLE) ? 0x02 : 0;
+	if (ctrl & NAND_ALE)
+		mask |= 0x04;
+	writeb(cmd, (unsigned long)this->IO_ADDR_W | mask);
+}
+
+#define H3_NAND_RB_GPIO_PIN	10
+
+static int nand_dev_ready(struct mtd_info *mtd)
+{
+	return gpio_get_value(H3_NAND_RB_GPIO_PIN);
+}
+
+static const char *part_probes[] = { "cmdlinepart", NULL };
+
+struct platform_nand_data nand_platdata = {
+	.chip	= {
+		.nr_chips		= 1,
+		.chip_offset		= 0,
+		.nr_partitions		= ARRAY_SIZE(nand_partitions),
+		.partitions		= nand_partitions,
+		.options		= NAND_SAMSUNG_LP_OPTIONS,
+		.part_probe_types	= part_probes,
+	},
+	.ctrl	= {
+		.cmd_ctrl	= nand_cmd_ctl,
+		.dev_ready	= nand_dev_ready,
+
+	},
 };
 
 static struct resource nand_resource = {
@@ -194,10 +225,10 @@ static struct resource nand_resource = {
 };
 
 static struct platform_device nand_device = {
-	.name		= "omapnand",
+	.name		= "gen_nand",
 	.id		= 0,
 	.dev		= {
-		.platform_data	= &nand_data,
+		.platform_data	= &nand_platdata,
 	},
 	.num_resources	= 1,
 	.resource	= &nand_resource,
@@ -342,13 +373,6 @@ static struct i2c_board_info __initdata h3_i2c_board_info[] = {
 	},
 };
 
-#define H3_NAND_RB_GPIO_PIN	10
-
-static int nand_dev_ready(struct omap_nand_platform_data *data)
-{
-	return gpio_get_value(H3_NAND_RB_GPIO_PIN);
-}
-
 static void __init h3_init(void)
 {
 	/* Here we assume the NOR boot config:  NOR on CS3 (possibly swapped
@@ -366,7 +390,7 @@ static void __init h3_init(void)
 	nand_resource.end += SZ_4K - 1;
 	if (gpio_request(H3_NAND_RB_GPIO_PIN, "NAND ready") < 0)
 		BUG();
-	nand_data.dev_ready = nand_dev_ready;
+	gpio_direction_input(H3_NAND_RB_GPIO_PIN);
 
 	/* GPIO10 Func_MUX_CTRL reg bit 29:27, Configure V2 to mode1 as GPIO */
 	/* GPIO10 pullup/down register, Enable pullup on GPIO10 */
diff --git a/arch/arm/mach-omap1/board-perseus2.c b/arch/arm/mach-omap1/board-perseus2.c
index b9ea312..1387a4f 100644
--- a/arch/arm/mach-omap1/board-perseus2.c
+++ b/arch/arm/mach-omap1/board-perseus2.c
@@ -31,7 +31,6 @@
 #include <mach/gpio.h>
 #include <plat/mux.h>
 #include <plat/fpga.h>
-#include <plat/nand.h>
 #include <plat/keypad.h>
 #include <plat/common.h>
 #include <plat/board.h>
@@ -141,8 +140,40 @@ static struct platform_device nor_device = {
 	.resource	= &nor_resource,
 };
 
-static struct omap_nand_platform_data nand_data = {
-	.options	= NAND_SAMSUNG_LP_OPTIONS,
+static void nand_cmd_ctl(struct mtd_info *mtd, int cmd,	unsigned int ctrl)
+{
+	struct nand_chip *this = mtd->priv;
+	unsigned long mask;
+
+	if (cmd == NAND_CMD_NONE)
+		return;
+
+	mask = (ctrl & NAND_CLE) ? 0x02 : 0;
+	if (ctrl & NAND_ALE)
+		mask |= 0x04;
+	writeb(cmd, (unsigned long)this->IO_ADDR_W | mask);
+}
+
+#define P2_NAND_RB_GPIO_PIN	62
+
+static int nand_dev_ready(struct mtd_info *mtd)
+{
+	return gpio_get_value(P2_NAND_RB_GPIO_PIN);
+}
+
+static const char *part_probes[] = { "cmdlinepart", NULL };
+
+static struct platform_nand_data nand_data = {
+	.chip	= {
+		.nr_chips		= 1,
+		.chip_offset		= 0,
+		.options		= NAND_SAMSUNG_LP_OPTIONS,
+		.part_probe_types	= part_probes,
+	},
+	.ctrl	= {
+		.cmd_ctrl	= nand_cmd_ctl,
+		.dev_ready	= nand_dev_ready,
+	},
 };
 
 static struct resource nand_resource = {
@@ -152,7 +183,7 @@ static struct resource nand_resource = {
 };
 
 static struct platform_device nand_device = {
-	.name		= "omapnand",
+	.name		= "gen_nand",
 	.id		= 0,
 	.dev		= {
 		.platform_data	= &nand_data,
@@ -211,13 +242,6 @@ static struct platform_device *devices[] __initdata = {
 	&lcd_device,
 };
 
-#define P2_NAND_RB_GPIO_PIN	62
-
-static int nand_dev_ready(struct omap_nand_platform_data *data)
-{
-	return gpio_get_value(P2_NAND_RB_GPIO_PIN);
-}
-
 static struct omap_lcd_config perseus2_lcd_config __initdata = {
 	.ctrl_name	= "internal",
 };
@@ -230,7 +254,7 @@ static void __init omap_perseus2_init(void)
 {
 	if (gpio_request(P2_NAND_RB_GPIO_PIN, "NAND ready") < 0)
 		BUG();
-	nand_data.dev_ready = nand_dev_ready;
+	gpio_direction_input(P2_NAND_RB_GPIO_PIN);
 
 	omap_cfg_reg(L3_1610_FLASH_CS2B_OE);
 	omap_cfg_reg(M8_1610_FLASH_CS2B_WE);

