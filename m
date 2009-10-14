From: Alistair Buxton <a.j.buxton@gmail.com>
Subject: [PATCH 06/17] OMAP7XX: IRQ: Remove duplicate omap850 code
Date: Wed, 14 Oct 2009 20:50:48 +0100
Message-ID: <3d374d00910141250k5c37cb57j303c3db87930676d@mail.gmail.com>
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

This patch is part of a series which unifies all duplicated code between
omap730 and omap850. All cpu checks are converted to cpu_is_omap7xx() and
CONFIG_ARCH_OMAP850 is added to all CONFIG_ARCH_OMAP730 checks.

This fixes a bug which prevents IRQs from being enabled on omap850 due to
a missing check in entry-macro.S, which was found by Cory Maccarrone.

Signed-off-by: Alistair Buxton <a.j.buxton@gmail.com>
Reviewed-by: Zebediah C. McClure <zmc@lurian.net>
---
 arch/arm/mach-omap1/irq.c                     |   24 +------
 arch/arm/plat-omap/include/mach/entry-macro.S |    6 +-
 arch/arm/plat-omap/include/mach/irqs.h        |   81 -------------------------
 3 files changed, 7 insertions(+), 104 deletions(-)

diff --git a/arch/arm/mach-omap1/irq.c b/arch/arm/mach-omap1/irq.c
index de03c84..c05999c 100644
--- a/arch/arm/mach-omap1/irq.c
+++ b/arch/arm/mach-omap1/irq.c
@@ -137,7 +137,7 @@ static void omap_irq_set_cfg(int irq, int fiq, int
priority, int trigger)
 	irq_bank_writel(val, bank, offset);
 }

-#ifdef CONFIG_ARCH_OMAP730
+#if defined (CONFIG_ARCH_OMAP730) || defined (CONFIG_ARCH_OMAP850)
 static struct omap_irq_bank omap730_irq_banks[] = {
 	{ .base_reg = OMAP_IH1_BASE,		.trigger_map = 0xb3f8e22f },
 	{ .base_reg = OMAP_IH2_BASE,		.trigger_map = 0xfdb9c1f2 },
@@ -145,14 +145,6 @@ static struct omap_irq_bank omap730_irq_banks[] = {
 };
 #endif

-#ifdef CONFIG_ARCH_OMAP850
-static struct omap_irq_bank omap850_irq_banks[] = {
-	{ .base_reg = OMAP_IH1_BASE,		.trigger_map = 0xb3f8e22f },
-	{ .base_reg = OMAP_IH2_BASE,		.trigger_map = 0xfdb9c1f2 },
-	{ .base_reg = OMAP_IH2_BASE + 0x100,	.trigger_map = 0x800040f3 },
-};
-#endif
-
 #ifdef CONFIG_ARCH_OMAP15XX
 static struct omap_irq_bank omap1510_irq_banks[] = {
 	{ .base_reg = OMAP_IH1_BASE,		.trigger_map = 0xb3febfff },
@@ -186,18 +178,12 @@ void __init omap_init_irq(void)
 {
 	int i, j;

-#ifdef CONFIG_ARCH_OMAP730
-	if (cpu_is_omap730()) {
+#if defined(CONFIG_ARCH_OMAP730) || defined(CONFIG_ARCH_OMAP850)
+	if (cpu_is_omap7xx()) {
 		irq_banks = omap730_irq_banks;
 		irq_bank_count = ARRAY_SIZE(omap730_irq_banks);
 	}
 #endif
-#ifdef CONFIG_ARCH_OMAP850
-	if (cpu_is_omap850()) {
-		irq_banks = omap850_irq_banks;
-		irq_bank_count = ARRAY_SIZE(omap850_irq_banks);
-	}
-#endif
 #ifdef CONFIG_ARCH_OMAP15XX
 	if (cpu_is_omap1510()) {
 		irq_banks = omap1510_irq_banks;
@@ -247,10 +233,8 @@ void __init omap_init_irq(void)

 	/* Unmask level 2 handler */

-	if (cpu_is_omap730())
+	if (cpu_is_omap7xx())
 		omap_unmask_irq(INT_730_IH2_IRQ);
-	else if (cpu_is_omap850())
-		omap_unmask_irq(INT_850_IH2_IRQ);
 	else if (cpu_is_omap15xx())
 		omap_unmask_irq(INT_1510_IH2_IRQ);
 	else if (cpu_is_omap16xx())
diff --git a/arch/arm/plat-omap/include/mach/entry-macro.S
b/arch/arm/plat-omap/include/mach/entry-macro.S
index a559299..bcf7158 100644
--- a/arch/arm/plat-omap/include/mach/entry-macro.S
+++ b/arch/arm/plat-omap/include/mach/entry-macro.S
@@ -17,10 +17,10 @@

 #if defined(CONFIG_ARCH_OMAP1)

-#if defined(CONFIG_ARCH_OMAP730) && \
+#if (defined(CONFIG_ARCH_OMAP730)||defined(CONFIG_ARCH_OMAP850)) && \
 	(defined(CONFIG_ARCH_OMAP15XX) || defined(CONFIG_ARCH_OMAP16XX))
-#error "FIXME: OMAP730 doesn't support multiple-OMAP"
-#elif defined(CONFIG_ARCH_OMAP730)
+#error "FIXME: OMAP7XX doesn't support multiple-OMAP"
+#elif defined(CONFIG_ARCH_OMAP730) || defined(CONFIG_ARCH_OMAP850)
 #define INT_IH2_IRQ		INT_730_IH2_IRQ
 #elif defined(CONFIG_ARCH_OMAP15XX)
 #define INT_IH2_IRQ		INT_1510_IH2_IRQ
diff --git a/arch/arm/plat-omap/include/mach/irqs.h
b/arch/arm/plat-omap/include/mach/irqs.h
index 28a1650..7f338f0 100644
--- a/arch/arm/plat-omap/include/mach/irqs.h
+++ b/arch/arm/plat-omap/include/mach/irqs.h
@@ -108,29 +108,6 @@
 #define INT_730_SPGIO_WR	29

 /*
- * OMAP-850 specific IRQ numbers for interrupt handler 1
- */
-#define INT_850_IH2_FIQ		0
-#define INT_850_IH2_IRQ		1
-#define INT_850_USB_NON_ISO	2
-#define INT_850_USB_ISO		3
-#define INT_850_ICR		4
-#define INT_850_EAC		5
-#define INT_850_GPIO_BANK1	6
-#define INT_850_GPIO_BANK2	7
-#define INT_850_GPIO_BANK3	8
-#define INT_850_McBSP2TX	10
-#define INT_850_McBSP2RX	11
-#define INT_850_McBSP2RX_OVF	12
-#define INT_850_LCD_LINE	14
-#define INT_850_GSM_PROTECT	15
-#define INT_850_TIMER3		16
-#define INT_850_GPIO_BANK5	17
-#define INT_850_GPIO_BANK6	18
-#define INT_850_SPGIO_WR	29
-
-
-/*
  * IRQ numbers for interrupt handler 2
  *
  * NOTE: See also the OMAP-1510 and 1610 specific IRQ numbers below
@@ -263,64 +240,6 @@
 #define INT_730_DMA_CH15	(62 + IH2_BASE)
 #define INT_730_NAND		(63 + IH2_BASE)

-/*
- * OMAP-850 specific IRQ numbers for interrupt handler 2
- */
-#define INT_850_HW_ERRORS	(0 + IH2_BASE)
-#define INT_850_NFIQ_PWR_FAIL	(1 + IH2_BASE)
-#define INT_850_CFCD		(2 + IH2_BASE)
-#define INT_850_CFIREQ		(3 + IH2_BASE)
-#define INT_850_I2C		(4 + IH2_BASE)
-#define INT_850_PCC		(5 + IH2_BASE)
-#define INT_850_MPU_EXT_NIRQ	(6 + IH2_BASE)
-#define INT_850_SPI_100K_1	(7 + IH2_BASE)
-#define INT_850_SYREN_SPI	(8 + IH2_BASE)
-#define INT_850_VLYNQ		(9 + IH2_BASE)
-#define INT_850_GPIO_BANK4	(10 + IH2_BASE)
-#define INT_850_McBSP1TX	(11 + IH2_BASE)
-#define INT_850_McBSP1RX	(12 + IH2_BASE)
-#define INT_850_McBSP1RX_OF	(13 + IH2_BASE)
-#define INT_850_UART_MODEM_IRDA_2 (14 + IH2_BASE)
-#define INT_850_UART_MODEM_1	(15 + IH2_BASE)
-#define INT_850_MCSI		(16 + IH2_BASE)
-#define INT_850_uWireTX		(17 + IH2_BASE)
-#define INT_850_uWireRX		(18 + IH2_BASE)
-#define INT_850_SMC_CD		(19 + IH2_BASE)
-#define INT_850_SMC_IREQ	(20 + IH2_BASE)
-#define INT_850_HDQ_1WIRE	(21 + IH2_BASE)
-#define INT_850_TIMER32K	(22 + IH2_BASE)
-#define INT_850_MMC_SDIO	(23 + IH2_BASE)
-#define INT_850_UPLD		(24 + IH2_BASE)
-#define INT_850_USB_HHC_1	(27 + IH2_BASE)
-#define INT_850_USB_HHC_2	(28 + IH2_BASE)
-#define INT_850_USB_GENI	(29 + IH2_BASE)
-#define INT_850_USB_OTG		(30 + IH2_BASE)
-#define INT_850_CAMERA_IF	(31 + IH2_BASE)
-#define INT_850_RNG		(32 + IH2_BASE)
-#define INT_850_DUAL_MODE_TIMER (33 + IH2_BASE)
-#define INT_850_DBB_RF_EN	(34 + IH2_BASE)
-#define INT_850_MPUIO_KEYPAD	(35 + IH2_BASE)
-#define INT_850_SHA1_MD5	(36 + IH2_BASE)
-#define INT_850_SPI_100K_2	(37 + IH2_BASE)
-#define INT_850_RNG_IDLE	(38 + IH2_BASE)
-#define INT_850_MPUIO		(39 + IH2_BASE)
-#define INT_850_LLPC_LCD_CTRL_CAN_BE_OFF	(40 + IH2_BASE)
-#define INT_850_LLPC_OE_FALLING (41 + IH2_BASE)
-#define INT_850_LLPC_OE_RISING	(42 + IH2_BASE)
-#define INT_850_LLPC_VSYNC	(43 + IH2_BASE)
-#define INT_850_WAKE_UP_REQ	(46 + IH2_BASE)
-#define INT_850_DMA_CH6		(53 + IH2_BASE)
-#define INT_850_DMA_CH7		(54 + IH2_BASE)
-#define INT_850_DMA_CH8		(55 + IH2_BASE)
-#define INT_850_DMA_CH9		(56 + IH2_BASE)
-#define INT_850_DMA_CH10	(57 + IH2_BASE)
-#define INT_850_DMA_CH11	(58 + IH2_BASE)
-#define INT_850_DMA_CH12	(59 + IH2_BASE)
-#define INT_850_DMA_CH13	(60 + IH2_BASE)
-#define INT_850_DMA_CH14	(61 + IH2_BASE)
-#define INT_850_DMA_CH15	(62 + IH2_BASE)
-#define INT_850_NAND		(63 + IH2_BASE)
-
 #define INT_24XX_SYS_NIRQ	7
 #define INT_24XX_SDMA_IRQ0	12
 #define INT_24XX_SDMA_IRQ1	13
-- 
1.6.5
