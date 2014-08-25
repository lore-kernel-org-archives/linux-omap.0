From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2] ARM: OMAP2+: fix gpmc_cs_remap: re-allocating
 chip-select address space based on DT
Date: Mon, 25 Aug 2014 11:50:32 -0700
Message-ID: <20140825185031.GQ17254@atomide.com>
References: <1406139458-11676-1-git-send-email-pekon@ti.com>
 <53FB1D95.8020405@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:47316 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752060AbaHYSug (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 25 Aug 2014 14:50:36 -0400
Content-Disposition: inline
In-Reply-To: <53FB1D95.8020405@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Javier Martinez Canillas <javier@dowhile0.org>, pekon <pekon@pek-sem.com>

* Roger Quadros <rogerq@ti.com> [140825 04:27]:
> From: Pekon Gupta <pekon@ti.com>
> 
> Each GPMC chip-select needs to be configured for (base-address,CS-size) so that
> GPMC understands the address-space allocated to device connected externally.
> These chip-select configurations (base-address, CS-size) follow some basic
> mapping rules like:
> - The CS size is programmable from 256 MBytes to 16 MBytes (must be a power of 2)
>   and is defined by the mask field. Attached memory smaller than the programmed
>   CS region size is accessed through the entire CS region (aliasing).
> - The programmed 'base-address' must be aligned to the 'CS-size' boundary and
>   be a power of 2.
> - Valid CS-size values are {256MB(max), 128MB, 64MB, 32MB and 16MB (min)}
>   Any intermediate values creates holes in the chip-select memory-map.
> 
> This patch adds above checks in gpmc_cs_remap() so that any invalid value
> passed by DT <reg> property can be filtered before actually allocating the
> address space.

There's now an issue here where it mixes up the configured CS
size and the configured device IO size. With this patch GPMC based
Ethernet devices trigger warning at arch/arm/mach-omap2/gpmc.c:556
as we have the minimal GPMC CS range of 16MB with the smsc IO size
being either 0xf or 0xff depending on the model.

So that check should be done on the CS size, not the device IO size.

Regards,

Tony
 
> [rogerq@ti.com] typo and print message fixes.
> 
> Signed-off-by: Pekon Gupta <pekon@ti.com>
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> ---
>  arch/arm/mach-omap2/gpmc.c | 51 +++++++++++++++++++++++++++++++++-------------
>  1 file changed, 37 insertions(+), 14 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
> index 8bc1338..793f3a9 100644
> --- a/arch/arm/mach-omap2/gpmc.c
> +++ b/arch/arm/mach-omap2/gpmc.c
> @@ -516,31 +516,54 @@ static int gpmc_cs_delete_mem(int cs)
>   * gpmc_cs_remap - remaps a chip-select physical base address
>   * @cs:		chip-select to remap
>   * @base:	physical base address to re-map chip-select to
> + * @size:	size of the chip select map
>   *
>   * Re-maps a chip-select to a new physical base address specified by
>   * "base". Returns 0 on success and appropriate negative error code
> - * on failure.
> + * on failure. "size" of the map must be either 16M, 32M, 64M or 128M.
>   */
> -static int gpmc_cs_remap(int cs, u32 base)
> +static int gpmc_cs_remap(int cs, u32 base, u32 size)
>  {
>  	int ret;
> -	u32 old_base, size;
>  
>  	if (cs > gpmc_cs_num) {
>  		pr_err("%s: requested chip-select is disabled\n", __func__);
>  		return -ENODEV;
>  	}
>  
> -	/*
> -	 * Make sure we ignore any device offsets from the GPMC partition
> -	 * allocated for the chip select and that the new base confirms
> -	 * to the GPMC 16MB minimum granularity.
> -	 */ 
> -	base &= ~(SZ_16M - 1);
> -
> -	gpmc_cs_get_memconf(cs, &old_base, &size);
> -	if (base == old_base)
> -		return 0;
> +	/* Align size to meet SoC limitations */
> +	if (size > SZ_256M) {
> +		pr_err("%s: CS memory map > 256MB not supported\n", __func__);
> +		return -ENODEV;
> +	} else if (size > SZ_128M) {
> +		WARN((size != SZ_256M), "%s: cs=%d: allocating 256MB\n",
> +		     __func__, cs);
> +		size = SZ_256M;
> +	} else if (size > SZ_64M) {
> +		WARN((size != SZ_128M), "%s: cs=%d: allocating 128MB\n",
> +		     __func__, cs);
> +		size = SZ_128M;
> +	} else if (size > SZ_32M) {
> +		WARN((size != SZ_64M), "%s: cs=%d: allocating 64MB\n",
> +		     __func__, cs);
> +		size = SZ_64M;
> +	} else if (size > SZ_16M) {
> +		WARN((size != SZ_32M), "%s: cs=%d: allocating 32MB\n",
> +		     __func__, cs);
> +		size = SZ_32M;
> +	} else {
> +		WARN((size != SZ_16M), "%s: cs=%d: allocating 16MB\n",
> +		     __func__, cs);
> +		size = SZ_16M;
> +	}
> +
> +	/* base address should be aligned with address-space size */
> +	if (base & (size - 1)) {
> +		pr_err("%s: cs base-addr: %x should be aligned to cs size: %x",
> +		       __func__, base, size);
> +		return -EINVAL;
> +	}
> +
>  	gpmc_cs_disable_mem(cs);
>  	ret = gpmc_cs_delete_mem(cs);
>  	if (ret < 0)
> @@ -1551,7 +1574,7 @@ static int gpmc_probe_generic_child(struct platform_device *pdev,
>  	 * CS to this location. Once DT migration is complete should
>  	 * just make gpmc_cs_request() map a specific address.
>  	 */
> -	ret = gpmc_cs_remap(cs, res.start);
> +	ret = gpmc_cs_remap(cs, res.start, resource_size(&res));
>  	if (ret < 0) {
>  		dev_err(&pdev->dev, "cannot remap GPMC CS %d to %pa\n",
>  			cs, &res.start);
> -- 
> 1.8.3.2
> 
