From: Alistair Buxton <a.j.buxton@gmail.com>
Subject: [PATCH 04/17] OMAP7XX: Mux: Remove duplicate omap850 code
Date: Wed, 14 Oct 2009 20:50:33 +0100
Message-ID: <3d374d00910141250j23282d2em3c872000b1e98bdd@mail.gmail.com>
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

Signed-off-by: Alistair Buxton <a.j.buxton@gmail.com>
Reviewed-by: Zebediah C. McClure <zmc@lurian.net>
---
 arch/arm/mach-omap1/mux.c             |   28 +-----------------
 arch/arm/plat-omap/include/mach/mux.h |   50 ---------------------------------
 2 files changed, 2 insertions(+), 76 deletions(-)

diff --git a/arch/arm/mach-omap1/mux.c b/arch/arm/mach-omap1/mux.c
index 721e0d9..f9d45a3 100644
--- a/arch/arm/mach-omap1/mux.c
+++ b/arch/arm/mach-omap1/mux.c
@@ -35,7 +35,7 @@

 static struct omap_mux_cfg arch_mux_cfg;

-#ifdef CONFIG_ARCH_OMAP730
+#if defined(CONFIG_ARCH_OMAP730) || defined(CONFIG_ARCH_OMAP850)
 static struct pin_config __initdata_or_module omap730_pins[] = {
 MUX_CFG_730("E2_730_KBR0",        12,   21,    0,   20,   1, 0)
 MUX_CFG_730("J7_730_KBR1",        12,   25,    0,   24,   1, 0)
@@ -58,25 +58,6 @@ MUX_CFG_730("W17_730_USB_VBUSI",   2,   29,    0,
28,   0, 0)
 #define OMAP730_PINS_SZ		0
 #endif	/* CONFIG_ARCH_OMAP730 */

-#ifdef CONFIG_ARCH_OMAP850
-struct pin_config __initdata_or_module omap850_pins[] = {
-MUX_CFG_850("E2_850_KBR0",        12,   21,    0,   20,   1, 0)
-MUX_CFG_850("J7_850_KBR1",        12,   25,    0,   24,   1, 0)
-MUX_CFG_850("E1_850_KBR2",        12,   29,    0,   28,   1, 0)
-MUX_CFG_850("F3_850_KBR3",        13,    1,    0,    0,   1, 0)
-MUX_CFG_850("D2_850_KBR4",        13,    5,    0,    4,   1, 0)
-MUX_CFG_850("C2_850_KBC0",        13,    9,    0,    8,   1, 0)
-MUX_CFG_850("D3_850_KBC1",        13,   13,    0,   12,   1, 0)
-MUX_CFG_850("E4_850_KBC2",        13,   17,    0,   16,   1, 0)
-MUX_CFG_850("F4_850_KBC3",        13,   21,    0,   20,   1, 0)
-MUX_CFG_850("E3_850_KBC4",        13,   25,    0,   24,   1, 0)
-
-MUX_CFG_850("AA17_850_USB_DM",     2,   21,    0,   20,   0, 0)
-MUX_CFG_850("W16_850_USB_PU_EN",   2,   25,    0,   24,   0, 0)
-MUX_CFG_850("W17_850_USB_VBUSI",   2,   29,    0,   28,   0, 0)
-};
-#endif
-
 #if defined(CONFIG_ARCH_OMAP15XX) || defined(CONFIG_ARCH_OMAP16XX)
 static struct pin_config __initdata_or_module omap1xxx_pins[] = {
 /*
@@ -438,11 +419,6 @@ int __init_or_module omap1_cfg_reg(const struct
pin_config *cfg)
 			printk("      %s (0x%08x) = 0x%08x -> 0x%08x\n",
 			       cfg->pull_name, cfg->pull_reg, pull_orig, pull);
 	}
-
-#ifdef CONFIG_ARCH_OMAP850
-	omap_mux_register(omap850_pins, ARRAY_SIZE(omap850_pins));
-#endif
-
 #endif

 #ifdef CONFIG_OMAP_MUX_ERRORS
@@ -454,7 +430,7 @@ int __init_or_module omap1_cfg_reg(const struct
pin_config *cfg)

 int __init omap1_mux_init(void)
 {
-	if (cpu_is_omap730()) {
+	if (cpu_is_omap7xx()) {
 		arch_mux_cfg.pins	= omap730_pins;
 		arch_mux_cfg.size	= OMAP730_PINS_SZ;
 		arch_mux_cfg.cfg_reg	= omap1_cfg_reg;
diff --git a/arch/arm/plat-omap/include/mach/mux.h
b/arch/arm/plat-omap/include/mach/mux.h
index 0f49d2d..587fb63 100644
--- a/arch/arm/plat-omap/include/mach/mux.h
+++ b/arch/arm/plat-omap/include/mach/mux.h
@@ -61,16 +61,6 @@
 					.pull_bit = bit, \
 					.pull_val = status,

-#define MUX_REG_850(reg, mode_offset, mode) .mux_reg_name =
"OMAP850_IO_CONF_"#reg, \
-					.mux_reg = OMAP850_IO_CONF_##reg, \
-					.mask_offset = mode_offset, \
-					.mask = mode,
-
-#define PULL_REG_850(reg, bit, status)	.pull_name = "OMAP850_IO_CONF_"#reg, \
-					.pull_reg = OMAP850_IO_CONF_##reg, \
-					.pull_bit = bit, \
-					.pull_val = status,
-
 #else

 #define MUX_REG(reg, mode_offset, mode) .mux_reg = FUNC_MUX_CTRL_##reg, \
@@ -93,15 +83,6 @@
 					.pull_bit = bit, \
 					.pull_val = status,

-#define MUX_REG_850(reg, mode_offset, mode) \
-					.mux_reg = OMAP850_IO_CONF_##reg, \
-					.mask_offset = mode_offset, \
-					.mask = mode,
-
-#define PULL_REG_850(reg, bit, status)	.pull_reg = OMAP850_IO_CONF_##reg, \
-					.pull_bit = bit, \
-					.pull_val = status,
-
 #endif /* CONFIG_OMAP_MUX_DEBUG */

 #define MUX_CFG(desc, mux_reg, mode_offset, mode,	\
@@ -133,17 +114,6 @@
 	PU_PD_REG(NA, 0)		\
 },

-#define MUX_CFG_850(desc, mux_reg, mode_offset, mode,	\
-		   pull_bit, pull_status, debug_status)\
-{							\
-	.name =	 desc,					\
-	.debug = debug_status,				\
-	MUX_REG_850(mux_reg, mode_offset, mode)		\
-	PULL_REG_850(mux_reg, pull_bit, pull_status)	\
-	PU_PD_REG(NA, 0)		\
-},
-
-
 #define MUX_CFG_24XX(desc, reg_offset, mode,			\
 				pull_en, pull_mode, dbg)	\
 {								\
@@ -251,26 +221,6 @@ enum omap730_index {
 	W17_730_USB_VBUSI,
 };

-enum omap850_index {
-	/* OMAP 850 keyboard */
-	E2_850_KBR0,
-	J7_850_KBR1,
-	E1_850_KBR2,
-	F3_850_KBR3,
-	D2_850_KBR4,
-	C2_850_KBC0,
-	D3_850_KBC1,
-	E4_850_KBC2,
-	F4_850_KBC3,
-	E3_850_KBC4,
-
-	/* USB */
-	AA17_850_USB_DM,
-	W16_850_USB_PU_EN,
-	W17_850_USB_VBUSI,
-};
-
-
 enum omap1xxx_index {
 	/* UART1 (BT_UART_GATING)*/
 	UART1_TX = 0,
-- 
1.6.5
