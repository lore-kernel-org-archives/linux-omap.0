From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH v2 1/2] ARM: OMAP: hwmod: Add possibility to count hwmod
 resources based on type
Date: Wed, 31 Oct 2012 12:09:49 +0100
Message-ID: <509106FD.2040804@ti.com>
References: <1351596296-13825-1-git-send-email-peter.ujfalusi@ti.com> <1351596296-13825-2-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:49106 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935437Ab2JaLJ4 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 31 Oct 2012 07:09:56 -0400
In-Reply-To: <1351596296-13825-2-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Peter,

That's great you've have done that fix.

On 10/30/2012 12:24 PM, Peter Ujfalusi wrote:
> Add flags parameter for omap_hwmod_count_resources() so users can tell which
> type of resources they are interested when counting them in hwmod database.

Mmm, does it worth doing that for every resources considering that this 
is a temporary situation and than only the DMA resources are an issue so 
far?

Otherwise that looks fine to me and will allow a much smoother 
transition to full DT.

Thanks,
Benoit

> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
>   arch/arm/mach-omap2/omap_hwmod.c             | 27 ++++++++++++++++-----------
>   arch/arm/plat-omap/include/plat/omap_hwmod.h |  2 +-
>   arch/arm/plat-omap/omap_device.c             | 11 ++++++++---
>   3 files changed, 25 insertions(+), 15 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
> index b969ab1..a79c941 100644
> --- a/arch/arm/mach-omap2/omap_hwmod.c
> +++ b/arch/arm/mach-omap2/omap_hwmod.c
> @@ -3337,7 +3337,7 @@ int omap_hwmod_reset(struct omap_hwmod *oh)
>   /**
>    * omap_hwmod_count_resources - count number of struct resources needed by hwmod
>    * @oh: struct omap_hwmod *
> - * @res: pointer to the first element of an array of struct resource to fill
> + * @flags: Type of resources to include when counting (IRQ/DMA/MEM)
>    *
>    * Count the number of struct resource array elements necessary to
>    * contain omap_hwmod @oh resources.  Intended to be called by code
> @@ -3350,20 +3350,25 @@ int omap_hwmod_reset(struct omap_hwmod *oh)
>    * resource IDs.
>    *
>    */
> -int omap_hwmod_count_resources(struct omap_hwmod *oh)
> +int omap_hwmod_count_resources(struct omap_hwmod *oh, unsigned long flags)
>   {
> -	struct omap_hwmod_ocp_if *os;
> -	struct list_head *p;
> -	int ret;
> -	int i = 0;
> +	int ret = 0;
>
> -	ret = _count_mpu_irqs(oh) + _count_sdma_reqs(oh);
> +	if (flags & IORESOURCE_IRQ)
> +		ret += _count_mpu_irqs(oh);
>
> -	p = oh->slave_ports.next;
> +	if (flags & IORESOURCE_DMA)
> +		ret += _count_sdma_reqs(oh);
>
> -	while (i < oh->slaves_cnt) {
> -		os = _fetch_next_ocp_if(&p, &i);
> -		ret += _count_ocp_if_addr_spaces(os);
> +	if (flags & IORESOURCE_MEM) {
> +		int i = 0;
> +		struct omap_hwmod_ocp_if *os;
> +		struct list_head *p = oh->slave_ports.next;
> +
> +		while (i < oh->slaves_cnt) {
> +			os = _fetch_next_ocp_if(&p, &i);
> +			ret += _count_ocp_if_addr_spaces(os);
> +		}
>   	}
>
>   	return ret;
> diff --git a/arch/arm/plat-omap/include/plat/omap_hwmod.h b/arch/arm/plat-omap/include/plat/omap_hwmod.h
> index b3349f7..48a6f5d 100644
> --- a/arch/arm/plat-omap/include/plat/omap_hwmod.h
> +++ b/arch/arm/plat-omap/include/plat/omap_hwmod.h
> @@ -628,7 +628,7 @@ void omap_hwmod_write(u32 v, struct omap_hwmod *oh, u16 reg_offs);
>   u32 omap_hwmod_read(struct omap_hwmod *oh, u16 reg_offs);
>   int omap_hwmod_softreset(struct omap_hwmod *oh);
>
> -int omap_hwmod_count_resources(struct omap_hwmod *oh);
> +int omap_hwmod_count_resources(struct omap_hwmod *oh, unsigned long flags);
>   int omap_hwmod_fill_resources(struct omap_hwmod *oh, struct resource *res);
>   int omap_hwmod_fill_dma_resources(struct omap_hwmod *oh, struct resource *res);
>   int omap_hwmod_get_resource_byname(struct omap_hwmod *oh, unsigned int type,
> diff --git a/arch/arm/plat-omap/omap_device.c b/arch/arm/plat-omap/omap_device.c
> index 7a7d1f2..915cf68 100644
> --- a/arch/arm/plat-omap/omap_device.c
> +++ b/arch/arm/plat-omap/omap_device.c
> @@ -442,19 +442,21 @@ int omap_device_get_context_loss_count(struct platform_device *pdev)
>   /**
>    * omap_device_count_resources - count number of struct resource entries needed
>    * @od: struct omap_device *
> + * @flags: Type of resources to include when counting (IRQ/DMA/MEM)
>    *
>    * Count the number of struct resource entries needed for this
>    * omap_device @od.  Used by omap_device_build_ss() to determine how
>    * much memory to allocate before calling
>    * omap_device_fill_resources().  Returns the count.
>    */
> -static int omap_device_count_resources(struct omap_device *od)
> +static int omap_device_count_resources(struct omap_device *od,
> +				       unsigned long flags)
>   {
>   	int c = 0;
>   	int i;
>
>   	for (i = 0; i < od->hwmods_cnt; i++)
> -		c += omap_hwmod_count_resources(od->hwmods[i]);
> +		c += omap_hwmod_count_resources(od->hwmods[i], flags);
>
>   	pr_debug("omap_device: %s: counted %d total resources across %d hwmods\n",
>   		 od->pdev->name, c, od->hwmods_cnt);
> @@ -558,7 +560,10 @@ struct omap_device *omap_device_alloc(struct platform_device *pdev,
>   	od->hwmods = hwmods;
>   	od->pdev = pdev;
>
> -	res_count = omap_device_count_resources(od);
> +	/* Count all resources for the device */
> +	res_count = omap_device_count_resources(od, IORESOURCE_IRQ |
> +						    IORESOURCE_DMA |
> +						    IORESOURCE_MEM);
>   	/*
>   	 * DT Boot:
>   	 *   OF framework will construct the resource structure (currently
>

