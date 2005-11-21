From: Komal Shah <komal_shah802003@yahoo.com>
Subject: [PATCH] omap24xx mcbsp support
Date: Sun, 20 Nov 2005 21:17:35 -0800 (PST)
Message-ID: <20051121051735.80492.qmail@web32904.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0-138721411-1132550255=:63427"
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
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

--0-138721411-1132550255=:63427
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Id: 
Content-Disposition: inline

Tony,

I have added the omap24xx mcbsp support to existing mcbsp framework.
Only tested with dumping the registers.

Initializing OMAP McBSP system
Muxing Y15_24XX_MCBSP2_CLKX (0x48000124): 0x0f -> 0x09
Muxing V15_24XX_MCBSP2_DX (0x48000127): 0x0f -> 0x09
Muxing R14_24XX_MCBSP2_FSX (0x48000125): 0x0f -> 0x09
Muxing W15_24XX_MCBSP2_DR (0x48000126): 0x0f -> 0x09
Muxing V14_24XX_GPIO117 (0x48000128): 0x0f -> 0x0b
**** MCBSP1 regs ****
DRR2:  0x0000
DRR1:  0x0000
DXR2:  0x0000
DXR1:  0x0000
SPCR2: 0x0000
SPCR1: 0x0000
RCR2:  0x0000
RCR1:  0x0000
XCR2:  0x0000
XCR1:  0x0000
SRGR2: 0x2000
SRGR1: 0x0001
PCR0:  0x0000
***********************
**** MCBSP2 regs ****
DRR2:  0x0000
DRR1:  0x0000
DXR2:  0x0000
DXR1:  0x0000
SPCR2: 0x0000
SPCR1: 0x0000
RCR2:  0x0000
RCR1:  0x0000
XCR2:  0x0000
XCR1:  0x0000
SRGR2: 0x2000
SRGR1: 0x0001
PCR0:  0x0000
***********************

Have you tested the dma chaining on 24xx? Next plan is to add audio and
touchscreen support taking spi code from 2.6.9 for time being. Once
audio + ts is tested then we can move to better spi framework from
spi-devel guys.

Signed-off-by: Komal Shah <komal_shah802003@yahoo.com>

---Komal Shah
http://komalshah.blogspot.com/


		
__________________________________ 
Yahoo! FareChase: Search multiple travel sites in one click.
http://farechase.yahoo.com
--0-138721411-1132550255=:63427
Content-Type: text/plain; name="0001-mcbsp-24xx.patch"
Content-Description: 2727527101-0001-mcbsp-24xx.patch
Content-Disposition: inline; filename="0001-mcbsp-24xx.patch"

diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
diff --git a/arch/arm/mach-omap2/mux.c b/arch/arm/mach-omap2/mux.c
index ea46548..391070e 100644
--- a/arch/arm/mach-omap2/mux.c
+++ b/arch/arm/mach-omap2/mux.c
@@ -53,6 +53,13 @@ MUX_CFG_24XX("W19_24XX_SYS_NIRQ",	0x12c,
 /* 24xx GPIO */
 MUX_CFG_24XX("Y20_24XX_GPIO60",		0x12c,	3,	0,	0,	1)
 MUX_CFG_24XX("M15_24XX_GPIO92",		0x10a,	3,	0,	0,	1)
+MUX_CFG_24XX("V14_24XX_GPIO117",	0x128,	3,	1,	0,	1)
+
+/* MCBSP2 */
+MUX_CFG_24XX("Y15_24XX_MCBSP2_CLKX",	0x124,	1,	1,	0,	1)
+MUX_CFG_24XX("R14_24XX_MCBSP2_FSX",	0x125,	1,	1,	0,	1)
+MUX_CFG_24XX("W15_24XX_MCBSP2_DR",	0x126,	1,	1,	0,	1)
+MUX_CFG_24XX("V15_24XX_MCBSP2_DX",	0x127,	1,	1,	0,	1)
 
 };
 
diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
diff --git a/arch/arm/plat-omap/mcbsp.c b/arch/arm/plat-omap/mcbsp.c
index b0a393d..ab6ba9b 100644
--- a/arch/arm/plat-omap/mcbsp.c
+++ b/arch/arm/plat-omap/mcbsp.c
@@ -68,7 +68,10 @@ static struct omap_mcbsp mcbsp[OMAP_MAX_
 static struct clk *mcbsp_dsp_ck = 0;
 static struct clk *mcbsp_api_ck = 0;
 static struct clk *mcbsp_dspxor_ck = 0;
-
+static struct clk *mcbsp1_ick = 0;
+static struct clk *mcbsp1_fck = 0;
+static struct clk *mcbsp2_ick = 0;
+static struct clk *mcbsp2_fck = 0;
 
 static void omap_mcbsp_dump_reg(u8 id)
 {
@@ -169,7 +172,7 @@ void omap_mcbsp_config(unsigned int id, 
 
 static int omap_mcbsp_check(unsigned int id)
 {
-	if (cpu_is_omap730()) {
+	if (cpu_is_omap730() || cpu_is_omap24xx()) {
 		if (id > OMAP_MAX_MCBSP_COUNT - 1) {
 		       printk(KERN_ERR "OMAP-McBSP: McBSP%d doesn't exist\n", id + 1);
 		       return -1;
@@ -228,8 +231,10 @@ int omap_mcbsp_request(unsigned int id)
 	 * On 1510, 1610 and 1710, McBSP1 and McBSP3
 	 * are DSP public peripherals.
 	 */
-	if (id == OMAP_MCBSP1 || id == OMAP_MCBSP3)
-		omap_mcbsp_dsp_request();
+	if (cpu_is_omap1510() || cpu_is_omap16xx()) {
+		if (id == OMAP_MCBSP1 || id == OMAP_MCBSP3)
+			omap_mcbsp_dsp_request();
+	}
 
 	spin_lock(&mcbsp[id].lock);
 	if (!mcbsp[id].free) {
@@ -274,8 +279,10 @@ void omap_mcbsp_free(unsigned int id)
 	if (omap_mcbsp_check(id) < 0)
 		return;
 
-	if (id == OMAP_MCBSP1 || id == OMAP_MCBSP3)
-		omap_mcbsp_dsp_free();
+	if (cpu_is_omap1510() || cpu_is_omap24xx()) {
+		if (id == OMAP_MCBSP1 || id == OMAP_MCBSP3)
+			omap_mcbsp_dsp_free();
+	}
 
 	spin_lock(&mcbsp[id].lock);
 	if (mcbsp[id].free) {
@@ -474,6 +481,9 @@ u32 omap_mcbsp_recv_word(unsigned int id
 int omap_mcbsp_xmit_buffer(unsigned int id, dma_addr_t buffer, unsigned int length)
 {
 	int dma_tx_ch;
+	int src_port = 0;
+	int dst_port = 0;
+	int sync_dev = 0;
 
 	if (omap_mcbsp_check(id) < 0)
 		return -EINVAL;
@@ -490,20 +500,27 @@ int omap_mcbsp_xmit_buffer(unsigned int 
 
 	init_completion(&(mcbsp[id].tx_dma_completion));
 
+	if (cpu_class_is_omap1()) {
+		src_port = OMAP_DMA_PORT_TIPB;
+		dst_port = OMAP_DMA_PORT_EMIFF;
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
+				dst_port,
 				OMAP_DMA_AMODE_POST_INC,
 				buffer,
 				0, 0);
@@ -517,6 +534,9 @@ int omap_mcbsp_xmit_buffer(unsigned int 
 int omap_mcbsp_recv_buffer(unsigned int id, dma_addr_t buffer, unsigned int length)
 {
 	int dma_rx_ch;
+	int src_port = 0;
+	int dst_port = 0;
+	int sync_dev = 0;
 
 	if (omap_mcbsp_check(id) < 0)
 		return -EINVAL;
@@ -533,20 +553,27 @@ int omap_mcbsp_recv_buffer(unsigned int 
 
 	init_completion(&(mcbsp[id].rx_dma_completion));
 
+	if (cpu_class_is_omap1()) {
+		src_port = OMAP_DMA_PORT_TIPB;
+		dst_port = OMAP_DMA_PORT_EMIFF;
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
+				 dst_port,
 				 OMAP_DMA_AMODE_POST_INC,
 				 buffer,
 				 0, 0);
@@ -691,6 +718,21 @@ static const struct omap_mcbsp_info mcbs
 };
 #endif
 
+#if defined(CONFIG_ARCH_OMAP24XX)
+static const struct omap_mcbsp_info mcbsp_2420[] = {
+	[0] = { .virt_base = io_p2v(OMAP2420_MCBSP1_BASE),
+		.dma_rx_sync = OMAP24XX_DMA_MCBSP1_RX,
+		.dma_tx_sync = OMAP24XX_DMA_MCBSP1_TX,
+		.rx_irq = INT_24XX_McBSP1RX,
+		.tx_irq = INT_24XX_McBSP1TX },
+	[1] = { .virt_base = io_p2v(OMAP2420_MCBSP2_BASE),
+		.dma_rx_sync = OMAP24XX_DMA_MCBSP2_RX,
+		.dma_tx_sync = OMAP24XX_DMA_MCBSP2_TX,
+		.rx_irq = INT_24XX_McBSP2RX,
+		.tx_irq = INT_24XX_McBSP2TX },
+};
+#endif
+
 static int __init omap_mcbsp_init(void)
 {
 	int mcbsp_count = 0, i;
@@ -698,20 +740,54 @@ static int __init omap_mcbsp_init(void)
 
 	printk("Initializing OMAP McBSP system\n");
 
-	mcbsp_dsp_ck = clk_get(0, "dsp_ck");
-	if (IS_ERR(mcbsp_dsp_ck)) {
-		printk(KERN_ERR "mcbsp: could not acquire dsp_ck handle.\n");
-		return PTR_ERR(mcbsp_dsp_ck);
-	}
-	mcbsp_api_ck = clk_get(0, "api_ck");
-	if (IS_ERR(mcbsp_api_ck)) {
-		printk(KERN_ERR "mcbsp: could not acquire api_ck handle.\n");
-		return PTR_ERR(mcbsp_api_ck);
-	}
-	mcbsp_dspxor_ck = clk_get(0, "dspxor_ck");
-	if (IS_ERR(mcbsp_dspxor_ck)) {
-		printk(KERN_ERR "mcbsp: could not acquire dspxor_ck handle.\n");
-		return PTR_ERR(mcbsp_dspxor_ck);
+	if (!cpu_is_omap24xx()) {
+		mcbsp_dsp_ck = clk_get(0, "dsp_ck");
+		if (IS_ERR(mcbsp_dsp_ck)) {
+			printk(KERN_ERR "mcbsp: could not acquire dsp_ck handle.\n");
+			return PTR_ERR(mcbsp_dsp_ck);
+		}
+		mcbsp_api_ck = clk_get(0, "api_ck");
+		if (IS_ERR(mcbsp_api_ck)) {
+			printk(KERN_ERR "mcbsp: could not acquire api_ck handle.\n");
+			return PTR_ERR(mcbsp_api_ck);
+		}
+		mcbsp_dspxor_ck = clk_get(0, "dspxor_ck");
+		if (IS_ERR(mcbsp_dspxor_ck)) {
+			printk(KERN_ERR "mcbsp: could not acquire dspxor_ck handle.\n");
+			return PTR_ERR(mcbsp_dspxor_ck);
+		}
+	} else {
+		mcbsp1_ick = clk_get(NULL, "mcbsp1_ick");
+		if (IS_ERR(mcbsp1_ick)) {
+			printk(KERN_ERR "mcbsp: could not acquire"
+			       "mcbsp1_ick handle.\n");
+			return PTR_ERR(mcbsp1_ick);
+		}
+		mcbsp1_fck = clk_get(NULL, "mcbsp1_fck");
+		if (IS_ERR(mcbsp1_fck)) {
+			printk(KERN_ERR "mcbsp: could not acquire"
+			       "mcbsp1_fck handle.\n");
+			return PTR_ERR(mcbsp1_fck);
+		}
+		mcbsp2_ick = clk_get(NULL, "mcbsp2_ick");
+		if (IS_ERR(mcbsp1_ick)) {
+			printk(KERN_ERR "mcbsp: could not acquire"
+			       "mcbsp2_ick handle.\n");
+			return PTR_ERR(mcbsp2_ick);
+		}
+		mcbsp2_fck = clk_get(NULL, "mcbsp2_fck");
+		if (IS_ERR(mcbsp1_fck)) {
+			printk(KERN_ERR "mcbsp: could not acquire"
+			       "mcbsp2_fck handle.\n");
+			return PTR_ERR(mcbsp2_fck);
+		}
+	
+		omap_cfg_reg(Y15_24XX_MCBSP2_CLKX);
+		omap_cfg_reg(R14_24XX_MCBSP2_FSX);
+		omap_cfg_reg(W15_24XX_MCBSP2_DR);
+		omap_cfg_reg(V15_24XX_MCBSP2_DX);
+		omap_cfg_reg(V14_24XX_GPIO117);
+
 	}
 
 #ifdef CONFIG_ARCH_OMAP730
@@ -732,6 +808,13 @@ static int __init omap_mcbsp_init(void)
 		mcbsp_count = ARRAY_SIZE(mcbsp_1610);
 	}
 #endif
+#if defined(CONFIG_ARCH_OMAP24XX)
+	if (cpu_is_omap24xx()) {
+		mcbsp_info = mcbsp_2420;
+		mcbsp_count = ARRAY_SIZE(mcbsp_2420);
+	}
+#endif
+
 	for (i = 0; i < OMAP_MAX_MCBSP_COUNT ; i++) {
 		if (i >= mcbsp_count) {
 			mcbsp[i].io_base = 0;
diff --git a/arch/arm/plat-omap/mux.c b/arch/arm/plat-omap/mux.c
diff --git a/include/asm-arm/arch-omap/io.h b/include/asm-arm/arch-omap/io.h
diff --git a/include/asm-arm/arch-omap/irqs.h b/include/asm-arm/arch-omap/irqs.h
index 9779686..ffe4a38 100644
--- a/include/asm-arm/arch-omap/irqs.h
+++ b/include/asm-arm/arch-omap/irqs.h
@@ -242,6 +242,10 @@
 #define INT_24XX_GPIO_BANK2	30
 #define INT_24XX_GPIO_BANK3	31
 #define INT_24XX_GPIO_BANK4	32
+#define INT_24XX_McBSP1TX	59
+#define INT_24XX_McBSP1RX	60
+#define INT_24XX_McBSP2TX	62
+#define INT_24XX_McBSP2RX	63
 
 /* Max. 128 level 2 IRQs (OMAP1610), 192 GPIOs (OMAP730) and
  * 16 MPUIO lines */
diff --git a/include/asm-arm/arch-omap/mcbsp.h b/include/asm-arm/arch-omap/mcbsp.h
index 305bdeb..f7701cc 100644
--- a/include/asm-arm/arch-omap/mcbsp.h
+++ b/include/asm-arm/arch-omap/mcbsp.h
@@ -37,6 +37,9 @@
 #define OMAP1610_MCBSP2_BASE	0xfffb1000
 #define OMAP1610_MCBSP3_BASE	0xe1017000
 
+#define OMAP2420_MCBSP1_BASE	0x48074000
+#define OMAP2420_MCBSP2_BASE	0x48076000
+
 #define OMAP_MCBSP_REG_DRR2	0x00
 #define OMAP_MCBSP_REG_DRR1	0x02
 #define OMAP_MCBSP_REG_DXR2	0x04
@@ -69,10 +72,49 @@
 #define OMAP_MCBSP_REG_XCERG	0x3A
 #define OMAP_MCBSP_REG_XCERH	0x3C
 
+/* OMAP2 specific*/
+#define OMAP2_MCBSP_REG_DRR2	0x00
+#define OMAP2_MCBSP_REG_DRR1	0x04
+#define OMAP2_MCBSP_REG_DXR2	0x08
+#define OMAP2_MCBSP_REG_DXR1	0x0C
+#define OMAP2_MCBSP_REG_SPCR2	0x10
+#define OMAP2_MCBSP_REG_SPCR1	0x14
+#define OMAP2_MCBSP_REG_RCR2	0x18
+#define OMAP2_MCBSP_REG_RCR1	0x1C
+#define OMAP2_MCBSP_REG_XCR2	0x20
+#define OMAP2_MCBSP_REG_XCR1	0x24
+#define OMAP2_MCBSP_REG_SRGR2	0x28
+#define OMAP2_MCBSP_REG_SRGR1	0x2C
+#define OMAP2_MCBSP_REG_MCR2	0x30
+#define OMAP2_MCBSP_REG_MCR1	0x34
+#define OMAP2_MCBSP_REG_RCERA	0x38
+#define OMAP2_MCBSP_REG_RCERB	0x3C
+#define OMAP2_MCBSP_REG_XCERA	0x40
+#define OMAP2_MCBSP_REG_XCERB	0x44
+#define OMAP2_MCBSP_REG_PCR0	0x48
+#define OMAP2_MCBSP_REG_RCERC	0x4C
+#define OMAP2_MCBSP_REG_RCERD	0x50
+#define OMAP2_MCBSP_REG_XCERC	0x54
+#define OMAP2_MCBSP_REG_XCERD	0x58
+#define OMAP2_MCBSP_REG_RCERE	0x5C
+#define OMAP2_MCBSP_REG_RCERF	0x60
+#define OMAP2_MCBSP_REG_XCERE	0x64
+#define OMAP2_MCBSP_REG_XCERF	0x68
+#define OMAP2_MCBSP_REG_RCERG	0x6C
+#define OMAP2_MCBSP_REG_RCERH	0x70
+#define OMAP2_MCBSP_REG_XCERG	0x74
+#define OMAP2_MCBSP_REG_XCERH	0x78
+
+
 #define OMAP_MAX_MCBSP_COUNT 3
 
+#if defined (CONFIG_ARCH_OMAP24XX)
+#define OMAP_MCBSP_READ(base, reg)		__raw_readw((base) + OMAP2_MCBSP_REG_##reg)
+#define OMAP_MCBSP_WRITE(base, reg, val)	__raw_writew((val), (base) + OMAP2_MCBSP_REG_##reg)
+#else
 #define OMAP_MCBSP_READ(base, reg)		__raw_readw((base) + OMAP_MCBSP_REG_##reg)
 #define OMAP_MCBSP_WRITE(base, reg, val)	__raw_writew((val), (base) + OMAP_MCBSP_REG_##reg)
+#endif
 
 /************************** McBSP SPCR1 bit definitions ***********************/
 #define RRST			0x0001
diff --git a/include/asm-arm/arch-omap/mux.h b/include/asm-arm/arch-omap/mux.h
index ef4f6ea..7da41ee 100644
--- a/include/asm-arm/arch-omap/mux.h
+++ b/include/asm-arm/arch-omap/mux.h
@@ -406,6 +406,14 @@ enum omap24xx_index {
 	/* 24xx GPIO */
 	Y20_24XX_GPIO60,
 	M15_24XX_GPIO92,
+	V14_24XX_GPIO117,
+
+	/* MCBSP2 */
+	Y15_24XX_MCBSP2_CLKX,
+	W15_24XX_MCBSP2_DR,
+	V15_24XX_MCBSP2_DX,
+	R14_24XX_MCBSP2_FSX,
+
 };
 
 #ifdef	CONFIG_OMAP_MUX
diff --git a/include/asm-arm/arch-omap/omap24xx.h b/include/asm-arm/arch-omap/omap24xx.h
diff --git a/include/asm-arm/io.h b/include/asm-arm/io.h
diff --git a/sound/oss/Makefile b/sound/oss/Makefile

--0-138721411-1132550255=:63427
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-omap-open-source mailing list
Linux-omap-open-source@linux.omap.com
http://linux.omap.com/mailman/listinfo/linux-omap-open-source

--0-138721411-1132550255=:63427--
