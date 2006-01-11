From: Kyungmin Park <kyungmin.park@samsung.com>
Subject: [PATCH] McBSP support on omap24xx
Date: Wed, 11 Jan 2006 13:52:33 +0900
Message-ID: <0ISW0094BW7LPP@mmp2.samsung.com>
References: <20060110105245.80937.qmail@web32913.mail.mud.yahoo.com>
Reply-To: kyungmin.park@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-reply-to: <20060110105245.80937.qmail@web32913.mail.mud.yahoo.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: 'Komal Shah' <komal_shah802003@yahoo.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

> 
> > I wait you SPI patch, In fact, I don't know SPI framework.
> > 
> > To test audio, we also modify sound/oss/omap-* files.
> > After some cleanup I will send it ASAP
> 
> Please post the McBSP and changed audio related files for 24xx, once
> you get time to the list. Atelast McBSP code can be merged the git
> tree, as audio works with your 24xx custom board.
> 

Here's McBSP patch on omap24xx

Any comments are welcome.

p.s., Yes there's TSC mux settings for future use.

Regards,
Kyungmin Park

--

diff --git a/arch/arm/mach-omap2/mux.c b/arch/arm/mach-omap2/mux.c
--- a/arch/arm/mach-omap2/mux.c
+++ b/arch/arm/mach-omap2/mux.c
@@ -50,9 +50,22 @@ MUX_CFG_24XX("H19_24XX_I2C2_SDA",	0x114,
 /* Menelaus interrupt */
 MUX_CFG_24XX("W19_24XX_SYS_NIRQ",	0x12c,	0,	1,	1,	1)
 
+/* 24xx clocks */
+MUX_CFG_24XX("W14_24XX_SYS_CLKOUT",	0x137,	0,	1,	1,	1)
+
+/* 24xx McBSP */
+MUX_CFG_24XX("Y15_24XX_MCBSP2_CLKX",	0x124,	1,	1,	0,	1)
+MUX_CFG_24XX("R14_24XX_MCBSP2_FSX",	0x125,	1,	1,	0,	1)
+MUX_CFG_24XX("W15_24XX_MCBSP2_DR",	0x126,	1,	1,	0,	1)
+MUX_CFG_24XX("V15_24XX_MCBSP2_DX",	0x127,	1,	1,	0,	1)
+
 /* 24xx GPIO */
 MUX_CFG_24XX("Y20_24XX_GPIO60",		0x12c,	3,	0,	0,
1)
 MUX_CFG_24XX("M15_24XX_GPIO92",		0x10a,	3,	0,	0,
1)
+MUX_CFG_24XX("V14_24XX_GPIO117",	0x128,	3,	1,	0,	1)
+
+/* TSC IRQ */
+MUX_CFG_24XX("P20_24XX_TSC_IRQ",	0x108,	0,	0,	0,	1)
 
 };
 
diff --git a/arch/arm/plat-omap/mcbsp.c b/arch/arm/plat-omap/mcbsp.c
--- a/arch/arm/plat-omap/mcbsp.c
+++ b/arch/arm/plat-omap/mcbsp.c
@@ -35,7 +35,7 @@
 #ifdef CONFIG_MCBSP_DEBUG
 #define DBG(x...)	printk(x)
 #else
-#define DBG(x...)	do { } while (0)
+#define DBG(x...)			do { } while (0)
 #endif
 
 struct omap_mcbsp {
@@ -65,10 +65,19 @@ struct omap_mcbsp {
 };
 
 static struct omap_mcbsp mcbsp[OMAP_MAX_MCBSP_COUNT];
+#ifdef CONFIG_ARCH_OMAP1
 static struct clk *mcbsp_dsp_ck = 0;
 static struct clk *mcbsp_api_ck = 0;
 static struct clk *mcbsp_dspxor_ck = 0;
-
+#endif
+#ifdef CONFIG_ARCH_OMAP2
+static struct clk *mcbsp1_ick = 0;
+static struct clk *mcbsp1_fck = 0;
+static struct clk *mcbsp2_ick = 0;
+static struct clk *mcbsp2_fck = 0;
+static struct clk *sys_ck = 0;
+static struct clk *sys_clkout = 0;
+#endif
 
 static void omap_mcbsp_dump_reg(u8 id)
 {
@@ -89,7 +98,6 @@ static void omap_mcbsp_dump_reg(u8 id)
 	DBG("***********************\n");
 }
 
-
 static irqreturn_t omap_mcbsp_tx_irq_handler(int irq, void *dev_id, struct
pt_regs *regs)
 {
 	struct omap_mcbsp * mcbsp_tx = (struct omap_mcbsp *)(dev_id);
@@ -110,7 +118,6 @@ static irqreturn_t omap_mcbsp_rx_irq_han
 	return IRQ_HANDLED;
 }
 
-
 static void omap_mcbsp_tx_dma_callback(int lch, u16 ch_status, void *data)
 {
 	struct omap_mcbsp * mcbsp_dma_tx = (struct omap_mcbsp *)(data);
@@ -177,7 +184,7 @@ static int omap_mcbsp_check(unsigned int
 		return 0;
 	}
 
-	if (cpu_is_omap1510() || cpu_is_omap16xx()) {
+	if (cpu_is_omap1510() || cpu_is_omap16xx() || cpu_is_omap24xx()) {
 		if (id > OMAP_MAX_MCBSP_COUNT) {
 			printk(KERN_ERR "OMAP-McBSP: McBSP%d doesn't
exist\n", id + 1);
 			return -1;
@@ -188,6 +195,7 @@ static int omap_mcbsp_check(unsigned int
 	return -1;
 }
 
+#ifdef CONFIG_ARCH_OMAP1
 static void omap_mcbsp_dsp_request(void)
 {
 	if (cpu_is_omap1510() || cpu_is_omap16xx()) {
@@ -216,6 +224,19 @@ static void omap_mcbsp_dsp_free(void)
 		clk_unuse(mcbsp_api_ck);
 	}
 }
+#endif
+
+#ifdef CONFIG_ARCH_OMAP2
+static void omap2_mcbsp2_mux_setup(void)
+{
+	omap_cfg_reg(Y15_24XX_MCBSP2_CLKX);
+	omap_cfg_reg(R14_24XX_MCBSP2_FSX);
+	omap_cfg_reg(W15_24XX_MCBSP2_DR);
+	omap_cfg_reg(V15_24XX_MCBSP2_DX);
+	omap_cfg_reg(V14_24XX_GPIO117);
+	omap_cfg_reg(W14_24XX_SYS_CLKOUT);
+}
+#endif
 
 int omap_mcbsp_request(unsigned int id)
 {
@@ -224,12 +245,26 @@ int omap_mcbsp_request(unsigned int id)
 	if (omap_mcbsp_check(id) < 0)
 		return -EINVAL;
 
+#ifdef CONFIG_ARCH_OMAP1
 	/*
 	 * On 1510, 1610 and 1710, McBSP1 and McBSP3
 	 * are DSP public peripherals.
 	 */
 	if (id == OMAP_MCBSP1 || id == OMAP_MCBSP3)
 		omap_mcbsp_dsp_request();
+#endif
+
+#ifdef CONFIG_ARCH_OMAP2
+	if (cpu_is_omap24xx()) {
+		if (id == OMAP_MCBSP1) {
+			clk_use(mcbsp1_ick);
+			clk_use(mcbsp1_fck);
+		} else {
+			clk_use(mcbsp2_ick);
+			clk_use(mcbsp2_fck);
+		}
+	}
+#endif
 
 	spin_lock(&mcbsp[id].lock);
 	if (!mcbsp[id].free) {
@@ -274,8 +309,24 @@ void omap_mcbsp_free(unsigned int id)
 	if (omap_mcbsp_check(id) < 0)
 		return;
 
-	if (id == OMAP_MCBSP1 || id == OMAP_MCBSP3)
-		omap_mcbsp_dsp_free();
+#ifdef CONFIG_ARCH_OMAP1
+	if (cpu_class_is_omap1()) {
+		if (id == OMAP_MCBSP1 || id == OMAP_MCBSP3)
+			omap_mcbsp_dsp_free();
+	}
+#endif
+
+#ifdef CONFIG_ARCH_OMAP2
+	if (cpu_is_omap24xx()) {
+		if (id == OMAP_MCBSP1) {
+			clk_unuse(mcbsp1_ick);
+			clk_unuse(mcbsp1_fck);
+		} else {
+			clk_unuse(mcbsp2_ick);
+			clk_unuse(mcbsp2_fck);
+		}
+	}
+#endif
 
 	spin_lock(&mcbsp[id].lock);
 	if (mcbsp[id].free) {
@@ -474,6 +525,9 @@ u32 omap_mcbsp_recv_word(unsigned int id
 int omap_mcbsp_xmit_buffer(unsigned int id, dma_addr_t buffer, unsigned int
length)
 {
 	int dma_tx_ch;
+	int src_port = 0;
+	int dest_port = 0;
+	int sync_dev = 0;
 
 	if (omap_mcbsp_check(id) < 0)
 		return -EINVAL;
@@ -490,20 +544,27 @@ int omap_mcbsp_xmit_buffer(unsigned int 
 
 	init_completion(&(mcbsp[id].tx_dma_completion));
 
+	if (cpu_class_is_omap1()) {
+		src_port = OMAP_DMA_PORT_TIPB;
+		dest_port = OMAP_DMA_PORT_EMIFF;
+	}
+	if (cpu_is_omap24xx())
+		sync_dev = mcbsp[id].dma_tx_sync;
+
 	omap_set_dma_transfer_params(mcbsp[id].dma_tx_lch,
 				     OMAP_DMA_DATA_TYPE_S16,
 				     length >> 1, 1,
 				     OMAP_DMA_SYNC_ELEMENT,
-				     0, 0);
+				     sync_dev, 0);
 
 	omap_set_dma_dest_params(mcbsp[id].dma_tx_lch,
-				 OMAP_DMA_PORT_TIPB,
+				 src_port,
 				 OMAP_DMA_AMODE_CONSTANT,
 				 mcbsp[id].io_base + OMAP_MCBSP_REG_DXR1,
 				 0, 0);
 
 	omap_set_dma_src_params(mcbsp[id].dma_tx_lch,
-				OMAP_DMA_PORT_EMIFF,
+				dest_port,
 				OMAP_DMA_AMODE_POST_INC,
 				buffer,
 				0, 0);
@@ -517,6 +578,9 @@ int omap_mcbsp_xmit_buffer(unsigned int 
 int omap_mcbsp_recv_buffer(unsigned int id, dma_addr_t buffer, unsigned int
length)
 {
 	int dma_rx_ch;
+	int src_port = 0;
+	int dest_port = 0;
+	int sync_dev = 0;
 
 	if (omap_mcbsp_check(id) < 0)
 		return -EINVAL;
@@ -533,20 +597,27 @@ int omap_mcbsp_recv_buffer(unsigned int 
 
 	init_completion(&(mcbsp[id].rx_dma_completion));
 
+	if (cpu_class_is_omap1()) {
+		src_port = OMAP_DMA_PORT_TIPB;
+		dest_port = OMAP_DMA_PORT_EMIFF;
+	}
+	if (cpu_is_omap24xx())
+		sync_dev = mcbsp[id].dma_rx_sync;
+
 	omap_set_dma_transfer_params(mcbsp[id].dma_rx_lch,
 				     OMAP_DMA_DATA_TYPE_S16,
 				     length >> 1, 1,
 				     OMAP_DMA_SYNC_ELEMENT,
-				     0, 0);
+				     sync_dev, 0);
 
 	omap_set_dma_src_params(mcbsp[id].dma_rx_lch,
-				OMAP_DMA_PORT_TIPB,
+				src_port,
 				OMAP_DMA_AMODE_CONSTANT,
 				mcbsp[id].io_base + OMAP_MCBSP_REG_DRR1,
 				0, 0);
 
 	omap_set_dma_dest_params(mcbsp[id].dma_rx_lch,
-				 OMAP_DMA_PORT_EMIFF,
+				 dest_port,
 				 OMAP_DMA_AMODE_POST_INC,
 				 buffer,
 				 0, 0);
@@ -691,6 +762,23 @@ static const struct omap_mcbsp_info mcbs
 };
 #endif
 
+#if defined(CONFIG_ARCH_OMAP24XX)
+static const struct omap_mcbsp_info mcbsp_24xx[] = {
+	[0] = { .virt_base = IO_ADDRESS(OMAP24XX_MCBSP1_BASE),
+		.dma_rx_sync = OMAP24XX_DMA_MCBSP1_RX,
+		.dma_tx_sync = OMAP24XX_DMA_MCBSP1_TX,
+		.rx_irq = INT_24XX_MCBSP1_IRQ_RX,
+		.tx_irq = INT_24XX_MCBSP1_IRQ_TX,
+		},
+	[1] = { .virt_base = IO_ADDRESS(OMAP24XX_MCBSP2_BASE),
+		.dma_rx_sync = OMAP24XX_DMA_MCBSP2_RX,
+		.dma_tx_sync = OMAP24XX_DMA_MCBSP2_TX,
+		.rx_irq = INT_24XX_MCBSP2_IRQ_RX,
+		.tx_irq = INT_24XX_MCBSP2_IRQ_TX,
+		},
+};
+#endif
+
 static int __init omap_mcbsp_init(void)
 {
 	int mcbsp_count = 0, i;
@@ -698,6 +786,7 @@ static int __init omap_mcbsp_init(void)
 
 	printk("Initializing OMAP McBSP system\n");
 
+#ifdef CONFIG_ARCH_OMAP1
 	mcbsp_dsp_ck = clk_get(0, "dsp_ck");
 	if (IS_ERR(mcbsp_dsp_ck)) {
 		printk(KERN_ERR "mcbsp: could not acquire dsp_ck
handle.\n");
@@ -713,6 +802,29 @@ static int __init omap_mcbsp_init(void)
 		printk(KERN_ERR "mcbsp: could not acquire dspxor_ck
handle.\n");
 		return PTR_ERR(mcbsp_dspxor_ck);
 	}
+#endif
+#ifdef CONFIG_ARCH_OMAP2
+	mcbsp1_ick = clk_get(0, "mcbsp1_ick");
+	if (IS_ERR(mcbsp1_ick)) {
+		printk(KERN_ERR "mcbsp: could not acquire mcbsp1_ick
handle.\n");
+		return PTR_ERR(mcbsp1_ick);
+	}
+	mcbsp1_fck = clk_get(0, "mcbsp1_fck");
+	if (IS_ERR(mcbsp1_fck)) {
+		printk(KERN_ERR "mcbsp: could not acquire mcbsp1_fck
handle.\n");
+		return PTR_ERR(mcbsp1_fck);
+	}
+	mcbsp2_ick = clk_get(0, "mcbsp2_ick");
+	if (IS_ERR(mcbsp2_ick)) {
+		printk(KERN_ERR "mcbsp: could not acquire mcbsp2_ick
handle.\n");
+		return PTR_ERR(mcbsp2_ick);
+	}
+	mcbsp2_fck = clk_get(0, "mcbsp2_fck");
+	if (IS_ERR(mcbsp2_fck)) {
+		printk(KERN_ERR "mcbsp: could not acquire mcbsp2_fck
handle.\n");
+		return PTR_ERR(mcbsp2_fck);
+	}
+#endif
 
 #ifdef CONFIG_ARCH_OMAP730
 	if (cpu_is_omap730()) {
@@ -732,6 +844,19 @@ static int __init omap_mcbsp_init(void)
 		mcbsp_count = ARRAY_SIZE(mcbsp_1610);
 	}
 #endif
+#if defined(CONFIG_ARCH_OMAP24XX)
+	if (cpu_is_omap24xx()) {
+		mcbsp_info = mcbsp_24xx;
+		mcbsp_count = ARRAY_SIZE(mcbsp_24xx);
+
+		/* REVISIT: where's the right place? */
+		omap2_mcbsp2_mux_setup();
+		sys_ck = clk_get(0, "sys_ck");
+		sys_clkout = clk_get(0, "sys_clkout");
+		clk_set_parent(sys_clkout, sys_ck);
+		clk_use(sys_clkout);
+	}
+#endif
 	for (i = 0; i < OMAP_MAX_MCBSP_COUNT ; i++) {
 		if (i >= mcbsp_count) {
 			mcbsp[i].io_base = 0;
@@ -754,7 +879,6 @@ static int __init omap_mcbsp_init(void)
 	return 0;
 }
 
-
 arch_initcall(omap_mcbsp_init);
 
 EXPORT_SYMBOL(omap_mcbsp_config);
diff --git a/include/asm-arm/arch-omap/irqs.h
b/include/asm-arm/arch-omap/irqs.h
--- a/include/asm-arm/arch-omap/irqs.h
+++ b/include/asm-arm/arch-omap/irqs.h
@@ -242,6 +242,10 @@
 #define INT_24XX_GPIO_BANK2	30
 #define INT_24XX_GPIO_BANK3	31
 #define INT_24XX_GPIO_BANK4	32
+#define INT_24XX_MCBSP1_IRQ_TX	59
+#define INT_24XX_MCBSP1_IRQ_RX	60
+#define INT_24XX_MCBSP2_IRQ_TX	62
+#define INT_24XX_MCBSP2_IRQ_RX	63
 
 /* Max. 128 level 2 IRQs (OMAP1610), 192 GPIOs (OMAP730) and
  * 16 MPUIO lines */
diff --git a/include/asm-arm/arch-omap/mcbsp.h
b/include/asm-arm/arch-omap/mcbsp.h
--- a/include/asm-arm/arch-omap/mcbsp.h
+++ b/include/asm-arm/arch-omap/mcbsp.h
@@ -37,6 +37,11 @@
 #define OMAP1610_MCBSP2_BASE	0xfffb1000
 #define OMAP1610_MCBSP3_BASE	0xe1017000
 
+#define OMAP24XX_MCBSP1_BASE	0x48074000
+#define OMAP24XX_MCBSP2_BASE	0x48076000
+
+#ifdef CONFIG_ARCH_OMAP16XX
+
 #define OMAP_MCBSP_REG_DRR2	0x00
 #define OMAP_MCBSP_REG_DRR1	0x02
 #define OMAP_MCBSP_REG_DXR2	0x04
@@ -71,9 +76,59 @@
 
 #define OMAP_MAX_MCBSP_COUNT 3
 
+#define AUDIO_MCBSP		OMAP_MCBSP1
+#define AUDIO_DMA_TX		OMAP_DMA_MCBSP1_TX
+#define AUDIO_DMA_RX		OMAP_DMA_MCBSP1_RX
+
+#elif defined(CONFIG_ARCH_OMAP24XX)
+
+#define OMAP_MCBSP_REG_DRR2	0x00
+#define OMAP_MCBSP_REG_DRR1	0x04
+#define OMAP_MCBSP_REG_DXR2	0x08
+#define OMAP_MCBSP_REG_DXR1	0x0C
+#define OMAP_MCBSP_REG_SPCR2	0x10
+#define OMAP_MCBSP_REG_SPCR1	0x14
+#define OMAP_MCBSP_REG_RCR2	0x18
+#define OMAP_MCBSP_REG_RCR1	0x1C
+#define OMAP_MCBSP_REG_XCR2	0x20
+#define OMAP_MCBSP_REG_XCR1	0x24
+#define OMAP_MCBSP_REG_SRGR2	0x28
+#define OMAP_MCBSP_REG_SRGR1	0x2C
+#define OMAP_MCBSP_REG_MCR2	0x30
+#define OMAP_MCBSP_REG_MCR1	0x34
+#define OMAP_MCBSP_REG_RCERA	0x38
+#define OMAP_MCBSP_REG_RCERB	0x3C
+#define OMAP_MCBSP_REG_XCERA	0x40
+#define OMAP_MCBSP_REG_XCERB	0x44
+#define OMAP_MCBSP_REG_PCR0	0x48
+#define OMAP_MCBSP_REG_RCERC	0x4C
+#define OMAP_MCBSP_REG_RCERD	0x50
+#define OMAP_MCBSP_REG_XCERC	0x54
+#define OMAP_MCBSP_REG_XCERD	0x58
+#define OMAP_MCBSP_REG_RCERE	0x5C
+#define OMAP_MCBSP_REG_RCERF	0x60
+#define OMAP_MCBSP_REG_XCERE	0x64
+#define OMAP_MCBSP_REG_XCERF	0x68
+#define OMAP_MCBSP_REG_RCERG	0x6C
+#define OMAP_MCBSP_REG_RCERH	0x70
+#define OMAP_MCBSP_REG_XCERG	0x74
+#define OMAP_MCBSP_REG_XCERH	0x78
+
+#define OMAP_MAX_MCBSP_COUNT 2
+
+#define AUDIO_MCBSP_DATAWRITE	(OMAP24XX_MCBSP2_BASE + OMAP_MCBSP_REG_DXR1)
+#define AUDIO_MCBSP_DATAREAD	(OMAP24XX_MCBSP2_BASE + OMAP_MCBSP_REG_DRR1)
+
+#define AUDIO_MCBSP		OMAP_MCBSP2
+#define AUDIO_DMA_TX		OMAP24XX_DMA_MCBSP2_TX
+#define AUDIO_DMA_RX		OMAP24XX_DMA_MCBSP2_RX
+
+#endif
+
 #define OMAP_MCBSP_READ(base, reg)		__raw_readw((base) +
OMAP_MCBSP_REG_##reg)
 #define OMAP_MCBSP_WRITE(base, reg, val)	__raw_writew((val), (base) +
OMAP_MCBSP_REG_##reg)
 
+
 /************************** McBSP SPCR1 bit definitions
***********************/
 #define RRST			0x0001
 #define RRDY			0x0002
diff --git a/include/asm-arm/arch-omap/mux.h
b/include/asm-arm/arch-omap/mux.h
--- a/include/asm-arm/arch-omap/mux.h
+++ b/include/asm-arm/arch-omap/mux.h
@@ -407,9 +407,21 @@ enum omap24xx_index {
 	/* 24xx Menelaus interrupt */
 	W19_24XX_SYS_NIRQ,
 
+	/* 24xx clock */
+	W14_24XX_SYS_CLKOUT,
+
+	/* 242X McBSP */
+	Y15_24XX_MCBSP2_CLKX,
+	R14_24XX_MCBSP2_FSX,
+	W15_24XX_MCBSP2_DR,
+	V15_24XX_MCBSP2_DX,
+
 	/* 24xx GPIO */
 	Y20_24XX_GPIO60,
 	M15_24XX_GPIO92,
+	V14_24XX_GPIO117,
+
+	P20_24XX_TSC_IRQ,
 };
 
 #ifdef	CONFIG_OMAP_MUX
