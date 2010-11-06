From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH 3/6] OMAP4: hwmod data: add mmu hwmod for ducati and tesla
Date: Sat, 06 Nov 2010 16:47:59 -0400
Message-ID: <4CD5BEFF.40301@ti.com>
References: <1289006396-27230-1-git-send-email-omar.ramirez@ti.com> <1289006396-27230-4-git-send-email-omar.ramirez@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:59839 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751866Ab0KFUrY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 6 Nov 2010 16:47:24 -0400
In-Reply-To: <1289006396-27230-4-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Russell King <linux@arm.linux.org.uk>, "Kanigeri, Hari" <h-kanigeri2@ti.com>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@deeprootsystems.com>, "Raja, Govindraj" <govindraj.raja@ti.com>, "Varadarajan, Charulatha" <charu@ti.com>, "Gupta, Ramesh" <grgupta@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 11/5/2010 9:19 PM, Ramirez Luna, Omar wrote:
> Add mmu hwmod data for ducati and tesla.

s/ducati/ipu/
s/tesla/dsp/

Please do not use internal codename.

Here again, you completely changed the omap4 existing data for (almost) 
nothing.

I agree, the original code was not considering the mmu as a hwmod but 
only the core of the subsystem: mmu + cache.

But as far as I can see, you just added a new mmu class, a dev_attr, and 
the hwmod remain almost the same.
Otherwise, you replaced the proper names by the bad one, and you removed 
important data (hw reset for ex).

Please start from the original code and fix what is missing or wrong but 
do not re-write everything.

>
> Signed-off-by: Omar Ramirez Luna<omar.ramirez@ti.com>
> ---
>   arch/arm/mach-omap2/omap_hwmod_44xx_data.c |  105 ++++++++++++++++++++++++++++
>   1 files changed, 105 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> index f7525e3..1d5eace 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> @@ -22,6 +22,7 @@
>
>   #include<plat/omap_hwmod.h>
>   #include<plat/cpu.h>
> +#include<plat/iommu.h>
>
>   #include "omap_hwmod_common_data.h"
>
> @@ -1103,6 +1104,106 @@ static struct omap_hwmod omap44xx_mailbox_hwmod = {
>   	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
>   };
>
> +/* mmu */
> +
> +static struct omap_hwmod_class omap44xx_mmu_hwmod_class = {
> +	.name = "mmu",
> +};

That change is OK. The remaining part seems to be completely broken.

> +
> +/* ducati mmu */
> +
> +static struct omap_hwmod omap44xx_ducati_mmu_hwmod;
> +
> +static struct omap_hwmod_addr_space omap44xx_ducati_mmu_addrs[] = {
> +	{
> +		.pa_start	= OMAP4_MMU1_BASE,
> +		.pa_end		= OMAP4_MMU1_BASE + SZ_4K - 1,
> +		.flags		= ADDR_TYPE_RT,
> +	},
> +};
> +
> +/* l3_main_1 ->  ducati mmu */
> +static struct omap_hwmod_ocp_if omap44xx_l3_main_1__ducati_mmu = {
> +	.master		=&omap44xx_l3_main_1_hwmod,
> +	.slave		=&omap44xx_ducati_mmu_hwmod,
> +	.addr		= omap44xx_ducati_mmu_addrs,
> +	.clk		= "dpll_mpu_m2_ck",

Are you sure of that?

Benoit

> +	.addr_cnt	= ARRAY_SIZE(omap44xx_ducati_mmu_addrs),
> +	.user		= OCP_USER_MPU | OCP_USER_SDMA,
> +};
> +
> +/* ducati mmu slave ports */
> +static struct omap_hwmod_ocp_if *omap44xx_ducati_mmu_slaves[] = {
> +	&omap44xx_l3_main_1__ducati_mmu,
> +};
> +
> +static struct omap_hwmod_irq_info omap44xx_ducati_mmu_irqs[] = {
> +	{ .name = "ducati", .irq = 100 + OMAP44XX_IRQ_GIC_START, },
> +};
> +
> +static struct omap_mmu_dev_attr ducati_mmu_dev_attr = {
> +	.nr_tlb_entries = 32,
> +};
> +
> +static struct omap_hwmod omap44xx_ducati_mmu_hwmod = {
> +	.name		= "ducati",
> +	.class		=&omap44xx_mmu_hwmod_class,
> +	.mpu_irqs	= omap44xx_ducati_mmu_irqs,
> +	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_ducati_mmu_irqs),
> +	.slaves		= omap44xx_ducati_mmu_slaves,
> +	.slaves_cnt	= ARRAY_SIZE(omap44xx_ducati_mmu_slaves),
> +	.dev_attr	=&ducati_mmu_dev_attr,
> +	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
> +	.flags		= HWMOD_NO_IDLEST,
> +};
> +
> +/* tesla mmu */
> +
> +static struct omap_hwmod omap44xx_tesla_mmu_hwmod;
> +
> +static struct omap_hwmod_addr_space omap44xx_tesla_mmu_addrs[] = {
> +	{
> +		.pa_start	= OMAP4_MMU2_BASE,
> +		.pa_end		= OMAP4_MMU2_BASE + SZ_4K - 1,
> +		.flags		= ADDR_TYPE_RT,
> +	},
> +};
> +
> +/* l3_main_1 ->  tesla mmu */
> +static struct omap_hwmod_ocp_if omap44xx_l3_main_1__tesla_mmu = {
> +	.master		=&omap44xx_l3_main_1_hwmod,
> +	.slave		=&omap44xx_tesla_mmu_hwmod,
> +	.addr		= omap44xx_tesla_mmu_addrs,
> +	.addr_cnt	= ARRAY_SIZE(omap44xx_tesla_mmu_addrs),
> +	.user		= OCP_USER_MPU | OCP_USER_SDMA,
> +};
> +
> +/* tesla mmu slave ports */
> +static struct omap_hwmod_ocp_if *omap44xx_tesla_mmu_slaves[] = {
> +	&omap44xx_l3_main_1__tesla_mmu,
> +};
> +
> +static struct omap_hwmod_irq_info omap44xx_tesla_mmu_irqs[] = {
> +	{ .name = "tesla", .irq = 28 + OMAP44XX_IRQ_GIC_START, },
> +};
> +
> +static struct omap_mmu_dev_attr tesla_mmu_dev_attr = {
> +	.nr_tlb_entries = 32,
> +};
> +
> +static struct omap_hwmod omap44xx_tesla_mmu_hwmod = {
> +	.name		= "tesla",
> +	.class		=&omap44xx_mmu_hwmod_class,
> +	.mpu_irqs	= omap44xx_tesla_mmu_irqs,
> +	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_tesla_mmu_irqs),
> +	.main_clk	= "dsp_fck",
> +	.slaves		= omap44xx_tesla_mmu_slaves,
> +	.slaves_cnt	= ARRAY_SIZE(omap44xx_tesla_mmu_slaves),
> +	.dev_attr	=&tesla_mmu_dev_attr,
> +	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
> +	.flags		= HWMOD_NO_IDLEST,
> +};
> +
>   static __initdata struct omap_hwmod *omap44xx_hwmods[] = {
>   	/* dmm class */
>   	&omap44xx_dmm_hwmod,
> @@ -1140,6 +1241,10 @@ static __initdata struct omap_hwmod *omap44xx_hwmods[] = {
>
>   	/* mailbox */
>   	&omap44xx_mailbox_hwmod,
> +
> +	/* mmu */
> +	&omap44xx_ducati_mmu_hwmod,
> +	&omap44xx_tesla_mmu_hwmod,
>   	NULL,
>   };
>

