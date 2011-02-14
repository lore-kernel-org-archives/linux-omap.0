From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH v3 2/4] OMAP4: hwmod: add entries for DMIC driver
Date: Mon, 14 Feb 2011 16:36:08 +0100
Message-ID: <4D594BE8.7010607@ti.com>
References: <1295992862-6154-1-git-send-email-dlambert@ti.com> <1295992862-6154-3-git-send-email-dlambert@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:45369 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754047Ab1BNPgY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 14 Feb 2011 10:36:24 -0500
In-Reply-To: <1295992862-6154-3-git-send-email-dlambert@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Lambert, David" <dlambert@ti.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>

Hi David,

I have few comments about the modification you did to the original code.

On 1/25/2011 11:01 PM, Lambert, David wrote:
> From: Benoit Cousson<b-cousson@ti.com>
> 
> Adds HWMOD entries for the OMAP DMIC driver and creates
> a platform device.  The HWMOD entires define the system

The changelog does not really reflect what the patch is doing.
You are not creating a platform device in that patch.

> resource requirements for the drvier such as DMA addresses, channels,
> and IRQ's.  Placing this information in the HWMOD database allows
> for more generic drivers to be written and having the specific
> implementation details defined in HWMOD.
> 

We already discussed that, but my S-O-B is missing.

> Signed-off-by: David Lambert<dlambert@ti.com>
> ---
>   arch/arm/mach-omap2/omap_hwmod_44xx_data.c |   91 ++++++++++++++++++++++++++++
>   1 files changed, 91 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> index 7274db4..f9b2ad3 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> @@ -383,6 +383,95 @@ static struct omap_hwmod omap44xx_l4_wkup_hwmod = {
>   };
> 
>   /*
> + * 'dmic' class
> + * digital microphone controller
> + */
> +
> +static struct omap_hwmod_class_sysconfig omap44xx_dmic_sysc = {
> +	.rev_offs	= 0x0000,
> +	.sysc_offs	= 0x0010,
> +	.sysc_flags	= (SYSC_HAS_EMUFREE | SYSC_HAS_RESET_STATUS |
> +			   SYSC_HAS_SIDLEMODE | SYSC_HAS_SOFTRESET),
> +	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART),

SIDLE_SMART_WKUP flag is missing.

> +	.sysc_fields	=&omap_hwmod_sysc_type2,
> +};
> +
> +static struct omap_hwmod_class omap44xx_dmic_hwmod_class = {
> +	.name = "omap-dmic",

This is not the right name. Please stick to the original one from the HW spec. You can rename it the way you want in the device only.

> +	.sysc =&omap44xx_dmic_sysc,
> +};
> +
> +/* dmic */
> +static struct omap_hwmod omap44xx_dmic_hwmod;
> +static struct omap_hwmod_irq_info omap44xx_dmic_irqs[] = {
> +	{ .irq = 114 + OMAP44XX_IRQ_GIC_START },
> +};
> +
> +static struct omap_hwmod_dma_info omap44xx_dmic_sdma_reqs[] = {
> +	{ .dma_req = 66 + OMAP44XX_DMA_REQ_START },
> +};
> +
> +static struct omap_hwmod_addr_space omap44xx_dmic_addrs[] = {
> +	{

it might not be useful for your driver, but we should use a name to differentiate the dual memory mapping here. It was introduce by Kishon in his McBSP series.

> +		.pa_start	= 0x4012e000,
> +		.pa_end		= 0x4012e07f,
> +		.flags		= ADDR_TYPE_RT
> +	},
> +};
> +
> +/* l4_abe ->  dmic */
> +static struct omap_hwmod_ocp_if omap44xx_l4_abe__dmic = {
> +	.master		=&omap44xx_l4_abe_hwmod,
> +	.slave		=&omap44xx_dmic_hwmod,
> +	.clk		= "ocp_abe_iclk",
> +	.addr		= omap44xx_dmic_addrs,
> +	.addr_cnt	= ARRAY_SIZE(omap44xx_dmic_addrs),
> +	.user		= OCP_USER_MPU,
> +};
> +
> +static struct omap_hwmod_addr_space omap44xx_dmic_dma_addrs[] = {
> +	{
> +		.pa_start	= 0x4902e000,
> +		.pa_end		= 0x4902e07f,
> +		.flags		= ADDR_TYPE_RT
> +	},
> +};
> +
> +/* l4_abe ->  dmic (dma) */
> +static struct omap_hwmod_ocp_if omap44xx_l4_abe__dmic_dma = {
> +	.master		=&omap44xx_l4_abe_hwmod,
> +	.slave		=&omap44xx_dmic_hwmod,
> +	.clk		= "ocp_abe_iclk",
> +	.addr		= omap44xx_dmic_dma_addrs,
> +	.addr_cnt	= ARRAY_SIZE(omap44xx_dmic_dma_addrs),
> +	.user		= OCP_USER_SDMA,
> +};
> +
> +/* dmic slave ports */
> +static struct omap_hwmod_ocp_if *omap44xx_dmic_slaves[] = {
> +	&omap44xx_l4_abe__dmic,
> +	&omap44xx_l4_abe__dmic_dma,
> +};
> +
> +static struct omap_hwmod omap44xx_dmic_hwmod = {
> +	.name		= "omap-dmic",
> +	.class		=&omap44xx_dmic_hwmod_class,
> +	.mpu_irqs	= omap44xx_dmic_irqs,
> +	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_dmic_irqs),
> +	.sdma_reqs	= omap44xx_dmic_sdma_reqs,
> +	.sdma_reqs_cnt	= ARRAY_SIZE(omap44xx_dmic_sdma_reqs),
> +	.main_clk	= "dmic_fck",
> +	.prcm = {
> +		.omap4 = {
> +			.clkctrl_reg = OMAP4430_CM1_ABE_DMIC_CLKCTRL,
> +		},
> +	},
> +	.slaves		= omap44xx_dmic_slaves,
> +	.slaves_cnt	= ARRAY_SIZE(omap44xx_dmic_slaves),
> +	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
> +};
> +
> +/*
>    * 'mpu_bus' class
>    * instance(s): mpu_private
>    */
> @@ -826,6 +915,8 @@ static __initdata struct omap_hwmod *omap44xx_hwmods[] = {
>   	&omap44xx_l4_cfg_hwmod,
>   	&omap44xx_l4_per_hwmod,
>   	&omap44xx_l4_wkup_hwmod,
> +	/* dmic class */
> +	&omap44xx_dmic_hwmod,

This is not the right place, and a blank line is missing before and after.

Please find the fixed version below. This is based on top of the spinlock + mcspi + mcbsp to avoid conflict and to get the hwmod memory name support.

Regards,
Benoit

---
>From 01f72d4f3887d2356455bb4455cd0ba3c7eb4758 Mon Sep 17 00:00:00 2001
From: Benoit Cousson <b-cousson@ti.com>
Date: Tue, 25 Jan 2011 22:01:00 +0000
Subject: [PATCH] OMAP4: hwmod data: Add entries for DMIC

Adds HWMOD entries for the OMAP DMIC. The HWMOD entires define the system
resource requirements for the driver such as DMA addresses, channels,
and IRQ's.  Placing this information in the HWMOD database allows for
more generic drivers to be written and having the specific implementation
details defined in HWMOD.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Signed-off-by: David Lambert <dlambert@ti.com>
[b-cousson@ti.com: Change the wrong hwmod name,
add memory name, add missing flag and re-order structures]
---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |   96 +++++++++++++++++++++++++++-
 1 files changed, 95 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index 6665922..703f3d4 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -519,7 +519,6 @@ static struct omap_hwmod omap44xx_mpu_private_hwmod = {
  *  ctrl_module_pad_wkup
  *  ctrl_module_wkup
  *  debugss
- *  dmic
  *  efuse_ctrl_cust
  *  efuse_ctrl_std
  *  elm
@@ -646,6 +645,98 @@ static struct omap_hwmod omap44xx_dma_system_hwmod = {
 };
 
 /*
+ * 'dmic' class
+ * digital microphone controller
+ */
+
+static struct omap_hwmod_class_sysconfig omap44xx_dmic_sysc = {
+	.rev_offs	= 0x0000,
+	.sysc_offs	= 0x0010,
+	.sysc_flags	= (SYSC_HAS_EMUFREE | SYSC_HAS_RESET_STATUS |
+			   SYSC_HAS_SIDLEMODE | SYSC_HAS_SOFTRESET),
+	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART |
+			   SIDLE_SMART_WKUP),
+	.sysc_fields	= &omap_hwmod_sysc_type2,
+};
+
+static struct omap_hwmod_class omap44xx_dmic_hwmod_class = {
+	.name	= "dmic",
+	.sysc	= &omap44xx_dmic_sysc,
+};
+
+/* dmic */
+static struct omap_hwmod omap44xx_dmic_hwmod;
+static struct omap_hwmod_irq_info omap44xx_dmic_irqs[] = {
+	{ .irq = 114 + OMAP44XX_IRQ_GIC_START },
+};
+
+static struct omap_hwmod_dma_info omap44xx_dmic_sdma_reqs[] = {
+	{ .dma_req = 66 + OMAP44XX_DMA_REQ_START },
+};
+
+static struct omap_hwmod_addr_space omap44xx_dmic_addrs[] = {
+	{
+		.name		= "mpu",
+		.pa_start	= 0x4012e000,
+		.pa_end		= 0x4012e07f,
+		.flags		= ADDR_TYPE_RT
+	},
+};
+
+/* l4_abe -> dmic */
+static struct omap_hwmod_ocp_if omap44xx_l4_abe__dmic = {
+	.master		= &omap44xx_l4_abe_hwmod,
+	.slave		= &omap44xx_dmic_hwmod,
+	.clk		= "ocp_abe_iclk",
+	.addr		= omap44xx_dmic_addrs,
+	.addr_cnt	= ARRAY_SIZE(omap44xx_dmic_addrs),
+	.user		= OCP_USER_MPU,
+};
+
+static struct omap_hwmod_addr_space omap44xx_dmic_dma_addrs[] = {
+	{
+		.name		= "dma",
+		.pa_start	= 0x4902e000,
+		.pa_end		= 0x4902e07f,
+		.flags		= ADDR_TYPE_RT
+	},
+};
+
+/* l4_abe -> dmic (dma) */
+static struct omap_hwmod_ocp_if omap44xx_l4_abe__dmic_dma = {
+	.master		= &omap44xx_l4_abe_hwmod,
+	.slave		= &omap44xx_dmic_hwmod,
+	.clk		= "ocp_abe_iclk",
+	.addr		= omap44xx_dmic_dma_addrs,
+	.addr_cnt	= ARRAY_SIZE(omap44xx_dmic_dma_addrs),
+	.user		= OCP_USER_SDMA,
+};
+
+/* dmic slave ports */
+static struct omap_hwmod_ocp_if *omap44xx_dmic_slaves[] = {
+	&omap44xx_l4_abe__dmic,
+	&omap44xx_l4_abe__dmic_dma,
+};
+
+static struct omap_hwmod omap44xx_dmic_hwmod = {
+	.name		= "dmic",
+	.class		= &omap44xx_dmic_hwmod_class,
+	.mpu_irqs	= omap44xx_dmic_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_dmic_irqs),
+	.sdma_reqs	= omap44xx_dmic_sdma_reqs,
+	.sdma_reqs_cnt	= ARRAY_SIZE(omap44xx_dmic_sdma_reqs),
+	.main_clk	= "dmic_fck",
+	.prcm		= {
+		.omap4 = {
+			.clkctrl_reg = OMAP4430_CM1_ABE_DMIC_CLKCTRL,
+		},
+	},
+	.slaves		= omap44xx_dmic_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap44xx_dmic_slaves),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+};
+
+/*
  * 'dsp' class
  * dsp sub-system
  */
@@ -3895,6 +3986,9 @@ static __initdata struct omap_hwmod *omap44xx_hwmods[] = {
 	/* dma class */
 	&omap44xx_dma_system_hwmod,
 
+	/* dmic class */
+	&omap44xx_dmic_hwmod,
+
 	/* dsp class */
 	&omap44xx_dsp_hwmod,
 	&omap44xx_dsp_c0_hwmod,
-- 
1.7.0.4

