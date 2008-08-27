From: Russell King <rmk@arm.linux.org.uk>
Subject: FOR COMMENT: void __iomem * and similar casts are Bad News
Date: Wed, 27 Aug 2008 23:08:21 +0100
Message-ID: <20080827220821.GE7227@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:57131 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751239AbYH0W2D (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 27 Aug 2008 18:28:03 -0400
Received: from flint.arm.linux.org.uk ([2002:4e20:1eda:1:201:2ff:fe14:8fad])
	by caramon.arm.linux.org.uk with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69)
	(envelope-from <rmk@arm.linux.org.uk>)
	id 1KYTUT-0003Zl-Rn
	for linux-omap@vger.kernel.org; Wed, 27 Aug 2008 23:27:52 +0100
Received: from rmk by flint.arm.linux.org.uk with local (Exim 4.69)
	(envelope-from <rmk@flint.arm.linux.org.uk>)
	id 1KYTBf-0001qb-0H
	for linux-omap@vger.kernel.org; Wed, 27 Aug 2008 23:08:23 +0100
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

... are bad when overused.  Unexpected bugs can creap in.  That one cast
which someone added to shut up a perfectly valid compiler warning now
hides a potential problem.

It is possible to eliminate _lots_ of these casts (and the potential
for bad casts) by making things return the right types.  Like, making
IO_ADDRESS return "void __iomem *" rather than an integer.

I sent a similar patch to the one below against mainline to Tony today.
I've marked some changes with certain tags:

- FIXME: where I think the code is just plain wrong -
  - such as putting a physical address through a macro which converts
    virtual to physical addresses (1510 and 1610 mcbsp).
  - or passing virtual addresses to DMA functions (mcbsp).
  - or passing physical addresses when what's required is a virtual address
    (omap_udc).

- CHECKME: where I've changed something to make it build but I don't
  know if this is right.

- WBNI: more a preference to see something changed than a bug.

Comments on the FIXMEs are what I'm really interested in, and preferably
having them actually fixed would be a good idea.

I've compile tested this on a few omap defconfigs and it at least builds.

diff --git a/arch/arm/mach-omap1/mcbsp.c b/arch/arm/mach-omap1/mcbsp.c
index 265cfc2..e5ac038 100644
--- a/arch/arm/mach-omap1/mcbsp.c
+++ b/arch/arm/mach-omap1/mcbsp.c
@@ -134,7 +134,7 @@ static struct omap_mcbsp_ops omap1_mcbsp_ops = {
 #ifdef CONFIG_ARCH_OMAP730
 static struct omap_mcbsp_platform_data omap730_mcbsp_pdata[] = {
 	{
-		.virt_base	= io_p2v(OMAP730_MCBSP1_BASE),
+		.virt_base	= IO_ADDRESS(OMAP730_MCBSP1_BASE),
 		.dma_rx_sync	= OMAP_DMA_MCBSP1_RX,
 		.dma_tx_sync	= OMAP_DMA_MCBSP1_TX,
 		.rx_irq		= INT_730_McBSP1RX,
@@ -142,7 +142,7 @@ static struct omap_mcbsp_platform_data omap730_mcbsp_pdata[] = {
 		.ops		= &omap1_mcbsp_ops,
 	},
 	{
-		.virt_base	= io_p2v(OMAP730_MCBSP2_BASE),
+		.virt_base	= IO_ADDRESS(OMAP730_MCBSP2_BASE),
 		.dma_rx_sync	= OMAP_DMA_MCBSP3_RX,
 		.dma_tx_sync	= OMAP_DMA_MCBSP3_TX,
 		.rx_irq		= INT_730_McBSP2RX,
@@ -159,7 +159,7 @@ static struct omap_mcbsp_platform_data omap730_mcbsp_pdata[] = {
 #ifdef CONFIG_ARCH_OMAP15XX
 static struct omap_mcbsp_platform_data omap15xx_mcbsp_pdata[] = {
 	{
-		.virt_base	= OMAP1510_MCBSP1_BASE,
+		.virt_base	= OMAP1510_MCBSP1_BASE,	/* FIXME: virtual or physical */
 		.dma_rx_sync	= OMAP_DMA_MCBSP1_RX,
 		.dma_tx_sync	= OMAP_DMA_MCBSP1_TX,
 		.rx_irq		= INT_McBSP1RX,
@@ -168,7 +168,7 @@ static struct omap_mcbsp_platform_data omap15xx_mcbsp_pdata[] = {
 		.clk_name	= "mcbsp_clk",
 		},
 	{
-		.virt_base	= io_p2v(OMAP1510_MCBSP2_BASE),
+		.virt_base	= IO_ADDRESS(OMAP1510_MCBSP2_BASE),
 		.dma_rx_sync	= OMAP_DMA_MCBSP2_RX,
 		.dma_tx_sync	= OMAP_DMA_MCBSP2_TX,
 		.rx_irq		= INT_1510_SPI_RX,
@@ -176,7 +176,7 @@ static struct omap_mcbsp_platform_data omap15xx_mcbsp_pdata[] = {
 		.ops		= &omap1_mcbsp_ops,
 	},
 	{
-		.virt_base	= OMAP1510_MCBSP3_BASE,
+		.virt_base	= OMAP1510_MCBSP3_BASE,	/* FIXME: virtual or physical */
 		.dma_rx_sync	= OMAP_DMA_MCBSP3_RX,
 		.dma_tx_sync	= OMAP_DMA_MCBSP3_TX,
 		.rx_irq		= INT_McBSP3RX,
@@ -194,7 +194,7 @@ static struct omap_mcbsp_platform_data omap15xx_mcbsp_pdata[] = {
 #ifdef CONFIG_ARCH_OMAP16XX
 static struct omap_mcbsp_platform_data omap16xx_mcbsp_pdata[] = {
 	{
-		.virt_base	= OMAP1610_MCBSP1_BASE,
+		.virt_base	= OMAP1610_MCBSP1_BASE,	/* FIXME: virtual or physical */
 		.dma_rx_sync	= OMAP_DMA_MCBSP1_RX,
 		.dma_tx_sync	= OMAP_DMA_MCBSP1_TX,
 		.rx_irq		= INT_McBSP1RX,
@@ -203,7 +203,7 @@ static struct omap_mcbsp_platform_data omap16xx_mcbsp_pdata[] = {
 		.clk_name	= "mcbsp_clk",
 	},
 	{
-		.virt_base	= io_p2v(OMAP1610_MCBSP2_BASE),
+		.virt_base	= IO_ADDRESS(OMAP1610_MCBSP2_BASE),
 		.dma_rx_sync	= OMAP_DMA_MCBSP2_RX,
 		.dma_tx_sync	= OMAP_DMA_MCBSP2_TX,
 		.rx_irq		= INT_1610_McBSP2_RX,
@@ -211,7 +211,7 @@ static struct omap_mcbsp_platform_data omap16xx_mcbsp_pdata[] = {
 		.ops		= &omap1_mcbsp_ops,
 	},
 	{
-		.virt_base	= OMAP1610_MCBSP3_BASE,
+		.virt_base	= OMAP1610_MCBSP3_BASE,	/* FIXME: virtual or physical */
 		.dma_rx_sync	= OMAP_DMA_MCBSP3_RX,
 		.dma_tx_sync	= OMAP_DMA_MCBSP3_TX,
 		.rx_irq		= INT_McBSP3RX,
diff --git a/arch/arm/mach-omap1/serial.c b/arch/arm/mach-omap1/serial.c
index 0e25a99..4965986 100644
--- a/arch/arm/mach-omap1/serial.c
+++ b/arch/arm/mach-omap1/serial.c
@@ -67,8 +67,8 @@ static void __init omap_serial_reset(struct plat_serial8250_port *p)
 
 static struct plat_serial8250_port serial_platform_data[] = {
 	{
-		.membase	= (char*)IO_ADDRESS(OMAP_UART1_BASE),
-		.mapbase	= (unsigned long)OMAP_UART1_BASE,
+		.membase	= IO_ADDRESS(OMAP_UART1_BASE),
+		.mapbase	= OMAP_UART1_BASE,
 		.irq		= INT_UART1,
 		.flags		= UPF_BOOT_AUTOCONF,
 		.iotype		= UPIO_MEM,
@@ -76,8 +76,8 @@ static struct plat_serial8250_port serial_platform_data[] = {
 		.uartclk	= OMAP16XX_BASE_BAUD * 16,
 	},
 	{
-		.membase	= (char*)IO_ADDRESS(OMAP_UART2_BASE),
-		.mapbase	= (unsigned long)OMAP_UART2_BASE,
+		.membase	= IO_ADDRESS(OMAP_UART2_BASE),
+		.mapbase	= OMAP_UART2_BASE,
 		.irq		= INT_UART2,
 		.flags		= UPF_BOOT_AUTOCONF,
 		.iotype		= UPIO_MEM,
@@ -85,8 +85,8 @@ static struct plat_serial8250_port serial_platform_data[] = {
 		.uartclk	= OMAP16XX_BASE_BAUD * 16,
 	},
 	{
-		.membase	= (char*)IO_ADDRESS(OMAP_UART3_BASE),
-		.mapbase	= (unsigned long)OMAP_UART3_BASE,
+		.membase	= IO_ADDRESS(OMAP_UART3_BASE),
+		.mapbase	= OMAP_UART3_BASE,
 		.irq		= INT_UART3,
 		.flags		= UPF_BOOT_AUTOCONF,
 		.iotype		= UPIO_MEM,
diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index be5c616..0c6a1b4 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -223,10 +223,11 @@ int omap2_wait_clock_ready(void __iomem *reg, u32 mask, const char *name)
 static void omap2_clk_wait_ready(struct clk *clk)
 {
 	u32 other_bit, idlest_bit;
-	unsigned long reg, other_reg, idlest_reg, prcm_mod, prcm_regid;
+	unsigned long reg, other_reg, idlest_reg, prcm_regid;
+	void __iomem *prcm_mod;
 
 	reg = (unsigned long)clk->enable_reg;
-	prcm_mod = reg & ~0xff;
+	prcm_mod = (void __iomem *)(reg & ~0xff);
 	prcm_regid = reg & 0xff;
 
 	if (prcm_regid >= CM_FCLKEN1 && prcm_regid <= OMAP24XX_CM_FCLKEN2)
diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
index 9d6c916..7e3de6e 100644
--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -59,34 +59,34 @@ static struct resource	gpmc_cs_mem[GPMC_CS_NUM];
 static DEFINE_SPINLOCK(gpmc_mem_lock);
 static unsigned		gpmc_cs_map;
 
-static u32 gpmc_base;
+static void __iomem *gpmc_base;
 
 static struct clk *gpmc_l3_clk;
 
 static void gpmc_write_reg(int idx, u32 val)
 {
-	__raw_writel(val, (__force void __iomem *)(gpmc_base + idx));
+	__raw_writel(val, gpmc_base + idx);
 }
 
 static u32 gpmc_read_reg(int idx)
 {
-	return __raw_readl((__force void __iomem *)(gpmc_base + idx));
+	return __raw_readl(gpmc_base + idx);
 }
 
 void gpmc_cs_write_reg(int cs, int idx, u32 val)
 {
-	u32 reg_addr;
+	void __iomem *reg_addr;
 
 	reg_addr = gpmc_base + GPMC_CS0 + (cs * GPMC_CS_SIZE) + idx;
-	__raw_writel(val, (__force void __iomem *)reg_addr);
+	__raw_writel(val, reg_addr);
 }
 
 u32 gpmc_cs_read_reg(int cs, int idx)
 {
-	u32 reg_addr;
+	void __iomem *reg_addr;
 
 	reg_addr = gpmc_base + GPMC_CS0 + (cs * GPMC_CS_SIZE) + idx;
-	return __raw_readl((__force void __iomem *)reg_addr);
+	return __raw_readl(reg_addr);
 }
 
 /* TODO: Add support for gpmc_fck to clock framework and use it */
@@ -417,12 +417,12 @@ void __init gpmc_init(void)
 	if (cpu_is_omap24xx()) {
 		gpmc_l3_clk = clk_get(NULL, "core_l3_ck");
 		if (cpu_is_omap2420())
-			gpmc_base = io_p2v(OMAP2420_GPMC_BASE);
+			gpmc_base = IO_ADDRESS(OMAP2420_GPMC_BASE);
 		else if (cpu_is_omap2430())
-			gpmc_base = io_p2v(OMAP243X_GPMC_BASE);
+			gpmc_base = IO_ADDRESS(OMAP243X_GPMC_BASE);
 	} else if (cpu_is_omap34xx()) {
 		gpmc_l3_clk = clk_get(NULL, "gpmc_fck");
-		gpmc_base = io_p2v(OMAP34XX_GPMC_BASE);
+		gpmc_base = IO_ADDRESS(OMAP34XX_GPMC_BASE);
 	}
 
 	BUG_ON(IS_ERR(gpmc_l3_clk));
diff --git a/arch/arm/mach-omap2/irq.c b/arch/arm/mach-omap2/irq.c
index 82e954a..7014505 100644
--- a/arch/arm/mach-omap2/irq.c
+++ b/arch/arm/mach-omap2/irq.c
@@ -38,7 +38,7 @@
  * for each bank.. when in doubt, consult the TRM.
  */
 static struct omap_irq_bank {
-	unsigned long base_reg;
+	void __iomem *base_reg;
 	unsigned int nr_irqs;
 } __attribute__ ((aligned(4))) irq_banks[] = {
 	{
@@ -52,12 +52,12 @@ static struct omap_irq_bank {
 
 static void intc_bank_write_reg(u32 val, struct omap_irq_bank *bank, u16 reg)
 {
-	__raw_writel(val, (__force void __iomem *)(bank->base_reg + reg));
+	__raw_writel(val, bank->base_reg + reg);
 }
 
 static u32 intc_bank_read_reg(struct omap_irq_bank *bank, u16 reg)
 {
-	return __raw_readl((__force void __iomem *)(bank->base_reg + reg));
+	return __raw_readl(bank->base_reg + reg);
 }
 
 /* XXX: FIQ and additional INTC support (only MPU at the moment) */
@@ -102,7 +102,7 @@ static void __init omap_irq_bank_init_one(struct omap_irq_bank *bank)
 	unsigned long tmp;
 
 	tmp = intc_bank_read_reg(bank, INTC_REVISION) & 0xff;
-	printk(KERN_INFO "IRQ: Found an INTC at 0x%08lx "
+	printk(KERN_INFO "IRQ: Found an INTC at 0x%p "
 			 "(revision %ld.%ld) with %d interrupts\n",
 			 bank->base_reg, tmp >> 4, tmp & 0xf, bank->nr_irqs);
 
@@ -147,9 +147,9 @@ void __init omap_init_irq(void)
 		struct omap_irq_bank *bank = irq_banks + i;
 
 		if (cpu_is_omap24xx())
-			bank->base_reg = io_p2v(OMAP24XX_IC_BASE);
+			bank->base_reg = IO_ADDRESS(OMAP24XX_IC_BASE);
 		else if (cpu_is_omap34xx())
-			bank->base_reg = io_p2v(OMAP34XX_IC_BASE);
+			bank->base_reg = IO_ADDRESS(OMAP34XX_IC_BASE);
 
 		omap_irq_bank_init_one(bank);
 
diff --git a/arch/arm/mach-omap2/mcbsp.c b/arch/arm/mach-omap2/mcbsp.c
index cedb9a6..bf6f413 100644
--- a/arch/arm/mach-omap2/mcbsp.c
+++ b/arch/arm/mach-omap2/mcbsp.c
@@ -148,7 +148,7 @@ static struct omap_mcbsp_ops omap2_mcbsp_ops = {
 #ifdef CONFIG_ARCH_OMAP24XX
 static struct omap_mcbsp_platform_data omap24xx_mcbsp_pdata[] = {
 	{
-		.virt_base	= OMAP2_IO_ADDRESS(OMAP24XX_MCBSP1_BASE),
+		.virt_base	= IO_ADDRESS(OMAP24XX_MCBSP1_BASE),
 		.dma_rx_sync	= OMAP24XX_DMA_MCBSP1_RX,
 		.dma_tx_sync	= OMAP24XX_DMA_MCBSP1_TX,
 		.rx_irq		= INT_24XX_MCBSP1_IRQ_RX,
@@ -157,7 +157,7 @@ static struct omap_mcbsp_platform_data omap24xx_mcbsp_pdata[] = {
 		.clk_name	= "mcbsp_clk",
 	},
 	{
-		.virt_base	= OMAP2_IO_ADDRESS(OMAP24XX_MCBSP2_BASE),
+		.virt_base	= IO_ADDRESS(OMAP24XX_MCBSP2_BASE),
 		.dma_rx_sync	= OMAP24XX_DMA_MCBSP2_RX,
 		.dma_tx_sync	= OMAP24XX_DMA_MCBSP2_TX,
 		.rx_irq		= INT_24XX_MCBSP2_IRQ_RX,
@@ -175,7 +175,7 @@ static struct omap_mcbsp_platform_data omap24xx_mcbsp_pdata[] = {
 #ifdef CONFIG_ARCH_OMAP34XX
 static struct omap_mcbsp_platform_data omap34xx_mcbsp_pdata[] = {
 	{
-		.virt_base	= OMAP2_IO_ADDRESS(OMAP34XX_MCBSP1_BASE),
+		.virt_base	= IO_ADDRESS(OMAP34XX_MCBSP1_BASE),
 		.dma_rx_sync	= OMAP24XX_DMA_MCBSP1_RX,
 		.dma_tx_sync	= OMAP24XX_DMA_MCBSP1_TX,
 		.rx_irq		= INT_24XX_MCBSP1_IRQ_RX,
@@ -184,7 +184,7 @@ static struct omap_mcbsp_platform_data omap34xx_mcbsp_pdata[] = {
 		.clk_name	= "mcbsp_clk",
 	},
 	{
-		.virt_base	= OMAP2_IO_ADDRESS(OMAP34XX_MCBSP2_BASE),
+		.virt_base	= IO_ADDRESS(OMAP34XX_MCBSP2_BASE),
 		.dma_rx_sync	= OMAP24XX_DMA_MCBSP2_RX,
 		.dma_tx_sync	= OMAP24XX_DMA_MCBSP2_TX,
 		.rx_irq		= INT_24XX_MCBSP2_IRQ_RX,
@@ -193,21 +193,21 @@ static struct omap_mcbsp_platform_data omap34xx_mcbsp_pdata[] = {
 		.clk_name	= "mcbsp_clk",
 	},
 	{
-		.virt_base	= OMAP2_IO_ADDRESS(OMAP34XX_MCBSP3_BASE),
+		.virt_base	= IO_ADDRESS(OMAP34XX_MCBSP3_BASE),
 		.dma_rx_sync	= OMAP24XX_DMA_MCBSP3_RX,
 		.dma_tx_sync	= OMAP24XX_DMA_MCBSP3_TX,
 		.ops		= &omap2_mcbsp_ops,
 		.clk_name	= "mcbsp_clk",
 	},
 	{
-		.virt_base	= OMAP2_IO_ADDRESS(OMAP34XX_MCBSP4_BASE),
+		.virt_base	= IO_ADDRESS(OMAP34XX_MCBSP4_BASE),
 		.dma_rx_sync	= OMAP24XX_DMA_MCBSP4_RX,
 		.dma_tx_sync	= OMAP24XX_DMA_MCBSP4_TX,
 		.ops		= &omap2_mcbsp_ops,
 		.clk_name	= "mcbsp_clk",
 	},
 	{
-		.virt_base	= OMAP2_IO_ADDRESS(OMAP34XX_MCBSP5_BASE),
+		.virt_base	= IO_ADDRESS(OMAP34XX_MCBSP5_BASE),
 		.dma_rx_sync	= OMAP24XX_DMA_MCBSP5_RX,
 		.dma_tx_sync	= OMAP24XX_DMA_MCBSP5_TX,
 		.ops		= &omap2_mcbsp_ops,
diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index bd6f8c9..dbbef90 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -28,24 +28,24 @@ static struct clk *uart_fck[OMAP_MAX_NR_PORTS];
 
 static struct plat_serial8250_port serial_platform_data[] = {
 	{
-		.membase	= (void __iomem *)IO_ADDRESS(OMAP_UART1_BASE),
-		.mapbase	= (unsigned long)OMAP_UART1_BASE,
+		.membase	= IO_ADDRESS(OMAP_UART1_BASE),
+		.mapbase	= OMAP_UART1_BASE,
 		.irq		= 72,
 		.flags		= UPF_BOOT_AUTOCONF,
 		.iotype		= UPIO_MEM,
 		.regshift	= 2,
 		.uartclk	= OMAP24XX_BASE_BAUD * 16,
 	}, {
-		.membase	= (void __iomem *)IO_ADDRESS(OMAP_UART2_BASE),
-		.mapbase	= (unsigned long)OMAP_UART2_BASE,
+		.membase	= IO_ADDRESS(OMAP_UART2_BASE),
+		.mapbase	= OMAP_UART2_BASE,
 		.irq		= 73,
 		.flags		= UPF_BOOT_AUTOCONF,
 		.iotype		= UPIO_MEM,
 		.regshift	= 2,
 		.uartclk	= OMAP24XX_BASE_BAUD * 16,
 	}, {
-		.membase	= (void __iomem *)IO_ADDRESS(OMAP_UART3_BASE),
-		.mapbase	= (unsigned long)OMAP_UART3_BASE,
+		.membase	= IO_ADDRESS(OMAP_UART3_BASE),
+		.mapbase	= OMAP_UART3_BASE,
 		.irq		= 74,
 		.flags		= UPF_BOOT_AUTOCONF,
 		.iotype		= UPIO_MEM,
diff --git a/arch/arm/plat-omap/common.c b/arch/arm/plat-omap/common.c
index 2914af0..3cf726b 100644
--- a/arch/arm/plat-omap/common.c
+++ b/arch/arm/plat-omap/common.c
@@ -281,12 +281,12 @@ static void __init __omap2_set_globals(void)
 
 static struct omap_globals omap242x_globals = {
 	.class	= OMAP242X_CLASS,
-	.tap	= (__force void __iomem *)OMAP2_IO_ADDRESS(0x48014000),
-	.sdrc	= (__force void __iomem *)OMAP2_IO_ADDRESS(OMAP2420_SDRC_BASE),
-	.sms	= (__force void __iomem *)OMAP2_IO_ADDRESS(OMAP2420_SMS_BASE),
-	.ctrl	= (__force void __iomem *)OMAP2_IO_ADDRESS(OMAP2420_CTRL_BASE),
-	.prm	= (__force void __iomem *)OMAP2_IO_ADDRESS(OMAP2420_PRM_BASE),
-	.cm	= (__force void __iomem *)OMAP2_IO_ADDRESS(OMAP2420_CM_BASE),
+	.tap	= IO_ADDRESS(0x48014000),
+	.sdrc	= IO_ADDRESS(OMAP2420_SDRC_BASE),
+	.sms	= IO_ADDRESS(OMAP2420_SMS_BASE),
+	.ctrl	= IO_ADDRESS(OMAP2420_CTRL_BASE),
+	.prm	= IO_ADDRESS(OMAP2420_PRM_BASE),
+	.cm	= IO_ADDRESS(OMAP2420_CM_BASE),
 };
 
 void __init omap2_set_globals_242x(void)
@@ -300,12 +300,12 @@ void __init omap2_set_globals_242x(void)
 
 static struct omap_globals omap243x_globals = {
 	.class	= OMAP243X_CLASS,
-	.tap	= (__force void __iomem *)OMAP2_IO_ADDRESS(0x4900a000),
-	.sdrc	= (__force void __iomem *)OMAP2_IO_ADDRESS(OMAP243X_SDRC_BASE),
-	.sms	= (__force void __iomem *)OMAP2_IO_ADDRESS(OMAP243X_SMS_BASE),
-	.ctrl	= (__force void __iomem *)OMAP2_IO_ADDRESS(OMAP243X_CTRL_BASE),
-	.prm	= (__force void __iomem *)OMAP2_IO_ADDRESS(OMAP2430_PRM_BASE),
-	.cm	= (__force void __iomem *)OMAP2_IO_ADDRESS(OMAP2430_CM_BASE),
+	.tap	= IO_ADDRESS(0x4900a000),
+	.sdrc	= IO_ADDRESS(OMAP243X_SDRC_BASE),
+	.sms	= IO_ADDRESS(OMAP243X_SMS_BASE),
+	.ctrl	= IO_ADDRESS(OMAP243X_CTRL_BASE),
+	.prm	= IO_ADDRESS(OMAP2430_PRM_BASE),
+	.cm	= IO_ADDRESS(OMAP2430_CM_BASE),
 };
 
 void __init omap2_set_globals_243x(void)
@@ -319,12 +319,12 @@ void __init omap2_set_globals_243x(void)
 
 static struct omap_globals omap343x_globals = {
 	.class	= OMAP343X_CLASS,
-	.tap	= (__force void __iomem *)OMAP2_IO_ADDRESS(0x4830A000),
-	.sdrc	= (__force void __iomem *)OMAP2_IO_ADDRESS(OMAP343X_SDRC_BASE),
-	.sms	= (__force void __iomem *)OMAP2_IO_ADDRESS(OMAP343X_SMS_BASE),
-	.ctrl	= (__force void __iomem *)OMAP2_IO_ADDRESS(OMAP343X_CTRL_BASE),
-	.prm	= (__force void __iomem *)OMAP2_IO_ADDRESS(OMAP3430_PRM_BASE),
-	.cm	= (__force void __iomem *)OMAP2_IO_ADDRESS(OMAP3430_CM_BASE),
+	.tap	= IO_ADDRESS(0x4830A000),
+	.sdrc	= IO_ADDRESS(OMAP343X_SDRC_BASE),
+	.sms	= IO_ADDRESS(OMAP343X_SMS_BASE),
+	.ctrl	= IO_ADDRESS(OMAP343X_CTRL_BASE),
+	.prm	= IO_ADDRESS(OMAP3430_PRM_BASE),
+	.cm	= IO_ADDRESS(OMAP3430_CM_BASE),
 };
 
 void __init omap2_set_globals_343x(void)
diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
index 1c6b905..bb3f187 100644
--- a/arch/arm/plat-omap/dma.c
+++ b/arch/arm/plat-omap/dma.c
@@ -2298,13 +2298,13 @@ static int __init omap_init_dma(void)
 	int ch, r;
 
 	if (cpu_class_is_omap1()) {
-		omap_dma_base = (void __iomem *)IO_ADDRESS(OMAP1_DMA_BASE);
+		omap_dma_base = IO_ADDRESS(OMAP1_DMA_BASE);
 		dma_lch_count = OMAP1_LOGICAL_DMA_CH_COUNT;
 	} else if (cpu_is_omap24xx()) {
-		omap_dma_base = (void __iomem *)IO_ADDRESS(OMAP24XX_DMA4_BASE);
+		omap_dma_base = IO_ADDRESS(OMAP24XX_DMA4_BASE);
 		dma_lch_count = OMAP_DMA4_LOGICAL_DMA_CH_COUNT;
 	} else if (cpu_is_omap34xx()) {
-		omap_dma_base = (void __iomem *)IO_ADDRESS(OMAP34XX_DMA4_BASE);
+		omap_dma_base = IO_ADDRESS(OMAP34XX_DMA4_BASE);
 		dma_lch_count = OMAP_DMA4_LOGICAL_DMA_CH_COUNT;
 	} else {
 		pr_err("DMA init failed for unsupported omap\n");
diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
index 8b4b553..167ec2f 100644
--- a/arch/arm/plat-omap/dmtimer.c
+++ b/arch/arm/plat-omap/dmtimer.c
@@ -693,7 +693,7 @@ int __init omap_dm_timer_init(void)
 
 	for (i = 0; i < dm_timer_count; i++) {
 		timer = &dm_timers[i];
-		timer->io_base = (void __iomem *)io_p2v(timer->phys_base);
+		timer->io_base = IO_ADDRESS(timer->phys_base);
 #if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
 		if (cpu_class_is_omap2()) {
 			char clk_name[16];
diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
index 3e76ee2..dee380b 100644
--- a/arch/arm/plat-omap/gpio.c
+++ b/arch/arm/plat-omap/gpio.c
@@ -1488,7 +1488,7 @@ static int __init _omap_gpio_init(void)
 		bank->chip.set = gpio_set;
 		if (bank_is_mpuio(bank)) {
 			bank->chip.label = "mpuio";
-#ifdef CONFIG_ARCH_OMAP1
+#ifdef CONFIG_ARCH_OMAP16XX /* CHECKME */
 			bank->chip.dev = &omap_mpuio_device.dev;
 #endif
 			bank->chip.base = OMAP_MPUIO(0);
diff --git a/arch/arm/plat-omap/include/mach/control.h b/arch/arm/plat-omap/include/mach/control.h
index 1cd98fd..91d7480 100644
--- a/arch/arm/plat-omap/include/mach/control.h
+++ b/arch/arm/plat-omap/include/mach/control.h
@@ -18,18 +18,9 @@
 
 #include <mach/io.h>
 
-#ifndef __ASSEMBLY__
-#define OMAP242X_CTRL_REGADDR(reg)					\
-	(void __iomem *)IO_ADDRESS(OMAP242X_CTRL_BASE + (reg))
-#define OMAP243X_CTRL_REGADDR(reg)					\
-	(void __iomem *)IO_ADDRESS(OMAP243X_CTRL_BASE + (reg))
-#define OMAP343X_CTRL_REGADDR(reg)					\
-	(void __iomem *)IO_ADDRESS(OMAP343X_CTRL_BASE + (reg))
-#else
 #define OMAP242X_CTRL_REGADDR(reg)	IO_ADDRESS(OMAP242X_CTRL_BASE + (reg))
 #define OMAP243X_CTRL_REGADDR(reg)	IO_ADDRESS(OMAP243X_CTRL_BASE + (reg))
 #define OMAP343X_CTRL_REGADDR(reg)	IO_ADDRESS(OMAP343X_CTRL_BASE + (reg))
-#endif /* __ASSEMBLY__ */
 
 /*
  * As elsewhere, the "OMAP2_" prefix indicates that the macro is valid for
diff --git a/arch/arm/plat-omap/include/mach/io.h b/arch/arm/plat-omap/include/mach/io.h
index 7d3481b..5126a0a 100644
--- a/arch/arm/plat-omap/include/mach/io.h
+++ b/arch/arm/plat-omap/include/mach/io.h
@@ -55,14 +55,12 @@
 
 #if defined(CONFIG_ARCH_OMAP1)
 
-#define IO_PHYS		0xFFFB0000
-#define IO_OFFSET	0x01000000	/* Virtual IO = 0xfefb0000 */
-#define IO_SIZE		0x40000
-#define IO_VIRT		(IO_PHYS - IO_OFFSET)
-#define IO_ADDRESS(pa)	((pa) - IO_OFFSET)
-#define OMAP1_IO_ADDRESS(pa)	((pa) - IO_OFFSET)
-#define io_p2v(pa)	((pa) - IO_OFFSET)
-#define io_v2p(va)	((va) + IO_OFFSET)
+#define IO_PHYS			0xFFFB0000
+#define IO_OFFSET		0x01000000	/* Virtual IO = 0xfefb0000 */
+#define IO_SIZE			0x40000
+#define IO_VIRT			(IO_PHYS - IO_OFFSET)
+#define __IO_ADDRESS(pa)	((pa) - IO_OFFSET)
+#define io_v2p(va)		((va) + IO_OFFSET)
 
 #elif defined(CONFIG_ARCH_OMAP2)
 
@@ -90,11 +88,9 @@
 
 #endif
 
-#define IO_OFFSET	0x90000000
-#define IO_ADDRESS(pa)	((pa) + IO_OFFSET)	/* Works for L3 and L4 */
-#define OMAP2_IO_ADDRESS(pa)	((pa) + IO_OFFSET)	/* Works for L3 and L4 */
-#define io_p2v(pa)	((pa) + IO_OFFSET)	/* Works for L3 and L4 */
-#define io_v2p(va)	((va) - IO_OFFSET)	/* Works for L3 and L4 */
+#define IO_OFFSET		0x90000000
+#define __IO_ADDRESS(pa)	((pa) + IO_OFFSET)	/* Works for L3 and L4 */
+#define io_v2p(va)		((va) - IO_OFFSET)	/* Works for L3 and L4 */
 
 /* DSP */
 #define DSP_MEM_24XX_PHYS	OMAP2420_DSP_MEM_BASE	/* 0x58000000 */
@@ -149,9 +145,7 @@
 
 
 #define IO_OFFSET		0x90000000
-#define IO_ADDRESS(pa)		((pa) + IO_OFFSET)/* Works for L3 and L4 */
-#define OMAP2_IO_ADDRESS(pa)	((pa) + IO_OFFSET)/* Works for L3 and L4 */
-#define io_p2v(pa)		((pa) + IO_OFFSET)/* Works for L3 and L4 */
+#define __IO_ADDRESS(pa)	((pa) + IO_OFFSET)/* Works for L3 and L4 */
 #define io_v2p(va)		((va) - IO_OFFSET)/* Works for L3 and L4 */
 
 /* DSP */
@@ -167,7 +161,13 @@
 
 #endif
 
-#ifndef __ASSEMBLER__
+#ifdef __ASSEMBLER__
+
+#define IO_ADDRESS(pa)		__IO_ADDRESS(pa)
+
+#else
+
+#define IO_ADDRESS(pa)		((void __iomem *)__IO_ADDRESS(pa))
 
 /*
  * Functions to access the OMAP IO region
diff --git a/arch/arm/plat-omap/include/mach/mcbsp.h b/arch/arm/plat-omap/include/mach/mcbsp.h
index c04bcd5..3c02bf6 100644
--- a/arch/arm/plat-omap/include/mach/mcbsp.h
+++ b/arch/arm/plat-omap/include/mach/mcbsp.h
@@ -326,7 +326,7 @@ struct omap_mcbsp_ops {
 };
 
 struct omap_mcbsp_platform_data {
-	u32 virt_base;
+	void __iomem *virt_base;
 	u8 dma_rx_sync, dma_tx_sync;
 	u16 rx_irq, tx_irq;
 	struct omap_mcbsp_ops *ops;
@@ -335,7 +335,7 @@ struct omap_mcbsp_platform_data {
 
 struct omap_mcbsp {
 	struct device *dev;
-	u32 io_base;
+	void __iomem *io_base;
 	u8 id;
 	u8 free;
 	omap_mcbsp_word_length rx_word_length;
diff --git a/arch/arm/plat-omap/include/mach/pm.h b/arch/arm/plat-omap/include/mach/pm.h
index 5a1f3db..e4cf1c5 100644
--- a/arch/arm/plat-omap/include/mach/pm.h
+++ b/arch/arm/plat-omap/include/mach/pm.h
@@ -39,11 +39,11 @@
  * Register and offset definitions to be used in PM assembler code
  * ----------------------------------------------------------------------------
  */
-#define CLKGEN_REG_ASM_BASE		io_p2v(0xfffece00)
+#define CLKGEN_REG_ASM_BASE		IO_ADDRESS(0xfffece00)
 #define ARM_IDLECT1_ASM_OFFSET		0x04
 #define ARM_IDLECT2_ASM_OFFSET		0x08
 
-#define TCMIF_ASM_BASE			io_p2v(0xfffecc00)
+#define TCMIF_ASM_BASE			IO_ADDRESS(0xfffecc00)
 #define EMIFS_CONFIG_ASM_OFFSET		0x0c
 #define EMIFF_SDRAM_CONFIG_ASM_OFFSET	0x20
 
diff --git a/arch/arm/plat-omap/include/mach/sdrc.h b/arch/arm/plat-omap/include/mach/sdrc.h
index b7db862..c66c838 100644
--- a/arch/arm/plat-omap/include/mach/sdrc.h
+++ b/arch/arm/plat-omap/include/mach/sdrc.h
@@ -75,12 +75,9 @@
  * SMS register access
  */
 
-#define OMAP242X_SMS_REGADDR(reg)					\
-			(void __iomem *)IO_ADDRESS(OMAP2420_SMS_BASE + reg)
-#define OMAP243X_SMS_REGADDR(reg)					\
-			(void __iomem *)IO_ADDRESS(OMAP243X_SMS_BASE + reg)
-#define OMAP343X_SMS_REGADDR(reg)					\
-			(void __iomem *)IO_ADDRESS(OMAP343X_SMS_BASE + reg)
+#define OMAP242X_SMS_REGADDR(reg)	IO_ADDRESS(OMAP2420_SMS_BASE + reg)
+#define OMAP243X_SMS_REGADDR(reg)	IO_ADDRESS(OMAP243X_SMS_BASE + reg)
+#define OMAP343X_SMS_REGADDR(reg)	IO_ADDRESS(OMAP343X_SMS_BASE + reg)
 
 /* SMS register offsets - read/write with sms_{read,write}_reg() */
 
diff --git a/arch/arm/plat-omap/include/mach/serial.h b/arch/arm/plat-omap/include/mach/serial.h
index abea6ef..c6b7f59 100644
--- a/arch/arm/plat-omap/include/mach/serial.h
+++ b/arch/arm/plat-omap/include/mach/serial.h
@@ -33,9 +33,9 @@
 #define OMAP24XX_BASE_BAUD	(48000000/16)
 
 #define is_omap_port(p)	({int __ret = 0;			\
-			if (p == IO_ADDRESS(OMAP_UART1_BASE) ||	\
-			    p == IO_ADDRESS(OMAP_UART2_BASE) ||	\
-			    p == IO_ADDRESS(OMAP_UART3_BASE))	\
+			if (p == OMAP_UART1_BASE ||		\
+			    p == OMAP_UART2_BASE ||		\
+			    p == OMAP_UART3_BASE)		\
 				__ret = 1;			\
 			__ret;					\
 			})
diff --git a/arch/arm/plat-omap/mcbsp.c b/arch/arm/plat-omap/mcbsp.c
index 0f0e3f3..51d715f 100644
--- a/arch/arm/plat-omap/mcbsp.c
+++ b/arch/arm/plat-omap/mcbsp.c
@@ -30,7 +30,7 @@
 struct omap_mcbsp **mcbsp_ptr;
 int omap_mcbsp_count;
 
-void omap_mcbsp_write(u32 io_base, u16 reg, u32 val)
+void omap_mcbsp_write(void __iomem *io_base, u16 reg, u32 val)
 {
 	if (cpu_class_is_omap1() || cpu_is_omap2420())
 		__raw_writew((u16)val, io_base + reg);
@@ -38,7 +38,7 @@ void omap_mcbsp_write(u32 io_base, u16 reg, u32 val)
 		__raw_writel(val, io_base + reg);
 }
 
-int omap_mcbsp_read(u32 io_base, u16 reg)
+int omap_mcbsp_read(void __iomem *io_base, u16 reg)
 {
 	if (cpu_class_is_omap1() || cpu_is_omap2420())
 		return __raw_readw(io_base + reg);
@@ -149,7 +149,7 @@ static void omap_mcbsp_rx_dma_callback(int lch, u16 ch_status, void *data)
 void omap_mcbsp_config(unsigned int id, const struct omap_mcbsp_reg_cfg *config)
 {
 	struct omap_mcbsp *mcbsp;
-	u32 io_base;
+	void __iomem *io_base;
 
 	if (!omap_mcbsp_check_valid_id(id)) {
 		printk(KERN_ERR "%s: Invalid id (%d)\n", __func__, id + 1);
@@ -158,7 +158,7 @@ void omap_mcbsp_config(unsigned int id, const struct omap_mcbsp_reg_cfg *config)
 	mcbsp = id_to_mcbsp_ptr(id);
 
 	io_base = mcbsp->io_base;
-	dev_dbg(mcbsp->dev, "Configuring McBSP%d  io_base: 0x%8x\n",
+	dev_dbg(mcbsp->dev, "Configuring McBSP%d  io_base: 0x%p\n",
 			mcbsp->id, io_base);
 
 	/* We write the given config */
@@ -306,7 +306,7 @@ EXPORT_SYMBOL(omap_mcbsp_free);
 void omap_mcbsp_start(unsigned int id)
 {
 	struct omap_mcbsp *mcbsp;
-	u32 io_base;
+	void __iomem *io_base;
 	u16 w;
 
 	if (!omap_mcbsp_check_valid_id(id)) {
@@ -344,7 +344,7 @@ EXPORT_SYMBOL(omap_mcbsp_start);
 void omap_mcbsp_stop(unsigned int id)
 {
 	struct omap_mcbsp *mcbsp;
-	u32 io_base;
+	void __iomem *io_base;
 	u16 w;
 
 	if (!omap_mcbsp_check_valid_id(id)) {
@@ -373,7 +373,7 @@ EXPORT_SYMBOL(omap_mcbsp_stop);
 int omap_mcbsp_pollwrite(unsigned int id, u16 buf)
 {
 	struct omap_mcbsp *mcbsp;
-	u32 base;
+	void __iomem *base;
 
 	if (!omap_mcbsp_check_valid_id(id)) {
 		printk(KERN_ERR "%s: Invalid id (%d)\n", __func__, id + 1);
@@ -418,7 +418,7 @@ EXPORT_SYMBOL(omap_mcbsp_pollwrite);
 int omap_mcbsp_pollread(unsigned int id, u16 *buf)
 {
 	struct omap_mcbsp *mcbsp;
-	u32 base;
+	void __iomem *base;
 
 	if (!omap_mcbsp_check_valid_id(id)) {
 		printk(KERN_ERR "%s: Invalid id (%d)\n", __func__, id + 1);
@@ -465,7 +465,7 @@ EXPORT_SYMBOL(omap_mcbsp_pollread);
 void omap_mcbsp_xmit_word(unsigned int id, u32 word)
 {
 	struct omap_mcbsp *mcbsp;
-	u32 io_base;
+	void __iomem *io_base;
 	omap_mcbsp_word_length word_length;
 
 	if (!omap_mcbsp_check_valid_id(id)) {
@@ -488,7 +488,7 @@ EXPORT_SYMBOL(omap_mcbsp_xmit_word);
 u32 omap_mcbsp_recv_word(unsigned int id)
 {
 	struct omap_mcbsp *mcbsp;
-	u32 io_base;
+	void __iomem *io_base;
 	u16 word_lsb, word_msb = 0;
 	omap_mcbsp_word_length word_length;
 
@@ -514,7 +514,7 @@ EXPORT_SYMBOL(omap_mcbsp_recv_word);
 int omap_mcbsp_spi_master_xmit_word_poll(unsigned int id, u32 word)
 {
 	struct omap_mcbsp *mcbsp;
-	u32 io_base;
+	void __iomem *io_base;
 	omap_mcbsp_word_length tx_word_length;
 	omap_mcbsp_word_length rx_word_length;
 	u16 spcr2, spcr1, attempts = 0, word_lsb, word_msb = 0;
@@ -580,7 +580,8 @@ EXPORT_SYMBOL(omap_mcbsp_spi_master_xmit_word_poll);
 int omap_mcbsp_spi_master_recv_word_poll(unsigned int id, u32 *word)
 {
 	struct omap_mcbsp *mcbsp;
-	u32 io_base, clock_word = 0;
+	u32 clock_word = 0;
+	void __iomem *io_base;
 	omap_mcbsp_word_length tx_word_length;
 	omap_mcbsp_word_length rx_word_length;
 	u16 spcr2, spcr1, attempts = 0, word_lsb, word_msb = 0;
@@ -701,6 +702,7 @@ int omap_mcbsp_xmit_buffer(unsigned int id, dma_addr_t buffer,
 	omap_set_dma_dest_params(mcbsp->dma_tx_lch,
 				 src_port,
 				 OMAP_DMA_AMODE_CONSTANT,
+				 /* FIXME: this is a virtual address */
 				 mcbsp->io_base + OMAP_MCBSP_REG_DXR1,
 				 0, 0);
 
@@ -764,6 +766,7 @@ int omap_mcbsp_recv_buffer(unsigned int id, dma_addr_t buffer,
 	omap_set_dma_src_params(mcbsp->dma_rx_lch,
 				src_port,
 				OMAP_DMA_AMODE_CONSTANT,
+				/* FIXME: this is a virtual address */
 				mcbsp->io_base + OMAP_MCBSP_REG_DRR1,
 				0, 0);
 
diff --git a/drivers/char/hw_random/omap-rng.c b/drivers/char/hw_random/omap-rng.c
index 154a21f..668bf7d 100644
--- a/drivers/char/hw_random/omap-rng.c
+++ b/drivers/char/hw_random/omap-rng.c
@@ -122,7 +122,7 @@ static int __init omap_rng_probe(struct platform_device *pdev)
 		return -EBUSY;
 
 	dev_set_drvdata(&pdev->dev, mem);
-	rng_base = (u32 __force __iomem *)io_p2v(res->start);
+	rng_base = IO_ADDRESS(res->start); /* WBNI: why not ioremap? */
 
 	ret = hwrng_register(&omap_rng_ops);
 	if (ret) {
diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 3c4e581..978c072 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -757,7 +757,7 @@ omap_i2c_probe(struct platform_device *pdev)
 	dev->speed = *speed;
 	dev->dev = &pdev->dev;
 	dev->irq = irq->start;
-	dev->base = (void __iomem *) IO_ADDRESS(mem->start);
+	dev->base = IO_ADDRESS(mem->start); /* WBNI: why not ioremap? */
 	platform_set_drvdata(pdev, dev);
 
 	if ((r = omap_i2c_get_clocks(dev)) != 0)
diff --git a/drivers/mmc/host/omap.c b/drivers/mmc/host/omap.c
index c160288..802877c 100644
--- a/drivers/mmc/host/omap.c
+++ b/drivers/mmc/host/omap.c
@@ -1455,7 +1455,7 @@ static int __init mmc_omap_probe(struct platform_device *pdev)
 
 	host->irq = irq;
 	host->phys_base = host->mem_res->start;
-	host->virt_base = (void __iomem *) IO_ADDRESS(host->phys_base);
+	host->virt_base = IO_ADDRESS(host->phys_base); /* WBNI: why not ioremap? */
 
 	if (cpu_is_omap24xx()) {
 		host->iclk = clk_get(&pdev->dev, "mmc_ick");
diff --git a/drivers/serial/8250.c b/drivers/serial/8250.c
index 5a5f95f..2ba5cbb 100644
--- a/drivers/serial/8250.c
+++ b/drivers/serial/8250.c
@@ -2209,7 +2209,7 @@ serial8250_set_termios(struct uart_port *port, struct ktermios *termios,
 
 #ifdef CONFIG_ARCH_OMAP15XX
 	/* Workaround to enable 115200 baud on OMAP1510 internal ports */
-	if (cpu_is_omap1510() && is_omap_port((unsigned int)up->port.membase)) {
+	if (cpu_is_omap1510() && is_omap_port(up->port.mapbase)) {
 		if (baud == 115200) {
 			quot = 1;
 			serial_out(up, UART_OMAP_OSC_12M_SEL, 1);
@@ -2284,7 +2284,7 @@ static int serial8250_request_std_resource(struct uart_8250_port *up)
 	int ret = 0;
 
 #ifdef CONFIG_ARCH_OMAP
-	if (is_omap_port((unsigned int)up->port.membase))
+	if (is_omap_port(up->port.mapbase))
 		size = 0x16 << up->port.regshift;
 #endif
 
diff --git a/drivers/spi/omap2_mcspi.c b/drivers/spi/omap2_mcspi.c
index 9d2186f..8178665 100644
--- a/drivers/spi/omap2_mcspi.c
+++ b/drivers/spi/omap2_mcspi.c
@@ -119,12 +119,14 @@ struct omap2_mcspi {
 	struct clk		*fck;
 	/* Virtual base address of the controller */
 	void __iomem		*base;
+	unsigned long		phys;
 	/* SPI1 has 4 channels, while SPI2 has 2 */
 	struct omap2_mcspi_dma	*dma_channels;
 };
 
 struct omap2_mcspi_cs {
 	void __iomem		*base;
+	unsigned long		phys;
 	int			word_len;
 };
 
@@ -233,7 +235,7 @@ omap2_mcspi_txrx_dma(struct spi_device *spi, struct spi_transfer *xfer)
 	c = count;
 	word_len = cs->word_len;
 
-	base = (unsigned long) io_v2p(cs->base);
+	base = cs->phys;
 	tx_reg = base + OMAP2_MCSPI_TX0;
 	rx_reg = base + OMAP2_MCSPI_RX0;
 	rx = xfer->rx_buf;
@@ -633,6 +635,7 @@ static int omap2_mcspi_setup(struct spi_device *spi)
 		if (!cs)
 			return -ENOMEM;
 		cs->base = mcspi->base + spi->chip_select * 0x14;
+		cs->phys = mcspi->phys + spi->chip_select * 0x14;
 		spi->controller_state = cs;
 	}
 
@@ -1005,7 +1008,8 @@ static int __init omap2_mcspi_probe(struct platform_device *pdev)
 		goto err1;
 	}
 
-	mcspi->base = (void __iomem *) io_p2v(r->start);
+	mcspi->phys = r->start;
+	mcspi->base = IO_ADDRESS(r->start); /* WBNI: why not ioremap? */
 
 	INIT_WORK(&mcspi->work, omap2_mcspi_work);
 
diff --git a/drivers/spi/omap_uwire.c b/drivers/spi/omap_uwire.c
index 5515eb9..3166635 100644
--- a/drivers/spi/omap_uwire.c
+++ b/drivers/spi/omap_uwire.c
@@ -59,7 +59,7 @@
  * and irqs should show there too...
  */
 #define UWIRE_BASE_PHYS		0xFFFB3000
-#define UWIRE_BASE		((void *__iomem)IO_ADDRESS(UWIRE_BASE_PHYS))
+#define UWIRE_BASE		IO_ADDRESS(UWIRE_BASE_PHYS)
 
 /* uWire Registers: */
 #define UWIRE_IO_SIZE 0x20
diff --git a/drivers/usb/gadget/omap_udc.c b/drivers/usb/gadget/omap_udc.c
index a2638ee..7032975 100644
--- a/drivers/usb/gadget/omap_udc.c
+++ b/drivers/usb/gadget/omap_udc.c
@@ -786,6 +786,7 @@ static void dma_channel_claim(struct omap_ep *ep, unsigned channel)
 			omap_set_dma_dest_params(ep->lch,
 				OMAP_DMA_PORT_TIPB,
 				OMAP_DMA_AMODE_CONSTANT,
+				/* FIXME: aren't these already physical addresses */
 				(unsigned long) io_v2p(UDC_DATA_DMA),
 				0, 0);
 		}
@@ -803,6 +804,7 @@ static void dma_channel_claim(struct omap_ep *ep, unsigned channel)
 			omap_set_dma_src_params(ep->lch,
 				OMAP_DMA_PORT_TIPB,
 				OMAP_DMA_AMODE_CONSTANT,
+				/* FIXME: aren't these already physical addresses */
 				(unsigned long) io_v2p(UDC_DATA_DMA),
 				0, 0);
 			/* EMIFF or SDRC */
diff --git a/drivers/usb/host/ohci-omap.c b/drivers/usb/host/ohci-omap.c
index 71fb9fd..c2fa621 100644
--- a/drivers/usb/host/ohci-omap.c
+++ b/drivers/usb/host/ohci-omap.c
@@ -208,7 +208,7 @@ static int ohci_omap_init(struct usb_hcd *hcd)
 	if (cpu_is_omap16xx())
 		ocpi_enable();
 
-#ifdef	CONFIG_ARCH_OMAP_OTG
+#ifdef	CONFIG_USB_OTG /* CHECKME */
 	if (need_transceiver) {
 		ohci->transceiver = otg_get_transceiver();
 		if (ohci->transceiver) {
@@ -343,7 +343,7 @@ static int usb_hcd_omap_probe (const struct hc_driver *driver,
 		goto err1;
 	}
 
-	hcd->regs = (void __iomem *) (int) IO_ADDRESS(hcd->rsrc_start);
+	hcd->regs = IO_ADDRESS(hcd->rsrc_start); /* WBNI: why not ioremap? */
 
 	ohci = hcd_to_ohci(hcd);
 	ohci_hcd_init(ohci);
diff --git a/drivers/video/omap/dispc.c b/drivers/video/omap/dispc.c
index 00ad6b2..3e802b7 100644
--- a/drivers/video/omap/dispc.c
+++ b/drivers/video/omap/dispc.c
@@ -156,7 +156,7 @@ struct resmap {
 };
 
 static struct {
-	u32		base;
+	void __iomem	*base;
 
 	struct omapfb_mem_desc	mem_desc;
 	struct resmap		*res_map[DISPC_MEMTYPE_NUM];
@@ -212,9 +212,9 @@ static void enable_rfbi_mode(int enable)
 	dispc_write_reg(DISPC_CONTROL, l);
 
 	/* Set bypass mode in RFBI module */
-	l = __raw_readl(io_p2v(RFBI_CONTROL));
+	l = __raw_readl(IO_ADDRESS(RFBI_CONTROL));
 	l |= enable ? 0 : (1 << 1);
-	__raw_writel(l, io_p2v(RFBI_CONTROL));
+	__raw_writel(l, IO_ADDRESS(RFBI_CONTROL));
 }
 
 static void set_lcd_data_lines(int data_lines)
@@ -1353,7 +1353,7 @@ static int omap_dispc_init(struct omapfb_device *fbdev, int ext_mode,
 
 	memset(&dispc, 0, sizeof(dispc));
 
-	dispc.base = io_p2v(DISPC_BASE);
+	dispc.base = IO_ADDRESS(DISPC_BASE);
 	dispc.fbdev = fbdev;
 	dispc.ext_mode = ext_mode;
 
@@ -1417,7 +1417,7 @@ static int omap_dispc_init(struct omapfb_device *fbdev, int ext_mode,
 	}
 
 	/* L3 firewall setting: enable access to OCM RAM */
-	__raw_writel(0x402000b0, io_p2v(0x680050a0));
+	__raw_writel(0x402000b0, IO_ADDRESS(0x680050a0));
 
 	if ((r = alloc_palette_ram()) < 0)
 		goto fail2;
diff --git a/drivers/video/omap/rfbi.c b/drivers/video/omap/rfbi.c
index 470920d..59f857e 100644
--- a/drivers/video/omap/rfbi.c
+++ b/drivers/video/omap/rfbi.c
@@ -59,7 +59,7 @@
 #define DISPC_CONTROL		0x0040
 
 static struct {
-	u32		base;
+	void __iomem	*base;
 	void		(*lcdc_callback)(void *data);
 	void		*lcdc_callback_data;
 	unsigned long	l4_khz;
@@ -518,7 +518,7 @@ static int rfbi_init(struct omapfb_device *fbdev)
 	int r;
 
 	rfbi.fbdev = fbdev;
-	rfbi.base = io_p2v(RFBI_BASE);
+	rfbi.base = IO_ADDRESS(RFBI_BASE);
 
 	if ((r = rfbi_get_clocks()) < 0)
 		return r;
diff --git a/drivers/video/omap/sossi.c b/drivers/video/omap/sossi.c
index b4f67fc..9839d35 100644
--- a/drivers/video/omap/sossi.c
+++ b/drivers/video/omap/sossi.c
@@ -574,7 +574,7 @@ static int sossi_init(struct omapfb_device *fbdev)
 	struct clk *dpll1out_ck;
 	int r;
 
-	sossi.base = (void __iomem *)IO_ADDRESS(OMAP_SOSSI_BASE);
+	sossi.base = IO_ADDRESS(OMAP_SOSSI_BASE);
 	sossi.fbdev = fbdev;
 	spin_lock_init(&sossi.lock);
 



-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
