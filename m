From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 07/10] OMAP: McBSP: implement functional clock switching via
	clock framework
Date: Fri, 01 Oct 2010 15:35:32 -0600
Message-ID: <20101001213531.1408.87922.stgit@twilight.localdomain>
References: <20101001213119.1408.65395.stgit@twilight.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:49842 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756105Ab0JAVl0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Oct 2010 17:41:26 -0400
In-Reply-To: <20101001213119.1408.65395.stgit@twilight.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Jarkko Nikula <jhnikula@gmail.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>

Previously the OMAP McBSP ASoC driver implemented CLKS switching by
using omap_ctrl_{read,write}l() directly.  This is against policy; the OMAP
System Control Module functions are not intended to be exported to drivers.
These symbols are no longer exported, so as a result, the OMAP McBSP ASoC
driver does not build as a module.

Resolve the CLKS clock changing portion of this problem by creating a
clock parent changing function that lives in
arch/arm/mach-omap2/mcbsp.c, and modify the ASoC driver to use it.
Due to the unfortunate way that McBSP support is implemented in ASoC
and the OMAP tree, this symbol must be exported for use by
sound/soc/omap/omap-mcbsp.c.

Going forward, the McBSP device driver should be moved from
arch/arm/*omap* into drivers/ or sound/soc/* and the CPU DAI driver
should be implemented as a platform_driver as many other ASoC CPU DAI
drivers are.  These two steps should resolve many of the layering
problems, which will rapidly reappear during a McBSP hwmod/PM runtime
conversions.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Jarkko Nikula <jhnikula@gmail.com>
Cc: Peter Ujfalusi <peter.ujfalusi@nokia.com>
---
 arch/arm/mach-omap2/mcbsp.c             |   51 +++++++++++++++++++++++
 arch/arm/plat-omap/include/plat/mcbsp.h |   11 +++++
 arch/arm/plat-omap/mcbsp.c              |    3 -
 sound/soc/omap/omap-mcbsp.c             |   69 ++++++-------------------------
 4 files changed, 75 insertions(+), 59 deletions(-)

diff --git a/arch/arm/mach-omap2/mcbsp.c b/arch/arm/mach-omap2/mcbsp.c
index 4c9c999..51abced 100644
--- a/arch/arm/mach-omap2/mcbsp.c
+++ b/arch/arm/mach-omap2/mcbsp.c
@@ -52,6 +52,54 @@ void omap2_mcbsp1_mux_fsr_src(u8 mux)
 }
 EXPORT_SYMBOL(omap2_mcbsp1_mux_fsr_src);
 
+/* McBSP CLKS source switching function */
+
+int omap2_mcbsp_set_clks_src(u8 id, u8 fck_src_id)
+{
+	struct omap_mcbsp *mcbsp;
+	struct clk *fck_src;
+	char *fck_src_name;
+	int r;
+
+	if (!omap_mcbsp_check_valid_id(id)) {
+		pr_err("%s: Invalid id (%d)\n", __func__, id + 1);
+		return -EINVAL;
+	}
+	mcbsp = id_to_mcbsp_ptr(id);
+
+	if (fck_src_id == MCBSP_CLKS_PAD_SRC)
+		fck_src_name = "pad_fck";
+	else if (fck_src_id == MCBSP_CLKS_PRCM_SRC)
+		fck_src_name = "prcm_fck";
+	else
+		return -EINVAL;
+
+	fck_src = clk_get(mcbsp->dev, fck_src_name);
+	if (IS_ERR_OR_NULL(fck_src)) {
+		pr_err("omap-mcbsp: %s: could not clk_get() %s\n", "clks",
+		       fck_src_name);
+		return -EINVAL;
+	}
+
+	clk_disable(mcbsp->fclk);
+
+	r = clk_set_parent(mcbsp->fclk, fck_src);
+	if (IS_ERR_VALUE(r)) {
+		pr_err("omap-mcbsp: %s: could not clk_set_parent() to %s\n",
+		       "clks", fck_src_name);
+		clk_put(fck_src);
+		return -EINVAL;
+	}
+
+	clk_enable(mcbsp->fclk);
+
+	clk_put(fck_src);
+
+	return 0;
+}
+EXPORT_SYMBOL(omap2_mcbsp_set_clks_src);
+
+
 /* Platform data */
 
 #ifdef CONFIG_ARCH_OMAP2420
@@ -190,18 +238,21 @@ static struct omap_mcbsp_platform_data omap44xx_mcbsp_pdata[] = {
 		.dma_rx_sync    = OMAP44XX_DMA_MCBSP2_RX,
 		.dma_tx_sync    = OMAP44XX_DMA_MCBSP2_TX,
 		.tx_irq         = OMAP44XX_IRQ_MCBSP2,
+		/* XXX .ops ? */
 	},
 	{
 		.phys_base      = OMAP44XX_MCBSP3_BASE,
 		.dma_rx_sync    = OMAP44XX_DMA_MCBSP3_RX,
 		.dma_tx_sync    = OMAP44XX_DMA_MCBSP3_TX,
 		.tx_irq         = OMAP44XX_IRQ_MCBSP3,
+		/* XXX .ops ? */
 	},
 	{
 		.phys_base      = OMAP44XX_MCBSP4_BASE,
 		.dma_rx_sync    = OMAP44XX_DMA_MCBSP4_RX,
 		.dma_tx_sync    = OMAP44XX_DMA_MCBSP4_TX,
 		.tx_irq         = OMAP44XX_IRQ_MCBSP4,
+		/* XXX .ops ? */
 	},
 };
 #define OMAP44XX_MCBSP_PDATA_SZ		ARRAY_SIZE(omap44xx_mcbsp_pdata)
diff --git a/arch/arm/plat-omap/include/plat/mcbsp.h b/arch/arm/plat-omap/include/plat/mcbsp.h
index 886d0e6..4da6f94 100644
--- a/arch/arm/plat-omap/include/plat/mcbsp.h
+++ b/arch/arm/plat-omap/include/plat/mcbsp.h
@@ -320,6 +320,10 @@
 #define FSR_SRC_FSR		0
 #define FSR_SRC_FSX		1
 
+/* McBSP functional clock sources */
+#define MCBSP_CLKS_PAD_SRC	0
+#define MCBSP_CLKS_PRCM_SRC	1
+
 /* we don't do multichannel for now */
 struct omap_mcbsp_reg_cfg {
 	u16 spcr2;
@@ -406,6 +410,7 @@ struct omap_mcbsp_spi_cfg {
 struct omap_mcbsp_ops {
 	void (*request)(unsigned int);
 	void (*free)(unsigned int);
+	int (*set_clks_src)(u8, u8);
 };
 
 struct omap_mcbsp_platform_data {
@@ -472,6 +477,9 @@ struct omap_mcbsp {
 extern struct omap_mcbsp **mcbsp_ptr;
 extern int omap_mcbsp_count, omap_mcbsp_cache_size;
 
+#define omap_mcbsp_check_valid_id(id)	(id < omap_mcbsp_count)
+#define id_to_mcbsp_ptr(id)		mcbsp_ptr[id];
+
 int omap_mcbsp_init(void);
 void omap_mcbsp_register_board_cfg(struct omap_mcbsp_platform_data *config,
 					int size);
@@ -509,6 +517,9 @@ int omap_mcbsp_recv_buffer(unsigned int id, dma_addr_t buffer, unsigned int leng
 int omap_mcbsp_spi_master_xmit_word_poll(unsigned int id, u32 word);
 int omap_mcbsp_spi_master_recv_word_poll(unsigned int id, u32 * word);
 
+
+/* McBSP functional clock source changing function */
+extern int omap2_mcbsp_set_clks_src(u8 id, u8 fck_src_id);
 /* SPI specific API */
 void omap_mcbsp_set_spi_mode(unsigned int id, const struct omap_mcbsp_spi_cfg * spi_cfg);
 
diff --git a/arch/arm/plat-omap/mcbsp.c b/arch/arm/plat-omap/mcbsp.c
index 89d7671..49bebbf 100644
--- a/arch/arm/plat-omap/mcbsp.c
+++ b/arch/arm/plat-omap/mcbsp.c
@@ -81,9 +81,6 @@ int omap_mcbsp_st_read(struct omap_mcbsp *mcbsp, u16 reg)
 #define MCBSP_READ_CACHE(mcbsp, reg) \
 		omap_mcbsp_read(mcbsp, OMAP_MCBSP_REG_##reg, 1)
 
-#define omap_mcbsp_check_valid_id(id)	(id < omap_mcbsp_count)
-#define id_to_mcbsp_ptr(id)		mcbsp_ptr[id];
-
 #define MCBSP_ST_READ(mcbsp, reg) \
 			omap_mcbsp_st_read(mcbsp, OMAP_ST_REG_##reg)
 #define MCBSP_ST_WRITE(mcbsp, reg, val) \
diff --git a/sound/soc/omap/omap-mcbsp.c b/sound/soc/omap/omap-mcbsp.c
index f50a5ab..b59ad11 100644
--- a/sound/soc/omap/omap-mcbsp.c
+++ b/sound/soc/omap/omap-mcbsp.c
@@ -31,7 +31,6 @@
 #include <sound/initval.h>
 #include <sound/soc.h>
 
-#include <plat/control.h>
 #include <plat/dma.h>
 #include <plat/mcbsp.h>
 #include "omap-mcbsp.h"
@@ -608,66 +607,12 @@ static int omap_mcbsp_dai_set_clkdiv(struct snd_soc_dai *cpu_dai,
 	return 0;
 }
 
-static int omap_mcbsp_dai_set_clks_src(struct omap_mcbsp_data *mcbsp_data,
-				       int clk_id)
-{
-	int sel_bit;
-	u16 reg, reg_devconf1 = OMAP243X_CONTROL_DEVCONF1;
-
-	if (cpu_class_is_omap1()) {
-		/* OMAP1's can use only external source clock */
-		if (unlikely(clk_id == OMAP_MCBSP_SYSCLK_CLKS_FCLK))
-			return -EINVAL;
-		else
-			return 0;
-	}
-
-	if (cpu_is_omap2420() && mcbsp_data->bus_id > 1)
-		return -EINVAL;
-
-	if (cpu_is_omap343x())
-		reg_devconf1 = OMAP343X_CONTROL_DEVCONF1;
-
-	switch (mcbsp_data->bus_id) {
-	case 0:
-		reg = OMAP2_CONTROL_DEVCONF0;
-		sel_bit = 2;
-		break;
-	case 1:
-		reg = OMAP2_CONTROL_DEVCONF0;
-		sel_bit = 6;
-		break;
-	case 2:
-		reg = reg_devconf1;
-		sel_bit = 0;
-		break;
-	case 3:
-		reg = reg_devconf1;
-		sel_bit = 2;
-		break;
-	case 4:
-		reg = reg_devconf1;
-		sel_bit = 4;
-		break;
-	default:
-		return -EINVAL;
-	}
-
-	if (clk_id == OMAP_MCBSP_SYSCLK_CLKS_FCLK)
-		omap_ctrl_writel(omap_ctrl_readl(reg) & ~(1 << sel_bit), reg);
-	else
-		omap_ctrl_writel(omap_ctrl_readl(reg) | (1 << sel_bit), reg);
-
-	return 0;
-}
-
 static int omap_mcbsp_dai_set_dai_sysclk(struct snd_soc_dai *cpu_dai,
 					 int clk_id, unsigned int freq,
 					 int dir)
 {
 	struct omap_mcbsp_data *mcbsp_data = to_mcbsp(cpu_dai->private_data);
 	struct omap_mcbsp_reg_cfg *regs = &mcbsp_data->regs;
-	struct omap_mcbsp_platform_data *pdata = cpu_dai->dev->platform_data;
 	int err = 0;
 
 	/* The McBSP signal muxing functions are only available on McBSP1 */
@@ -685,8 +630,20 @@ static int omap_mcbsp_dai_set_dai_sysclk(struct snd_soc_dai *cpu_dai,
 		regs->srgr2	|= CLKSM;
 		break;
 	case OMAP_MCBSP_SYSCLK_CLKS_FCLK:
+		if (cpu_class_is_omap1()) {
+			err = -EINVAL;
+			break;
+		}
+		err = omap2_mcbsp_set_clks_src(mcbsp_data->bus_id,
+					       MCBSP_CLKS_PRCM_SRC);
+		break;
 	case OMAP_MCBSP_SYSCLK_CLKS_EXT:
-		err = omap_mcbsp_dai_set_clks_src(mcbsp_data, clk_id);
+		if (cpu_class_is_omap1()) {
+			err = 0;
+			break;
+		}
+		err = omap2_mcbsp_set_clks_src(mcbsp_data->bus_id,
+					       MCBSP_CLKS_PAD_SRC);
 		break;
 
 	case OMAP_MCBSP_SYSCLK_CLKX_EXT:


