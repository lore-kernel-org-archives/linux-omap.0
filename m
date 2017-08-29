From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 4/6] ARM: OMAP2+: Drop omap_hwmod_irq_info
Date: Tue, 29 Aug 2017 10:29:59 -0700
Message-ID: <20170829173001.20358-5-tony@atomide.com>
References: <20170829173001.20358-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170829173001.20358-1-tony@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org
Cc: Nishanth Menon <nm@ti.com>, Paul Walmsley <paul@pwsan.com>, Lokesh Vutla <lokeshvutla@ti.com>, Tero Kristo <t-kristo@ti.com>, Marc Zyngier <marc.zyngier@arm.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

With the previous patches removing the need for legacy IRQs
now that all of mach-omap2 is booting in device tree only mode,
we can drop struct omap_hwmod_irq_info.

Note that we can now also finally drop omap4_xlate_irq.

Cc: Lokesh Vutla <lokeshvutla@ti.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Tero Kristo <t-kristo@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/common.h                       |   1 -
 arch/arm/mach-omap2/omap4-common.c                 |  24 -----
 arch/arm/mach-omap2/omap_hwmod.c                   | 100 +--------------------
 arch/arm/mach-omap2/omap_hwmod.h                   |  17 ----
 arch/arm/mach-omap2/omap_hwmod_2420_data.c         |   1 -
 arch/arm/mach-omap2/omap_hwmod_2430_data.c         |   1 -
 .../mach-omap2/omap_hwmod_2xxx_3xxx_ipblock_data.c |  15 ----
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c         |   2 -
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c         |  38 --------
 arch/arm/mach-omap2/omap_hwmod_54xx_data.c         |  10 ---
 arch/arm/mach-omap2/omap_hwmod_common_data.h       |  21 -----
 11 files changed, 4 insertions(+), 226 deletions(-)

diff --git a/arch/arm/mach-omap2/common.h b/arch/arm/mach-omap2/common.h
--- a/arch/arm/mach-omap2/common.h
+++ b/arch/arm/mach-omap2/common.h
@@ -225,7 +225,6 @@ extern struct device *omap2_get_iva_device(void);
 extern struct device *omap2_get_l3_device(void);
 extern struct device *omap4_get_dsp_device(void);
 
-unsigned int omap4_xlate_irq(unsigned int hwirq);
 void omap_gic_of_init(void);
 
 #ifdef CONFIG_CACHE_L2X0
diff --git a/arch/arm/mach-omap2/omap4-common.c b/arch/arm/mach-omap2/omap4-common.c
--- a/arch/arm/mach-omap2/omap4-common.c
+++ b/arch/arm/mach-omap2/omap4-common.c
@@ -299,30 +299,6 @@ static const struct of_device_id intc_match[] = {
 
 static struct device_node *intc_node;
 
-unsigned int omap4_xlate_irq(unsigned int hwirq)
-{
-	struct of_phandle_args irq_data;
-	unsigned int irq;
-
-	if (!intc_node)
-		intc_node = of_find_matching_node(NULL, intc_match);
-
-	if (WARN_ON(!intc_node))
-		return hwirq;
-
-	irq_data.np = intc_node;
-	irq_data.args_count = 3;
-	irq_data.args[0] = 0;
-	irq_data.args[1] = hwirq - OMAP44XX_IRQ_GIC_START;
-	irq_data.args[2] = IRQ_TYPE_LEVEL_HIGH;
-
-	irq = irq_create_of_mapping(&irq_data);
-	if (WARN_ON(!irq))
-		irq = hwirq;
-
-	return irq;
-}
-
 void __init omap_gic_of_init(void)
 {
 	struct device_node *np;
diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -1101,29 +1101,6 @@ static int _omap4_wait_target_disable(struct omap_hwmod *oh)
 					oh->prcm.omap4.clkctrl_offs, 0);
 }
 
-/**
- * _count_mpu_irqs - count the number of MPU IRQ lines associated with @oh
- * @oh: struct omap_hwmod *oh
- *
- * Count and return the number of MPU IRQs associated with the hwmod
- * @oh.  Used to allocate struct resource data.  Returns 0 if @oh is
- * NULL.
- */
-static int _count_mpu_irqs(struct omap_hwmod *oh)
-{
-	struct omap_hwmod_irq_info *ohii;
-	int i = 0;
-
-	if (!oh || !oh->mpu_irqs)
-		return 0;
-
-	do {
-		ohii = &oh->mpu_irqs[i++];
-	} while (ohii->irq != -1);
-
-	return i-1;
-}
-
 /**
  * _count_sdma_reqs - count the number of SDMA request lines associated with @oh
  * @oh: struct omap_hwmod *oh
@@ -1170,50 +1147,6 @@ static int _count_ocp_if_addr_spaces(struct omap_hwmod_ocp_if *os)
 	return i-1;
 }
 
-/**
- * _get_mpu_irq_by_name - fetch MPU interrupt line number by name
- * @oh: struct omap_hwmod * to operate on
- * @name: pointer to the name of the MPU interrupt number to fetch (optional)
- * @irq: pointer to an unsigned int to store the MPU IRQ number to
- *
- * Retrieve a MPU hardware IRQ line number named by @name associated
- * with the IP block pointed to by @oh.  The IRQ number will be filled
- * into the address pointed to by @dma.  When @name is non-null, the
- * IRQ line number associated with the named entry will be returned.
- * If @name is null, the first matching entry will be returned.  Data
- * order is not meaningful in hwmod data, so callers are strongly
- * encouraged to use a non-null @name whenever possible to avoid
- * unpredictable effects if hwmod data is later added that causes data
- * ordering to change.  Returns 0 upon success or a negative error
- * code upon error.
- */
-static int _get_mpu_irq_by_name(struct omap_hwmod *oh, const char *name,
-				unsigned int *irq)
-{
-	int i;
-	bool found = false;
-
-	if (!oh->mpu_irqs)
-		return -ENOENT;
-
-	i = 0;
-	while (oh->mpu_irqs[i].irq != -1) {
-		if (name == oh->mpu_irqs[i].name ||
-		    !strcmp(name, oh->mpu_irqs[i].name)) {
-			found = true;
-			break;
-		}
-		i++;
-	}
-
-	if (!found)
-		return -ENOENT;
-
-	*irq = oh->mpu_irqs[i].irq;
-
-	return 0;
-}
-
 /**
  * _get_sdma_req_by_name - fetch SDMA request line ID by name
  * @oh: struct omap_hwmod * to operate on
@@ -3376,9 +3309,6 @@ int omap_hwmod_count_resources(struct omap_hwmod *oh, unsigned long flags)
 {
 	int ret = 0;
 
-	if (flags & IORESOURCE_IRQ)
-		ret += _count_mpu_irqs(oh);
-
 	if (flags & IORESOURCE_DMA)
 		ret += _count_sdma_reqs(oh);
 
@@ -3405,25 +3335,10 @@ int omap_hwmod_count_resources(struct omap_hwmod *oh, unsigned long flags)
 int omap_hwmod_fill_resources(struct omap_hwmod *oh, struct resource *res)
 {
 	struct omap_hwmod_ocp_if *os;
-	int i, j, mpu_irqs_cnt, sdma_reqs_cnt, addr_cnt;
+	int i, j, sdma_reqs_cnt, addr_cnt;
 	int r = 0;
 
-	/* For each IRQ, DMA, memory area, fill in array.*/
-
-	mpu_irqs_cnt = _count_mpu_irqs(oh);
-	for (i = 0; i < mpu_irqs_cnt; i++) {
-		unsigned int irq;
-
-		if (oh->xlate_irq)
-			irq = oh->xlate_irq((oh->mpu_irqs + i)->irq);
-		else
-			irq = (oh->mpu_irqs + i)->irq;
-		(res + r)->name = (oh->mpu_irqs + i)->name;
-		(res + r)->start = irq;
-		(res + r)->end = irq;
-		(res + r)->flags = IORESOURCE_IRQ;
-		r++;
-	}
+	/* For each DMA, memory area, fill in array.*/
 
 	sdma_reqs_cnt = _count_sdma_reqs(oh);
 	for (i = 0; i < sdma_reqs_cnt; i++) {
@@ -3502,20 +3417,13 @@ int omap_hwmod_get_resource_byname(struct omap_hwmod *oh, unsigned int type,
 				   const char *name, struct resource *rsrc)
 {
 	int r;
-	unsigned int irq, dma;
+	unsigned int dma;
 	u32 pa_start, pa_end;
 
 	if (!oh || !rsrc)
 		return -EINVAL;
 
-	if (type == IORESOURCE_IRQ) {
-		r = _get_mpu_irq_by_name(oh, name, &irq);
-		if (r)
-			return r;
-
-		rsrc->start = irq;
-		rsrc->end = irq;
-	} else if (type == IORESOURCE_DMA) {
+	if (type == IORESOURCE_DMA) {
 		r = _get_sdma_req_by_name(oh, name, &dma);
 		if (r)
 			return r;
diff --git a/arch/arm/mach-omap2/omap_hwmod.h b/arch/arm/mach-omap2/omap_hwmod.h
--- a/arch/arm/mach-omap2/omap_hwmod.h
+++ b/arch/arm/mach-omap2/omap_hwmod.h
@@ -149,20 +149,6 @@ extern struct omap_hwmod_sysc_fields omap_hwmod_sysc_type3;
 #define DEBUG_AM33XXUART1_FLAGS DEBUG_OMAPUART_FLAGS
 #endif
 
-/**
- * struct omap_hwmod_irq_info - MPU IRQs used by the hwmod
- * @name: name of the IRQ channel (module local name)
- * @irq: IRQ channel ID (should be non-negative except -1 = terminator)
- *
- * @name should be something short, e.g., "tx" or "rx".  It is for use
- * by platform_get_resource_byname().  It is defined locally to the
- * hwmod.
- */
-struct omap_hwmod_irq_info {
-	const char	*name;
-	s16		irq;
-};
-
 /**
  * struct omap_hwmod_dma_info - DMA channels used by the hwmod
  * @name: name of the DMA channel (module local name)
@@ -612,7 +598,6 @@ struct omap_hwmod_class {
  * @name: name of the hwmod
  * @class: struct omap_hwmod_class * to the class of this hwmod
  * @od: struct omap_device currently associated with this hwmod (internal use)
- * @mpu_irqs: ptr to an array of MPU IRQs
  * @sdma_reqs: ptr to an array of System DMA request IDs
  * @prcm: PRCM data pertaining to this hwmod
  * @main_clk: main clock: OMAP clock name
@@ -656,7 +641,6 @@ struct omap_hwmod {
 	const char			*name;
 	struct omap_hwmod_class		*class;
 	struct omap_device		*od;
-	struct omap_hwmod_irq_info	*mpu_irqs;
 	struct omap_hwmod_dma_info	*sdma_reqs;
 	struct omap_hwmod_rst_info	*rst_lines;
 	union {
@@ -676,7 +660,6 @@ struct omap_hwmod {
 	struct lock_class_key		hwmod_key; /* unique lock class */
 	struct list_head		node;
 	struct omap_hwmod_ocp_if	*_mpu_port;
-	unsigned int			(*xlate_irq)(unsigned int);
 	u32				flags;
 	u8				mpu_rt_idx;
 	u8				response_lat;
diff --git a/arch/arm/mach-omap2/omap_hwmod_2420_data.c b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
--- a/arch/arm/mach-omap2/omap_hwmod_2420_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
@@ -155,7 +155,6 @@ static struct omap_dma_dev_attr dma_dev_attr = {
 static struct omap_hwmod omap2420_dma_system_hwmod = {
 	.name		= "dma",
 	.class		= &omap2xxx_dma_hwmod_class,
-	.mpu_irqs	= omap2_dma_system_irqs,
 	.main_clk	= "core_l3_ck",
 	.dev_attr	= &dma_dev_attr,
 	.flags		= HWMOD_NO_IDLEST,
diff --git a/arch/arm/mach-omap2/omap_hwmod_2430_data.c b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
--- a/arch/arm/mach-omap2/omap_hwmod_2430_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
@@ -153,7 +153,6 @@ static struct omap_dma_dev_attr dma_dev_attr = {
 static struct omap_hwmod omap2430_dma_system_hwmod = {
 	.name		= "dma",
 	.class		= &omap2xxx_dma_hwmod_class,
-	.mpu_irqs	= omap2_dma_system_irqs,
 	.main_clk	= "core_l3_ck",
 	.dev_attr	= &dma_dev_attr,
 	.flags		= HWMOD_NO_IDLEST,
diff --git a/arch/arm/mach-omap2/omap_hwmod_2xxx_3xxx_ipblock_data.c b/arch/arm/mach-omap2/omap_hwmod_2xxx_3xxx_ipblock_data.c
--- a/arch/arm/mach-omap2/omap_hwmod_2xxx_3xxx_ipblock_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2xxx_3xxx_ipblock_data.c
@@ -65,21 +65,6 @@ struct omap_hwmod_class iva_hwmod_class = {
 	.name = "iva",
 };
 
-/* Common MPU IRQ line data */
-
-struct omap_hwmod_irq_info omap2_dispc_irqs[] = {
-	{ .irq = 25 + OMAP_INTC_START, },
-	{ .irq = -1, },
-};
-
-struct omap_hwmod_irq_info omap2_dma_system_irqs[] = {
-	{ .name = "0", .irq = 12 + OMAP_INTC_START, }, /* INT_24XX_SDMA_IRQ0 */
-	{ .name = "1", .irq = 13 + OMAP_INTC_START, }, /* INT_24XX_SDMA_IRQ1 */
-	{ .name = "2", .irq = 14 + OMAP_INTC_START, }, /* INT_24XX_SDMA_IRQ2 */
-	{ .name = "3", .irq = 15 + OMAP_INTC_START, }, /* INT_24XX_SDMA_IRQ3 */
-	{ .irq = -1, },
-};
-
 struct omap_hwmod_class_sysconfig omap2_hdq1w_sysc = {
 	.rev_offs	= 0x0,
 	.sysc_offs	= 0x14,
diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -647,7 +647,6 @@ static struct omap_hwmod_class omap3_dispc_hwmod_class = {
 static struct omap_hwmod omap3xxx_dss_dispc_hwmod = {
 	.name		= "dss_dispc",
 	.class		= &omap3_dispc_hwmod_class,
-	.mpu_irqs	= omap2_dispc_irqs,
 	.main_clk	= "dss1_alwon_fck",
 	.prcm		= {
 		.omap2 = {
@@ -1017,7 +1016,6 @@ static struct omap_hwmod_class omap3xxx_dma_hwmod_class = {
 static struct omap_hwmod omap3xxx_dma_system_hwmod = {
 	.name		= "dma",
 	.class		= &omap3xxx_dma_hwmod_class,
-	.mpu_irqs	= omap2_dma_system_irqs,
 	.main_clk	= "core_l3_ick",
 	.prcm = {
 		.omap2 = {
diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -465,20 +465,10 @@ static struct omap_dma_dev_attr dma_dev_attr = {
 };
 
 /* dma_system */
-static struct omap_hwmod_irq_info omap44xx_dma_system_irqs[] = {
-	{ .name = "0", .irq = 12 + OMAP44XX_IRQ_GIC_START },
-	{ .name = "1", .irq = 13 + OMAP44XX_IRQ_GIC_START },
-	{ .name = "2", .irq = 14 + OMAP44XX_IRQ_GIC_START },
-	{ .name = "3", .irq = 15 + OMAP44XX_IRQ_GIC_START },
-	{ .irq = -1 }
-};
-
 static struct omap_hwmod omap44xx_dma_system_hwmod = {
 	.name		= "dma_system",
 	.class		= &omap44xx_dma_hwmod_class,
 	.clkdm_name	= "l3_dma_clkdm",
-	.mpu_irqs	= omap44xx_dma_system_irqs,
-	.xlate_irq	= omap4_xlate_irq,
 	.main_clk	= "l3_div_ck",
 	.prcm = {
 		.omap4 = {
@@ -620,11 +610,6 @@ static struct omap_hwmod_class omap44xx_dispc_hwmod_class = {
 };
 
 /* dss_dispc */
-static struct omap_hwmod_irq_info omap44xx_dss_dispc_irqs[] = {
-	{ .irq = 25 + OMAP44XX_IRQ_GIC_START },
-	{ .irq = -1 }
-};
-
 static struct omap_hwmod_dma_info omap44xx_dss_dispc_sdma_reqs[] = {
 	{ .dma_req = 5 + OMAP44XX_DMA_REQ_START },
 	{ .dma_req = -1 }
@@ -639,8 +624,6 @@ static struct omap_hwmod omap44xx_dss_dispc_hwmod = {
 	.name		= "dss_dispc",
 	.class		= &omap44xx_dispc_hwmod_class,
 	.clkdm_name	= "l3_dss_clkdm",
-	.mpu_irqs	= omap44xx_dss_dispc_irqs,
-	.xlate_irq	= omap4_xlate_irq,
 	.sdma_reqs	= omap44xx_dss_dispc_sdma_reqs,
 	.main_clk	= "dss_dss_clk",
 	.prcm = {
@@ -675,11 +658,6 @@ static struct omap_hwmod_class omap44xx_dsi_hwmod_class = {
 };
 
 /* dss_dsi1 */
-static struct omap_hwmod_irq_info omap44xx_dss_dsi1_irqs[] = {
-	{ .irq = 53 + OMAP44XX_IRQ_GIC_START },
-	{ .irq = -1 }
-};
-
 static struct omap_hwmod_dma_info omap44xx_dss_dsi1_sdma_reqs[] = {
 	{ .dma_req = 74 + OMAP44XX_DMA_REQ_START },
 	{ .dma_req = -1 }
@@ -693,8 +671,6 @@ static struct omap_hwmod omap44xx_dss_dsi1_hwmod = {
 	.name		= "dss_dsi1",
 	.class		= &omap44xx_dsi_hwmod_class,
 	.clkdm_name	= "l3_dss_clkdm",
-	.mpu_irqs	= omap44xx_dss_dsi1_irqs,
-	.xlate_irq	= omap4_xlate_irq,
 	.sdma_reqs	= omap44xx_dss_dsi1_sdma_reqs,
 	.main_clk	= "dss_dss_clk",
 	.prcm = {
@@ -709,11 +685,6 @@ static struct omap_hwmod omap44xx_dss_dsi1_hwmod = {
 };
 
 /* dss_dsi2 */
-static struct omap_hwmod_irq_info omap44xx_dss_dsi2_irqs[] = {
-	{ .irq = 84 + OMAP44XX_IRQ_GIC_START },
-	{ .irq = -1 }
-};
-
 static struct omap_hwmod_dma_info omap44xx_dss_dsi2_sdma_reqs[] = {
 	{ .dma_req = 83 + OMAP44XX_DMA_REQ_START },
 	{ .dma_req = -1 }
@@ -727,8 +698,6 @@ static struct omap_hwmod omap44xx_dss_dsi2_hwmod = {
 	.name		= "dss_dsi2",
 	.class		= &omap44xx_dsi_hwmod_class,
 	.clkdm_name	= "l3_dss_clkdm",
-	.mpu_irqs	= omap44xx_dss_dsi2_irqs,
-	.xlate_irq	= omap4_xlate_irq,
 	.sdma_reqs	= omap44xx_dss_dsi2_sdma_reqs,
 	.main_clk	= "dss_dss_clk",
 	.prcm = {
@@ -763,11 +732,6 @@ static struct omap_hwmod_class omap44xx_hdmi_hwmod_class = {
 };
 
 /* dss_hdmi */
-static struct omap_hwmod_irq_info omap44xx_dss_hdmi_irqs[] = {
-	{ .irq = 101 + OMAP44XX_IRQ_GIC_START },
-	{ .irq = -1 }
-};
-
 static struct omap_hwmod_dma_info omap44xx_dss_hdmi_sdma_reqs[] = {
 	{ .dma_req = 75 + OMAP44XX_DMA_REQ_START },
 	{ .dma_req = -1 }
@@ -787,8 +751,6 @@ static struct omap_hwmod omap44xx_dss_hdmi_hwmod = {
 	 * set idle mode by software.
 	 */
 	.flags		= HWMOD_SWSUP_SIDLE | HWMOD_OPT_CLKS_NEEDED,
-	.mpu_irqs	= omap44xx_dss_hdmi_irqs,
-	.xlate_irq	= omap4_xlate_irq,
 	.sdma_reqs	= omap44xx_dss_hdmi_sdma_reqs,
 	.main_clk	= "dss_48mhz_clk",
 	.prcm = {
diff --git a/arch/arm/mach-omap2/omap_hwmod_54xx_data.c b/arch/arm/mach-omap2/omap_hwmod_54xx_data.c
--- a/arch/arm/mach-omap2/omap_hwmod_54xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_54xx_data.c
@@ -275,20 +275,10 @@ static struct omap_dma_dev_attr dma_dev_attr = {
 };
 
 /* dma_system */
-static struct omap_hwmod_irq_info omap54xx_dma_system_irqs[] = {
-	{ .name = "0", .irq = 12 + OMAP54XX_IRQ_GIC_START },
-	{ .name = "1", .irq = 13 + OMAP54XX_IRQ_GIC_START },
-	{ .name = "2", .irq = 14 + OMAP54XX_IRQ_GIC_START },
-	{ .name = "3", .irq = 15 + OMAP54XX_IRQ_GIC_START },
-	{ .irq = -1 }
-};
-
 static struct omap_hwmod omap54xx_dma_system_hwmod = {
 	.name		= "dma_system",
 	.class		= &omap54xx_dma_hwmod_class,
 	.clkdm_name	= "dma_clkdm",
-	.mpu_irqs	= omap54xx_dma_system_irqs,
-	.xlate_irq	= omap4_xlate_irq,
 	.main_clk	= "l3_iclk_div",
 	.prcm = {
 		.omap4 = {
diff --git a/arch/arm/mach-omap2/omap_hwmod_common_data.h b/arch/arm/mach-omap2/omap_hwmod_common_data.h
--- a/arch/arm/mach-omap2/omap_hwmod_common_data.h
+++ b/arch/arm/mach-omap2/omap_hwmod_common_data.h
@@ -104,28 +104,7 @@ extern struct omap_hwmod_dma_info omap2_mcbsp2_sdma_reqs[];
 extern struct omap_hwmod_dma_info omap2_mcbsp3_sdma_reqs[];
 
 /* Common IP block data across OMAP2/3 */
-extern struct omap_hwmod_irq_info omap2_timer1_mpu_irqs[];
-extern struct omap_hwmod_irq_info omap2_timer2_mpu_irqs[];
-extern struct omap_hwmod_irq_info omap2_timer3_mpu_irqs[];
-extern struct omap_hwmod_irq_info omap2_timer4_mpu_irqs[];
-extern struct omap_hwmod_irq_info omap2_timer5_mpu_irqs[];
-extern struct omap_hwmod_irq_info omap2_timer6_mpu_irqs[];
-extern struct omap_hwmod_irq_info omap2_timer7_mpu_irqs[];
-extern struct omap_hwmod_irq_info omap2_timer8_mpu_irqs[];
-extern struct omap_hwmod_irq_info omap2_timer9_mpu_irqs[];
-extern struct omap_hwmod_irq_info omap2_timer10_mpu_irqs[];
-extern struct omap_hwmod_irq_info omap2_timer11_mpu_irqs[];
-extern struct omap_hwmod_irq_info omap2_uart1_mpu_irqs[];
-extern struct omap_hwmod_irq_info omap2_uart2_mpu_irqs[];
-extern struct omap_hwmod_irq_info omap2_uart3_mpu_irqs[];
-extern struct omap_hwmod_irq_info omap2_dispc_irqs[];
-extern struct omap_hwmod_irq_info omap2_i2c1_mpu_irqs[];
-extern struct omap_hwmod_irq_info omap2_i2c2_mpu_irqs[];
-extern struct omap_hwmod_irq_info omap2_dma_system_irqs[];
-extern struct omap_hwmod_irq_info omap2_mcspi1_mpu_irqs[];
-extern struct omap_hwmod_irq_info omap2_mcspi2_mpu_irqs[];
 extern struct omap_hwmod_addr_space omap2xxx_timer12_addrs[];
-extern struct omap_hwmod_irq_info omap2_hdq1w_mpu_irqs[];
 
 /* OMAP hwmod classes - forward declarations */
 extern struct omap_hwmod_class l3_hwmod_class;
-- 
2.14.1
