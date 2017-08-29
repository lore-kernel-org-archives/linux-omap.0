From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 5/6] ARM: OMAP2+: Drop omap_hwmod_dma_info
Date: Tue, 29 Aug 2017 10:30:00 -0700
Message-ID: <20170829173001.20358-6-tony@atomide.com>
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

We have all of mach-omap2 booting in device tree only
mode now, and this data is populated from device tree.

Note that once we have removed support for the omap legacy
DMA, we can also drop struct omap_dma_dev_attr.

Cc: Lokesh Vutla <lokeshvutla@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Tero Kristo <t-kristo@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/omap_device.c                  | 155 +--------------------
 arch/arm/mach-omap2/omap_hwmod.c                   | 119 +---------------
 arch/arm/mach-omap2/omap_hwmod.h                   |  17 ---
 arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c |   6 -
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c         |   8 --
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c         | 108 --------------
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c          |   6 -
 arch/arm/mach-omap2/omap_hwmod_common_data.h       |  14 --
 8 files changed, 4 insertions(+), 429 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_device.c b/arch/arm/mach-omap2/omap_device.c
--- a/arch/arm/mach-omap2/omap_device.c
+++ b/arch/arm/mach-omap2/omap_device.c
@@ -310,88 +310,6 @@ int omap_device_get_context_loss_count(struct platform_device *pdev)
 	return ret;
 }
 
-/**
- * omap_device_count_resources - count number of struct resource entries needed
- * @od: struct omap_device *
- * @flags: Type of resources to include when counting (IRQ/DMA/MEM)
- *
- * Count the number of struct resource entries needed for this
- * omap_device @od.  Used by omap_device_build_ss() to determine how
- * much memory to allocate before calling
- * omap_device_fill_resources().  Returns the count.
- */
-static int omap_device_count_resources(struct omap_device *od,
-				       unsigned long flags)
-{
-	int c = 0;
-	int i;
-
-	for (i = 0; i < od->hwmods_cnt; i++)
-		c += omap_hwmod_count_resources(od->hwmods[i], flags);
-
-	pr_debug("omap_device: %s: counted %d total resources across %d hwmods\n",
-		 od->pdev->name, c, od->hwmods_cnt);
-
-	return c;
-}
-
-/**
- * omap_device_fill_resources - fill in array of struct resource
- * @od: struct omap_device *
- * @res: pointer to an array of struct resource to be filled in
- *
- * Populate one or more empty struct resource pointed to by @res with
- * the resource data for this omap_device @od.  Used by
- * omap_device_build_ss() after calling omap_device_count_resources().
- * Ideally this function would not be needed at all.  If omap_device
- * replaces platform_device, then we can specify our own
- * get_resource()/ get_irq()/etc functions that use the underlying
- * omap_hwmod information.  Or if platform_device is extended to use
- * subarchitecture-specific function pointers, the various
- * platform_device functions can simply call omap_device internal
- * functions to get device resources.  Hacking around the existing
- * platform_device code wastes memory.  Returns 0.
- */
-static int omap_device_fill_resources(struct omap_device *od,
-				      struct resource *res)
-{
-	int i, r;
-
-	for (i = 0; i < od->hwmods_cnt; i++) {
-		r = omap_hwmod_fill_resources(od->hwmods[i], res);
-		res += r;
-	}
-
-	return 0;
-}
-
-/**
- * _od_fill_dma_resources - fill in array of struct resource with dma resources
- * @od: struct omap_device *
- * @res: pointer to an array of struct resource to be filled in
- *
- * Populate one or more empty struct resource pointed to by @res with
- * the dma resource data for this omap_device @od.  Used by
- * omap_device_alloc() after calling omap_device_count_resources().
- *
- * Ideally this function would not be needed at all.  If we have
- * mechanism to get dma resources from DT.
- *
- * Returns 0.
- */
-static int _od_fill_dma_resources(struct omap_device *od,
-				      struct resource *res)
-{
-	int i, r;
-
-	for (i = 0; i < od->hwmods_cnt; i++) {
-		r = omap_hwmod_fill_dma_resources(od->hwmods[i], res);
-		res += r;
-	}
-
-	return 0;
-}
-
 /**
  * omap_device_alloc - allocate an omap_device
  * @pdev: platform_device that will be included in this omap_device
@@ -409,8 +327,7 @@ struct omap_device *omap_device_alloc(struct platform_device *pdev,
 {
 	int ret = -ENOMEM;
 	struct omap_device *od;
-	struct resource *res = NULL;
-	int i, res_count;
+	int i;
 	struct omap_hwmod **hwmods;
 
 	od = kzalloc(sizeof(struct omap_device), GFP_KERNEL);
@@ -426,74 +343,6 @@ struct omap_device *omap_device_alloc(struct platform_device *pdev,
 
 	od->hwmods = hwmods;
 	od->pdev = pdev;
-
-	/*
-	 * Non-DT Boot:
-	 *   Here, pdev->num_resources = 0, and we should get all the
-	 *   resources from hwmod.
-	 *
-	 * DT Boot:
-	 *   OF framework will construct the resource structure (currently
-	 *   does for MEM & IRQ resource) and we should respect/use these
-	 *   resources, killing hwmod dependency.
-	 *   If pdev->num_resources > 0, we assume that MEM & IRQ resources
-	 *   have been allocated by OF layer already (through DTB).
-	 *   As preparation for the future we examine the OF provided resources
-	 *   to see if we have DMA resources provided already. In this case
-	 *   there is no need to update the resources for the device, we use the
-	 *   OF provided ones.
-	 *
-	 * TODO: Once DMA resource is available from OF layer, we should
-	 *   kill filling any resources from hwmod.
-	 */
-	if (!pdev->num_resources) {
-		/* Count all resources for the device */
-		res_count = omap_device_count_resources(od, IORESOURCE_IRQ |
-							    IORESOURCE_DMA |
-							    IORESOURCE_MEM);
-	} else {
-		/* Take a look if we already have DMA resource via DT */
-		for (i = 0; i < pdev->num_resources; i++) {
-			struct resource *r = &pdev->resource[i];
-
-			/* We have it, no need to touch the resources */
-			if (r->flags == IORESOURCE_DMA)
-				goto have_everything;
-		}
-		/* Count only DMA resources for the device */
-		res_count = omap_device_count_resources(od, IORESOURCE_DMA);
-		/* The device has no DMA resource, no need for update */
-		if (!res_count)
-			goto have_everything;
-
-		res_count += pdev->num_resources;
-	}
-
-	/* Allocate resources memory to account for new resources */
-	res = kzalloc(sizeof(struct resource) * res_count, GFP_KERNEL);
-	if (!res)
-		goto oda_exit3;
-
-	if (!pdev->num_resources) {
-		dev_dbg(&pdev->dev, "%s: using %d resources from hwmod\n",
-			__func__, res_count);
-		omap_device_fill_resources(od, res);
-	} else {
-		dev_dbg(&pdev->dev,
-			"%s: appending %d DMA resources from hwmod\n",
-			__func__, res_count - pdev->num_resources);
-		memcpy(res, pdev->resource,
-		       sizeof(struct resource) * pdev->num_resources);
-		_od_fill_dma_resources(od, &res[pdev->num_resources]);
-	}
-
-	ret = platform_device_add_resources(pdev, res, res_count);
-	kfree(res);
-
-	if (ret)
-		goto oda_exit3;
-
-have_everything:
 	pdev->archdata.od = od;
 
 	for (i = 0; i < oh_cnt; i++) {
@@ -503,8 +352,6 @@ struct omap_device *omap_device_alloc(struct platform_device *pdev,
 
 	return od;
 
-oda_exit3:
-	kfree(hwmods);
 oda_exit2:
 	kfree(od);
 oda_exit1:
diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -1101,29 +1101,6 @@ static int _omap4_wait_target_disable(struct omap_hwmod *oh)
 					oh->prcm.omap4.clkctrl_offs, 0);
 }
 
-/**
- * _count_sdma_reqs - count the number of SDMA request lines associated with @oh
- * @oh: struct omap_hwmod *oh
- *
- * Count and return the number of SDMA request lines associated with
- * the hwmod @oh.  Used to allocate struct resource data.  Returns 0
- * if @oh is NULL.
- */
-static int _count_sdma_reqs(struct omap_hwmod *oh)
-{
-	struct omap_hwmod_dma_info *ohdi;
-	int i = 0;
-
-	if (!oh || !oh->sdma_reqs)
-		return 0;
-
-	do {
-		ohdi = &oh->sdma_reqs[i++];
-	} while (ohdi->dma_req != -1);
-
-	return i-1;
-}
-
 /**
  * _count_ocp_if_addr_spaces - count the number of address space entries for @oh
  * @oh: struct omap_hwmod *oh
@@ -1147,49 +1124,6 @@ static int _count_ocp_if_addr_spaces(struct omap_hwmod_ocp_if *os)
 	return i-1;
 }
 
-/**
- * _get_sdma_req_by_name - fetch SDMA request line ID by name
- * @oh: struct omap_hwmod * to operate on
- * @name: pointer to the name of the SDMA request line to fetch (optional)
- * @dma: pointer to an unsigned int to store the request line ID to
- *
- * Retrieve an SDMA request line ID named by @name on the IP block
- * pointed to by @oh.  The ID will be filled into the address pointed
- * to by @dma.  When @name is non-null, the request line ID associated
- * with the named entry will be returned.  If @name is null, the first
- * matching entry will be returned.  Data order is not meaningful in
- * hwmod data, so callers are strongly encouraged to use a non-null
- * @name whenever possible to avoid unpredictable effects if hwmod
- * data is later added that causes data ordering to change.  Returns 0
- * upon success or a negative error code upon error.
- */
-static int _get_sdma_req_by_name(struct omap_hwmod *oh, const char *name,
-				 unsigned int *dma)
-{
-	int i;
-	bool found = false;
-
-	if (!oh->sdma_reqs)
-		return -ENOENT;
-
-	i = 0;
-	while (oh->sdma_reqs[i].dma_req != -1) {
-		if (name == oh->sdma_reqs[i].name ||
-		    !strcmp(name, oh->sdma_reqs[i].name)) {
-			found = true;
-			break;
-		}
-		i++;
-	}
-
-	if (!found)
-		return -ENOENT;
-
-	*dma = oh->sdma_reqs[i].dma_req;
-
-	return 0;
-}
-
 /**
  * _get_addr_space_by_name - fetch address space start & end by name
  * @oh: struct omap_hwmod * to operate on
@@ -3309,9 +3243,6 @@ int omap_hwmod_count_resources(struct omap_hwmod *oh, unsigned long flags)
 {
 	int ret = 0;
 
-	if (flags & IORESOURCE_DMA)
-		ret += _count_sdma_reqs(oh);
-
 	if (flags & IORESOURCE_MEM) {
 		struct omap_hwmod_ocp_if *os;
 
@@ -3335,19 +3266,10 @@ int omap_hwmod_count_resources(struct omap_hwmod *oh, unsigned long flags)
 int omap_hwmod_fill_resources(struct omap_hwmod *oh, struct resource *res)
 {
 	struct omap_hwmod_ocp_if *os;
-	int i, j, sdma_reqs_cnt, addr_cnt;
+	int j, addr_cnt;
 	int r = 0;
 
-	/* For each DMA, memory area, fill in array.*/
-
-	sdma_reqs_cnt = _count_sdma_reqs(oh);
-	for (i = 0; i < sdma_reqs_cnt; i++) {
-		(res + r)->name = (oh->sdma_reqs + i)->name;
-		(res + r)->start = (oh->sdma_reqs + i)->dma_req;
-		(res + r)->end = (oh->sdma_reqs + i)->dma_req;
-		(res + r)->flags = IORESOURCE_DMA;
-		r++;
-	}
+	/* For each memory area, fill in array.*/
 
 	list_for_each_entry(os, &oh->slave_ports, node) {
 		addr_cnt = _count_ocp_if_addr_spaces(os);
@@ -3364,33 +3286,6 @@ int omap_hwmod_fill_resources(struct omap_hwmod *oh, struct resource *res)
 	return r;
 }
 
-/**
- * omap_hwmod_fill_dma_resources - fill struct resource array with dma data
- * @oh: struct omap_hwmod *
- * @res: pointer to the array of struct resource to fill
- *
- * Fill the struct resource array @res with dma resource data from the
- * omap_hwmod @oh.  Intended to be called by code that registers
- * omap_devices.  See also omap_hwmod_count_resources().  Returns the
- * number of array elements filled.
- */
-int omap_hwmod_fill_dma_resources(struct omap_hwmod *oh, struct resource *res)
-{
-	int i, sdma_reqs_cnt;
-	int r = 0;
-
-	sdma_reqs_cnt = _count_sdma_reqs(oh);
-	for (i = 0; i < sdma_reqs_cnt; i++) {
-		(res + r)->name = (oh->sdma_reqs + i)->name;
-		(res + r)->start = (oh->sdma_reqs + i)->dma_req;
-		(res + r)->end = (oh->sdma_reqs + i)->dma_req;
-		(res + r)->flags = IORESOURCE_DMA;
-		r++;
-	}
-
-	return r;
-}
-
 /**
  * omap_hwmod_get_resource_byname - fetch IP block integration data by name
  * @oh: struct omap_hwmod * to operate on
@@ -3417,20 +3312,12 @@ int omap_hwmod_get_resource_byname(struct omap_hwmod *oh, unsigned int type,
 				   const char *name, struct resource *rsrc)
 {
 	int r;
-	unsigned int dma;
 	u32 pa_start, pa_end;
 
 	if (!oh || !rsrc)
 		return -EINVAL;
 
-	if (type == IORESOURCE_DMA) {
-		r = _get_sdma_req_by_name(oh, name, &dma);
-		if (r)
-			return r;
-
-		rsrc->start = dma;
-		rsrc->end = dma;
-	} else if (type == IORESOURCE_MEM) {
+	if (type == IORESOURCE_MEM) {
 		r = _get_addr_space_by_name(oh, name, &pa_start, &pa_end);
 		if (r)
 			return r;
diff --git a/arch/arm/mach-omap2/omap_hwmod.h b/arch/arm/mach-omap2/omap_hwmod.h
--- a/arch/arm/mach-omap2/omap_hwmod.h
+++ b/arch/arm/mach-omap2/omap_hwmod.h
@@ -149,20 +149,6 @@ extern struct omap_hwmod_sysc_fields omap_hwmod_sysc_type3;
 #define DEBUG_AM33XXUART1_FLAGS DEBUG_OMAPUART_FLAGS
 #endif
 
-/**
- * struct omap_hwmod_dma_info - DMA channels used by the hwmod
- * @name: name of the DMA channel (module local name)
- * @dma_req: DMA request ID (should be non-negative except -1 = terminator)
- *
- * @name should be something short, e.g., "tx" or "rx".  It is for use
- * by platform_get_resource_byname().  It is defined locally to the
- * hwmod.
- */
-struct omap_hwmod_dma_info {
-	const char	*name;
-	s16		dma_req;
-};
-
 /**
  * struct omap_hwmod_rst_info - IPs reset lines use by hwmod
  * @name: name of the reset line (module local name)
@@ -598,7 +584,6 @@ struct omap_hwmod_class {
  * @name: name of the hwmod
  * @class: struct omap_hwmod_class * to the class of this hwmod
  * @od: struct omap_device currently associated with this hwmod (internal use)
- * @sdma_reqs: ptr to an array of System DMA request IDs
  * @prcm: PRCM data pertaining to this hwmod
  * @main_clk: main clock: OMAP clock name
  * @_clk: pointer to the main struct clk (filled in at runtime)
@@ -641,7 +626,6 @@ struct omap_hwmod {
 	const char			*name;
 	struct omap_hwmod_class		*class;
 	struct omap_device		*od;
-	struct omap_hwmod_dma_info	*sdma_reqs;
 	struct omap_hwmod_rst_info	*rst_lines;
 	union {
 		struct omap_hwmod_omap2_prcm omap2;
@@ -692,7 +676,6 @@ int omap_hwmod_softreset(struct omap_hwmod *oh);
 
 int omap_hwmod_count_resources(struct omap_hwmod *oh, unsigned long flags);
 int omap_hwmod_fill_resources(struct omap_hwmod *oh, struct resource *res);
-int omap_hwmod_fill_dma_resources(struct omap_hwmod *oh, struct resource *res);
 int omap_hwmod_get_resource_byname(struct omap_hwmod *oh, unsigned int type,
 				   const char *name, struct resource *res);
 
diff --git a/arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c b/arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c
--- a/arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c
@@ -20,11 +20,6 @@
 #include "prm-regbits-24xx.h"
 #include "wd_timer.h"
 
-static struct omap_hwmod_dma_info omap2xxx_dss_sdma_chs[] = {
-	{ .name = "dispc", .dma_req = 5 },
-	{ .dma_req = -1, },
-};
-
 /*
  * 'dispc' class
  * display controller
@@ -550,7 +545,6 @@ struct omap_hwmod omap2xxx_dss_core_hwmod = {
 	.name		= "dss_core",
 	.class		= &omap2_dss_hwmod_class,
 	.main_clk	= "dss1_fck", /* instead of dss_fck */
-	.sdma_reqs	= omap2xxx_dss_sdma_chs,
 	.prcm		= {
 		.omap2 = {
 			.prcm_reg_id = 1,
diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -565,12 +565,6 @@ static struct omap_hwmod_class i2c_class = {
 	.reset	= &omap_i2c_reset,
 };
 
-static struct omap_hwmod_dma_info omap3xxx_dss_sdma_chs[] = {
-	{ .name = "dispc", .dma_req = 5 },
-	{ .name = "dsi1", .dma_req = 74 },
-	{ .dma_req = -1, },
-};
-
 /* dss */
 static struct omap_hwmod_opt_clk dss_opt_clks[] = {
 	/*
@@ -587,7 +581,6 @@ static struct omap_hwmod omap3430es1_dss_core_hwmod = {
 	.name		= "dss_core",
 	.class		= &omap2_dss_hwmod_class,
 	.main_clk	= "dss1_alwon_fck", /* instead of dss_fck */
-	.sdma_reqs	= omap3xxx_dss_sdma_chs,
 	.prcm		= {
 		.omap2 = {
 			.prcm_reg_id = 1,
@@ -607,7 +600,6 @@ static struct omap_hwmod omap3xxx_dss_core_hwmod = {
 	.flags		= HWMOD_CONTROL_OPT_CLKS_IN_RESET,
 	.class		= &omap2_dss_hwmod_class,
 	.main_clk	= "dss1_alwon_fck", /* instead of dss_fck */
-	.sdma_reqs	= omap3xxx_dss_sdma_chs,
 	.prcm		= {
 		.omap2 = {
 			.prcm_reg_id = 1,
diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -610,11 +610,6 @@ static struct omap_hwmod_class omap44xx_dispc_hwmod_class = {
 };
 
 /* dss_dispc */
-static struct omap_hwmod_dma_info omap44xx_dss_dispc_sdma_reqs[] = {
-	{ .dma_req = 5 + OMAP44XX_DMA_REQ_START },
-	{ .dma_req = -1 }
-};
-
 static struct omap_dss_dispc_dev_attr omap44xx_dss_dispc_dev_attr = {
 	.manager_count		= 3,
 	.has_framedonetv_irq	= 1
@@ -624,7 +619,6 @@ static struct omap_hwmod omap44xx_dss_dispc_hwmod = {
 	.name		= "dss_dispc",
 	.class		= &omap44xx_dispc_hwmod_class,
 	.clkdm_name	= "l3_dss_clkdm",
-	.sdma_reqs	= omap44xx_dss_dispc_sdma_reqs,
 	.main_clk	= "dss_dss_clk",
 	.prcm = {
 		.omap4 = {
@@ -658,11 +652,6 @@ static struct omap_hwmod_class omap44xx_dsi_hwmod_class = {
 };
 
 /* dss_dsi1 */
-static struct omap_hwmod_dma_info omap44xx_dss_dsi1_sdma_reqs[] = {
-	{ .dma_req = 74 + OMAP44XX_DMA_REQ_START },
-	{ .dma_req = -1 }
-};
-
 static struct omap_hwmod_opt_clk dss_dsi1_opt_clks[] = {
 	{ .role = "sys_clk", .clk = "dss_sys_clk" },
 };
@@ -671,7 +660,6 @@ static struct omap_hwmod omap44xx_dss_dsi1_hwmod = {
 	.name		= "dss_dsi1",
 	.class		= &omap44xx_dsi_hwmod_class,
 	.clkdm_name	= "l3_dss_clkdm",
-	.sdma_reqs	= omap44xx_dss_dsi1_sdma_reqs,
 	.main_clk	= "dss_dss_clk",
 	.prcm = {
 		.omap4 = {
@@ -685,11 +673,6 @@ static struct omap_hwmod omap44xx_dss_dsi1_hwmod = {
 };
 
 /* dss_dsi2 */
-static struct omap_hwmod_dma_info omap44xx_dss_dsi2_sdma_reqs[] = {
-	{ .dma_req = 83 + OMAP44XX_DMA_REQ_START },
-	{ .dma_req = -1 }
-};
-
 static struct omap_hwmod_opt_clk dss_dsi2_opt_clks[] = {
 	{ .role = "sys_clk", .clk = "dss_sys_clk" },
 };
@@ -698,7 +681,6 @@ static struct omap_hwmod omap44xx_dss_dsi2_hwmod = {
 	.name		= "dss_dsi2",
 	.class		= &omap44xx_dsi_hwmod_class,
 	.clkdm_name	= "l3_dss_clkdm",
-	.sdma_reqs	= omap44xx_dss_dsi2_sdma_reqs,
 	.main_clk	= "dss_dss_clk",
 	.prcm = {
 		.omap4 = {
@@ -732,11 +714,6 @@ static struct omap_hwmod_class omap44xx_hdmi_hwmod_class = {
 };
 
 /* dss_hdmi */
-static struct omap_hwmod_dma_info omap44xx_dss_hdmi_sdma_reqs[] = {
-	{ .dma_req = 75 + OMAP44XX_DMA_REQ_START },
-	{ .dma_req = -1 }
-};
-
 static struct omap_hwmod_opt_clk dss_hdmi_opt_clks[] = {
 	{ .role = "sys_clk", .clk = "dss_sys_clk" },
 	{ .role = "hdmi_clk", .clk = "dss_48mhz_clk" },
@@ -751,7 +728,6 @@ static struct omap_hwmod omap44xx_dss_hdmi_hwmod = {
 	 * set idle mode by software.
 	 */
 	.flags		= HWMOD_SWSUP_SIDLE | HWMOD_OPT_CLKS_NEEDED,
-	.sdma_reqs	= omap44xx_dss_hdmi_sdma_reqs,
 	.main_clk	= "dss_48mhz_clk",
 	.prcm = {
 		.omap4 = {
@@ -785,11 +761,6 @@ static struct omap_hwmod_class omap44xx_rfbi_hwmod_class = {
 };
 
 /* dss_rfbi */
-static struct omap_hwmod_dma_info omap44xx_dss_rfbi_sdma_reqs[] = {
-	{ .dma_req = 13 + OMAP44XX_DMA_REQ_START },
-	{ .dma_req = -1 }
-};
-
 static struct omap_hwmod_opt_clk dss_rfbi_opt_clks[] = {
 	{ .role = "ick", .clk = "l3_div_ck" },
 };
@@ -798,7 +769,6 @@ static struct omap_hwmod omap44xx_dss_rfbi_hwmod = {
 	.name		= "dss_rfbi",
 	.class		= &omap44xx_rfbi_hwmod_class,
 	.clkdm_name	= "l3_dss_clkdm",
-	.sdma_reqs	= omap44xx_dss_rfbi_sdma_reqs,
 	.main_clk	= "dss_dss_clk",
 	.prcm = {
 		.omap4 = {
@@ -1898,19 +1868,6 @@ static struct omap_hwmod_class omap44xx_mcspi_hwmod_class = {
 };
 
 /* mcspi1 */
-static struct omap_hwmod_dma_info omap44xx_mcspi1_sdma_reqs[] = {
-	{ .name = "tx0", .dma_req = 34 + OMAP44XX_DMA_REQ_START },
-	{ .name = "rx0", .dma_req = 35 + OMAP44XX_DMA_REQ_START },
-	{ .name = "tx1", .dma_req = 36 + OMAP44XX_DMA_REQ_START },
-	{ .name = "rx1", .dma_req = 37 + OMAP44XX_DMA_REQ_START },
-	{ .name = "tx2", .dma_req = 38 + OMAP44XX_DMA_REQ_START },
-	{ .name = "rx2", .dma_req = 39 + OMAP44XX_DMA_REQ_START },
-	{ .name = "tx3", .dma_req = 40 + OMAP44XX_DMA_REQ_START },
-	{ .name = "rx3", .dma_req = 41 + OMAP44XX_DMA_REQ_START },
-	{ .dma_req = -1 }
-};
-
-/* mcspi1 dev_attr */
 static struct omap2_mcspi_dev_attr mcspi1_dev_attr = {
 	.num_chipselect	= 4,
 };
@@ -1919,7 +1876,6 @@ static struct omap_hwmod omap44xx_mcspi1_hwmod = {
 	.name		= "mcspi1",
 	.class		= &omap44xx_mcspi_hwmod_class,
 	.clkdm_name	= "l4_per_clkdm",
-	.sdma_reqs	= omap44xx_mcspi1_sdma_reqs,
 	.main_clk	= "func_48m_fclk",
 	.prcm = {
 		.omap4 = {
@@ -1932,15 +1888,6 @@ static struct omap_hwmod omap44xx_mcspi1_hwmod = {
 };
 
 /* mcspi2 */
-static struct omap_hwmod_dma_info omap44xx_mcspi2_sdma_reqs[] = {
-	{ .name = "tx0", .dma_req = 42 + OMAP44XX_DMA_REQ_START },
-	{ .name = "rx0", .dma_req = 43 + OMAP44XX_DMA_REQ_START },
-	{ .name = "tx1", .dma_req = 44 + OMAP44XX_DMA_REQ_START },
-	{ .name = "rx1", .dma_req = 45 + OMAP44XX_DMA_REQ_START },
-	{ .dma_req = -1 }
-};
-
-/* mcspi2 dev_attr */
 static struct omap2_mcspi_dev_attr mcspi2_dev_attr = {
 	.num_chipselect	= 2,
 };
@@ -1949,7 +1896,6 @@ static struct omap_hwmod omap44xx_mcspi2_hwmod = {
 	.name		= "mcspi2",
 	.class		= &omap44xx_mcspi_hwmod_class,
 	.clkdm_name	= "l4_per_clkdm",
-	.sdma_reqs	= omap44xx_mcspi2_sdma_reqs,
 	.main_clk	= "func_48m_fclk",
 	.prcm = {
 		.omap4 = {
@@ -1962,15 +1908,6 @@ static struct omap_hwmod omap44xx_mcspi2_hwmod = {
 };
 
 /* mcspi3 */
-static struct omap_hwmod_dma_info omap44xx_mcspi3_sdma_reqs[] = {
-	{ .name = "tx0", .dma_req = 14 + OMAP44XX_DMA_REQ_START },
-	{ .name = "rx0", .dma_req = 15 + OMAP44XX_DMA_REQ_START },
-	{ .name = "tx1", .dma_req = 22 + OMAP44XX_DMA_REQ_START },
-	{ .name = "rx1", .dma_req = 23 + OMAP44XX_DMA_REQ_START },
-	{ .dma_req = -1 }
-};
-
-/* mcspi3 dev_attr */
 static struct omap2_mcspi_dev_attr mcspi3_dev_attr = {
 	.num_chipselect	= 2,
 };
@@ -1979,7 +1916,6 @@ static struct omap_hwmod omap44xx_mcspi3_hwmod = {
 	.name		= "mcspi3",
 	.class		= &omap44xx_mcspi_hwmod_class,
 	.clkdm_name	= "l4_per_clkdm",
-	.sdma_reqs	= omap44xx_mcspi3_sdma_reqs,
 	.main_clk	= "func_48m_fclk",
 	.prcm = {
 		.omap4 = {
@@ -1992,13 +1928,6 @@ static struct omap_hwmod omap44xx_mcspi3_hwmod = {
 };
 
 /* mcspi4 */
-static struct omap_hwmod_dma_info omap44xx_mcspi4_sdma_reqs[] = {
-	{ .name = "tx0", .dma_req = 69 + OMAP44XX_DMA_REQ_START },
-	{ .name = "rx0", .dma_req = 70 + OMAP44XX_DMA_REQ_START },
-	{ .dma_req = -1 }
-};
-
-/* mcspi4 dev_attr */
 static struct omap2_mcspi_dev_attr mcspi4_dev_attr = {
 	.num_chipselect	= 1,
 };
@@ -2007,7 +1936,6 @@ static struct omap_hwmod omap44xx_mcspi4_hwmod = {
 	.name		= "mcspi4",
 	.class		= &omap44xx_mcspi_hwmod_class,
 	.clkdm_name	= "l4_per_clkdm",
-	.sdma_reqs	= omap44xx_mcspi4_sdma_reqs,
 	.main_clk	= "func_48m_fclk",
 	.prcm = {
 		.omap4 = {
@@ -2042,13 +1970,6 @@ static struct omap_hwmod_class omap44xx_mmc_hwmod_class = {
 };
 
 /* mmc1 */
-static struct omap_hwmod_dma_info omap44xx_mmc1_sdma_reqs[] = {
-	{ .name = "tx", .dma_req = 60 + OMAP44XX_DMA_REQ_START },
-	{ .name = "rx", .dma_req = 61 + OMAP44XX_DMA_REQ_START },
-	{ .dma_req = -1 }
-};
-
-/* mmc1 dev_attr */
 static struct omap_hsmmc_dev_attr mmc1_dev_attr = {
 	.flags	= OMAP_HSMMC_SUPPORTS_DUAL_VOLT,
 };
@@ -2057,7 +1978,6 @@ static struct omap_hwmod omap44xx_mmc1_hwmod = {
 	.name		= "mmc1",
 	.class		= &omap44xx_mmc_hwmod_class,
 	.clkdm_name	= "l3_init_clkdm",
-	.sdma_reqs	= omap44xx_mmc1_sdma_reqs,
 	.main_clk	= "hsmmc1_fclk",
 	.prcm = {
 		.omap4 = {
@@ -2070,17 +1990,10 @@ static struct omap_hwmod omap44xx_mmc1_hwmod = {
 };
 
 /* mmc2 */
-static struct omap_hwmod_dma_info omap44xx_mmc2_sdma_reqs[] = {
-	{ .name = "tx", .dma_req = 46 + OMAP44XX_DMA_REQ_START },
-	{ .name = "rx", .dma_req = 47 + OMAP44XX_DMA_REQ_START },
-	{ .dma_req = -1 }
-};
-
 static struct omap_hwmod omap44xx_mmc2_hwmod = {
 	.name		= "mmc2",
 	.class		= &omap44xx_mmc_hwmod_class,
 	.clkdm_name	= "l3_init_clkdm",
-	.sdma_reqs	= omap44xx_mmc2_sdma_reqs,
 	.main_clk	= "hsmmc2_fclk",
 	.prcm = {
 		.omap4 = {
@@ -2092,17 +2005,10 @@ static struct omap_hwmod omap44xx_mmc2_hwmod = {
 };
 
 /* mmc3 */
-static struct omap_hwmod_dma_info omap44xx_mmc3_sdma_reqs[] = {
-	{ .name = "tx", .dma_req = 76 + OMAP44XX_DMA_REQ_START },
-	{ .name = "rx", .dma_req = 77 + OMAP44XX_DMA_REQ_START },
-	{ .dma_req = -1 }
-};
-
 static struct omap_hwmod omap44xx_mmc3_hwmod = {
 	.name		= "mmc3",
 	.class		= &omap44xx_mmc_hwmod_class,
 	.clkdm_name	= "l4_per_clkdm",
-	.sdma_reqs	= omap44xx_mmc3_sdma_reqs,
 	.main_clk	= "func_48m_fclk",
 	.prcm = {
 		.omap4 = {
@@ -2114,17 +2020,10 @@ static struct omap_hwmod omap44xx_mmc3_hwmod = {
 };
 
 /* mmc4 */
-static struct omap_hwmod_dma_info omap44xx_mmc4_sdma_reqs[] = {
-	{ .name = "tx", .dma_req = 56 + OMAP44XX_DMA_REQ_START },
-	{ .name = "rx", .dma_req = 57 + OMAP44XX_DMA_REQ_START },
-	{ .dma_req = -1 }
-};
-
 static struct omap_hwmod omap44xx_mmc4_hwmod = {
 	.name		= "mmc4",
 	.class		= &omap44xx_mmc_hwmod_class,
 	.clkdm_name	= "l4_per_clkdm",
-	.sdma_reqs	= omap44xx_mmc4_sdma_reqs,
 	.main_clk	= "func_48m_fclk",
 	.prcm = {
 		.omap4 = {
@@ -2136,17 +2035,10 @@ static struct omap_hwmod omap44xx_mmc4_hwmod = {
 };
 
 /* mmc5 */
-static struct omap_hwmod_dma_info omap44xx_mmc5_sdma_reqs[] = {
-	{ .name = "tx", .dma_req = 58 + OMAP44XX_DMA_REQ_START },
-	{ .name = "rx", .dma_req = 59 + OMAP44XX_DMA_REQ_START },
-	{ .dma_req = -1 }
-};
-
 static struct omap_hwmod omap44xx_mmc5_hwmod = {
 	.name		= "mmc5",
 	.class		= &omap44xx_mmc_hwmod_class,
 	.clkdm_name	= "l4_per_clkdm",
-	.sdma_reqs	= omap44xx_mmc5_sdma_reqs,
 	.main_clk	= "func_48m_fclk",
 	.prcm = {
 		.omap4 = {
diff --git a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
--- a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
@@ -571,11 +571,6 @@ static struct omap_hwmod_class dra7xx_dss_hwmod_class = {
 };
 
 /* dss */
-static struct omap_hwmod_dma_info dra7xx_dss_sdma_reqs[] = {
-	{ .dma_req = 75 + DRA7XX_DMA_REQ_START },
-	{ .dma_req = -1 }
-};
-
 static struct omap_hwmod_opt_clk dss_opt_clks[] = {
 	{ .role = "dss_clk", .clk = "dss_dss_clk" },
 	{ .role = "hdmi_phy_clk", .clk = "dss_48mhz_clk" },
@@ -591,7 +586,6 @@ static struct omap_hwmod dra7xx_dss_hwmod = {
 	.class		= &dra7xx_dss_hwmod_class,
 	.clkdm_name	= "dss_clkdm",
 	.flags		= HWMOD_CONTROL_OPT_CLKS_IN_RESET,
-	.sdma_reqs	= dra7xx_dss_sdma_reqs,
 	.main_clk	= "dss_dss_clk",
 	.prcm = {
 		.omap4 = {
diff --git a/arch/arm/mach-omap2/omap_hwmod_common_data.h b/arch/arm/mach-omap2/omap_hwmod_common_data.h
--- a/arch/arm/mach-omap2/omap_hwmod_common_data.h
+++ b/arch/arm/mach-omap2/omap_hwmod_common_data.h
@@ -89,20 +89,6 @@ extern struct omap_hwmod_ocp_if omap2xxx_l4_core__rng;
 extern struct omap_hwmod_ocp_if omap2xxx_l4_core__sham;
 extern struct omap_hwmod_ocp_if omap2xxx_l4_core__aes;
 
-/* Common IP block data */
-extern struct omap_hwmod_dma_info omap2_uart1_sdma_reqs[];
-extern struct omap_hwmod_dma_info omap2_uart2_sdma_reqs[];
-extern struct omap_hwmod_dma_info omap2_uart3_sdma_reqs[];
-extern struct omap_hwmod_dma_info omap2_i2c1_sdma_reqs[];
-extern struct omap_hwmod_dma_info omap2_i2c2_sdma_reqs[];
-extern struct omap_hwmod_dma_info omap2_mcspi1_sdma_reqs[];
-extern struct omap_hwmod_dma_info omap2_mcspi2_sdma_reqs[];
-extern struct omap_hwmod_dma_info omap2_mcbsp1_sdma_reqs[];
-extern struct omap_hwmod_dma_info omap2_mcbsp2_sdma_reqs[];
-
-/* Common IP block data on OMAP2430/OMAP3 */
-extern struct omap_hwmod_dma_info omap2_mcbsp3_sdma_reqs[];
-
 /* Common IP block data across OMAP2/3 */
 extern struct omap_hwmod_addr_space omap2xxx_timer12_addrs[];
 
-- 
2.14.1
