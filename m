From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: Re: [PATCH v2 6/9] OMAP4: hwmod data: add system DMA
Date: Mon, 20 Dec 2010 18:42:21 +0530
Message-ID: <20101220131221.GB15602@GLPP-machine>
References: <1292600388-13094-1-git-send-email-manjugk@ti.com>
 <1292600388-13094-7-git-send-email-manjugk@ti.com>
 <4D0F3E43.6090207@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:50946 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752703Ab0LTNKq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 20 Dec 2010 08:10:46 -0500
Received: by mail-yw0-f52.google.com with SMTP id 9so1196607ywf.39
        for <linux-omap@vger.kernel.org>; Mon, 20 Dec 2010 05:10:46 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4D0F3E43.6090207@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: "G, Manjunath Kondaiah" <manjugk@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "tony@atomide.com" <tony@atomide.com>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "paul@pwsan.com" <paul@pwsan.com>

On Mon, Dec 20, 2010 at 12:30:11PM +0100, Cousson, Benoit wrote:
> On 12/17/2010 4:39 PM, G, Manjunath Kondaiah wrote:
> >From: Benoit Cousson<b-cousson@ti.com>
> >
> >Add OMAP4 DMA hwmod data
> >
> >Signed-off-by: Benoit Cousson<b-cousson@ti.com>
> >Signed-off-by: G, Manjunath Kondaiah<manjugk@ti.com>
> 
> It will be good to explicitly list the changes you did compared to
> the original generated version. Even if these are some minor
> changes.

I can add if it is informative.

> I thought it was the original patch and it appears it is not the case :-(

Indeed, it is original patch. Only device attributes and no idlest flags
are added.

> 
> The general minor commestic comment is you should try to keep the
> original order of the structures. That does not changes anything,
> but that will keep the file in sync with the generated one.

The order might have slightly changed when I am rebasing every time. I
can restore the order from full hwmod db if you want maintain
consistency.

> 
> >Tested-by: Kevin Hilman<khilman@deeprootsystems.com>
> >Acked-by: Kevin Hilman<khilman@deeprootsystems.com>
> >---
> >  arch/arm/mach-omap2/omap_hwmod_44xx_data.c |  101 ++++++++++++++++++++++++++++
> >  1 files changed, 101 insertions(+), 0 deletions(-)
> >
> >diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> >index d258936..50c00d6 100644
> >--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> >+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> >@@ -23,6 +23,7 @@
> >  #include<plat/omap_hwmod.h>
> >  #include<plat/cpu.h>
> >  #include<plat/gpio.h>
> >+#include<plat/dma.h>
> >
> >  #include "omap_hwmod_common_data.h"
> >
> >@@ -36,6 +37,7 @@
> >  #define OMAP44XX_DMA_REQ_START  1
> >
> >  /* Backward references (IPs with Bus Master capability) */
> >+static struct omap_hwmod omap44xx_dma_system_hwmod;
> >  static struct omap_hwmod omap44xx_dmm_hwmod;
> >  static struct omap_hwmod omap44xx_emif_fw_hwmod;
> >  static struct omap_hwmod omap44xx_l3_instr_hwmod;
> >@@ -216,6 +218,14 @@ static struct omap_hwmod_ocp_if omap44xx_l3_main_1__l3_main_2 = {
> >  	.user		= OCP_USER_MPU | OCP_USER_SDMA,
> >  };
> >
> >+/* dma_system ->  l3_main_2 */
> >+static struct omap_hwmod_ocp_if omap44xx_dma_system__l3_main_2 = {
> >+	.master		=&omap44xx_dma_system_hwmod,
> >+	.slave		=&omap44xx_l3_main_2_hwmod,
> >+	.clk		= "l3_div_ck",
> >+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
> >+};
> >+
> >  /* l4_cfg ->  l3_main_2 */
> >  static struct omap_hwmod_ocp_if omap44xx_l4_cfg__l3_main_2 = {
> >  	.master		=&omap44xx_l4_cfg_hwmod,
> >@@ -227,6 +237,7 @@ static struct omap_hwmod_ocp_if omap44xx_l4_cfg__l3_main_2 = {
> >  /* l3_main_2 slave ports */
> >  static struct omap_hwmod_ocp_if *omap44xx_l3_main_2_slaves[] = {
> >  	&omap44xx_l3_main_1__l3_main_2,
> >+	&omap44xx_dma_system__l3_main_2,
> >  	&omap44xx_l4_cfg__l3_main_2,
> >  };
> >
> >@@ -1376,6 +1387,93 @@ static struct omap_hwmod omap44xx_gpio6_hwmod = {
> >  	.slaves_cnt	= ARRAY_SIZE(omap44xx_gpio6_slaves),
> >  	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
> >  };
> >+
> >+/*
> >+ * 'dma' class
> >+ * dma controller for data exchange between memory to memory (i.e. internal or
> >+ * external memory) and gp peripherals to memory or memory to gp peripherals
> >+ */
> >+
> >+static struct omap_hwmod_class_sysconfig omap44xx_dma_sysc = {
> >+	.rev_offs	= 0x0000,
> >+	.sysc_offs	= 0x002c,
> >+	.syss_offs	= 0x0028,
> >+	.sysc_flags	= (SYSC_HAS_SIDLEMODE | SYSC_HAS_SOFTRESET |
> >+			   SYSC_HAS_MIDLEMODE | SYSC_HAS_CLOCKACTIVITY |
> >+			   SYSC_HAS_EMUFREE | SYSC_HAS_AUTOIDLE),
> 
> A new flag was introduce in 2.6.37 to handle properly the softreset
> (SYSS_HAS_RESET_STATUS). You should use it otherwise the reset might
> not work properly. The generated hwmod data was updated accordingly
> at that time (git://gitorious.org/omap-pm/linux.git
> hwmods-omap4-full)

ok.

> 
> Here are the proper data:
> 
> +static struct omap_hwmod_class_sysconfig omap44xx_dma_sysc = {
> +       .rev_offs       = 0x0000,
> +       .sysc_offs      = 0x002c,
> +       .syss_offs      = 0x0028,
> +       .sysc_flags     = (SYSC_HAS_AUTOIDLE | SYSC_HAS_CLOCKACTIVITY |
> +                          SYSC_HAS_EMUFREE | SYSC_HAS_MIDLEMODE |
> +                          SYSC_HAS_SIDLEMODE | SYSC_HAS_SOFTRESET |
> +                          SYSS_HAS_RESET_STATUS),
> 
> >+	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART |
> >+			   MSTANDBY_FORCE | MSTANDBY_NO | MSTANDBY_SMART),
> >+	.sysc_fields	=&omap_hwmod_sysc_type1,
> >+};
> >+
> >+static struct omap_hwmod_class omap44xx_dma_hwmod_class = {
> >+	.name = "dma",
> >+	.sysc =&omap44xx_dma_sysc,
> >+};
> >+
> >+/* dma attributes */
> >+static struct omap_dma_dev_attr dma_dev_attr = {
> >+	.dev_caps  = RESERVE_CHANNEL | DMA_LINKED_LCH | GLOBAL_PRIORITY |
> >+				IS_CSSA_32 | IS_CDSA_32 | IS_RW_PRIORITY,
> >+	.lch_count = 32,
> >+};
> >+
> >+/* dma_system */
> >+static struct omap_hwmod_irq_info omap44xx_dma_system_irqs[] = {
> >+	{ .name = "0", .irq = 12 + OMAP44XX_IRQ_GIC_START },
> >+	{ .name = "1", .irq = 13 + OMAP44XX_IRQ_GIC_START },
> >+	{ .name = "2", .irq = 14 + OMAP44XX_IRQ_GIC_START },
> >+	{ .name = "3", .irq = 15 + OMAP44XX_IRQ_GIC_START },
> >+};
> >+
> >+static struct omap_hwmod_addr_space omap44xx_dma_system_addrs[] = {
> >+	{
> >+		.pa_start	= 0x4a056000,
> >+		.pa_end		= 0x4a0560ff,
> >+		.flags		= ADDR_TYPE_RT
> >+	},
> >+};
> >+
> >+/* dma_system master ports */
> >+static struct omap_hwmod_ocp_if *omap44xx_dma_system_masters[] = {
> >+	&omap44xx_dma_system__l3_main_2,
> >+};
> >+
> >+/* l4_cfg ->  dma_system */
> >+static struct omap_hwmod_ocp_if omap44xx_l4_cfg__dma_system = {
> >+	.master		=&omap44xx_l4_cfg_hwmod,
> >+	.slave		=&omap44xx_dma_system_hwmod,
> >+	.clk		= "l4_div_ck",
> >+	.addr		= omap44xx_dma_system_addrs,
> >+	.addr_cnt	= ARRAY_SIZE(omap44xx_dma_system_addrs),
> >+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
> >+};
> >+
> >+/* dma_system slave ports */
> >+static struct omap_hwmod_ocp_if *omap44xx_dma_system_slaves[] = {
> >+	&omap44xx_l4_cfg__dma_system,
> >+};
> >+
> >+static struct omap_hwmod omap44xx_dma_system_hwmod = {
> >+	.name		= "dma_system",
> >+	.class		=&omap44xx_dma_hwmod_class,
> >+	.mpu_irqs	= omap44xx_dma_system_irqs,
> >+	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_dma_system_irqs),
> >+	.main_clk	= "l3_div_ck",
> >+	.prcm = {
> >+		.omap4 = {
> >+			.clkctrl_reg = OMAP4430_CM_SDMA_SDMA_CLKCTRL,
> >+		},
> >+	},
> >+	.slaves		= omap44xx_dma_system_slaves,
> >+	.slaves_cnt	= ARRAY_SIZE(omap44xx_dma_system_slaves),
> >+	.masters	= omap44xx_dma_system_masters,
> >+	.masters_cnt	= ARRAY_SIZE(omap44xx_dma_system_masters),
> >+	.dev_attr	=&dma_dev_attr,
> >+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
> >+	.flags		= HWMOD_NO_IDLEST,
> 
> That one is wrong! It was the case on OMAP 2& 3, but we do have an
> IDLEST on OMAP4.
> TRM vM page 958: Table 3-1210. CM_SDMA_SDMA_CLKCTRL.IDLEST
> 
> It might not work, but that's another story. Why did you add that?

When we were discussing omap3 idlest issue, I was under impression that,
it is applicable to omap4 also. If that is not the case, I will remove
this entry.

-Manjunath

