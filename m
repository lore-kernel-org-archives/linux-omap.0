From: Alistair Buxton <a.j.buxton@gmail.com>
Subject: [PATCH 12/17] OMAP7XX: Replace omap730 references in irqs.h and all
	users
Date: Wed, 14 Oct 2009 20:51:31 +0100
Message-ID: <3d374d00910141251g16d59117j4b3ac2df563635c1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

This patch is part of a series which removes references to omap730 in code
which is shared with omap850, replacing them with references to omap7xx.

Turns INT_730_* to INT_7XX_* for definitions in irqs.h and all users.

Signed-off-by: Alistair Buxton <a.j.buxton@gmail.com>
Reviewed-by: Zebediah C. McClure <zmc@lurian.net>
---
 arch/arm/mach-omap1/board-fsample.c           |    6 +-
 arch/arm/mach-omap1/board-perseus2.c          |    6 +-
 arch/arm/mach-omap1/irq.c                     |    2 +-
 arch/arm/mach-omap1/mcbsp.c                   |    8 +-
 arch/arm/mach-omap1/pm.c                      |   10 +-
 arch/arm/mach-omap1/serial.c                  |    4 +-
 arch/arm/plat-omap/gpio.c                     |   14 +-
 arch/arm/plat-omap/include/mach/entry-macro.S |    2 +-
 arch/arm/plat-omap/include/mach/irqs.h        |  148 ++++++++++++------------
 arch/arm/plat-omap/usb.c                      |    4 +-
 10 files changed, 102 insertions(+), 102 deletions(-)

diff --git a/arch/arm/mach-omap1/board-fsample.c
b/arch/arm/mach-omap1/board-fsample.c
index e53f774..74720e6 100644
--- a/arch/arm/mach-omap1/board-fsample.c
+++ b/arch/arm/mach-omap1/board-fsample.c
@@ -107,7 +107,7 @@ static struct resource smc91x_resources[] = {
 		.flags	= IORESOURCE_MEM,
 	},
 	[1] = {
-		.start	= INT_730_MPU_EXT_NIRQ,
+		.start	= INT_7XX_MPU_EXT_NIRQ,
 		.end	= 0,
 		.flags	= IORESOURCE_IRQ | IORESOURCE_IRQ_HIGHEDGE,
 	},
@@ -196,8 +196,8 @@ static struct platform_device smc91x_device = {

 static struct resource kp_resources[] = {
 	[0] = {
-		.start	= INT_730_MPUIO_KEYPAD,
-		.end	= INT_730_MPUIO_KEYPAD,
+		.start	= INT_7XX_MPUIO_KEYPAD,
+		.end	= INT_7XX_MPUIO_KEYPAD,
 		.flags	= IORESOURCE_IRQ,
 	},
 };
diff --git a/arch/arm/mach-omap1/board-perseus2.c
b/arch/arm/mach-omap1/board-perseus2.c
index ec22838..2f897cf 100644
--- a/arch/arm/mach-omap1/board-perseus2.c
+++ b/arch/arm/mach-omap1/board-perseus2.c
@@ -74,7 +74,7 @@ static struct resource smc91x_resources[] = {
 		.flags	= IORESOURCE_MEM,
 	},
 	[1] = {
-		.start	= INT_730_MPU_EXT_NIRQ,
+		.start	= INT_7XX_MPU_EXT_NIRQ,
 		.end	= 0,
 		.flags	= IORESOURCE_IRQ | IORESOURCE_IRQ_HIGHEDGE,
 	},
@@ -163,8 +163,8 @@ static struct platform_device smc91x_device = {

 static struct resource kp_resources[] = {
 	[0] = {
-		.start	= INT_730_MPUIO_KEYPAD,
-		.end	= INT_730_MPUIO_KEYPAD,
+		.start	= INT_7XX_MPUIO_KEYPAD,
+		.end	= INT_7XX_MPUIO_KEYPAD,
 		.flags	= IORESOURCE_IRQ,
 	},
 };
diff --git a/arch/arm/mach-omap1/irq.c b/arch/arm/mach-omap1/irq.c
index c05999c..704a80c 100644
--- a/arch/arm/mach-omap1/irq.c
+++ b/arch/arm/mach-omap1/irq.c
@@ -234,7 +234,7 @@ void __init omap_init_irq(void)
 	/* Unmask level 2 handler */

 	if (cpu_is_omap7xx())
-		omap_unmask_irq(INT_730_IH2_IRQ);
+		omap_unmask_irq(INT_7XX_IH2_IRQ);
 	else if (cpu_is_omap15xx())
 		omap_unmask_irq(INT_1510_IH2_IRQ);
 	else if (cpu_is_omap16xx())
diff --git a/arch/arm/mach-omap1/mcbsp.c b/arch/arm/mach-omap1/mcbsp.c
index 06f380b..7ccca00 100644
--- a/arch/arm/mach-omap1/mcbsp.c
+++ b/arch/arm/mach-omap1/mcbsp.c
@@ -85,16 +85,16 @@ static struct omap_mcbsp_platform_data
omap730_mcbsp_pdata[] = {
 		.phys_base	= OMAP730_MCBSP1_BASE,
 		.dma_rx_sync	= OMAP_DMA_MCBSP1_RX,
 		.dma_tx_sync	= OMAP_DMA_MCBSP1_TX,
-		.rx_irq		= INT_730_McBSP1RX,
-		.tx_irq		= INT_730_McBSP1TX,
+		.rx_irq		= INT_7XX_McBSP1RX,
+		.tx_irq		= INT_7XX_McBSP1TX,
 		.ops		= &omap1_mcbsp_ops,
 	},
 	{
 		.phys_base	= OMAP730_MCBSP2_BASE,
 		.dma_rx_sync	= OMAP_DMA_MCBSP3_RX,
 		.dma_tx_sync	= OMAP_DMA_MCBSP3_TX,
-		.rx_irq		= INT_730_McBSP2RX,
-		.tx_irq		= INT_730_McBSP2TX,
+		.rx_irq		= INT_7XX_McBSP2RX,
+		.tx_irq		= INT_7XX_McBSP2TX,
 		.ops		= &omap1_mcbsp_ops,
 	},
 };
diff --git a/arch/arm/mach-omap1/pm.c b/arch/arm/mach-omap1/pm.c
index 12f246e..58479c7 100644
--- a/arch/arm/mach-omap1/pm.c
+++ b/arch/arm/mach-omap1/pm.c
@@ -184,8 +184,8 @@ static void omap_pm_wakeup_setup(void)
 	 * wake up to a GPIO interrupt.
 	 */
 	if (cpu_is_omap7xx())
-		level1_wake = OMAP_IRQ_BIT(INT_730_GPIO_BANK1) |
-			OMAP_IRQ_BIT(INT_730_IH2_IRQ);
+		level1_wake = OMAP_IRQ_BIT(INT_7XX_GPIO_BANK1) |
+			OMAP_IRQ_BIT(INT_7XX_IH2_IRQ);
 	else if (cpu_is_omap15xx())
 		level1_wake = OMAP_IRQ_BIT(INT_GPIO_BANK1) |
 			OMAP_IRQ_BIT(INT_1510_IH2_IRQ);
@@ -197,8 +197,8 @@ static void omap_pm_wakeup_setup(void)

 	if (cpu_is_omap7xx()) {
 		omap_writel(~level2_wake, OMAP_IH2_0_MIR);
-		omap_writel(~(OMAP_IRQ_BIT(INT_730_WAKE_UP_REQ) |
-				OMAP_IRQ_BIT(INT_730_MPUIO_KEYPAD)),
+		omap_writel(~(OMAP_IRQ_BIT(INT_7XX_WAKE_UP_REQ) |
+				OMAP_IRQ_BIT(INT_7XX_MPUIO_KEYPAD)),
 				OMAP_IH2_1_MIR);
 	} else if (cpu_is_omap15xx()) {
 		level2_wake |= OMAP_IRQ_BIT(INT_KEYBOARD);
@@ -687,7 +687,7 @@ static int __init omap_pm_init(void)
 	pm_idle = omap1_pm_idle;

 	if (cpu_is_omap7xx())
-		setup_irq(INT_730_WAKE_UP_REQ, &omap_wakeup_irq);
+		setup_irq(INT_7XX_WAKE_UP_REQ, &omap_wakeup_irq);
 	else if (cpu_is_omap16xx())
 		setup_irq(INT_1610_WAKE_UP_REQ, &omap_wakeup_irq);

diff --git a/arch/arm/mach-omap1/serial.c b/arch/arm/mach-omap1/serial.c
index 49381e2..ed07af1 100644
--- a/arch/arm/mach-omap1/serial.c
+++ b/arch/arm/mach-omap1/serial.c
@@ -113,8 +113,8 @@ void __init omap_serial_init(void)
 	if (cpu_is_omap7xx()) {
 		serial_platform_data[0].regshift = 0;
 		serial_platform_data[1].regshift = 0;
-		serial_platform_data[0].irq = INT_730_UART_MODEM_1;
-		serial_platform_data[1].irq = INT_730_UART_MODEM_IRDA_2;
+		serial_platform_data[0].irq = INT_7XX_UART_MODEM_1;
+		serial_platform_data[1].irq = INT_7XX_UART_MODEM_IRDA_2;
 	}

 	if (cpu_is_omap15xx()) {
diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
index 665ca05..22f6e68 100644
--- a/arch/arm/plat-omap/gpio.c
+++ b/arch/arm/plat-omap/gpio.c
@@ -221,13 +221,13 @@ static struct gpio_bank gpio_bank_1510[2] = {

 #if defined(CONFIG_ARCH_OMAP730) || defined(CONFIG_ARCH_OMAP850)
 static struct gpio_bank gpio_bank_730[7] = {
-	{ OMAP1_MPUIO_VBASE,    INT_730_MPUIO,	    IH_MPUIO_BASE,	METHOD_MPUIO },
-	{ OMAP730_GPIO1_BASE,  INT_730_GPIO_BANK1,  IH_GPIO_BASE,	METHOD_GPIO_730 },
-	{ OMAP730_GPIO2_BASE,  INT_730_GPIO_BANK2,  IH_GPIO_BASE +
32,	METHOD_GPIO_730 },
-	{ OMAP730_GPIO3_BASE,  INT_730_GPIO_BANK3,  IH_GPIO_BASE +
64,	METHOD_GPIO_730 },
-	{ OMAP730_GPIO4_BASE,  INT_730_GPIO_BANK4,  IH_GPIO_BASE +
96,	METHOD_GPIO_730 },
-	{ OMAP730_GPIO5_BASE,  INT_730_GPIO_BANK5,  IH_GPIO_BASE + 128,
METHOD_GPIO_730 },
-	{ OMAP730_GPIO6_BASE,  INT_730_GPIO_BANK6,  IH_GPIO_BASE + 160,
METHOD_GPIO_730 },
+	{ OMAP1_MPUIO_VBASE,    INT_7XX_MPUIO,	    IH_MPUIO_BASE,	METHOD_MPUIO },
+	{ OMAP730_GPIO1_BASE,  INT_7XX_GPIO_BANK1,  IH_GPIO_BASE,	METHOD_GPIO_730 },
+	{ OMAP730_GPIO2_BASE,  INT_7XX_GPIO_BANK2,  IH_GPIO_BASE +
32,	METHOD_GPIO_730 },
+	{ OMAP730_GPIO3_BASE,  INT_7XX_GPIO_BANK3,  IH_GPIO_BASE +
64,	METHOD_GPIO_730 },
+	{ OMAP730_GPIO4_BASE,  INT_7XX_GPIO_BANK4,  IH_GPIO_BASE +
96,	METHOD_GPIO_730 },
+	{ OMAP730_GPIO5_BASE,  INT_7XX_GPIO_BANK5,  IH_GPIO_BASE + 128,
METHOD_GPIO_730 },
+	{ OMAP730_GPIO6_BASE,  INT_7XX_GPIO_BANK6,  IH_GPIO_BASE + 160,
METHOD_GPIO_730 },
 };
 #endif

diff --git a/arch/arm/plat-omap/include/mach/entry-macro.S
b/arch/arm/plat-omap/include/mach/entry-macro.S
index bcf7158..abe0864 100644
--- a/arch/arm/plat-omap/include/mach/entry-macro.S
+++ b/arch/arm/plat-omap/include/mach/entry-macro.S
@@ -21,7 +21,7 @@
 	(defined(CONFIG_ARCH_OMAP15XX) || defined(CONFIG_ARCH_OMAP16XX))
 #error "FIXME: OMAP7XX doesn't support multiple-OMAP"
 #elif defined(CONFIG_ARCH_OMAP730) || defined(CONFIG_ARCH_OMAP850)
-#define INT_IH2_IRQ		INT_730_IH2_IRQ
+#define INT_IH2_IRQ		INT_7XX_IH2_IRQ
 #elif defined(CONFIG_ARCH_OMAP15XX)
 #define INT_IH2_IRQ		INT_1510_IH2_IRQ
 #elif defined(CONFIG_ARCH_OMAP16XX)
diff --git a/arch/arm/plat-omap/include/mach/irqs.h
b/arch/arm/plat-omap/include/mach/irqs.h
index 7f338f0..6a6d028 100644
--- a/arch/arm/plat-omap/include/mach/irqs.h
+++ b/arch/arm/plat-omap/include/mach/irqs.h
@@ -86,26 +86,26 @@
 #define INT_1610_SSR_FIFO_0	29

 /*
- * OMAP-730 specific IRQ numbers for interrupt handler 1
+ * OMAP-7xx specific IRQ numbers for interrupt handler 1
  */
-#define INT_730_IH2_FIQ		0
-#define INT_730_IH2_IRQ		1
-#define INT_730_USB_NON_ISO	2
-#define INT_730_USB_ISO		3
-#define INT_730_ICR		4
-#define INT_730_EAC		5
-#define INT_730_GPIO_BANK1	6
-#define INT_730_GPIO_BANK2	7
-#define INT_730_GPIO_BANK3	8
-#define INT_730_McBSP2TX	10
-#define INT_730_McBSP2RX	11
-#define INT_730_McBSP2RX_OVF	12
-#define INT_730_LCD_LINE	14
-#define INT_730_GSM_PROTECT	15
-#define INT_730_TIMER3		16
-#define INT_730_GPIO_BANK5	17
-#define INT_730_GPIO_BANK6	18
-#define INT_730_SPGIO_WR	29
+#define INT_7XX_IH2_FIQ		0
+#define INT_7XX_IH2_IRQ		1
+#define INT_7XX_USB_NON_ISO	2
+#define INT_7XX_USB_ISO		3
+#define INT_7XX_ICR		4
+#define INT_7XX_EAC		5
+#define INT_7XX_GPIO_BANK1	6
+#define INT_7XX_GPIO_BANK2	7
+#define INT_7XX_GPIO_BANK3	8
+#define INT_7XX_McBSP2TX	10
+#define INT_7XX_McBSP2RX	11
+#define INT_7XX_McBSP2RX_OVF	12
+#define INT_7XX_LCD_LINE	14
+#define INT_7XX_GSM_PROTECT	15
+#define INT_7XX_TIMER3		16
+#define INT_7XX_GPIO_BANK5	17
+#define INT_7XX_GPIO_BANK6	18
+#define INT_7XX_SPGIO_WR	29

 /*
  * IRQ numbers for interrupt handler 2
@@ -183,62 +183,62 @@
 #define INT_1610_SHA1MD5	(91 + IH2_BASE)

 /*
- * OMAP-730 specific IRQ numbers for interrupt handler 2
+ * OMAP-7xx specific IRQ numbers for interrupt handler 2
  */
-#define INT_730_HW_ERRORS	(0 + IH2_BASE)
-#define INT_730_NFIQ_PWR_FAIL	(1 + IH2_BASE)
-#define INT_730_CFCD		(2 + IH2_BASE)
-#define INT_730_CFIREQ		(3 + IH2_BASE)
-#define INT_730_I2C		(4 + IH2_BASE)
-#define INT_730_PCC		(5 + IH2_BASE)
-#define INT_730_MPU_EXT_NIRQ	(6 + IH2_BASE)
-#define INT_730_SPI_100K_1	(7 + IH2_BASE)
-#define INT_730_SYREN_SPI	(8 + IH2_BASE)
-#define INT_730_VLYNQ		(9 + IH2_BASE)
-#define INT_730_GPIO_BANK4	(10 + IH2_BASE)
-#define INT_730_McBSP1TX	(11 + IH2_BASE)
-#define INT_730_McBSP1RX	(12 + IH2_BASE)
-#define INT_730_McBSP1RX_OF	(13 + IH2_BASE)
-#define INT_730_UART_MODEM_IRDA_2 (14 + IH2_BASE)
-#define INT_730_UART_MODEM_1	(15 + IH2_BASE)
-#define INT_730_MCSI		(16 + IH2_BASE)
-#define INT_730_uWireTX		(17 + IH2_BASE)
-#define INT_730_uWireRX		(18 + IH2_BASE)
-#define INT_730_SMC_CD		(19 + IH2_BASE)
-#define INT_730_SMC_IREQ	(20 + IH2_BASE)
-#define INT_730_HDQ_1WIRE	(21 + IH2_BASE)
-#define INT_730_TIMER32K	(22 + IH2_BASE)
-#define INT_730_MMC_SDIO	(23 + IH2_BASE)
-#define INT_730_UPLD		(24 + IH2_BASE)
-#define INT_730_USB_HHC_1	(27 + IH2_BASE)
-#define INT_730_USB_HHC_2	(28 + IH2_BASE)
-#define INT_730_USB_GENI	(29 + IH2_BASE)
-#define INT_730_USB_OTG		(30 + IH2_BASE)
-#define INT_730_CAMERA_IF	(31 + IH2_BASE)
-#define INT_730_RNG		(32 + IH2_BASE)
-#define INT_730_DUAL_MODE_TIMER (33 + IH2_BASE)
-#define INT_730_DBB_RF_EN	(34 + IH2_BASE)
-#define INT_730_MPUIO_KEYPAD	(35 + IH2_BASE)
-#define INT_730_SHA1_MD5	(36 + IH2_BASE)
-#define INT_730_SPI_100K_2	(37 + IH2_BASE)
-#define INT_730_RNG_IDLE	(38 + IH2_BASE)
-#define INT_730_MPUIO		(39 + IH2_BASE)
-#define INT_730_LLPC_LCD_CTRL_CAN_BE_OFF	(40 + IH2_BASE)
-#define INT_730_LLPC_OE_FALLING (41 + IH2_BASE)
-#define INT_730_LLPC_OE_RISING	(42 + IH2_BASE)
-#define INT_730_LLPC_VSYNC	(43 + IH2_BASE)
-#define INT_730_WAKE_UP_REQ	(46 + IH2_BASE)
-#define INT_730_DMA_CH6		(53 + IH2_BASE)
-#define INT_730_DMA_CH7		(54 + IH2_BASE)
-#define INT_730_DMA_CH8		(55 + IH2_BASE)
-#define INT_730_DMA_CH9		(56 + IH2_BASE)
-#define INT_730_DMA_CH10	(57 + IH2_BASE)
-#define INT_730_DMA_CH11	(58 + IH2_BASE)
-#define INT_730_DMA_CH12	(59 + IH2_BASE)
-#define INT_730_DMA_CH13	(60 + IH2_BASE)
-#define INT_730_DMA_CH14	(61 + IH2_BASE)
-#define INT_730_DMA_CH15	(62 + IH2_BASE)
-#define INT_730_NAND		(63 + IH2_BASE)
+#define INT_7XX_HW_ERRORS	(0 + IH2_BASE)
+#define INT_7XX_NFIQ_PWR_FAIL	(1 + IH2_BASE)
+#define INT_7XX_CFCD		(2 + IH2_BASE)
+#define INT_7XX_CFIREQ		(3 + IH2_BASE)
+#define INT_7XX_I2C		(4 + IH2_BASE)
+#define INT_7XX_PCC		(5 + IH2_BASE)
+#define INT_7XX_MPU_EXT_NIRQ	(6 + IH2_BASE)
+#define INT_7XX_SPI_100K_1	(7 + IH2_BASE)
+#define INT_7XX_SYREN_SPI	(8 + IH2_BASE)
+#define INT_7XX_VLYNQ		(9 + IH2_BASE)
+#define INT_7XX_GPIO_BANK4	(10 + IH2_BASE)
+#define INT_7XX_McBSP1TX	(11 + IH2_BASE)
+#define INT_7XX_McBSP1RX	(12 + IH2_BASE)
+#define INT_7XX_McBSP1RX_OF	(13 + IH2_BASE)
+#define INT_7XX_UART_MODEM_IRDA_2 (14 + IH2_BASE)
+#define INT_7XX_UART_MODEM_1	(15 + IH2_BASE)
+#define INT_7XX_MCSI		(16 + IH2_BASE)
+#define INT_7XX_uWireTX		(17 + IH2_BASE)
+#define INT_7XX_uWireRX		(18 + IH2_BASE)
+#define INT_7XX_SMC_CD		(19 + IH2_BASE)
+#define INT_7XX_SMC_IREQ	(20 + IH2_BASE)
+#define INT_7XX_HDQ_1WIRE	(21 + IH2_BASE)
+#define INT_7XX_TIMER32K	(22 + IH2_BASE)
+#define INT_7XX_MMC_SDIO	(23 + IH2_BASE)
+#define INT_7XX_UPLD		(24 + IH2_BASE)
+#define INT_7XX_USB_HHC_1	(27 + IH2_BASE)
+#define INT_7XX_USB_HHC_2	(28 + IH2_BASE)
+#define INT_7XX_USB_GENI	(29 + IH2_BASE)
+#define INT_7XX_USB_OTG		(30 + IH2_BASE)
+#define INT_7XX_CAMERA_IF	(31 + IH2_BASE)
+#define INT_7XX_RNG		(32 + IH2_BASE)
+#define INT_7XX_DUAL_MODE_TIMER (33 + IH2_BASE)
+#define INT_7XX_DBB_RF_EN	(34 + IH2_BASE)
+#define INT_7XX_MPUIO_KEYPAD	(35 + IH2_BASE)
+#define INT_7XX_SHA1_MD5	(36 + IH2_BASE)
+#define INT_7XX_SPI_100K_2	(37 + IH2_BASE)
+#define INT_7XX_RNG_IDLE	(38 + IH2_BASE)
+#define INT_7XX_MPUIO		(39 + IH2_BASE)
+#define INT_7XX_LLPC_LCD_CTRL_CAN_BE_OFF	(40 + IH2_BASE)
+#define INT_7XX_LLPC_OE_FALLING (41 + IH2_BASE)
+#define INT_7XX_LLPC_OE_RISING	(42 + IH2_BASE)
+#define INT_7XX_LLPC_VSYNC	(43 + IH2_BASE)
+#define INT_7XX_WAKE_UP_REQ	(46 + IH2_BASE)
+#define INT_7XX_DMA_CH6		(53 + IH2_BASE)
+#define INT_7XX_DMA_CH7		(54 + IH2_BASE)
+#define INT_7XX_DMA_CH8		(55 + IH2_BASE)
+#define INT_7XX_DMA_CH9		(56 + IH2_BASE)
+#define INT_7XX_DMA_CH10	(57 + IH2_BASE)
+#define INT_7XX_DMA_CH11	(58 + IH2_BASE)
+#define INT_7XX_DMA_CH12	(59 + IH2_BASE)
+#define INT_7XX_DMA_CH13	(60 + IH2_BASE)
+#define INT_7XX_DMA_CH14	(61 + IH2_BASE)
+#define INT_7XX_DMA_CH15	(62 + IH2_BASE)
+#define INT_7XX_NAND		(63 + IH2_BASE)

 #define INT_24XX_SYS_NIRQ	7
 #define INT_24XX_SDMA_IRQ0	12
diff --git a/arch/arm/plat-omap/usb.c b/arch/arm/plat-omap/usb.c
index 980d2eb..3c40b85 100644
--- a/arch/arm/plat-omap/usb.c
+++ b/arch/arm/plat-omap/usb.c
@@ -615,7 +615,7 @@ omap_otg_init(struct omap_usb_config *config)
 		syscon &= ~HST_IDLE_EN;
 		ohci_device.dev.platform_data = config;
 		if (cpu_is_omap7xx())
-			ohci_resources[1].start = INT_730_USB_HHC_1;
+			ohci_resources[1].start = INT_7XX_USB_HHC_1;
 		status = platform_device_register(&ohci_device);
 		if (status)
 			pr_debug("can't register OHCI device, %d\n", status);
@@ -627,7 +627,7 @@ omap_otg_init(struct omap_usb_config *config)
 		syscon &= ~OTG_IDLE_EN;
 		otg_device.dev.platform_data = config;
 		if (cpu_is_omap7xx())
-			otg_resources[1].start = INT_730_USB_OTG;
+			otg_resources[1].start = INT_7XX_USB_OTG;
 		status = platform_device_register(&otg_device);
 		if (status)
 			pr_debug("can't register OTG device, %d\n", status);
-- 
1.6.5
