From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 06/10] OMAP: McBSP: implement McBSP CLKR and FSR signal muxing
	via mach-omap2/mcbsp.c
Date: Fri, 01 Oct 2010 15:35:31 -0600
Message-ID: <20101001213502.1408.88866.stgit@twilight.localdomain>
References: <20101001213119.1408.65395.stgit@twilight.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:49835 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756072Ab0JAVlZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Oct 2010 17:41:25 -0400
In-Reply-To: <20101001213119.1408.65395.stgit@twilight.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Jarkko Nikula <jhnikula@gmail.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>

The OMAP ASoC McBSP code implemented CLKR and FSR signal muxing via
direct System Control Module writes on OMAP2+.  This required the
omap_ctrl_{read,write}l() functions to be exported, which is against
policy: the only code that should call those functions directly is
OMAP core code, not device drivers.  omap_ctrl_{read,write}*() are no
longer exported, so the driver no longer builds as a module.

Fix the pinmuxing part of the problem by removing calls to
omap_ctrl_{read,write}l() from the OMAP ASoC McBSP code and
implementing signal muxing functions in arch/arm/mach-omap2/mcbsp.c.
Due to the unfortunate way that McBSP support is implemented in ASoC
and the OMAP tree, these symbols must be exported for use by
sound/soc/omap/omap-mcbsp.c.

Going forward, the McBSP device driver should be moved from
arch/arm/*omap* into drivers/ or sound/soc/*, and the CPU DAI driver
should be implemented as a platform_driver as many other ASoC CPU DAI
drivers are.  These two steps should resolve many of the layering
problems, which will rapidly reappear during a McBSP hwmod/PM runtime
conversion.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Jarkko Nikula <jhnikula@gmail.com>
Cc: Peter Ujfalusi <peter.ujfalusi@nokia.com>
---
 arch/arm/mach-omap2/mcbsp.c               |   30 +++++++++++++++++
 arch/arm/plat-omap/include/plat/control.h |    2 +
 arch/arm/plat-omap/include/plat/mcbsp.h   |   13 +++++++
 arch/arm/plat-omap/mcbsp.c                |    1 +
 sound/soc/omap/omap-mcbsp.c               |   52 +++++++++--------------------
 5 files changed, 62 insertions(+), 36 deletions(-)

diff --git a/arch/arm/mach-omap2/mcbsp.c b/arch/arm/mach-omap2/mcbsp.c
index 88b8790..4c9c999 100644
--- a/arch/arm/mach-omap2/mcbsp.c
+++ b/arch/arm/mach-omap2/mcbsp.c
@@ -22,7 +22,37 @@
 #include <plat/dma.h>
 #include <plat/cpu.h>
 #include <plat/mcbsp.h>
+#include <plat/control.h>
 
+/* McBSP internal signal muxing functions */
+
+void omap2_mcbsp1_mux_clkr_src(u8 mux)
+{
+	u32 v;
+
+	v = omap_ctrl_readl(OMAP2_CONTROL_DEVCONF0);
+	if (mux == CLKR_SRC_CLKR)
+		v &= OMAP2_MCBSP1_CLKR_MASK;
+	else if (mux == CLKR_SRC_CLKX)
+		v |= OMAP2_MCBSP1_CLKR_MASK;
+	omap_ctrl_writel(v, OMAP2_CONTROL_DEVCONF0);
+}
+EXPORT_SYMBOL(omap2_mcbsp1_mux_clkr_src);
+
+void omap2_mcbsp1_mux_fsr_src(u8 mux)
+{
+	u32 v;
+
+	v = omap_ctrl_readl(OMAP2_CONTROL_DEVCONF0);
+	if (mux == FSR_SRC_FSR)
+		v &= OMAP2_MCBSP1_FSR_MASK;
+	else if (mux == FSR_SRC_FSX)
+		v |= OMAP2_MCBSP1_FSR_MASK;
+	omap_ctrl_writel(v, OMAP2_CONTROL_DEVCONF0);
+}
+EXPORT_SYMBOL(omap2_mcbsp1_mux_fsr_src);
+
+/* Platform data */
 
 #ifdef CONFIG_ARCH_OMAP2420
 static struct omap_mcbsp_platform_data omap2420_mcbsp_pdata[] = {
diff --git a/arch/arm/plat-omap/include/plat/control.h b/arch/arm/plat-omap/include/plat/control.h
index 19c9b2a..54b0c35 100644
--- a/arch/arm/plat-omap/include/plat/control.h
+++ b/arch/arm/plat-omap/include/plat/control.h
@@ -223,6 +223,8 @@
 #define OMAP2_MMCSDIO1ADPCLKISEL	(1 << 24) /* MMC1 loop back clock */
 #define OMAP24XX_USBSTANDBYCTRL		(1 << 15)
 #define OMAP2_MCBSP2_CLKS_MASK		(1 << 6)
+#define OMAP2_MCBSP1_FSR_MASK		(1 << 4)
+#define OMAP2_MCBSP1_CLKR_MASK		(1 << 3)
 #define OMAP2_MCBSP1_CLKS_MASK		(1 << 2)
 
 /* CONTROL_DEVCONF1 bits */
diff --git a/arch/arm/plat-omap/include/plat/mcbsp.h b/arch/arm/plat-omap/include/plat/mcbsp.h
index b4ff6a1..886d0e6 100644
--- a/arch/arm/plat-omap/include/plat/mcbsp.h
+++ b/arch/arm/plat-omap/include/plat/mcbsp.h
@@ -312,6 +312,14 @@
 #define RFSREN			0x0002
 #define RSYNCERREN		0x0001
 
+/* CLKR signal muxing options */
+#define CLKR_SRC_CLKR		0
+#define CLKR_SRC_CLKX		1
+
+/* FSR signal muxing options */
+#define FSR_SRC_FSR		0
+#define FSR_SRC_FSX		1
+
 /* we don't do multichannel for now */
 struct omap_mcbsp_reg_cfg {
 	u16 spcr2;
@@ -501,7 +509,6 @@ int omap_mcbsp_recv_buffer(unsigned int id, dma_addr_t buffer, unsigned int leng
 int omap_mcbsp_spi_master_xmit_word_poll(unsigned int id, u32 word);
 int omap_mcbsp_spi_master_recv_word_poll(unsigned int id, u32 * word);
 
-
 /* SPI specific API */
 void omap_mcbsp_set_spi_mode(unsigned int id, const struct omap_mcbsp_spi_cfg * spi_cfg);
 
@@ -510,6 +517,10 @@ int omap_mcbsp_pollread(unsigned int id, u16 * buf);
 int omap_mcbsp_pollwrite(unsigned int id, u16 buf);
 int omap_mcbsp_set_io_type(unsigned int id, omap_mcbsp_io_type_t io_type);
 
+/* McBSP signal muxing API */
+void omap2_mcbsp1_mux_clkr_src(u8 mux);
+void omap2_mcbsp1_mux_fsr_src(u8 mux);
+
 #ifdef CONFIG_ARCH_OMAP3
 /* Sidetone specific API */
 int omap_st_set_chgain(unsigned int id, int channel, s16 chgain);
diff --git a/arch/arm/plat-omap/mcbsp.c b/arch/arm/plat-omap/mcbsp.c
index dcb0926..89d7671 100644
--- a/arch/arm/plat-omap/mcbsp.c
+++ b/arch/arm/plat-omap/mcbsp.c
@@ -27,6 +27,7 @@
 
 #include <plat/dma.h>
 #include <plat/mcbsp.h>
+#include <plat/control.h>
 
 #include "../mach-omap2/cm-regbits-34xx.h"
 
diff --git a/sound/soc/omap/omap-mcbsp.c b/sound/soc/omap/omap-mcbsp.c
index 86f2139..f50a5ab 100644
--- a/sound/soc/omap/omap-mcbsp.c
+++ b/sound/soc/omap/omap-mcbsp.c
@@ -661,48 +661,23 @@ static int omap_mcbsp_dai_set_clks_src(struct omap_mcbsp_data *mcbsp_data,
 	return 0;
 }
 
-static int omap_mcbsp_dai_set_rcvr_src(struct omap_mcbsp_data *mcbsp_data,
-				       int clk_id)
-{
-	int sel_bit, set = 0;
-	u16 reg = OMAP2_CONTROL_DEVCONF0;
-
-	if (cpu_class_is_omap1())
-		return -EINVAL; /* TODO: Can this be implemented for OMAP1? */
-	if (mcbsp_data->bus_id != 0)
-		return -EINVAL;
-
-	switch (clk_id) {
-	case OMAP_MCBSP_CLKR_SRC_CLKX:
-		set = 1;
-	case OMAP_MCBSP_CLKR_SRC_CLKR:
-		sel_bit = 3;
-		break;
-	case OMAP_MCBSP_FSR_SRC_FSX:
-		set = 1;
-	case OMAP_MCBSP_FSR_SRC_FSR:
-		sel_bit = 4;
-		break;
-	default:
-		return -EINVAL;
-	}
-
-	if (set)
-		omap_ctrl_writel(omap_ctrl_readl(reg) | (1 << sel_bit), reg);
-	else
-		omap_ctrl_writel(omap_ctrl_readl(reg) & ~(1 << sel_bit), reg);
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
+	struct omap_mcbsp_platform_data *pdata = cpu_dai->dev->platform_data;
 	int err = 0;
 
+	/* The McBSP signal muxing functions are only available on McBSP1 */
+	if (clk_id == OMAP_MCBSP_CLKR_SRC_CLKR ||
+	    clk_id == OMAP_MCBSP_CLKR_SRC_CLKX ||
+	    clk_id == OMAP_MCBSP_FSR_SRC_FSR ||
+	    clk_id == OMAP_MCBSP_FSR_SRC_FSX)
+		if (cpu_class_is_omap1() || mcbsp_data->bus_id != 0)
+			return -EINVAL;
+
 	mcbsp_data->in_freq = freq;
 
 	switch (clk_id) {
@@ -720,11 +695,18 @@ static int omap_mcbsp_dai_set_dai_sysclk(struct snd_soc_dai *cpu_dai,
 		regs->pcr0	|= SCLKME;
 		break;
 
+
 	case OMAP_MCBSP_CLKR_SRC_CLKR:
+		omap2_mcbsp1_mux_clkr_src(CLKR_SRC_CLKR);
+		break;
 	case OMAP_MCBSP_CLKR_SRC_CLKX:
+		omap2_mcbsp1_mux_clkr_src(CLKR_SRC_CLKX);
+		break;
 	case OMAP_MCBSP_FSR_SRC_FSR:
+		omap2_mcbsp1_mux_fsr_src(FSR_SRC_FSR);
+		break;
 	case OMAP_MCBSP_FSR_SRC_FSX:
-		err = omap_mcbsp_dai_set_rcvr_src(mcbsp_data, clk_id);
+		omap2_mcbsp1_mux_fsr_src(FSR_SRC_FSX);
 		break;
 	default:
 		err = -ENODEV;


