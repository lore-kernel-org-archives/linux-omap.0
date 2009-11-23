From: Ladislav Michl <Ladislav.Michl@seznam.cz>
Subject: [PATCH] [OMAP1] use gen_nand
Date: Mon, 23 Nov 2009 13:45:45 +0100
Message-ID: <20091123124545.GA31420@localhost.localdomain>
Reply-To: Ladislav Michl <ladis@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.seznam.cz ([77.75.72.43]:33336 "EHLO smtp.seznam.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756489AbZKWLpn (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 23 Nov 2009 06:45:43 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Imre Deak <imre.deak@nokia.com>, Brian Swetland <swetland@google.com>, Kevin Hilman <kjh@hilman.org>

Since omapnand driver never find its way into mainline, switch to gen_nand instead.
Following patch is compile tested only, but it is based on code I wrote for
NetStar board and runtime tested it there.

Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
Cc: Imre Deak <imre.deak@nokia.com>
Cc: Brian Swetland <swetland@google.com>
Cc: Kevin Hilman <kjh@hilman.org>

diff --git a/arch/arm/mach-omap1/board-fsample.c b/arch/arm/mach-omap1/board-fsample.c
index f4b72c1..8da8c64 100644
--- a/arch/arm/mach-omap1/board-fsample.c
+++ b/arch/arm/mach-omap1/board-fsample.c
@@ -30,7 +30,6 @@
 #include <mach/gpio.h>
 #include <plat/mux.h>
 #include <plat/fpga.h>
-#include <plat/nand.h>
 #include <plat/keypad.h>
 #include <plat/common.h>
 #include <plat/board.h>
@@ -167,8 +166,40 @@ static struct platform_device nor_device = {
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
@@ -178,7 +209,7 @@ static struct resource nand_resource = {
 };
 
 static struct platform_device nand_device = {
-	.name		= "omapnand",
+	.name		= "gen_nand",
 	.id		= 0,
 	.dev		= {
 		.platform_data	= &nand_data,
@@ -233,13 +264,6 @@ static struct platform_device *devices[] __initdata = {
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
@@ -250,9 +274,9 @@ static struct omap_board_config_kernel fsample_config[] = {
 
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
index 89ba8ec..283a6f2 100644
--- a/arch/arm/mach-omap1/board-h2.c
+++ b/arch/arm/mach-omap1/board-h2.c
@@ -40,7 +40,6 @@
 #include <plat/mux.h>
 #include <plat/dma.h>
 #include <plat/tc.h>
-#include <plat/nand.h>
 #include <plat/irda.h>
 #include <plat/usb.h>
 #include <plat/keypad.h>
@@ -179,11 +178,43 @@ static struct mtd_partition h2_nand_partitions[] = {
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
@@ -191,10 +222,10 @@ static struct resource h2_nand_resource = {
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
@@ -368,8 +399,6 @@ static struct omap_board_config_kernel h2_config[] __initdata = {
 	{ OMAP_TAG_LCD,		&h2_lcd_config },
 };
 
-#define H2_NAND_RB_GPIO_PIN	62
-
 static void __init h2_init(void)
 {
 	/* Here we assume the NOR boot config:  NOR on CS3 (possibly swapped
diff --git a/arch/arm/mach-omap1/board-h3.c b/arch/arm/mach-omap1/board-h3.c
index f5cc0a7..f96cd1e 100644
--- a/arch/arm/mach-omap1/board-h3.c
+++ b/arch/arm/mach-omap1/board-h3.c
@@ -42,7 +42,6 @@
 #include <mach/irqs.h>
 #include <plat/mux.h>
 #include <plat/tc.h>
-#include <plat/nand.h>
 #include <plat/usb.h>
 #include <plat/keypad.h>
 #include <plat/dma.h>
@@ -181,11 +180,43 @@ static struct mtd_partition nand_partitions[] = {
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
@@ -193,10 +224,10 @@ static struct resource nand_resource = {
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
@@ -332,13 +363,6 @@ static struct i2c_board_info __initdata h3_i2c_board_info[] = {
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
@@ -356,7 +380,7 @@ static void __init h3_init(void)
 	nand_resource.end += SZ_4K - 1;
 	if (gpio_request(H3_NAND_RB_GPIO_PIN, "NAND ready") < 0)
 		BUG();
-	nand_data.dev_ready = nand_dev_ready;
+	gpio_direction_input(H3_NAND_RB_GPIO_PIN);
 
 	/* GPIO10 Func_MUX_CTRL reg bit 29:27, Configure V2 to mode1 as GPIO */
 	/* GPIO10 pullup/down register, Enable pullup on GPIO10 */
diff --git a/arch/arm/mach-omap1/board-perseus2.c b/arch/arm/mach-omap1/board-perseus2.c
index ca7df1e..dba0f7b 100644
--- a/arch/arm/mach-omap1/board-perseus2.c
+++ b/arch/arm/mach-omap1/board-perseus2.c
@@ -30,7 +30,6 @@
 #include <mach/gpio.h>
 #include <plat/mux.h>
 #include <plat/fpga.h>
-#include <plat/nand.h>
 #include <plat/keypad.h>
 #include <plat/common.h>
 #include <plat/board.h>
@@ -134,8 +133,40 @@ static struct platform_device nor_device = {
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
@@ -145,7 +176,7 @@ static struct resource nand_resource = {
 };
 
 static struct platform_device nand_device = {
-	.name		= "omapnand",
+	.name		= "gen_nand",
 	.id		= 0,
 	.dev		= {
 		.platform_data	= &nand_data,
@@ -201,13 +232,6 @@ static struct platform_device *devices[] __initdata = {
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
@@ -220,7 +244,7 @@ static void __init omap_perseus2_init(void)
 {
 	if (gpio_request(P2_NAND_RB_GPIO_PIN, "NAND ready") < 0)
 		BUG();
-	nand_data.dev_ready = nand_dev_ready;
+	gpio_direction_input(P2_NAND_RB_GPIO_PIN);
 
 	omap_cfg_reg(L3_1610_FLASH_CS2B_OE);
 	omap_cfg_reg(M8_1610_FLASH_CS2B_WE);
