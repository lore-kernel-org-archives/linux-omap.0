From: Alistair Buxton <a.j.buxton@gmail.com>
Subject: [PATCH 13/17] OMAP7XX: Rename all the rest of the omap730 references
	in omap1 core
Date: Wed, 14 Oct 2009 20:51:37 +0100
Message-ID: <3d374d00910141251v3c724d90sc2030dcc066c8a44@mail.gmail.com>
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

This updates all the remaining omap730 references in miscellaneous local
variables, macros and similar.

Signed-off-by: Alistair Buxton <a.j.buxton@gmail.com>
Reviewed-by: Zebediah C. McClure <zmc@lurian.net>
---
 arch/arm/mach-omap1/clock.c             |    8 +-
 arch/arm/mach-omap1/io.c                |    4 +-
 arch/arm/mach-omap1/irq.c               |    6 +-
 arch/arm/mach-omap1/mcbsp.c             |   18 +++---
 arch/arm/mach-omap1/mux.c               |   42 +++++++-------
 arch/arm/mach-omap1/pm.c                |   70 ++++++++++++------------
 arch/arm/mach-omap1/pm.h                |   52 +++++++++---------
 arch/arm/mach-omap1/sleep.S             |   22 ++++----
 arch/arm/plat-omap/devices.c            |   22 ++++----
 arch/arm/plat-omap/gpio.c               |   92 +++++++++++++++---------------
 arch/arm/plat-omap/include/mach/mcbsp.h |    4 +-
 arch/arm/plat-omap/include/mach/mux.h   |   42 +++++++-------
 12 files changed, 191 insertions(+), 191 deletions(-)

diff --git a/arch/arm/mach-omap1/clock.c b/arch/arm/mach-omap1/clock.c
index c24cc28..d2b00a5 100644
--- a/arch/arm/mach-omap1/clock.c
+++ b/arch/arm/mach-omap1/clock.c
@@ -69,7 +69,7 @@ struct omap_clk {
 	}

 #define CK_310	(1 << 0)
-#define CK_730	(1 << 1)
+#define CK_7XX	(1 << 1)
 #define CK_1510	(1 << 2)
 #define CK_16XX	(1 << 3)

@@ -97,7 +97,7 @@ static struct omap_clk omap_clks[] = {
 	CLK(NULL,	"dspxor_ck",	&dspxor_ck,	CK_16XX | CK_1510 | CK_310),
 	CLK(NULL,	"dsptim_ck",	&dsptim_ck,	CK_16XX | CK_1510 | CK_310),
 	/* CK_GEN3 clocks */
-	CLK(NULL,	"tc_ck",	&tc_ck.clk,	CK_16XX | CK_1510 | CK_310 | CK_730),
+	CLK(NULL,	"tc_ck",	&tc_ck.clk,	CK_16XX | CK_1510 | CK_310 | CK_7XX),
 	CLK(NULL,	"tipb_ck",	&tipb_ck,	CK_1510 | CK_310),
 	CLK(NULL,	"l3_ocpi_ck",	&l3_ocpi_ck,	CK_16XX),
 	CLK(NULL,	"tc1_ck",	&tc1_ck,	CK_16XX),
@@ -108,7 +108,7 @@ static struct omap_clk omap_clks[] = {
 	CLK(NULL,	"lb_ck",	&lb_ck.clk,	CK_1510 | CK_310),
 	CLK(NULL,	"rhea1_ck",	&rhea1_ck,	CK_16XX),
 	CLK(NULL,	"rhea2_ck",	&rhea2_ck,	CK_16XX),
-	CLK(NULL,	"lcd_ck",	&lcd_ck_16xx,	CK_16XX | CK_730),
+	CLK(NULL,	"lcd_ck",	&lcd_ck_16xx,	CK_16XX | CK_7XX),
 	CLK(NULL,	"lcd_ck",	&lcd_ck_1510.clk, CK_1510 | CK_310),
 	/* ULPD clocks */
 	CLK(NULL,	"uart1_ck",	&uart1_1510,	CK_1510 | CK_310),
@@ -784,7 +784,7 @@ int __init omap1_clk_init(void)
 	if (cpu_is_omap1510())
 		cpu_mask |= CK_1510;
 	if (cpu_is_omap7xx())
-		cpu_mask |= CK_730;
+		cpu_mask |= CK_7XX;
 	if (cpu_is_omap310())
 		cpu_mask |= CK_310;

diff --git a/arch/arm/mach-omap1/io.c b/arch/arm/mach-omap1/io.c
index 157d508..a27df2c 100644
--- a/arch/arm/mach-omap1/io.c
+++ b/arch/arm/mach-omap1/io.c
@@ -37,7 +37,7 @@ static struct map_desc omap_io_desc[] __initdata = {
 };

 #if defined (CONFIG_ARCH_OMAP730) || defined (CONFIG_ARCH_OMAP850)
-static struct map_desc omap730_io_desc[] __initdata = {
+static struct map_desc omap7xx_io_desc[] __initdata = {
 	{
 		.virtual	= OMAP7XX_DSP_BASE,
 		.pfn		= __phys_to_pfn(OMAP7XX_DSP_START),
@@ -106,7 +106,7 @@ void __init omap1_map_common_io(void)

 #if defined (CONFIG_ARCH_OMAP730) || defined (CONFIG_ARCH_OMAP850)
 	if (cpu_is_omap7xx()) {
-		iotable_init(omap730_io_desc, ARRAY_SIZE(omap730_io_desc));
+		iotable_init(omap7xx_io_desc, ARRAY_SIZE(omap7xx_io_desc));
 	}
 #endif
 #ifdef CONFIG_ARCH_OMAP15XX
diff --git a/arch/arm/mach-omap1/irq.c b/arch/arm/mach-omap1/irq.c
index 704a80c..8f98b58 100644
--- a/arch/arm/mach-omap1/irq.c
+++ b/arch/arm/mach-omap1/irq.c
@@ -138,7 +138,7 @@ static void omap_irq_set_cfg(int irq, int fiq, int
priority, int trigger)
 }

 #if defined (CONFIG_ARCH_OMAP730) || defined (CONFIG_ARCH_OMAP850)
-static struct omap_irq_bank omap730_irq_banks[] = {
+static struct omap_irq_bank omap7xx_irq_banks[] = {
 	{ .base_reg = OMAP_IH1_BASE,		.trigger_map = 0xb3f8e22f },
 	{ .base_reg = OMAP_IH2_BASE,		.trigger_map = 0xfdb9c1f2 },
 	{ .base_reg = OMAP_IH2_BASE + 0x100,	.trigger_map = 0x800040f3 },
@@ -180,8 +180,8 @@ void __init omap_init_irq(void)

 #if defined(CONFIG_ARCH_OMAP730) || defined(CONFIG_ARCH_OMAP850)
 	if (cpu_is_omap7xx()) {
-		irq_banks = omap730_irq_banks;
-		irq_bank_count = ARRAY_SIZE(omap730_irq_banks);
+		irq_banks = omap7xx_irq_banks;
+		irq_bank_count = ARRAY_SIZE(omap7xx_irq_banks);
 	}
 #endif
 #ifdef CONFIG_ARCH_OMAP15XX
diff --git a/arch/arm/mach-omap1/mcbsp.c b/arch/arm/mach-omap1/mcbsp.c
index 7ccca00..3a51cb2 100644
--- a/arch/arm/mach-omap1/mcbsp.c
+++ b/arch/arm/mach-omap1/mcbsp.c
@@ -80,9 +80,9 @@ static struct omap_mcbsp_ops omap1_mcbsp_ops = {
 };

 #if defined(CONFIG_ARCH_OMAP730) || defined(CONFIG_ARCH_OMAP850)
-static struct omap_mcbsp_platform_data omap730_mcbsp_pdata[] = {
+static struct omap_mcbsp_platform_data omap7xx_mcbsp_pdata[] = {
 	{
-		.phys_base	= OMAP730_MCBSP1_BASE,
+		.phys_base	= OMAP7XX_MCBSP1_BASE,
 		.dma_rx_sync	= OMAP_DMA_MCBSP1_RX,
 		.dma_tx_sync	= OMAP_DMA_MCBSP1_TX,
 		.rx_irq		= INT_7XX_McBSP1RX,
@@ -90,7 +90,7 @@ static struct omap_mcbsp_platform_data
omap730_mcbsp_pdata[] = {
 		.ops		= &omap1_mcbsp_ops,
 	},
 	{
-		.phys_base	= OMAP730_MCBSP2_BASE,
+		.phys_base	= OMAP7XX_MCBSP2_BASE,
 		.dma_rx_sync	= OMAP_DMA_MCBSP3_RX,
 		.dma_tx_sync	= OMAP_DMA_MCBSP3_TX,
 		.rx_irq		= INT_7XX_McBSP2RX,
@@ -98,10 +98,10 @@ static struct omap_mcbsp_platform_data
omap730_mcbsp_pdata[] = {
 		.ops		= &omap1_mcbsp_ops,
 	},
 };
-#define OMAP730_MCBSP_PDATA_SZ		ARRAY_SIZE(omap730_mcbsp_pdata)
+#define OMAP7XX_MCBSP_PDATA_SZ		ARRAY_SIZE(omap7xx_mcbsp_pdata)
 #else
-#define omap730_mcbsp_pdata		NULL
-#define OMAP730_MCBSP_PDATA_SZ		0
+#define omap7xx_mcbsp_pdata		NULL
+#define OMAP7XX_MCBSP_PDATA_SZ		0
 #endif

 #ifdef CONFIG_ARCH_OMAP15XX
@@ -173,7 +173,7 @@ static struct omap_mcbsp_platform_data
omap16xx_mcbsp_pdata[] = {
 int __init omap1_mcbsp_init(void)
 {
 	if (cpu_is_omap7xx())
-		omap_mcbsp_count = OMAP730_MCBSP_PDATA_SZ;
+		omap_mcbsp_count = OMAP7XX_MCBSP_PDATA_SZ;
 	if (cpu_is_omap15xx())
 		omap_mcbsp_count = OMAP15XX_MCBSP_PDATA_SZ;
 	if (cpu_is_omap16xx())
@@ -185,8 +185,8 @@ int __init omap1_mcbsp_init(void)
 		return -ENOMEM;

 	if (cpu_is_omap7xx())
-		omap_mcbsp_register_board_cfg(omap730_mcbsp_pdata,
-						OMAP730_MCBSP_PDATA_SZ);
+		omap_mcbsp_register_board_cfg(omap7xx_mcbsp_pdata,
+						OMAP7XX_MCBSP_PDATA_SZ);

 	if (cpu_is_omap15xx())
 		omap_mcbsp_register_board_cfg(omap15xx_mcbsp_pdata,
diff --git a/arch/arm/mach-omap1/mux.c b/arch/arm/mach-omap1/mux.c
index f9d45a3..d59899d 100644
--- a/arch/arm/mach-omap1/mux.c
+++ b/arch/arm/mach-omap1/mux.c
@@ -36,27 +36,27 @@
 static struct omap_mux_cfg arch_mux_cfg;

 #if defined(CONFIG_ARCH_OMAP730) || defined(CONFIG_ARCH_OMAP850)
-static struct pin_config __initdata_or_module omap730_pins[] = {
-MUX_CFG_730("E2_730_KBR0",        12,   21,    0,   20,   1, 0)
-MUX_CFG_730("J7_730_KBR1",        12,   25,    0,   24,   1, 0)
-MUX_CFG_730("E1_730_KBR2",        12,   29,    0,   28,   1, 0)
-MUX_CFG_730("F3_730_KBR3",        13,    1,    0,    0,   1, 0)
-MUX_CFG_730("D2_730_KBR4",        13,    5,    0,    4,   1, 0)
-MUX_CFG_730("C2_730_KBC0",        13,    9,    0,    8,   1, 0)
-MUX_CFG_730("D3_730_KBC1",        13,   13,    0,   12,   1, 0)
-MUX_CFG_730("E4_730_KBC2",        13,   17,    0,   16,   1, 0)
-MUX_CFG_730("F4_730_KBC3",        13,   21,    0,   20,   1, 0)
-MUX_CFG_730("E3_730_KBC4",        13,   25,    0,   24,   1, 0)
-
-MUX_CFG_730("AA17_730_USB_DM",     2,   21,    0,   20,   0, 0)
-MUX_CFG_730("W16_730_USB_PU_EN",   2,   25,    0,   24,   0, 0)
-MUX_CFG_730("W17_730_USB_VBUSI",   2,   29,    0,   28,   0, 0)
+static struct pin_config __initdata_or_module omap7xx_pins[] = {
+MUX_CFG_7XX("E2_7XX_KBR0",        12,   21,    0,   20,   1, 0)
+MUX_CFG_7XX("J7_7XX_KBR1",        12,   25,    0,   24,   1, 0)
+MUX_CFG_7XX("E1_7XX_KBR2",        12,   29,    0,   28,   1, 0)
+MUX_CFG_7XX("F3_7XX_KBR3",        13,    1,    0,    0,   1, 0)
+MUX_CFG_7XX("D2_7XX_KBR4",        13,    5,    0,    4,   1, 0)
+MUX_CFG_7XX("C2_7XX_KBC0",        13,    9,    0,    8,   1, 0)
+MUX_CFG_7XX("D3_7XX_KBC1",        13,   13,    0,   12,   1, 0)
+MUX_CFG_7XX("E4_7XX_KBC2",        13,   17,    0,   16,   1, 0)
+MUX_CFG_7XX("F4_7XX_KBC3",        13,   21,    0,   20,   1, 0)
+MUX_CFG_7XX("E3_7XX_KBC4",        13,   25,    0,   24,   1, 0)
+
+MUX_CFG_7XX("AA17_7XX_USB_DM",     2,   21,    0,   20,   0, 0)
+MUX_CFG_7XX("W16_7XX_USB_PU_EN",   2,   25,    0,   24,   0, 0)
+MUX_CFG_7XX("W17_7XX_USB_VBUSI",   2,   29,    0,   28,   0, 0)
 };
-#define OMAP730_PINS_SZ		ARRAY_SIZE(omap730_pins)
+#define OMAP7XX_PINS_SZ		ARRAY_SIZE(omap7xx_pins)
 #else
-#define omap730_pins		NULL
-#define OMAP730_PINS_SZ		0
-#endif	/* CONFIG_ARCH_OMAP730 */
+#define omap7xx_pins		NULL
+#define OMAP7XX_PINS_SZ		0
+#endif	/* CONFIG_ARCH_OMAP730 || CONFIG_ARCH_OMAP850 */

 #if defined(CONFIG_ARCH_OMAP15XX) || defined(CONFIG_ARCH_OMAP16XX)
 static struct pin_config __initdata_or_module omap1xxx_pins[] = {
@@ -431,8 +431,8 @@ int __init_or_module omap1_cfg_reg(const struct
pin_config *cfg)
 int __init omap1_mux_init(void)
 {
 	if (cpu_is_omap7xx()) {
-		arch_mux_cfg.pins	= omap730_pins;
-		arch_mux_cfg.size	= OMAP730_PINS_SZ;
+		arch_mux_cfg.pins	= omap7xx_pins;
+		arch_mux_cfg.size	= OMAP7XX_PINS_SZ;
 		arch_mux_cfg.cfg_reg	= omap1_cfg_reg;
 	}

diff --git a/arch/arm/mach-omap1/pm.c b/arch/arm/mach-omap1/pm.c
index 58479c7..10f4e4a 100644
--- a/arch/arm/mach-omap1/pm.c
+++ b/arch/arm/mach-omap1/pm.c
@@ -62,7 +62,7 @@
 static unsigned int arm_sleep_save[ARM_SLEEP_SAVE_SIZE];
 static unsigned short dsp_sleep_save[DSP_SLEEP_SAVE_SIZE];
 static unsigned short ulpd_sleep_save[ULPD_SLEEP_SAVE_SIZE];
-static unsigned int mpui730_sleep_save[MPUI730_SLEEP_SAVE_SIZE];
+static unsigned int mpui7xx_sleep_save[MPUI7XX_SLEEP_SAVE_SIZE];
 static unsigned int mpui1510_sleep_save[MPUI1510_SLEEP_SAVE_SIZE];
 static unsigned int mpui1610_sleep_save[MPUI1610_SLEEP_SAVE_SIZE];

@@ -254,14 +254,14 @@ void omap1_pm_suspend(void)
 	 */

 	if (cpu_is_omap7xx()) {
-		MPUI730_SAVE(OMAP_IH1_MIR);
-		MPUI730_SAVE(OMAP_IH2_0_MIR);
-		MPUI730_SAVE(OMAP_IH2_1_MIR);
-		MPUI730_SAVE(MPUI_CTRL);
-		MPUI730_SAVE(MPUI_DSP_BOOT_CONFIG);
-		MPUI730_SAVE(MPUI_DSP_API_CONFIG);
-		MPUI730_SAVE(EMIFS_CONFIG);
-		MPUI730_SAVE(EMIFF_SDRAM_CONFIG);
+		MPUI7XX_SAVE(OMAP_IH1_MIR);
+		MPUI7XX_SAVE(OMAP_IH2_0_MIR);
+		MPUI7XX_SAVE(OMAP_IH2_1_MIR);
+		MPUI7XX_SAVE(MPUI_CTRL);
+		MPUI7XX_SAVE(MPUI_DSP_BOOT_CONFIG);
+		MPUI7XX_SAVE(MPUI_DSP_API_CONFIG);
+		MPUI7XX_SAVE(EMIFS_CONFIG);
+		MPUI7XX_SAVE(EMIFF_SDRAM_CONFIG);

 	} else if (cpu_is_omap15xx()) {
 		MPUI1510_SAVE(OMAP_IH1_MIR);
@@ -384,11 +384,11 @@ void omap1_pm_suspend(void)
 	ULPD_RESTORE(ULPD_STATUS_REQ);

 	if (cpu_is_omap7xx()) {
-		MPUI730_RESTORE(EMIFS_CONFIG);
-		MPUI730_RESTORE(EMIFF_SDRAM_CONFIG);
-		MPUI730_RESTORE(OMAP_IH1_MIR);
-		MPUI730_RESTORE(OMAP_IH2_0_MIR);
-		MPUI730_RESTORE(OMAP_IH2_1_MIR);
+		MPUI7XX_RESTORE(EMIFS_CONFIG);
+		MPUI7XX_RESTORE(EMIFF_SDRAM_CONFIG);
+		MPUI7XX_RESTORE(OMAP_IH1_MIR);
+		MPUI7XX_RESTORE(OMAP_IH2_0_MIR);
+		MPUI7XX_RESTORE(OMAP_IH2_1_MIR);
 	} else if (cpu_is_omap15xx()) {
 		MPUI1510_RESTORE(MPUI_CTRL);
 		MPUI1510_RESTORE(MPUI_DSP_BOOT_CONFIG);
@@ -462,12 +462,12 @@ static int omap_pm_read_proc(
 	ULPD_SAVE(ULPD_POWER_CTRL);

 	if (cpu_is_omap7xx()) {
-		MPUI730_SAVE(MPUI_CTRL);
-		MPUI730_SAVE(MPUI_DSP_STATUS);
-		MPUI730_SAVE(MPUI_DSP_BOOT_CONFIG);
-		MPUI730_SAVE(MPUI_DSP_API_CONFIG);
-		MPUI730_SAVE(EMIFF_SDRAM_CONFIG);
-		MPUI730_SAVE(EMIFS_CONFIG);
+		MPUI7XX_SAVE(MPUI_CTRL);
+		MPUI7XX_SAVE(MPUI_DSP_STATUS);
+		MPUI7XX_SAVE(MPUI_DSP_BOOT_CONFIG);
+		MPUI7XX_SAVE(MPUI_DSP_API_CONFIG);
+		MPUI7XX_SAVE(EMIFF_SDRAM_CONFIG);
+		MPUI7XX_SAVE(EMIFS_CONFIG);
 	} else if (cpu_is_omap15xx()) {
 		MPUI1510_SAVE(MPUI_CTRL);
 		MPUI1510_SAVE(MPUI_DSP_STATUS);
@@ -519,18 +519,18 @@ static int omap_pm_read_proc(

 		if (cpu_is_omap7xx()) {
 			my_buffer_offset += sprintf(my_base + my_buffer_offset,
-			   "MPUI730_CTRL_REG	     0x%-8x \n"
-			   "MPUI730_DSP_STATUS_REG:      0x%-8x \n"
-			   "MPUI730_DSP_BOOT_CONFIG_REG: 0x%-8x \n"
-			   "MPUI730_DSP_API_CONFIG_REG:  0x%-8x \n"
-			   "MPUI730_SDRAM_CONFIG_REG:    0x%-8x \n"
-			   "MPUI730_EMIFS_CONFIG_REG:    0x%-8x \n",
-			   MPUI730_SHOW(MPUI_CTRL),
-			   MPUI730_SHOW(MPUI_DSP_STATUS),
-			   MPUI730_SHOW(MPUI_DSP_BOOT_CONFIG),
-			   MPUI730_SHOW(MPUI_DSP_API_CONFIG),
-			   MPUI730_SHOW(EMIFF_SDRAM_CONFIG),
-			   MPUI730_SHOW(EMIFS_CONFIG));
+			   "MPUI7XX_CTRL_REG	     0x%-8x \n"
+			   "MPUI7XX_DSP_STATUS_REG:      0x%-8x \n"
+			   "MPUI7XX_DSP_BOOT_CONFIG_REG: 0x%-8x \n"
+			   "MPUI7XX_DSP_API_CONFIG_REG:  0x%-8x \n"
+			   "MPUI7XX_SDRAM_CONFIG_REG:    0x%-8x \n"
+			   "MPUI7XX_EMIFS_CONFIG_REG:    0x%-8x \n",
+			   MPUI7XX_SHOW(MPUI_CTRL),
+			   MPUI7XX_SHOW(MPUI_DSP_STATUS),
+			   MPUI7XX_SHOW(MPUI_DSP_BOOT_CONFIG),
+			   MPUI7XX_SHOW(MPUI_DSP_API_CONFIG),
+			   MPUI7XX_SHOW(EMIFF_SDRAM_CONFIG),
+			   MPUI7XX_SHOW(EMIFS_CONFIG));
 		} else if (cpu_is_omap15xx()) {
 			my_buffer_offset += sprintf(my_base + my_buffer_offset,
 			   "MPUI1510_CTRL_REG             0x%-8x \n"
@@ -669,8 +669,8 @@ static int __init omap_pm_init(void)
 	 * memory the MPU can see when it wakes up.
 	 */
 	if (cpu_is_omap7xx()) {
-		omap_sram_suspend = omap_sram_push(omap730_cpu_suspend,
-						   omap730_cpu_suspend_sz);
+		omap_sram_suspend = omap_sram_push(omap7xx_cpu_suspend,
+						   omap7xx_cpu_suspend_sz);
 	} else if (cpu_is_omap15xx()) {
 		omap_sram_suspend = omap_sram_push(omap1510_cpu_suspend,
 						   omap1510_cpu_suspend_sz);
@@ -701,7 +701,7 @@ static int __init omap_pm_init(void)

 	/* Configure IDLECT3 */
 	if (cpu_is_omap7xx())
-		omap_writel(OMAP730_IDLECT3_VAL, OMAP730_IDLECT3);
+		omap_writel(OMAP7XX_IDLECT3_VAL, OMAP7XX_IDLECT3);
 	else if (cpu_is_omap16xx())
 		omap_writel(OMAP1610_IDLECT3_VAL, OMAP1610_IDLECT3);

diff --git a/arch/arm/mach-omap1/pm.h b/arch/arm/mach-omap1/pm.h
index c4f05bd..0f20aed 100644
--- a/arch/arm/mach-omap1/pm.h
+++ b/arch/arm/mach-omap1/pm.h
@@ -98,11 +98,11 @@
 #define OMAP1610_IDLECT3		0xfffece24
 #define OMAP1610_IDLE_LOOP_REQUEST	0x0400

-#define OMAP730_IDLECT1_SLEEP_VAL	0x16c7
-#define OMAP730_IDLECT2_SLEEP_VAL	0x09c7
-#define OMAP730_IDLECT3_VAL		0x3f
-#define OMAP730_IDLECT3		0xfffece24
-#define OMAP730_IDLE_LOOP_REQUEST	0x0C00
+#define OMAP7XX_IDLECT1_SLEEP_VAL	0x16c7
+#define OMAP7XX_IDLECT2_SLEEP_VAL	0x09c7
+#define OMAP7XX_IDLECT3_VAL		0x3f
+#define OMAP7XX_IDLECT3		0xfffece24
+#define OMAP7XX_IDLE_LOOP_REQUEST	0x0C00

 #if     !defined(CONFIG_ARCH_OMAP730) && \
 	!defined(CONFIG_ARCH_OMAP15XX) && \
@@ -122,17 +122,17 @@ extern void allow_idle_sleep(void);
 extern void omap1_pm_idle(void);
 extern void omap1_pm_suspend(void);

-extern void omap730_cpu_suspend(unsigned short, unsigned short);
+extern void omap7xx_cpu_suspend(unsigned short, unsigned short);
 extern void omap1510_cpu_suspend(unsigned short, unsigned short);
 extern void omap1610_cpu_suspend(unsigned short, unsigned short);
-extern void omap730_idle_loop_suspend(void);
+extern void omap7xx_idle_loop_suspend(void);
 extern void omap1510_idle_loop_suspend(void);
 extern void omap1610_idle_loop_suspend(void);

-extern unsigned int omap730_cpu_suspend_sz;
+extern unsigned int omap7xx_cpu_suspend_sz;
 extern unsigned int omap1510_cpu_suspend_sz;
 extern unsigned int omap1610_cpu_suspend_sz;
-extern unsigned int omap730_idle_loop_suspend_sz;
+extern unsigned int omap7xx_idle_loop_suspend_sz;
 extern unsigned int omap1510_idle_loop_suspend_sz;
 extern unsigned int omap1610_idle_loop_suspend_sz;

@@ -155,9 +155,9 @@ extern void omap_serial_wake_trigger(int enable);
 #define ULPD_RESTORE(x)
omap_writew((ulpd_sleep_save[ULPD_SLEEP_SAVE_##x]), (x))
 #define ULPD_SHOW(x) ulpd_sleep_save[ULPD_SLEEP_SAVE_##x]

-#define MPUI730_SAVE(x) mpui730_sleep_save[MPUI730_SLEEP_SAVE_##x] =
omap_readl(x)
-#define MPUI730_RESTORE(x)
omap_writel((mpui730_sleep_save[MPUI730_SLEEP_SAVE_##x]), (x))
-#define MPUI730_SHOW(x) mpui730_sleep_save[MPUI730_SLEEP_SAVE_##x]
+#define MPUI7XX_SAVE(x) mpui7xx_sleep_save[MPUI7XX_SLEEP_SAVE_##x] =
omap_readl(x)
+#define MPUI7XX_RESTORE(x)
omap_writel((mpui7xx_sleep_save[MPUI7XX_SLEEP_SAVE_##x]), (x))
+#define MPUI7XX_SHOW(x) mpui7xx_sleep_save[MPUI7XX_SLEEP_SAVE_##x]

 #define MPUI1510_SAVE(x) mpui1510_sleep_save[MPUI1510_SLEEP_SAVE_##x]
= omap_readl(x)
 #define MPUI1510_RESTORE(x)
omap_writel((mpui1510_sleep_save[MPUI1510_SLEEP_SAVE_##x]), (x))
@@ -232,24 +232,24 @@ enum mpui1510_save_state {
 #endif
 };

-enum mpui730_save_state {
-	MPUI730_SLEEP_SAVE_START = 0,
+enum mpui7xx_save_state {
+	MPUI7XX_SLEEP_SAVE_START = 0,
 	/*
 	 * MPUI registers 32 bits
 	 */
-	MPUI730_SLEEP_SAVE_MPUI_CTRL,
-	MPUI730_SLEEP_SAVE_MPUI_DSP_BOOT_CONFIG,
-	MPUI730_SLEEP_SAVE_MPUI_DSP_API_CONFIG,
-	MPUI730_SLEEP_SAVE_MPUI_DSP_STATUS,
-	MPUI730_SLEEP_SAVE_EMIFF_SDRAM_CONFIG,
-	MPUI730_SLEEP_SAVE_EMIFS_CONFIG,
-	MPUI730_SLEEP_SAVE_OMAP_IH1_MIR,
-	MPUI730_SLEEP_SAVE_OMAP_IH2_0_MIR,
-	MPUI730_SLEEP_SAVE_OMAP_IH2_1_MIR,
-#if defined(CONFIG_ARCH_OMAP730)
-	MPUI730_SLEEP_SAVE_SIZE
+	MPUI7XX_SLEEP_SAVE_MPUI_CTRL,
+	MPUI7XX_SLEEP_SAVE_MPUI_DSP_BOOT_CONFIG,
+	MPUI7XX_SLEEP_SAVE_MPUI_DSP_API_CONFIG,
+	MPUI7XX_SLEEP_SAVE_MPUI_DSP_STATUS,
+	MPUI7XX_SLEEP_SAVE_EMIFF_SDRAM_CONFIG,
+	MPUI7XX_SLEEP_SAVE_EMIFS_CONFIG,
+	MPUI7XX_SLEEP_SAVE_OMAP_IH1_MIR,
+	MPUI7XX_SLEEP_SAVE_OMAP_IH2_0_MIR,
+	MPUI7XX_SLEEP_SAVE_OMAP_IH2_1_MIR,
+#if defined(CONFIG_ARCH_OMAP730) || defined(CONFIG_ARCH_OMAP850)
+	MPUI7XX_SLEEP_SAVE_SIZE
 #else
-	MPUI730_SLEEP_SAVE_SIZE = 0
+	MPUI7XX_SLEEP_SAVE_SIZE = 0
 #endif
 };

diff --git a/arch/arm/mach-omap1/sleep.S b/arch/arm/mach-omap1/sleep.S
index 22e8568..ef771ce 100644
--- a/arch/arm/mach-omap1/sleep.S
+++ b/arch/arm/mach-omap1/sleep.S
@@ -1,7 +1,7 @@
 /*
  * linux/arch/arm/mach-omap1/sleep.S
  *
- * Low-level OMAP730/1510/1610 sleep/wakeUp support
+ * Low-level OMAP7XX/1510/1610 sleep/wakeUp support
  *
  * Initial SA1110 code:
  * Copyright (c) 2001 Cliff Brake <cbrake@accelent.com>
@@ -57,8 +57,8 @@
  *
  */

-#if defined(CONFIG_ARCH_OMAP730)
-ENTRY(omap730_cpu_suspend)
+#if defined(CONFIG_ARCH_OMAP730) || defined(CONFIG_ARCH_OMAP850)
+ENTRY(omap7xx_cpu_suspend)

 	@ save registers on stack
 	stmfd	sp!, {r0 - r12, lr}
@@ -91,13 +91,13 @@ ENTRY(omap730_cpu_suspend)

 	@ turn off clock domains
 	@ do not disable PERCK (0x04)
-	mov	r5, #OMAP730_IDLECT2_SLEEP_VAL & 0xff
-	orr	r5, r5, #OMAP730_IDLECT2_SLEEP_VAL & 0xff00
+	mov	r5, #OMAP7XX_IDLECT2_SLEEP_VAL & 0xff
+	orr	r5, r5, #OMAP7XX_IDLECT2_SLEEP_VAL & 0xff00
 	strh	r5, [r4, #ARM_IDLECT2_ASM_OFFSET & 0xff]

 	@ request ARM idle
-	mov	r3, #OMAP730_IDLECT1_SLEEP_VAL & 0xff
-	orr	r3, r3, #OMAP730_IDLECT1_SLEEP_VAL & 0xff00
+	mov	r3, #OMAP7XX_IDLECT1_SLEEP_VAL & 0xff
+	orr	r3, r3, #OMAP7XX_IDLECT1_SLEEP_VAL & 0xff00
 	strh	r3, [r4, #ARM_IDLECT1_ASM_OFFSET & 0xff]

 	@ disable instruction cache
@@ -113,7 +113,7 @@ ENTRY(omap730_cpu_suspend)
 	mov	r2, #0
 	mcr	p15, 0, r2, c7, c0, 4		@ wait for interrupt
 /*
- * omap730_cpu_suspend()'s resume point.
+ * omap7xx_cpu_suspend()'s resume point.
  *
  * It will just start executing here, so we'll restore stuff from the
  * stack.
@@ -132,9 +132,9 @@ ENTRY(omap730_cpu_suspend)
 	@ restore regs and return
 	ldmfd	sp!, {r0 - r12, pc}

-ENTRY(omap730_cpu_suspend_sz)
-	.word	. - omap730_cpu_suspend
-#endif /* CONFIG_ARCH_OMAP730 */
+ENTRY(omap7xx_cpu_suspend_sz)
+	.word	. - omap7xx_cpu_suspend
+#endif /* CONFIG_ARCH_OMAP730 || CONFIG_ARCH_OMAP850 */

 #ifdef CONFIG_ARCH_OMAP15XX
 ENTRY(omap1510_cpu_suspend)
diff --git a/arch/arm/plat-omap/devices.c b/arch/arm/plat-omap/devices.c
index a64b692..d2f5475 100644
--- a/arch/arm/plat-omap/devices.c
+++ b/arch/arm/plat-omap/devices.c
@@ -113,17 +113,17 @@ static void omap_init_kp(void)
 		omap_cfg_reg(E19_1610_KBR4);
 		omap_cfg_reg(N19_1610_KBR5);
 	} else if (machine_is_omap_perseus2() || machine_is_omap_fsample()) {
-		omap_cfg_reg(E2_730_KBR0);
-		omap_cfg_reg(J7_730_KBR1);
-		omap_cfg_reg(E1_730_KBR2);
-		omap_cfg_reg(F3_730_KBR3);
-		omap_cfg_reg(D2_730_KBR4);
-
-		omap_cfg_reg(C2_730_KBC0);
-		omap_cfg_reg(D3_730_KBC1);
-		omap_cfg_reg(E4_730_KBC2);
-		omap_cfg_reg(F4_730_KBC3);
-		omap_cfg_reg(E3_730_KBC4);
+		omap_cfg_reg(E2_7XX_KBR0);
+		omap_cfg_reg(J7_7XX_KBR1);
+		omap_cfg_reg(E1_7XX_KBR2);
+		omap_cfg_reg(F3_7XX_KBR3);
+		omap_cfg_reg(D2_7XX_KBR4);
+
+		omap_cfg_reg(C2_7XX_KBC0);
+		omap_cfg_reg(D3_7XX_KBC1);
+		omap_cfg_reg(E4_7XX_KBC2);
+		omap_cfg_reg(F4_7XX_KBC3);
+		omap_cfg_reg(E3_7XX_KBC4);
 	} else if (machine_is_omap_h4()) {
 		omap_cfg_reg(T19_24XX_KBR0);
 		omap_cfg_reg(R19_24XX_KBR1);
diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
index 22f6e68..b0c7361 100644
--- a/arch/arm/plat-omap/gpio.c
+++ b/arch/arm/plat-omap/gpio.c
@@ -68,20 +68,20 @@
 #define OMAP1610_GPIO_SET_DATAOUT	0x00f0

 /*
- * OMAP730 specific GPIO registers
+ * OMAP7XX specific GPIO registers
  */
-#define OMAP730_GPIO1_BASE		OMAP1_IO_ADDRESS(0xfffbc000)
-#define OMAP730_GPIO2_BASE		OMAP1_IO_ADDRESS(0xfffbc800)
-#define OMAP730_GPIO3_BASE		OMAP1_IO_ADDRESS(0xfffbd000)
-#define OMAP730_GPIO4_BASE		OMAP1_IO_ADDRESS(0xfffbd800)
-#define OMAP730_GPIO5_BASE		OMAP1_IO_ADDRESS(0xfffbe000)
-#define OMAP730_GPIO6_BASE		OMAP1_IO_ADDRESS(0xfffbe800)
-#define OMAP730_GPIO_DATA_INPUT		0x00
-#define OMAP730_GPIO_DATA_OUTPUT	0x04
-#define OMAP730_GPIO_DIR_CONTROL	0x08
-#define OMAP730_GPIO_INT_CONTROL	0x0c
-#define OMAP730_GPIO_INT_MASK		0x10
-#define OMAP730_GPIO_INT_STATUS		0x14
+#define OMAP7XX_GPIO1_BASE		OMAP1_IO_ADDRESS(0xfffbc000)
+#define OMAP7XX_GPIO2_BASE		OMAP1_IO_ADDRESS(0xfffbc800)
+#define OMAP7XX_GPIO3_BASE		OMAP1_IO_ADDRESS(0xfffbd000)
+#define OMAP7XX_GPIO4_BASE		OMAP1_IO_ADDRESS(0xfffbd800)
+#define OMAP7XX_GPIO5_BASE		OMAP1_IO_ADDRESS(0xfffbe000)
+#define OMAP7XX_GPIO6_BASE		OMAP1_IO_ADDRESS(0xfffbe800)
+#define OMAP7XX_GPIO_DATA_INPUT		0x00
+#define OMAP7XX_GPIO_DATA_OUTPUT	0x04
+#define OMAP7XX_GPIO_DIR_CONTROL	0x08
+#define OMAP7XX_GPIO_INT_CONTROL	0x0c
+#define OMAP7XX_GPIO_INT_MASK		0x10
+#define OMAP7XX_GPIO_INT_STATUS		0x14

 #define OMAP1_MPUIO_VBASE		OMAP1_IO_ADDRESS(OMAP1_MPUIO_BASE)

@@ -199,7 +199,7 @@ struct gpio_bank {
 #define METHOD_MPUIO		0
 #define METHOD_GPIO_1510	1
 #define METHOD_GPIO_1610	2
-#define METHOD_GPIO_730		3
+#define METHOD_GPIO_7XX		3
 #define METHOD_GPIO_24XX	5

 #ifdef CONFIG_ARCH_OMAP16XX
@@ -220,14 +220,14 @@ static struct gpio_bank gpio_bank_1510[2] = {
 #endif

 #if defined(CONFIG_ARCH_OMAP730) || defined(CONFIG_ARCH_OMAP850)
-static struct gpio_bank gpio_bank_730[7] = {
+static struct gpio_bank gpio_bank_7xx[7] = {
 	{ OMAP1_MPUIO_VBASE,    INT_7XX_MPUIO,	    IH_MPUIO_BASE,	METHOD_MPUIO },
-	{ OMAP730_GPIO1_BASE,  INT_7XX_GPIO_BANK1,  IH_GPIO_BASE,	METHOD_GPIO_730 },
-	{ OMAP730_GPIO2_BASE,  INT_7XX_GPIO_BANK2,  IH_GPIO_BASE +
32,	METHOD_GPIO_730 },
-	{ OMAP730_GPIO3_BASE,  INT_7XX_GPIO_BANK3,  IH_GPIO_BASE +
64,	METHOD_GPIO_730 },
-	{ OMAP730_GPIO4_BASE,  INT_7XX_GPIO_BANK4,  IH_GPIO_BASE +
96,	METHOD_GPIO_730 },
-	{ OMAP730_GPIO5_BASE,  INT_7XX_GPIO_BANK5,  IH_GPIO_BASE + 128,
METHOD_GPIO_730 },
-	{ OMAP730_GPIO6_BASE,  INT_7XX_GPIO_BANK6,  IH_GPIO_BASE + 160,
METHOD_GPIO_730 },
+	{ OMAP7XX_GPIO1_BASE,  INT_7XX_GPIO_BANK1,  IH_GPIO_BASE,	METHOD_GPIO_7XX },
+	{ OMAP7XX_GPIO2_BASE,  INT_7XX_GPIO_BANK2,  IH_GPIO_BASE +
32,	METHOD_GPIO_7XX },
+	{ OMAP7XX_GPIO3_BASE,  INT_7XX_GPIO_BANK3,  IH_GPIO_BASE +
64,	METHOD_GPIO_7XX },
+	{ OMAP7XX_GPIO4_BASE,  INT_7XX_GPIO_BANK4,  IH_GPIO_BASE +
96,	METHOD_GPIO_7XX },
+	{ OMAP7XX_GPIO5_BASE,  INT_7XX_GPIO_BANK5,  IH_GPIO_BASE + 128,
METHOD_GPIO_7XX },
+	{ OMAP7XX_GPIO6_BASE,  INT_7XX_GPIO_BANK6,  IH_GPIO_BASE + 160,
METHOD_GPIO_7XX },
 };
 #endif

@@ -373,8 +373,8 @@ static void _set_gpio_direction(struct gpio_bank
*bank, int gpio, int is_input)
 		break;
 #endif
 #if defined(CONFIG_ARCH_OMAP730) || defined(CONFIG_ARCH_OMAP850)
-	case METHOD_GPIO_730:
-		reg += OMAP730_GPIO_DIR_CONTROL;
+	case METHOD_GPIO_7XX:
+		reg += OMAP7XX_GPIO_DIR_CONTROL;
 		break;
 #endif
 #if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
@@ -435,8 +435,8 @@ static void _set_gpio_dataout(struct gpio_bank
*bank, int gpio, int enable)
 		break;
 #endif
 #if defined(CONFIG_ARCH_OMAP730) || defined(CONFIG_ARCH_OMAP850)
-	case METHOD_GPIO_730:
-		reg += OMAP730_GPIO_DATA_OUTPUT;
+	case METHOD_GPIO_7XX:
+		reg += OMAP7XX_GPIO_DATA_OUTPUT;
 		l = __raw_readl(reg);
 		if (enable)
 			l |= 1 << gpio;
@@ -493,8 +493,8 @@ static int _get_gpio_datain(struct gpio_bank
*bank, int gpio)
 		break;
 #endif
 #if defined(CONFIG_ARCH_OMAP730) || defined(CONFIG_ARCH_OMAP850)
-	case METHOD_GPIO_730:
-		reg += OMAP730_GPIO_DATA_INPUT;
+	case METHOD_GPIO_7XX:
+		reg += OMAP7XX_GPIO_DATA_INPUT;
 		break;
 #endif
 #if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
@@ -539,8 +539,8 @@ static int _get_gpio_dataout(struct gpio_bank
*bank, int gpio)
 		break;
 #endif
 #if defined(CONFIG_ARCH_OMAP730) || defined(CONFIG_ARCH_OMAP850)
-	case METHOD_GPIO_730:
-		reg += OMAP730_GPIO_DATA_OUTPUT;
+	case METHOD_GPIO_7XX:
+		reg += OMAP7XX_GPIO_DATA_OUTPUT;
 		break;
 #endif
 #if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX) || \
@@ -743,8 +743,8 @@ static int _set_gpio_triggering(struct gpio_bank
*bank, int gpio, int trigger)
 		break;
 #endif
 #if defined(CONFIG_ARCH_OMAP730) || defined(CONFIG_ARCH_OMAP850)
-	case METHOD_GPIO_730:
-		reg += OMAP730_GPIO_INT_CONTROL;
+	case METHOD_GPIO_7XX:
+		reg += OMAP7XX_GPIO_INT_CONTROL;
 		l = __raw_readl(reg);
 		if (trigger & IRQ_TYPE_EDGE_RISING)
 			l |= 1 << gpio;
@@ -831,8 +831,8 @@ static void _clear_gpio_irqbank(struct gpio_bank
*bank, int gpio_mask)
 		break;
 #endif
 #if defined(CONFIG_ARCH_OMAP730) || defined(CONFIG_ARCH_OMAP850)
-	case METHOD_GPIO_730:
-		reg += OMAP730_GPIO_INT_STATUS;
+	case METHOD_GPIO_7XX:
+		reg += OMAP7XX_GPIO_INT_STATUS;
 		break;
 #endif
 #if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
@@ -900,8 +900,8 @@ static u32 _get_gpio_irqbank_mask(struct gpio_bank *bank)
 		break;
 #endif
 #if defined(CONFIG_ARCH_OMAP730) || defined(CONFIG_ARCH_OMAP850)
-	case METHOD_GPIO_730:
-		reg += OMAP730_GPIO_INT_MASK;
+	case METHOD_GPIO_7XX:
+		reg += OMAP7XX_GPIO_INT_MASK;
 		mask = 0xffffffff;
 		inv = 1;
 		break;
@@ -966,8 +966,8 @@ static void _enable_gpio_irqbank(struct gpio_bank
*bank, int gpio_mask, int enab
 		break;
 #endif
 #if defined(CONFIG_ARCH_OMAP730) || defined(CONFIG_ARCH_OMAP850)
-	case METHOD_GPIO_730:
-		reg += OMAP730_GPIO_INT_MASK;
+	case METHOD_GPIO_7XX:
+		reg += OMAP7XX_GPIO_INT_MASK;
 		l = __raw_readl(reg);
 		if (enable)
 			l &= ~(gpio_mask);
@@ -1161,8 +1161,8 @@ static void gpio_irq_handler(unsigned int irq,
struct irq_desc *desc)
 		isr_reg = bank->base + OMAP1610_GPIO_IRQSTATUS1;
 #endif
 #if defined(CONFIG_ARCH_OMAP730) || defined(CONFIG_ARCH_OMAP850)
-	if (bank->method == METHOD_GPIO_730)
-		isr_reg = bank->base + OMAP730_GPIO_INT_STATUS;
+	if (bank->method == METHOD_GPIO_7XX)
+		isr_reg = bank->base + OMAP7XX_GPIO_INT_STATUS;
 #endif
 #if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
 	if (bank->method == METHOD_GPIO_24XX)
@@ -1431,8 +1431,8 @@ static int gpio_is_input(struct gpio_bank *bank, int mask)
 	case METHOD_GPIO_1610:
 		reg += OMAP1610_GPIO_DIRECTION;
 		break;
-	case METHOD_GPIO_730:
-		reg += OMAP730_GPIO_DIR_CONTROL;
+	case METHOD_GPIO_7XX:
+		reg += OMAP7XX_GPIO_DIR_CONTROL;
 		break;
 	case METHOD_GPIO_24XX:
 		reg += OMAP24XX_GPIO_OE;
@@ -1603,7 +1603,7 @@ static int __init _omap_gpio_init(void)
 	if (cpu_is_omap7xx()) {
 		printk(KERN_INFO "OMAP7XX GPIO hardware\n");
 		gpio_bank_count = 7;
-		gpio_bank = gpio_bank_730;
+		gpio_bank = gpio_bank_7xx;
 	}
 #endif
 #ifdef CONFIG_ARCH_OMAP24XX
@@ -1664,11 +1664,11 @@ static int __init _omap_gpio_init(void)
 			__raw_writew(0xffff, bank->base + OMAP1610_GPIO_IRQSTATUS1);
 			__raw_writew(0x0014, bank->base + OMAP1610_GPIO_SYSCONFIG);
 		}
-		if (cpu_is_omap7xx() && bank->method == METHOD_GPIO_730) {
-			__raw_writel(0xffffffff, bank->base + OMAP730_GPIO_INT_MASK);
-			__raw_writel(0x00000000, bank->base + OMAP730_GPIO_INT_STATUS);
+		if (cpu_is_omap7xx() && bank->method == METHOD_GPIO_7XX) {
+			__raw_writel(0xffffffff, bank->base + OMAP7XX_GPIO_INT_MASK);
+			__raw_writel(0x00000000, bank->base + OMAP7XX_GPIO_INT_STATUS);

-			gpio_count = 32; /* 730 has 32-bit GPIOs */
+			gpio_count = 32; /* 7xx has 32-bit GPIOs */
 		}

 #if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX) || \
diff --git a/arch/arm/plat-omap/include/mach/mcbsp.h
b/arch/arm/plat-omap/include/mach/mcbsp.h
index 0b476b9..7e9cae3 100644
--- a/arch/arm/plat-omap/include/mach/mcbsp.h
+++ b/arch/arm/plat-omap/include/mach/mcbsp.h
@@ -30,8 +30,8 @@
 #include <mach/hardware.h>
 #include <mach/clock.h>

-#define OMAP730_MCBSP1_BASE	0xfffb1000
-#define OMAP730_MCBSP2_BASE	0xfffb1800
+#define OMAP7XX_MCBSP1_BASE	0xfffb1000
+#define OMAP7XX_MCBSP2_BASE	0xfffb1800

 #define OMAP1510_MCBSP1_BASE	0xe1011800
 #define OMAP1510_MCBSP2_BASE	0xfffb1000
diff --git a/arch/arm/plat-omap/include/mach/mux.h
b/arch/arm/plat-omap/include/mach/mux.h
index 66ae302..f3c1d8a 100644
--- a/arch/arm/plat-omap/include/mach/mux.h
+++ b/arch/arm/plat-omap/include/mach/mux.h
@@ -51,12 +51,12 @@
 					.pu_pd_reg = PU_PD_SEL_##reg, \
 					.pu_pd_val = status,

-#define MUX_REG_730(reg, mode_offset, mode) .mux_reg_name =
"OMAP7XX_IO_CONF_"#reg, \
+#define MUX_REG_7XX(reg, mode_offset, mode) .mux_reg_name =
"OMAP7XX_IO_CONF_"#reg, \
 					.mux_reg = OMAP7XX_IO_CONF_##reg, \
 					.mask_offset = mode_offset, \
 					.mask = mode,

-#define PULL_REG_730(reg, bit, status)	.pull_name = "OMAP7XX_IO_CONF_"#reg, \
+#define PULL_REG_7XX(reg, bit, status)	.pull_name = "OMAP7XX_IO_CONF_"#reg, \
 					.pull_reg = OMAP7XX_IO_CONF_##reg, \
 					.pull_bit = bit, \
 					.pull_val = status,
@@ -74,12 +74,12 @@
 #define PU_PD_REG(reg, status)		.pu_pd_reg = PU_PD_SEL_##reg, \
 					.pu_pd_val = status,

-#define MUX_REG_730(reg, mode_offset, mode) \
+#define MUX_REG_7XX(reg, mode_offset, mode) \
 					.mux_reg = OMAP7XX_IO_CONF_##reg, \
 					.mask_offset = mode_offset, \
 					.mask = mode,

-#define PULL_REG_730(reg, bit, status)	.pull_reg = OMAP7XX_IO_CONF_##reg, \
+#define PULL_REG_7XX(reg, bit, status)	.pull_reg = OMAP7XX_IO_CONF_##reg, \
 					.pull_bit = bit, \
 					.pull_val = status,

@@ -104,13 +104,13 @@
  * - for pull-up/down, only has one enable bit which is is in the same register
  *   as mux config
  */
-#define MUX_CFG_730(desc, mux_reg, mode_offset, mode,	\
+#define MUX_CFG_7XX(desc, mux_reg, mode_offset, mode,	\
 		   pull_bit, pull_status, debug_status)\
 {							\
 	.name =	 desc,					\
 	.debug = debug_status,				\
-	MUX_REG_730(mux_reg, mode_offset, mode)		\
-	PULL_REG_730(mux_reg, pull_bit, pull_status)	\
+	MUX_REG_7XX(mux_reg, mode_offset, mode)		\
+	PULL_REG_7XX(mux_reg, pull_bit, pull_status)	\
 	PU_PD_REG(NA, 0)		\
 },

@@ -202,23 +202,23 @@ struct pin_config {

 };

-enum omap730_index {
+enum omap7xx_index {
 	/* OMAP 730 keyboard */
-	E2_730_KBR0,
-	J7_730_KBR1,
-	E1_730_KBR2,
-	F3_730_KBR3,
-	D2_730_KBR4,
-	C2_730_KBC0,
-	D3_730_KBC1,
-	E4_730_KBC2,
-	F4_730_KBC3,
-	E3_730_KBC4,
+	E2_7XX_KBR0,
+	J7_7XX_KBR1,
+	E1_7XX_KBR2,
+	F3_7XX_KBR3,
+	D2_7XX_KBR4,
+	C2_7XX_KBC0,
+	D3_7XX_KBC1,
+	E4_7XX_KBC2,
+	F4_7XX_KBC3,
+	E3_7XX_KBC4,

 	/* USB */
-	AA17_730_USB_DM,
-	W16_730_USB_PU_EN,
-	W17_730_USB_VBUSI,
+	AA17_7XX_USB_DM,
+	W16_7XX_USB_PU_EN,
+	W17_7XX_USB_VBUSI,
 };

 enum omap1xxx_index {
-- 
1.6.5
