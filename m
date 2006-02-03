From: Ladislav Michl <ladis@linux-mips.org>
Subject: [PATCH] various whitespace cleanups
Date: Fri, 3 Feb 2006 11:56:33 +0100
Message-ID: <20060203105632.GA11888@orphique>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
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

Hi,

please use 'let c_space_errors=1' in vim to see what this patch fixes.
While there, remove initilizers from variables which are by default
initialized to zero (to respect linux policy). No code changes.

diff --git a/arch/arm/mach-omap1/clock.c b/arch/arm/mach-omap1/clock.c
index 0bc2d7a..619db18 100644
--- a/arch/arm/mach-omap1/clock.c
+++ b/arch/arm/mach-omap1/clock.c
@@ -345,7 +345,7 @@ static unsigned calc_ext_dsor(unsigned l
 	 */
 	for (dsor = 2; dsor < 96; ++dsor) {
 		if ((dsor & 1) && dsor > 8)
-		  	continue;
+			continue;
 		if (rate >= 96000000 / dsor)
 			break;
 	}
diff --git a/arch/arm/mach-omap1/irq.c b/arch/arm/mach-omap1/irq.c
index ed65a7d..a0431c0 100644
--- a/arch/arm/mach-omap1/irq.c
+++ b/arch/arm/mach-omap1/irq.c
@@ -60,7 +60,7 @@ struct omap_irq_bank {
 	unsigned long wake_enable;
 };
 
-static unsigned int irq_bank_count = 0;
+static unsigned int irq_bank_count;
 static struct omap_irq_bank *irq_banks;
 
 static inline unsigned int irq_bank_readl(int bank, int offset)
@@ -142,28 +142,28 @@ static void omap_irq_set_cfg(int irq, in
 
 #ifdef CONFIG_ARCH_OMAP730
 static struct omap_irq_bank omap730_irq_banks[] = {
-	{ .base_reg = OMAP_IH1_BASE, 		.trigger_map = 0xb3f8e22f },
-	{ .base_reg = OMAP_IH2_BASE, 		.trigger_map = 0xfdb9c1f2 },
+	{ .base_reg = OMAP_IH1_BASE,		.trigger_map = 0xb3f8e22f },
+	{ .base_reg = OMAP_IH2_BASE,		.trigger_map = 0xfdb9c1f2 },
 	{ .base_reg = OMAP_IH2_BASE + 0x100,	.trigger_map = 0x800040f3 },
 };
 #endif
 
 #ifdef CONFIG_ARCH_OMAP15XX
 static struct omap_irq_bank omap1510_irq_banks[] = {
-	{ .base_reg = OMAP_IH1_BASE, 		.trigger_map = 0xb3febfff },
-	{ .base_reg = OMAP_IH2_BASE, 		.trigger_map = 0xffbfffed },
+	{ .base_reg = OMAP_IH1_BASE,		.trigger_map = 0xb3febfff },
+	{ .base_reg = OMAP_IH2_BASE,		.trigger_map = 0xffbfffed },
 };
 static struct omap_irq_bank omap310_irq_banks[] = {
-	{ .base_reg = OMAP_IH1_BASE, 		.trigger_map = 0xb3faefc3 },
-	{ .base_reg = OMAP_IH2_BASE, 		.trigger_map = 0x65b3c061 },
+	{ .base_reg = OMAP_IH1_BASE,		.trigger_map = 0xb3faefc3 },
+	{ .base_reg = OMAP_IH2_BASE,		.trigger_map = 0x65b3c061 },
 };
 #endif
 
 #if defined(CONFIG_ARCH_OMAP16XX)
 
 static struct omap_irq_bank omap1610_irq_banks[] = {
-	{ .base_reg = OMAP_IH1_BASE, 		.trigger_map = 0xb3fefe8f },
-	{ .base_reg = OMAP_IH2_BASE, 		.trigger_map = 0xfdb7c1fd },
+	{ .base_reg = OMAP_IH1_BASE,		.trigger_map = 0xb3fefe8f },
+	{ .base_reg = OMAP_IH2_BASE,		.trigger_map = 0xfdb7c1fd },
 	{ .base_reg = OMAP_IH2_BASE + 0x100,	.trigger_map = 0xffffb7ff },
 	{ .base_reg = OMAP_IH2_BASE + 0x200,	.trigger_map = 0xffffffff },
 };
diff --git a/arch/arm/mach-omap1/mux.c b/arch/arm/mach-omap1/mux.c
index 013a2be..10fe0b3 100644
--- a/arch/arm/mach-omap1/mux.c
+++ b/arch/arm/mach-omap1/mux.c
@@ -77,8 +77,8 @@ MUX_CFG("UART3_BCLK",		 A,    0,    0,	 
 MUX_CFG("Y15_1610_UART3_RTS",	 A,    0,    1,	  2,   6,   0,	 NA,	 0,  0)
 
 /* PWT & PWL, conflicts with UART3 */
-MUX_CFG("PWT",		 	 6,    0,    2,	  0,  30,   0,	 NA,	 0,  0)
-MUX_CFG("PWL",		 	 6,    3,    1,	  0,  31,   1,	 NA,	 0,  0)
+MUX_CFG("PWT",			 6,    0,    2,	  0,  30,   0,	 NA,	 0,  0)
+MUX_CFG("PWL",			 6,    3,    1,	  0,  31,   1,	 NA,	 0,  0)
 
 /* USB internal master generic */
 MUX_CFG("R18_USB_VBUS",		 7,    9,    2,	  1,  11,   0,	 NA,	 0,  1)
@@ -155,7 +155,7 @@ MUX_CFG("MCBSP3_CLKX",		 9,    3,    1,	
 
 /* Misc ballouts */
 MUX_CFG("BALLOUT_V8_ARMIO3",	 B,   18,    0,	  2,  25,   1,	 NA,	 0,  1)
-MUX_CFG("N20_HDQ",	       6,   18,    1,   1,   4,   0,    1,     4,  0)
+MUX_CFG("N20_HDQ",		 6,   18,    1,   1,   4,   0,    1,     4,  0)
 
 /* OMAP-1610 MMC2 */
 MUX_CFG("W8_1610_MMC2_DAT0",	 B,   21,    6,	  2,  23,   1,	  2,	 1,  1)
diff --git a/arch/arm/mach-omap1/pm.c b/arch/arm/mach-omap1/pm.c
index cc01813..be0d6b7 100644
--- a/arch/arm/mach-omap1/pm.c
+++ b/arch/arm/mach-omap1/pm.c
@@ -234,7 +234,7 @@ static void omap_pm_wakeup_setup(void)
 
 	/*  New IRQ agreement, recalculate in cascade order */
 	omap_writel(1, OMAP_IH2_CONTROL);
- 	omap_writel(1, OMAP_IH1_CONTROL);
+	omap_writel(1, OMAP_IH1_CONTROL);
 }
 
 #define EN_DSPCK	13	/* ARM_CKCTL */
@@ -271,7 +271,7 @@ void omap_pm_suspend(void)
 	 * We have to save and restore very little register state to
 	 * idle the omap.
          *
- 	 * Save interrupt, MPUI, ARM and UPLD control registers.
+	 * Save interrupt, MPUI, ARM and UPLD control registers.
 	 */
 
 	if (cpu_is_omap730()) {
@@ -371,7 +371,7 @@ void omap_pm_suspend(void)
 	 * Step 6c: ARM and Traffic controller shutdown
 	 *
 	 * Jump to assembly code. The processor will stay there
- 	 * until wake up.
+	 * until wake up.
 	 */
         omap_sram_suspend(arg0, arg1);
 
@@ -559,29 +559,29 @@ static int omap_pm_read_proc(
 			   "MPUI1510_CTRL_REG             0x%-8x \n"
 			   "MPUI1510_DSP_STATUS_REG:      0x%-8x \n"
 			   "MPUI1510_DSP_BOOT_CONFIG_REG: 0x%-8x \n"
-		   	   "MPUI1510_DSP_API_CONFIG_REG:  0x%-8x \n"
-		   	   "MPUI1510_SDRAM_CONFIG_REG:    0x%-8x \n"
-		   	   "MPUI1510_EMIFS_CONFIG_REG:    0x%-8x \n",
-		   	   MPUI1510_SHOW(MPUI_CTRL),
-		   	   MPUI1510_SHOW(MPUI_DSP_STATUS),
-		   	   MPUI1510_SHOW(MPUI_DSP_BOOT_CONFIG),
-		   	   MPUI1510_SHOW(MPUI_DSP_API_CONFIG),
-		   	   MPUI1510_SHOW(EMIFF_SDRAM_CONFIG),
-		   	   MPUI1510_SHOW(EMIFS_CONFIG));
+			   "MPUI1510_DSP_API_CONFIG_REG:  0x%-8x \n"
+			   "MPUI1510_SDRAM_CONFIG_REG:    0x%-8x \n"
+			   "MPUI1510_EMIFS_CONFIG_REG:    0x%-8x \n",
+			   MPUI1510_SHOW(MPUI_CTRL),
+			   MPUI1510_SHOW(MPUI_DSP_STATUS),
+			   MPUI1510_SHOW(MPUI_DSP_BOOT_CONFIG),
+			   MPUI1510_SHOW(MPUI_DSP_API_CONFIG),
+			   MPUI1510_SHOW(EMIFF_SDRAM_CONFIG),
+			   MPUI1510_SHOW(EMIFS_CONFIG));
 		} else if (cpu_is_omap16xx()) {
 			my_buffer_offset += sprintf(my_base + my_buffer_offset,
 			   "MPUI1610_CTRL_REG             0x%-8x \n"
 			   "MPUI1610_DSP_STATUS_REG:      0x%-8x \n"
 			   "MPUI1610_DSP_BOOT_CONFIG_REG: 0x%-8x \n"
-		   	   "MPUI1610_DSP_API_CONFIG_REG:  0x%-8x \n"
-		   	   "MPUI1610_SDRAM_CONFIG_REG:    0x%-8x \n"
-		   	   "MPUI1610_EMIFS_CONFIG_REG:    0x%-8x \n",
-		   	   MPUI1610_SHOW(MPUI_CTRL),
-		   	   MPUI1610_SHOW(MPUI_DSP_STATUS),
-		   	   MPUI1610_SHOW(MPUI_DSP_BOOT_CONFIG),
-		   	   MPUI1610_SHOW(MPUI_DSP_API_CONFIG),
-		   	   MPUI1610_SHOW(EMIFF_SDRAM_CONFIG),
-		   	   MPUI1610_SHOW(EMIFS_CONFIG));
+			   "MPUI1610_DSP_API_CONFIG_REG:  0x%-8x \n"
+			   "MPUI1610_SDRAM_CONFIG_REG:    0x%-8x \n"
+			   "MPUI1610_EMIFS_CONFIG_REG:    0x%-8x \n",
+			   MPUI1610_SHOW(MPUI_CTRL),
+			   MPUI1610_SHOW(MPUI_DSP_STATUS),
+			   MPUI1610_SHOW(MPUI_DSP_BOOT_CONFIG),
+			   MPUI1610_SHOW(MPUI_DSP_API_CONFIG),
+			   MPUI1610_SHOW(EMIFF_SDRAM_CONFIG),
+			   MPUI1610_SHOW(EMIFS_CONFIG));
 		}
 
 		g_read_completed++;
@@ -694,10 +694,10 @@ static struct irqaction omap_wakeup_irq 
 
 
 static struct pm_ops omap_pm_ops ={
-	.pm_disk_mode = 0,
-        .prepare        = omap_pm_prepare,
-        .enter          = omap_pm_enter,
-        .finish         = omap_pm_finish,
+	.pm_disk_mode	= 0,
+	.prepare	= omap_pm_prepare,
+	.enter		= omap_pm_enter,
+	.finish		= omap_pm_finish,
 };
 
 static int __init omap_pm_init(void)
diff --git a/arch/arm/mach-omap1/serial.c b/arch/arm/mach-omap1/serial.c
index e924e0c..9b4cd69 100644
--- a/arch/arm/mach-omap1/serial.c
+++ b/arch/arm/mach-omap1/serial.c
@@ -30,9 +30,9 @@
 #include <asm/arch/pm.h>
 #endif
 
-static struct clk * uart1_ck = NULL;
-static struct clk * uart2_ck = NULL;
-static struct clk * uart3_ck = NULL;
+static struct clk * uart1_ck;
+static struct clk * uart2_ck;
+static struct clk * uart3_ck;
 
 static inline unsigned int omap_serial_in(struct plat_serial8250_port *up,
 					  int offset)
