From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v8 00/11] OMAP: GPIO: Implement GPIO as platform device
Date: Tue, 7 Dec 2010 16:54:52 -0800
Message-ID: <20101208005452.GG17435@atomide.com>
References: <1290689318-10191-1-git-send-email-charu@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:43376 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756659Ab0LHAzD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Dec 2010 19:55:03 -0500
Content-Disposition: inline
In-Reply-To: <1290689318-10191-1-git-send-email-charu@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Varadarajan, Charulatha" <charu@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, khilman@deeprootsystems.com, paul@pwsan.com, b-cousson@ti.com, p-basak2@ti.com, Cory Maccarrone <darkstar6262@gmail.com>, Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>

* Varadarajan, Charulatha <charu@ti.com> [101125 04:39]:
> Implement OMAP GPIO module in platform device model. OMAP2+ specific GPIO
> module uses hwmod FW.

I'll add the following patch underneath this series as otherwise some
gpio_request calls will fail after this series.

Regards,

Tony


From: Tony Lindgren <tony@atomide.com>
Date: Tue, 7 Dec 2010 16:26:55 -0800
Subject: [PATCH] omap: Fix gpio_request calls to happen as arch_initcall

Looks like some boards are calling gpio_request from init_irq.
This will make the request_irq fail, as GPIO will be initialized
as postcore_initcall.

Reported-by: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/mach-omap1/board-fsample.c b/arch/arm/mach-omap1/board-fsample.c
index 149fdd3..295ab67 100644
--- a/arch/arm/mach-omap1/board-fsample.c
+++ b/arch/arm/mach-omap1/board-fsample.c
@@ -120,6 +120,15 @@ static struct resource smc91x_resources[] = {
 	},
 };
 
+static void __init fsample_init_smc91x(void)
+{
+	fpga_write(1, H2P2_DBG_FPGA_LAN_RESET);
+	mdelay(50);
+	fpga_write(fpga_read(H2P2_DBG_FPGA_LAN_RESET) & ~1,
+		   H2P2_DBG_FPGA_LAN_RESET);
+	mdelay(50);
+}
+
 static struct mtd_partition nor_partitions[] = {
 	/* bootloader (U-Boot, etc) in first sector */
 	{
@@ -285,6 +294,8 @@ static struct omap_board_config_kernel fsample_config[] = {
 
 static void __init omap_fsample_init(void)
 {
+	fsample_init_smc91x();
+
 	if (gpio_request(FSAMPLE_NAND_RB_GPIO_PIN, "NAND ready") < 0)
 		BUG();
 	gpio_direction_input(FSAMPLE_NAND_RB_GPIO_PIN);
@@ -312,21 +323,11 @@ static void __init omap_fsample_init(void)
 	omap_register_i2c_bus(1, 100, NULL, 0);
 }
 
-static void __init fsample_init_smc91x(void)
-{
-	fpga_write(1, H2P2_DBG_FPGA_LAN_RESET);
-	mdelay(50);
-	fpga_write(fpga_read(H2P2_DBG_FPGA_LAN_RESET) & ~1,
-		   H2P2_DBG_FPGA_LAN_RESET);
-	mdelay(50);
-}
-
 static void __init omap_fsample_init_irq(void)
 {
 	omap1_init_common_hw();
 	omap_init_irq();
 	omap_gpio_init();
-	fsample_init_smc91x();
 }
 
 /* Only FPGA needs to be mapped here. All others are done with ioremap */
diff --git a/arch/arm/mach-omap1/board-h2.c b/arch/arm/mach-omap1/board-h2.c
index 197adb4..dd35efd 100644
--- a/arch/arm/mach-omap1/board-h2.c
+++ b/arch/arm/mach-omap1/board-h2.c
@@ -375,7 +375,6 @@ static void __init h2_init_irq(void)
 	omap1_init_common_hw();
 	omap_init_irq();
 	omap_gpio_init();
-	h2_init_smc91x();
 }
 
 static struct omap_usb_config h2_usb_config __initdata = {
@@ -403,6 +402,8 @@ static struct omap_board_config_kernel h2_config[] __initdata = {
 
 static void __init h2_init(void)
 {
+	h2_init_smc91x();
+
 	/* Here we assume the NOR boot config:  NOR on CS3 (possibly swapped
 	 * to address 0 by a dip switch), NAND on CS2B.  The NAND driver will
 	 * notice whether a NAND chip is enabled at probe time.
diff --git a/arch/arm/mach-omap1/board-h3.c b/arch/arm/mach-omap1/board-h3.c
index 9126e3e..7871919 100644
--- a/arch/arm/mach-omap1/board-h3.c
+++ b/arch/arm/mach-omap1/board-h3.c
@@ -264,6 +264,15 @@ static struct platform_device smc91x_device = {
 	.resource	= smc91x_resources,
 };
 
+static void __init h3_init_smc91x(void)
+{
+	omap_cfg_reg(W15_1710_GPIO40);
+	if (gpio_request(40, "SMC91x irq") < 0) {
+		printk("Error requesting gpio 40 for smc91x irq\n");
+		return;
+	}
+}
+
 #define GPTIMER_BASE		0xFFFB1400
 #define GPTIMER_REGS(x)	(0xFFFB1400 + (x * 0x800))
 #define GPTIMER_REGS_SIZE	0x46
@@ -376,6 +385,8 @@ static struct i2c_board_info __initdata h3_i2c_board_info[] = {
 
 static void __init h3_init(void)
 {
+	h3_init_smc91x();
+
 	/* Here we assume the NOR boot config:  NOR on CS3 (possibly swapped
 	 * to address 0 by a dip switch), NAND on CS2B.  The NAND driver will
 	 * notice whether a NAND chip is enabled at probe time.
@@ -422,21 +433,11 @@ static void __init h3_init(void)
 	h3_mmc_init();
 }
 
-static void __init h3_init_smc91x(void)
-{
-	omap_cfg_reg(W15_1710_GPIO40);
-	if (gpio_request(40, "SMC91x irq") < 0) {
-		printk("Error requesting gpio 40 for smc91x irq\n");
-		return;
-	}
-}
-
 static void __init h3_init_irq(void)
 {
 	omap1_init_common_hw();
 	omap_init_irq();
 	omap_gpio_init();
-	h3_init_smc91x();
 }
 
 static void __init h3_map_io(void)
diff --git a/arch/arm/mach-omap1/board-innovator.c b/arch/arm/mach-omap1/board-innovator.c
index dc2b86f..0feaa67 100644
--- a/arch/arm/mach-omap1/board-innovator.c
+++ b/arch/arm/mach-omap1/board-innovator.c
@@ -296,7 +296,6 @@ static void __init innovator_init_irq(void)
 		omap1510_fpga_init_irq();
 	}
 #endif
-	innovator_init_smc91x();
 }
 
 #ifdef CONFIG_ARCH_OMAP15XX
@@ -387,6 +386,8 @@ static struct omap_board_config_kernel innovator_config[] = {
 
 static void __init innovator_init(void)
 {
+	innovator_init_smc91x();
+
 #ifdef CONFIG_ARCH_OMAP15XX
 	if (cpu_is_omap1510()) {
 		unsigned char reg;
diff --git a/arch/arm/mach-omap1/board-osk.c b/arch/arm/mach-omap1/board-osk.c
index e9dd791..30bdbdb 100644
--- a/arch/arm/mach-omap1/board-osk.c
+++ b/arch/arm/mach-omap1/board-osk.c
@@ -284,8 +284,6 @@ static void __init osk_init_irq(void)
 	omap1_init_common_hw();
 	omap_init_irq();
 	omap_gpio_init();
-	osk_init_smc91x();
-	osk_init_cf();
 }
 
 static struct omap_usb_config osk_usb_config __initdata = {
@@ -541,6 +539,9 @@ static void __init osk_init(void)
 {
 	u32 l;
 
+	osk_init_smc91x();
+	osk_init_cf();
+
 	/* Workaround for wrong CS3 (NOR flash) timing
 	 * There are some U-Boot versions out there which configure
 	 * wrong CS3 memory timings. This mainly leads to CRC
diff --git a/arch/arm/mach-omap1/board-perseus2.c b/arch/arm/mach-omap1/board-perseus2.c
index a8d16a2..07660be 100644
--- a/arch/arm/mach-omap1/board-perseus2.c
+++ b/arch/arm/mach-omap1/board-perseus2.c
@@ -251,8 +251,19 @@ static struct omap_board_config_kernel perseus2_config[] __initdata = {
 	{ OMAP_TAG_LCD,		&perseus2_lcd_config },
 };
 
+static void __init perseus2_init_smc91x(void)
+{
+	fpga_write(1, H2P2_DBG_FPGA_LAN_RESET);
+	mdelay(50);
+	fpga_write(fpga_read(H2P2_DBG_FPGA_LAN_RESET) & ~1,
+		   H2P2_DBG_FPGA_LAN_RESET);
+	mdelay(50);
+}
+
 static void __init omap_perseus2_init(void)
 {
+	perseus2_init_smc91x();
+
 	if (gpio_request(P2_NAND_RB_GPIO_PIN, "NAND ready") < 0)
 		BUG();
 	gpio_direction_input(P2_NAND_RB_GPIO_PIN);
@@ -280,21 +291,11 @@ static void __init omap_perseus2_init(void)
 	omap_register_i2c_bus(1, 100, NULL, 0);
 }
 
-static void __init perseus2_init_smc91x(void)
-{
-	fpga_write(1, H2P2_DBG_FPGA_LAN_RESET);
-	mdelay(50);
-	fpga_write(fpga_read(H2P2_DBG_FPGA_LAN_RESET) & ~1,
-		   H2P2_DBG_FPGA_LAN_RESET);
-	mdelay(50);
-}
-
 static void __init omap_perseus2_init_irq(void)
 {
 	omap1_init_common_hw();
 	omap_init_irq();
 	omap_gpio_init();
-	perseus2_init_smc91x();
 }
 /* Only FPGA needs to be mapped here. All others are done with ioremap */
 static struct map_desc omap_perseus2_io_desc[] __initdata = {
diff --git a/arch/arm/mach-omap2/board-apollon.c b/arch/arm/mach-omap2/board-apollon.c
index 2c6db1a..6ae777e 100644
--- a/arch/arm/mach-omap2/board-apollon.c
+++ b/arch/arm/mach-omap2/board-apollon.c
@@ -281,7 +281,6 @@ static void __init omap_apollon_init_irq(void)
 	omap2_init_common_hw(NULL, NULL);
 	omap_init_irq();
 	omap_gpio_init();
-	apollon_init_smc91x();
 }
 
 static void __init apollon_led_init(void)
@@ -324,6 +323,7 @@ static void __init omap_apollon_init(void)
 
 	omap2420_mux_init(board_mux, OMAP_PACKAGE_ZAC);
 
+	apollon_init_smc91x();
 	apollon_led_init();
 	apollon_flash_init();
 	apollon_usb_init();
diff --git a/arch/arm/mach-omap2/board-ldp.c b/arch/arm/mach-omap2/board-ldp.c
index 001fd97..3dab44e 100644
--- a/arch/arm/mach-omap2/board-ldp.c
+++ b/arch/arm/mach-omap2/board-ldp.c
@@ -295,7 +295,6 @@ static void __init omap_ldp_init_irq(void)
 	omap2_init_common_hw(NULL, NULL);
 	omap_init_irq();
 	omap_gpio_init();
-	ldp_init_smsc911x();
 }
 
 static struct twl4030_usb_data ldp_usb_data = {
@@ -426,6 +425,7 @@ static struct mtd_partition ldp_nand_partitions[] = {
 static void __init omap_ldp_init(void)
 {
 	omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
+	ldp_init_smsc911x();
 	omap_i2c_init();
 	platform_add_devices(ldp_devices, ARRAY_SIZE(ldp_devices));
 	ts_gpio = 54;
