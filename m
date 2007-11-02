From: jarkko.nikula@nokia.com
Subject: [PATCH 2/3] ARM: OMAP: Use I2C bus registration helper
Date: Fri,  2 Nov 2007 15:46:30 +0200
Message-ID: <1194011191-29395-3-git-send-email-jarkko.nikula@nokia.com>
References: <1194011191-29395-1-git-send-email-jarkko.nikula@nokia.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <1194011191-29395-1-git-send-email-jarkko.nikula@nokia.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

From: Jarkko Nikula <jarkko.nikula@nokia.com>

This patch starts using introduced I2C bus registration helper by cleaning
up registration currently done in various places and by doing necessary
board file modifications.

Patch modifies those board files that are merged upstream.

Signed-off-by: Jarkko Nikula <jarkko.nikula@nokia.com>
---
 arch/arm/mach-omap1/board-ams-delta.c |    1 +
 arch/arm/mach-omap1/board-fsample.c   |    1 +
 arch/arm/mach-omap1/board-generic.c   |    1 +
 arch/arm/mach-omap1/board-h2.c        |    1 +
 arch/arm/mach-omap1/board-h3.c        |    1 +
 arch/arm/mach-omap1/board-innovator.c |    1 +
 arch/arm/mach-omap1/board-nokia770.c  |    1 +
 arch/arm/mach-omap1/board-osk.c       |    1 +
 arch/arm/mach-omap1/board-palmte.c    |    1 +
 arch/arm/mach-omap1/board-palmtt.c    |    1 +
 arch/arm/mach-omap1/board-palmz71.c   |    1 +
 arch/arm/mach-omap1/board-perseus2.c  |    1 +
 arch/arm/mach-omap1/board-sx1.c       |    1 +
 arch/arm/mach-omap1/board-voiceblue.c |    1 +
 arch/arm/mach-omap2/board-2430sdp.c   |   69 +------------------------------
 arch/arm/mach-omap2/board-apollon.c   |    2 +
 arch/arm/mach-omap2/board-generic.c   |    2 +
 arch/arm/mach-omap2/board-h4.c        |    2 +
 arch/arm/mach-omap2/devices.c         |   52 -----------------------
 arch/arm/plat-omap/devices.c          |   73 ---------------------------------
 20 files changed, 22 insertions(+), 192 deletions(-)

diff --git a/arch/arm/mach-omap1/board-ams-delta.c b/arch/arm/mach-omap1/board-ams-delta.c
index c73ca61..4a7d1da 100644
--- a/arch/arm/mach-omap1/board-ams-delta.c
+++ b/arch/arm/mach-omap1/board-ams-delta.c
@@ -227,6 +227,7 @@ static void __init ams_delta_init(void)
 	omap_board_config = ams_delta_config;
 	omap_board_config_size = ARRAY_SIZE(ams_delta_config);
 	omap_serial_init();
+	omap_register_i2c_bus(1, 100);
 
 	/* Clear latch2 (NAND, LCD, modem enable) */
 	ams_delta_latch2_write(~0, 0);
diff --git a/arch/arm/mach-omap1/board-fsample.c b/arch/arm/mach-omap1/board-fsample.c
index d5f6ea1..1c843ef 100644
--- a/arch/arm/mach-omap1/board-fsample.c
+++ b/arch/arm/mach-omap1/board-fsample.c
@@ -233,6 +233,7 @@ static void __init omap_fsample_init(void)
 	omap_board_config = fsample_config;
 	omap_board_config_size = ARRAY_SIZE(fsample_config);
 	omap_serial_init();
+	omap_register_i2c_bus(1, 100);
 }
 
 static void __init fsample_init_smc91x(void)
diff --git a/arch/arm/mach-omap1/board-generic.c b/arch/arm/mach-omap1/board-generic.c
index 4b35f16..1cb7f02 100644
--- a/arch/arm/mach-omap1/board-generic.c
+++ b/arch/arm/mach-omap1/board-generic.c
@@ -100,6 +100,7 @@ static void __init omap_generic_init(void)
 	omap_board_config = generic_config;
 	omap_board_config_size = ARRAY_SIZE(generic_config);
 	omap_serial_init();
+	omap_register_i2c_bus(1, 100);
 }
 
 static void __init omap_generic_map_io(void)
diff --git a/arch/arm/mach-omap1/board-h2.c b/arch/arm/mach-omap1/board-h2.c
index d2214ad..a11637b 100644
--- a/arch/arm/mach-omap1/board-h2.c
+++ b/arch/arm/mach-omap1/board-h2.c
@@ -530,6 +530,7 @@ static void __init h2_init(void)
 	omap_board_config = h2_config;
 	omap_board_config_size = ARRAY_SIZE(h2_config);
 	omap_serial_init();
+	omap_register_i2c_bus(1, 100);
 }
 
 static void __init h2_map_io(void)
diff --git a/arch/arm/mach-omap1/board-h3.c b/arch/arm/mach-omap1/board-h3.c
index df77cf5..d3d90ba 100644
--- a/arch/arm/mach-omap1/board-h3.c
+++ b/arch/arm/mach-omap1/board-h3.c
@@ -575,6 +575,7 @@ static void __init h3_init(void)
 	omap_board_config = h3_config;
 	omap_board_config_size = ARRAY_SIZE(h3_config);
 	omap_serial_init();
+	omap_register_i2c_bus(1, 100);
 }
 
 static void __init h3_init_smc91x(void)
diff --git a/arch/arm/mach-omap1/board-innovator.c b/arch/arm/mach-omap1/board-innovator.c
index 7e63a41..f979fc5 100644
--- a/arch/arm/mach-omap1/board-innovator.c
+++ b/arch/arm/mach-omap1/board-innovator.c
@@ -411,6 +411,7 @@ static void __init innovator_init(void)
 	omap_board_config = innovator_config;
 	omap_board_config_size = ARRAY_SIZE(innovator_config);
 	omap_serial_init();
+	omap_register_i2c_bus(1, 100);
 }
 
 static void __init innovator_map_io(void)
diff --git a/arch/arm/mach-omap1/board-nokia770.c b/arch/arm/mach-omap1/board-nokia770.c
index df5bda2..a79e38a 100644
--- a/arch/arm/mach-omap1/board-nokia770.c
+++ b/arch/arm/mach-omap1/board-nokia770.c
@@ -373,6 +373,7 @@ static void __init omap_nokia770_init(void)
 	omap_board_config_size = ARRAY_SIZE(nokia770_config);
 	omap_gpio_init();
 	omap_serial_init();
+	omap_register_i2c_bus(1, 100);
 	omap_dsp_init();
 	hwa742_dev_init();
 	ads7846_dev_init();
diff --git a/arch/arm/mach-omap1/board-osk.c b/arch/arm/mach-omap1/board-osk.c
index 5fab8f4..ec1469c 100644
--- a/arch/arm/mach-omap1/board-osk.c
+++ b/arch/arm/mach-omap1/board-osk.c
@@ -477,6 +477,7 @@ static void __init osk_init(void)
 			ARRAY_SIZE(osk_i2c_board_info));
 
 	omap_serial_init();
+	omap_register_i2c_bus(1, 100);
 	osk_mistral_init();
 }
 
diff --git a/arch/arm/mach-omap1/board-palmte.c b/arch/arm/mach-omap1/board-palmte.c
index e5e0957..f92f5ad 100644
--- a/arch/arm/mach-omap1/board-palmte.c
+++ b/arch/arm/mach-omap1/board-palmte.c
@@ -416,6 +416,7 @@ static void __init omap_palmte_init(void)
 
 	palmte_misc_gpio_setup();
 	omap_serial_init();
+	omap_register_i2c_bus(1, 100);
 }
 
 static void __init omap_palmte_map_io(void)
diff --git a/arch/arm/mach-omap1/board-palmtt.c b/arch/arm/mach-omap1/board-palmtt.c
index dd69e01..15e2e66 100644
--- a/arch/arm/mach-omap1/board-palmtt.c
+++ b/arch/arm/mach-omap1/board-palmtt.c
@@ -339,6 +339,7 @@ static void __init omap_palmtt_init(void)
 
 	spi_register_board_info(palmtt_boardinfo,ARRAY_SIZE(palmtt_boardinfo));
 	omap_serial_init();
+	omap_register_i2c_bus(1, 100);
 }
 
 static void __init omap_palmtt_map_io(void)
diff --git a/arch/arm/mach-omap1/board-palmz71.c b/arch/arm/mach-omap1/board-palmz71.c
index 6b49c71..fd35309 100644
--- a/arch/arm/mach-omap1/board-palmz71.c
+++ b/arch/arm/mach-omap1/board-palmz71.c
@@ -364,6 +364,7 @@ omap_palmz71_init(void)
 	spi_register_board_info(palmz71_boardinfo,
 				ARRAY_SIZE(palmz71_boardinfo));
 	omap_serial_init();
+	omap_register_i2c_bus(1, 100);
 	palmz71_gpio_setup(0);
 }
 
diff --git a/arch/arm/mach-omap1/board-perseus2.c b/arch/arm/mach-omap1/board-perseus2.c
index e9e352e..61d0df9 100644
--- a/arch/arm/mach-omap1/board-perseus2.c
+++ b/arch/arm/mach-omap1/board-perseus2.c
@@ -233,6 +233,7 @@ static void __init omap_perseus2_init(void)
 	omap_board_config = perseus2_config;
 	omap_board_config_size = ARRAY_SIZE(perseus2_config);
 	omap_serial_init();
+	omap_register_i2c_bus(1, 100);
 }
 
 static void __init perseus2_init_smc91x(void)
diff --git a/arch/arm/mach-omap1/board-sx1.c b/arch/arm/mach-omap1/board-sx1.c
index f25ec6f..af5f07b 100644
--- a/arch/arm/mach-omap1/board-sx1.c
+++ b/arch/arm/mach-omap1/board-sx1.c
@@ -439,6 +439,7 @@ static void __init omap_sx1_init(void)
 	omap_board_config = sx1_config;
 	omap_board_config_size = ARRAY_SIZE(sx1_config);
 	omap_serial_init();
+	omap_register_i2c_bus(1, 100);
 
 	/* turn on USB power */
 	/* sx1_setusbpower(1); cant do it here because i2c is not ready */
diff --git a/arch/arm/mach-omap1/board-voiceblue.c b/arch/arm/mach-omap1/board-voiceblue.c
index 214dd19..757153e 100644
--- a/arch/arm/mach-omap1/board-voiceblue.c
+++ b/arch/arm/mach-omap1/board-voiceblue.c
@@ -198,6 +198,7 @@ static void __init voiceblue_init(void)
 	omap_board_config = voiceblue_config;
 	omap_board_config_size = ARRAY_SIZE(voiceblue_config);
 	omap_serial_init();
+	omap_register_i2c_bus(1, 100);
 
 	/* There is a good chance board is going up, so enable power LED
 	 * (it is connected through invertor) */
diff --git a/arch/arm/mach-omap2/board-2430sdp.c b/arch/arm/mach-omap2/board-2430sdp.c
index 9e6592c..aa98688 100644
--- a/arch/arm/mach-omap2/board-2430sdp.c
+++ b/arch/arm/mach-omap2/board-2430sdp.c
@@ -354,75 +354,10 @@ static struct omap_board_config_kernel sdp2430_config[] __initdata = {
 	{OMAP_TAG_LCD, &sdp2430_lcd_config},
 };
 
-#if	defined(CONFIG_I2C_OMAP) || defined(CONFIG_I2C_OMAP_MODULE)
-
-#define OMAP2_I2C_BASE1		0x48070000
-#define OMAP2_I2C_BASE2		0x48072000
-#define OMAP2_I2C_INT1		56
-#define OMAP2_I2C_INT2		57
-
-static u32 omap2_i2c1_clkrate	= 400;
-static u32 omap2_i2c2_clkrate	= 2600;
-
-static struct resource i2c_resources1[] = {
-	{
-		.start	= OMAP2_I2C_BASE1,
-		.end	= OMAP2_I2C_BASE1 + 0x3f,
-		.flags	= IORESOURCE_MEM,
-	},
-	{
-		.start	= OMAP2_I2C_INT1,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static struct resource i2c_resources2[] = {
-	{
-		.start	= OMAP2_I2C_BASE2,
-		.end	= OMAP2_I2C_BASE2 + 0x3f,
-		.flags	= IORESOURCE_MEM,
-	},
-	{
-		.start	= OMAP2_I2C_INT2,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static struct platform_device omap_i2c_device1 = {
-	.name		= "i2c_omap",
-	.id		= 1,
-	.num_resources	= ARRAY_SIZE(i2c_resources1),
-	.resource	= i2c_resources1,
-	.dev		= {
-		.platform_data	= &omap2_i2c1_clkrate,
-	},
-};
-
-static struct platform_device omap_i2c_device2 = {
-	.name		= "i2c_omap",
-	.id		= 2,
-	.num_resources	= ARRAY_SIZE(i2c_resources2),
-	.resource	= i2c_resources2,
-	.dev		= {
-		.platform_data	= &omap2_i2c2_clkrate,
-	},
-};
-
-static void omap_init_i2c(void)
-{
-	(void) platform_device_register(&omap_i2c_device2);
-	(void) platform_device_register(&omap_i2c_device1);
-}
-
-#else
-
-static void omap_init_i2c(void) {}
-
-#endif
-
 static int __init omap2430_i2c_init(void)
 {
-	omap_init_i2c();
+	omap_register_i2c_bus(1, 400);
+	omap_register_i2c_bus(2, 2600);
 	return 0;
 }
 
diff --git a/arch/arm/mach-omap2/board-apollon.c b/arch/arm/mach-omap2/board-apollon.c
index ff8459c..8dcf9fd 100644
--- a/arch/arm/mach-omap2/board-apollon.c
+++ b/arch/arm/mach-omap2/board-apollon.c
@@ -381,6 +381,8 @@ static void __init omap_apollon_init(void)
 	omap_board_config = apollon_config;
 	omap_board_config_size = ARRAY_SIZE(apollon_config);
 	omap_serial_init();
+	omap_register_i2c_bus(1, 100);
+	omap_register_i2c_bus(2, 100);
 
 	spi_register_board_info(apollon_spi_board_info,
 				ARRAY_SIZE(apollon_spi_board_info));
diff --git a/arch/arm/mach-omap2/board-generic.c b/arch/arm/mach-omap2/board-generic.c
index d8da3c1..9f469ac 100644
--- a/arch/arm/mach-omap2/board-generic.c
+++ b/arch/arm/mach-omap2/board-generic.c
@@ -61,6 +61,8 @@ static void __init omap_generic_init(void)
 	omap_board_config = generic_config;
 	omap_board_config_size = ARRAY_SIZE(generic_config);
 	omap_serial_init();
+	omap_register_i2c_bus(1, 100);
+	omap_register_i2c_bus(2, 100);
 }
 
 static void __init omap_generic_map_io(void)
diff --git a/arch/arm/mach-omap2/board-h4.c b/arch/arm/mach-omap2/board-h4.c
index fc30021..e1bb854 100644
--- a/arch/arm/mach-omap2/board-h4.c
+++ b/arch/arm/mach-omap2/board-h4.c
@@ -708,6 +708,8 @@ static void __init omap_h4_init(void)
 	omap_board_config = h4_config;
 	omap_board_config_size = ARRAY_SIZE(h4_config);
 	omap_serial_init();
+	/* REVISIT: Second I2C not in use on H4? */
+	omap_register_i2c_bus(1, 100);
 
 	/* smc91x, debug leds, ps/2, extra uarts */
 	h4_init_debug();
diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index 376b49f..85bc01a 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -56,55 +56,6 @@ static inline void omap_init_camera(void)
 }
 #endif
 
-#if	!defined(CONFIG_ARCH_OMAP243X)
-#if	defined(CONFIG_I2C_OMAP) || defined(CONFIG_I2C_OMAP_MODULE)
-
-#define OMAP2_I2C_BASE2		0x48072000
-#define OMAP2_I2C_INT2		57
-
-static u32 omap2_i2c2_clkrate	= 100;
-static struct resource i2c_resources2[] = {
-	{
-		.start		= OMAP2_I2C_BASE2,
-		.end		= OMAP2_I2C_BASE2 + 0x3f,
-		.flags		= IORESOURCE_MEM,
-	},
-	{
-		.start		= OMAP2_I2C_INT2,
-		.flags		= IORESOURCE_IRQ,
-	},
-};
-
-static struct platform_device omap_i2c_device2 = {
-	.name           = "i2c_omap",
-	.id             = 2,
-	.num_resources	= ARRAY_SIZE(i2c_resources2),
-	.resource	= i2c_resources2,
-	.dev		= {
-		.platform_data	= &omap2_i2c2_clkrate,
-	},
-};
-
-/* See also arch/arm/plat-omap/devices.c for first I2C on 24xx */
-static void omap_init_i2c(void)
-{
-	/* REVISIT: Second I2C not in use on H4? */
-	if (machine_is_omap_h4())
-		return;
-
-	omap_cfg_reg(J15_24XX_I2C2_SCL);
-	omap_cfg_reg(H19_24XX_I2C2_SDA);
-
-	(void) platform_device_register(&omap_i2c_device2);
-}
-
-#else
-
-static void omap_init_i2c(void) {}
-
-#endif
-#endif
-
 #if defined(CONFIG_OMAP_DSP) || defined(CONFIG_OMAP_DSP_MODULE)
 #define OMAP2_MBOX_BASE		IO_ADDRESS(OMAP24XX_MAILBOX_BASE)
 
@@ -278,9 +229,6 @@ static int __init omap2_init_devices(void)
 	 * in alphabetical order so they're easier to sort through.
 	 */
 	omap_init_camera();
-	if (!cpu_is_omap2430()) {
-		omap_init_i2c();
-	}
 	omap_init_mbox();
 	omap_init_mcspi();
 	omap_init_sti();
diff --git a/arch/arm/plat-omap/devices.c b/arch/arm/plat-omap/devices.c
index 6b795ab..b84e7f8 100644
--- a/arch/arm/plat-omap/devices.c
+++ b/arch/arm/plat-omap/devices.c
@@ -89,76 +89,6 @@ static inline void omap_init_dsp(void) { }
 #endif	/* CONFIG_OMAP_DSP */
 
 /*-------------------------------------------------------------------------*/
-#if	!defined(CONFIG_ARCH_OMAP243X)
-#if	defined(CONFIG_I2C_OMAP) || defined(CONFIG_I2C_OMAP_MODULE)
-
-#define	OMAP1_I2C_BASE		0xfffb3800
-#define OMAP2_I2C_BASE1		0x48070000
-#define OMAP_I2C_SIZE		0x3f
-#define OMAP1_I2C_INT		INT_I2C
-#define OMAP2_I2C_INT1		56
-
-static u32 omap2_i2c1_clkrate	= 100;
-
-static struct resource i2c_resources1[] = {
-	{
-		.start		= 0,
-		.end		= 0,
-		.flags		= IORESOURCE_MEM,
-	},
-	{
-		.start		= 0,
-		.flags		= IORESOURCE_IRQ,
-	},
-};
-
-/* DMA not used; works around erratum writing to non-empty i2c fifo */
-
-static struct platform_device omap_i2c_device1 = {
-	.name           = "i2c_omap",
-	.id             = 1,
-	.num_resources	= ARRAY_SIZE(i2c_resources1),
-	.resource	= i2c_resources1,
-	.dev		= {
-		.platform_data	= &omap2_i2c1_clkrate,
-	},
-};
-
-/* See also arch/arm/mach-omap2/devices.c for second I2C on 24xx */
-static void omap_init_i2c(void)
-{
-	if (cpu_is_omap242x()) {
-		i2c_resources1[0].start = OMAP2_I2C_BASE1;
-		i2c_resources1[0].end = OMAP2_I2C_BASE1 + OMAP_I2C_SIZE;
-		i2c_resources1[1].start = OMAP2_I2C_INT1;
-	} else {
-		i2c_resources1[0].start = OMAP1_I2C_BASE;
-		i2c_resources1[0].end = OMAP1_I2C_BASE + OMAP_I2C_SIZE;
-		i2c_resources1[1].start = OMAP1_I2C_INT;
-	}
-
-	/* FIXME define and use a boot tag, in case of boards that
-	 * either don't wire up I2C, or chips that mux it differently...
-	 * it can include clocking and address info, maybe more.
-	 */
-	if (cpu_class_is_omap2()) {
-		if (machine_is_omap_h4()) {
-			omap_cfg_reg(M19_24XX_I2C1_SCL);
-			omap_cfg_reg(L15_24XX_I2C1_SDA);
-		}
-	} else {
-		omap_cfg_reg(I2C_SCL);
-		omap_cfg_reg(I2C_SDA);
-	}
-
-	(void) platform_device_register(&omap_i2c_device1);
-}
-
-#else
-static inline void omap_init_i2c(void) {}
-#endif
-#endif
-/*-------------------------------------------------------------------------*/
 #if	defined(CONFIG_KEYBOARD_OMAP) || defined(CONFIG_KEYBOARD_OMAP_MODULE)
 
 static void omap_init_kp(void)
@@ -539,9 +469,6 @@ static int __init omap_init_devices(void)
 	omap_init_uwire();
 	omap_init_wdt();
 	omap_init_rng();
-	if (!cpu_is_omap2430() && !cpu_is_omap34xx()) {
-		omap_init_i2c();
-	}
 	return 0;
 }
 arch_initcall(omap_init_devices);
-- 
1.5.3.4
