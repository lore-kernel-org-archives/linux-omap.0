From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH V2 14/14] ARM: OMAP4: hwmod data: Clean up the data file
Date: Fri, 7 Jun 2013 10:50:06 -0700
Message-ID: <20130607175005.GB3331@atomide.com>
References: <1370606175-22599-1-git-send-email-r.sricharan@ti.com>
 <alpine.DEB.2.02.1306071230500.5589@utopia.booyaka.com>
 <20130607162927.GA3331@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:14908 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756038Ab3FGRuK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Jun 2013 13:50:10 -0400
Content-Disposition: inline
In-Reply-To: <20130607162927.GA3331@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Sricharan R <r.sricharan@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, santosh.shilimkar@ti.com, rnayak@ti.com, b-cousson@ti.com, t-kristo@ti.com, ambresh@ti.com

* Tony Lindgren <tony@atomide.com> [130607 09:35]:
> * Paul Walmsley <paul@pwsan.com> [130607 05:38]:
> > On Fri, 7 Jun 2013, Sricharan R wrote:
> > 
> > > - The IO resource information like dma request lines, irq number and
> > >   ocp address space can be populated via dt blob. So such data is stripped
> > >   from OMAP4 SOC hwmod data file.
> > > 
> > > - The devices which are still missing the device tree bindings,
> > >   address space entries are not removed yet. When such devices add
> > >   the dt bindings, respective address space data can be deleted.
> > > 
> > > - Also other unnecessary hwmods like firewalls are removed as a part of this.
> > >   Since emif was getting registered only because of this firewalls links,
> > >   the mpu->emif direct link is added now.
> > > 
> > > The above update, results in reduction of about ~1650 lines of code.
> > > 
> > > Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> > > Signed-off-by: Sricharan R <r.sricharan@ti.com>
> > 
> > Acked-by: Paul Walmsley <paul@pwsan.com>
> > 
> > Can't test this one since I don't have an OMAP4 DT config set up in the testbed
> > yet.  Maybe will add that to the testbed after the v3.10 release.
> 
> OK thanks, applying into omap-for-v3.11/cleanup.

I had to undo the following parts to avoid regressions on omap4sdp.
Can you please follow up on fixing the related issues so the fixup
won't be needed?

Seems to work now the same way as earlier for both omap4sdp and blaze
es, except for DSS, which seems to be a separate issue as posted by
Tomi. Pushed out now to omap-for-v3.11/cleanup.

Regards,

Tony


--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -465,6 +465,7 @@ static struct omap_dma_dev_attr dma_dev_attr = {
 	.lch_count	= 32,
 };
 
+/* dma_system */
 static struct omap_hwmod_irq_info omap44xx_dma_system_irqs[] = {
 	{ .name = "0", .irq = 12 + OMAP44XX_IRQ_GIC_START },
 	{ .name = "1", .irq = 13 + OMAP44XX_IRQ_GIC_START },
@@ -473,7 +474,6 @@ static struct omap_hwmod_irq_info omap44xx_dma_system_irqs[] = {
 	{ .irq = -1 }
 };
 
-/* dma_system */
 static struct omap_hwmod omap44xx_dma_system_hwmod = {
 	.name		= "dma_system",
 	.class		= &omap44xx_dma_hwmod_class,
@@ -1747,6 +1747,23 @@ static struct omap_hwmod_class omap44xx_mcspi_hwmod_class = {
 };
 
 /* mcspi1 */
+static struct omap_hwmod_irq_info omap44xx_mcspi1_irqs[] = {
+	{ .irq = 65 + OMAP44XX_IRQ_GIC_START },
+	{ .irq = -1 }
+};
+
+static struct omap_hwmod_dma_info omap44xx_mcspi1_sdma_reqs[] = {
+	{ .name = "tx0", .dma_req = 34 + OMAP44XX_DMA_REQ_START },
+	{ .name = "rx0", .dma_req = 35 + OMAP44XX_DMA_REQ_START },
+	{ .name = "tx1", .dma_req = 36 + OMAP44XX_DMA_REQ_START },
+	{ .name = "rx1", .dma_req = 37 + OMAP44XX_DMA_REQ_START },
+	{ .name = "tx2", .dma_req = 38 + OMAP44XX_DMA_REQ_START },
+	{ .name = "rx2", .dma_req = 39 + OMAP44XX_DMA_REQ_START },
+	{ .name = "tx3", .dma_req = 40 + OMAP44XX_DMA_REQ_START },
+	{ .name = "rx3", .dma_req = 41 + OMAP44XX_DMA_REQ_START },
+	{ .dma_req = -1 }
+};
+
 /* mcspi1 dev_attr */
 static struct omap2_mcspi_dev_attr mcspi1_dev_attr = {
 	.num_chipselect	= 4,
@@ -1756,6 +1773,8 @@ static struct omap_hwmod omap44xx_mcspi1_hwmod = {
 	.name		= "mcspi1",
 	.class		= &omap44xx_mcspi_hwmod_class,
 	.clkdm_name	= "l4_per_clkdm",
+	.mpu_irqs	= omap44xx_mcspi1_irqs,
+	.sdma_reqs	= omap44xx_mcspi1_sdma_reqs,
 	.main_clk	= "func_48m_fclk",
 	.prcm = {
 		.omap4 = {
@@ -1768,6 +1787,19 @@ static struct omap_hwmod omap44xx_mcspi1_hwmod = {
 };
 
 /* mcspi2 */
+static struct omap_hwmod_irq_info omap44xx_mcspi2_irqs[] = {
+	{ .irq = 66 + OMAP44XX_IRQ_GIC_START },
+	{ .irq = -1 }
+};
+
+static struct omap_hwmod_dma_info omap44xx_mcspi2_sdma_reqs[] = {
+	{ .name = "tx0", .dma_req = 42 + OMAP44XX_DMA_REQ_START },
+	{ .name = "rx0", .dma_req = 43 + OMAP44XX_DMA_REQ_START },
+	{ .name = "tx1", .dma_req = 44 + OMAP44XX_DMA_REQ_START },
+	{ .name = "rx1", .dma_req = 45 + OMAP44XX_DMA_REQ_START },
+	{ .dma_req = -1 }
+};
+
 /* mcspi2 dev_attr */
 static struct omap2_mcspi_dev_attr mcspi2_dev_attr = {
 	.num_chipselect	= 2,
@@ -1777,6 +1809,8 @@ static struct omap_hwmod omap44xx_mcspi2_hwmod = {
 	.name		= "mcspi2",
 	.class		= &omap44xx_mcspi_hwmod_class,
 	.clkdm_name	= "l4_per_clkdm",
+	.mpu_irqs	= omap44xx_mcspi2_irqs,
+	.sdma_reqs	= omap44xx_mcspi2_sdma_reqs,
 	.main_clk	= "func_48m_fclk",
 	.prcm = {
 		.omap4 = {
@@ -1789,6 +1823,19 @@ static struct omap_hwmod omap44xx_mcspi2_hwmod = {
 };
 
 /* mcspi3 */
+static struct omap_hwmod_irq_info omap44xx_mcspi3_irqs[] = {
+	{ .irq = 91 + OMAP44XX_IRQ_GIC_START },
+	{ .irq = -1 }
+};
+
+static struct omap_hwmod_dma_info omap44xx_mcspi3_sdma_reqs[] = {
+	{ .name = "tx0", .dma_req = 14 + OMAP44XX_DMA_REQ_START },
+	{ .name = "rx0", .dma_req = 15 + OMAP44XX_DMA_REQ_START },
+	{ .name = "tx1", .dma_req = 22 + OMAP44XX_DMA_REQ_START },
+	{ .name = "rx1", .dma_req = 23 + OMAP44XX_DMA_REQ_START },
+	{ .dma_req = -1 }
+};
+
 /* mcspi3 dev_attr */
 static struct omap2_mcspi_dev_attr mcspi3_dev_attr = {
 	.num_chipselect	= 2,
@@ -1798,6 +1845,8 @@ static struct omap_hwmod omap44xx_mcspi3_hwmod = {
 	.name		= "mcspi3",
 	.class		= &omap44xx_mcspi_hwmod_class,
 	.clkdm_name	= "l4_per_clkdm",
+	.mpu_irqs	= omap44xx_mcspi3_irqs,
+	.sdma_reqs	= omap44xx_mcspi3_sdma_reqs,
 	.main_clk	= "func_48m_fclk",
 	.prcm = {
 		.omap4 = {
@@ -1810,6 +1859,17 @@ static struct omap_hwmod omap44xx_mcspi3_hwmod = {
 };
 
 /* mcspi4 */
+static struct omap_hwmod_irq_info omap44xx_mcspi4_irqs[] = {
+	{ .irq = 48 + OMAP44XX_IRQ_GIC_START },
+	{ .irq = -1 }
+};
+
+static struct omap_hwmod_dma_info omap44xx_mcspi4_sdma_reqs[] = {
+	{ .name = "tx0", .dma_req = 69 + OMAP44XX_DMA_REQ_START },
+	{ .name = "rx0", .dma_req = 70 + OMAP44XX_DMA_REQ_START },
+	{ .dma_req = -1 }
+};
+
 /* mcspi4 dev_attr */
 static struct omap2_mcspi_dev_attr mcspi4_dev_attr = {
 	.num_chipselect	= 1,
@@ -1819,6 +1879,8 @@ static struct omap_hwmod omap44xx_mcspi4_hwmod = {
 	.name		= "mcspi4",
 	.class		= &omap44xx_mcspi_hwmod_class,
 	.clkdm_name	= "l4_per_clkdm",
+	.mpu_irqs	= omap44xx_mcspi4_irqs,
+	.sdma_reqs	= omap44xx_mcspi4_sdma_reqs,
 	.main_clk	= "func_48m_fclk",
 	.prcm = {
 		.omap4 = {
@@ -1853,6 +1915,17 @@ static struct omap_hwmod_class omap44xx_mmc_hwmod_class = {
 };
 
 /* mmc1 */
+static struct omap_hwmod_irq_info omap44xx_mmc1_irqs[] = {
+	{ .irq = 83 + OMAP44XX_IRQ_GIC_START },
+	{ .irq = -1 }
+};
+
+static struct omap_hwmod_dma_info omap44xx_mmc1_sdma_reqs[] = {
+	{ .name = "tx", .dma_req = 60 + OMAP44XX_DMA_REQ_START },
+	{ .name = "rx", .dma_req = 61 + OMAP44XX_DMA_REQ_START },
+	{ .dma_req = -1 }
+};
+
 /* mmc1 dev_attr */
 static struct omap_mmc_dev_attr mmc1_dev_attr = {
 	.flags	= OMAP_HSMMC_SUPPORTS_DUAL_VOLT,
@@ -1862,6 +1935,8 @@ static struct omap_hwmod omap44xx_mmc1_hwmod = {
 	.name		= "mmc1",
 	.class		= &omap44xx_mmc_hwmod_class,
 	.clkdm_name	= "l3_init_clkdm",
+	.mpu_irqs	= omap44xx_mmc1_irqs,
+	.sdma_reqs	= omap44xx_mmc1_sdma_reqs,
 	.main_clk	= "hsmmc1_fclk",
 	.prcm = {
 		.omap4 = {
@@ -1874,10 +1949,23 @@ static struct omap_hwmod omap44xx_mmc1_hwmod = {
 };
 
 /* mmc2 */
+static struct omap_hwmod_irq_info omap44xx_mmc2_irqs[] = {
+	{ .irq = 86 + OMAP44XX_IRQ_GIC_START },
+	{ .irq = -1 }
+};
+
+static struct omap_hwmod_dma_info omap44xx_mmc2_sdma_reqs[] = {
+	{ .name = "tx", .dma_req = 46 + OMAP44XX_DMA_REQ_START },
+	{ .name = "rx", .dma_req = 47 + OMAP44XX_DMA_REQ_START },
+	{ .dma_req = -1 }
+};
+
 static struct omap_hwmod omap44xx_mmc2_hwmod = {
 	.name		= "mmc2",
 	.class		= &omap44xx_mmc_hwmod_class,
 	.clkdm_name	= "l3_init_clkdm",
+	.mpu_irqs	= omap44xx_mmc2_irqs,
+	.sdma_reqs	= omap44xx_mmc2_sdma_reqs,
 	.main_clk	= "hsmmc2_fclk",
 	.prcm = {
 		.omap4 = {
@@ -1889,10 +1977,23 @@ static struct omap_hwmod omap44xx_mmc2_hwmod = {
 };
 
 /* mmc3 */
+static struct omap_hwmod_irq_info omap44xx_mmc3_irqs[] = {
+	{ .irq = 94 + OMAP44XX_IRQ_GIC_START },
+	{ .irq = -1 }
+};
+
+static struct omap_hwmod_dma_info omap44xx_mmc3_sdma_reqs[] = {
+	{ .name = "tx", .dma_req = 76 + OMAP44XX_DMA_REQ_START },
+	{ .name = "rx", .dma_req = 77 + OMAP44XX_DMA_REQ_START },
+	{ .dma_req = -1 }
+};
+
 static struct omap_hwmod omap44xx_mmc3_hwmod = {
 	.name		= "mmc3",
 	.class		= &omap44xx_mmc_hwmod_class,
 	.clkdm_name	= "l4_per_clkdm",
+	.mpu_irqs	= omap44xx_mmc3_irqs,
+	.sdma_reqs	= omap44xx_mmc3_sdma_reqs,
 	.main_clk	= "func_48m_fclk",
 	.prcm = {
 		.omap4 = {
@@ -1904,10 +2005,23 @@ static struct omap_hwmod omap44xx_mmc3_hwmod = {
 };
 
 /* mmc4 */
+static struct omap_hwmod_irq_info omap44xx_mmc4_irqs[] = {
+	{ .irq = 96 + OMAP44XX_IRQ_GIC_START },
+	{ .irq = -1 }
+};
+
+static struct omap_hwmod_dma_info omap44xx_mmc4_sdma_reqs[] = {
+	{ .name = "tx", .dma_req = 56 + OMAP44XX_DMA_REQ_START },
+	{ .name = "rx", .dma_req = 57 + OMAP44XX_DMA_REQ_START },
+	{ .dma_req = -1 }
+};
+
 static struct omap_hwmod omap44xx_mmc4_hwmod = {
 	.name		= "mmc4",
 	.class		= &omap44xx_mmc_hwmod_class,
 	.clkdm_name	= "l4_per_clkdm",
+	.mpu_irqs	= omap44xx_mmc4_irqs,
+	.sdma_reqs	= omap44xx_mmc4_sdma_reqs,
 	.main_clk	= "func_48m_fclk",
 	.prcm = {
 		.omap4 = {
@@ -1919,10 +2033,23 @@ static struct omap_hwmod omap44xx_mmc4_hwmod = {
 };
 
 /* mmc5 */
+static struct omap_hwmod_irq_info omap44xx_mmc5_irqs[] = {
+	{ .irq = 59 + OMAP44XX_IRQ_GIC_START },
+	{ .irq = -1 }
+};
+
+static struct omap_hwmod_dma_info omap44xx_mmc5_sdma_reqs[] = {
+	{ .name = "tx", .dma_req = 58 + OMAP44XX_DMA_REQ_START },
+	{ .name = "rx", .dma_req = 59 + OMAP44XX_DMA_REQ_START },
+	{ .dma_req = -1 }
+};
+
 static struct omap_hwmod omap44xx_mmc5_hwmod = {
 	.name		= "mmc5",
 	.class		= &omap44xx_mmc_hwmod_class,
 	.clkdm_name	= "l4_per_clkdm",
+	.mpu_irqs	= omap44xx_mmc5_irqs,
+	.sdma_reqs	= omap44xx_mmc5_sdma_reqs,
 	.main_clk	= "func_48m_fclk",
 	.prcm = {
 		.omap4 = {
