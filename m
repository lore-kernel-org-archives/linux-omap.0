From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 4/7] ARM: OMAP2: Add MMC hwmod data for 2420
Date: Wed, 2 May 2012 19:02:01 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1205021844280.19695@utopia.booyaka.com>
References: <20120424000607.17783.81686.stgit@muffinssi.local> <20120424000832.17783.21327.stgit@muffinssi.local> <alpine.DEB.2.00.1205021840160.19695@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:56617 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753466Ab2ECBCC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 May 2012 21:02:02 -0400
In-Reply-To: <alpine.DEB.2.00.1205021840160.19695@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Benoit Cousson <b-cousson@ti.com>

On Wed, 2 May 2012, Paul Walmsley wrote:

> Hi Tony,
> 
> On Mon, 23 Apr 2012, Tony Lindgren wrote:
> 
> > Add MMC for 2420 so we can pass the DMA request lines the same
> > way as we already do on omap2430 and later.
> > 
> > Cc: Benoit Cousson <b-cousson@ti.com>
> > Cc: Paul Walmsley <paul@pwsan.com>
> > Signed-off-by: Tony Lindgren <tony@atomide.com>
> 
> Made a few changes here so that it applies on the omap-devel-a-for-3.5 tag 
> that you pulled in.  Also changed the 2420 MMC class name to "msdi" and 
> the hwmod name to "msdi1" -- this is the IP block name that is listed in 
> the 2420 TRM Rev. X Table 26-9 "Instance Summary".  It also is convenient 
> for us, because the 2420 MMC driver is different than the 2430+ HSMMC 
> driver, so we can just probe all of the hwmods of class "msdi" to register 
> the 2420 MMC :-)

Also, forgot to mention that a struct omap_hwmod_class_sysconfig record 
was added here too, based on the info in the 2420 TRM.

The updated patch is below.  Have queued it in a hwmod data update branch 
here along with some other hwmod data updates.  Will send a pull request 
after testing is finished here...


- Paul


From: Tony Lindgren <tony@atomide.com>
Date: Mon, 23 Apr 2012 17:08:32 -0700
Subject: [PATCH] ARM: OMAP2: hwmod data: Add MMC hwmod data for 2420

Add MMC for 2420 so we can pass the DMA request lines the same
way as we already do on omap2430 and later.

Cc: Benoit Cousson <b-cousson@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
[paul@pwsan.com: updated to apply on top of the 3.5 hwmod cleanup;
 changed mmc hwmod name/class to "msdi" as documented in the 2420 TRM Rev X;
 added sysconfig register information]
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/omap_hwmod_2420_data.c |   61 ++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/arch/arm/mach-omap2/omap_hwmod_2420_data.c b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
index 2c087ff..8698819 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2420_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
@@ -239,6 +239,48 @@ static struct omap_hwmod omap2420_mcbsp2_hwmod = {
 	},
 };
 
+static struct omap_hwmod_class_sysconfig omap2420_msdi_sysc = {
+	.rev_offs	= 0x3c,
+	.sysc_offs	= 0x64,
+	.syss_offs	= 0x68,
+	.sysc_flags	= (SYSC_HAS_SOFTRESET | SYSS_HAS_RESET_STATUS),
+	.sysc_fields	= &omap_hwmod_sysc_type1,
+};
+
+static struct omap_hwmod_class omap2420_msdi_hwmod_class = {
+	.name = "msdi",
+	.sysc = &omap2420_msdi_sysc,
+};
+
+/* msdi1 */
+static struct omap_hwmod_irq_info omap2420_msdi1_irqs[] = {
+	{ .irq = 83 },
+	{ .irq = -1 }
+};
+
+static struct omap_hwmod_dma_info omap2420_msdi1_sdma_reqs[] = {
+	{ .name = "tx", .dma_req = 61 }, /* OMAP24XX_DMA_MMC1_TX */
+	{ .name = "rx", .dma_req = 62 }, /* OMAP24XX_DMA_MMC1_RX */
+	{ .dma_req = -1 }
+};
+
+static struct omap_hwmod omap2420_msdi1_hwmod = {
+	.name		= "msdi1",
+	.class		= &omap2420_msdi_hwmod_class,
+	.mpu_irqs	= omap2420_msdi1_irqs,
+	.sdma_reqs	= omap2420_msdi1_sdma_reqs,
+	.main_clk	= "mmc_fck",
+	.prcm		= {
+		.omap2 = {
+			.prcm_reg_id = 1,
+			.module_bit = OMAP2420_EN_MMC_SHIFT,
+			.module_offs = CORE_MOD,
+			.idlest_reg_id = 1,
+			.idlest_idle_bit = OMAP2420_ST_MMC_SHIFT,
+		},
+	},
+};
+
 /*
  * interfaces
  */
@@ -428,6 +470,24 @@ static struct omap_hwmod_ocp_if omap2420_l4_core__mcbsp2 = {
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
+struct omap_hwmod_addr_space omap2420_msdi1_addrs[] = {
+	{
+		.pa_start	= 0x4809c000,
+		.pa_end		= 0x4809c000 + SZ_128 - 1,
+		.flags		= ADDR_TYPE_RT,
+	},
+	{ }
+};
+
+/* l4_core -> msdi1 */
+static struct omap_hwmod_ocp_if omap2420_l4_core__msdi1 = {
+	.master		= &omap2xxx_l4_core_hwmod,
+	.slave		= &omap2420_msdi1_hwmod,
+	.clk		= "mmc_ick",
+	.addr		= omap2420_msdi1_addrs,
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
 static struct omap_hwmod_ocp_if *omap2420_hwmod_ocp_ifs[] __initdata = {
 	&omap2xxx_l3_main__l4_core,
 	&omap2xxx_mpu__l3_main,
@@ -468,6 +528,7 @@ static struct omap_hwmod_ocp_if *omap2420_hwmod_ocp_ifs[] __initdata = {
 	&omap2420_l4_core__mailbox,
 	&omap2420_l4_core__mcbsp1,
 	&omap2420_l4_core__mcbsp2,
+	&omap2420_l4_core__msdi1,
 	NULL,
 };
 
-- 
1.7.10


