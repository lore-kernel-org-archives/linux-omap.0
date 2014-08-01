From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH] ARM: OMAP2+: fix gpmc_cs_remap: re-allocating chip-select
 address space based on DT
Date: Fri, 1 Aug 2014 14:00:25 +0300
Message-ID: <53DB7349.4000105@ti.com>
References: <1406139458-11676-1-git-send-email-pekon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:47127 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753060AbaHALBC (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 1 Aug 2014 07:01:02 -0400
In-Reply-To: <1406139458-11676-1-git-send-email-pekon@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Pekon Gupta <pekon.gupta@gmail.com>, Tony Lindgren <tony@atomide.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Javier Martinez Canillas <javier@dowhile0.org>

Hi Pekon,

On 07/23/2014 09:17 PM, Pekon Gupta wrote:
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
> 
> Signed-off-by: Pekon Gupta <pekon@ti.com>
> ---
>  arch/arm/mach-omap2/gpmc.c | 42 +++++++++++++++++++++++++++++-------------
>  1 file changed, 29 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
> index 8bc1338..4a4cc04 100644
> --- a/arch/arm/mach-omap2/gpmc.c
> +++ b/arch/arm/mach-omap2/gpmc.c
> @@ -521,26 +521,42 @@ static int gpmc_cs_delete_mem(int cs)
>   * "base". Returns 0 on success and appropriate negative error code
>   * on failure.
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
> +	/* allocate enough address-space under GPMC chip-select to device */
> +	if (size > SZ_256M) {
> +		pr_err("%s: memory device > 256MB not supported\n", __func__);
> +		return -ENODEV;
> +	} else if (size > SZ_128M) {
> +		WARN((size != SZ_256M), "cs=%d: allocating 256MB\n", cs);
> +		size = SZ_256M;
> +	} else if (size > SZ_64M) {
> +		WARN((size != SZ_128M), "cs=%d: allocating 128MB\n", cs);
> +		size = SZ_128M;
> +	} else if (size > SZ_32M) {
> +		WARN((size != SZ_64M), "cs=%d: allocating 64MB\n", cs);
> +		size = SZ_64M;
> +	} else if (size > SZ_16M) {
> +		WARN((size != SZ_32M), "cs=%d: allocating 64MB\n", cs);

Print message should be "allocating 32MB"

> +		size = SZ_32M;
> +	} else {
> +		WARN((size != SZ_16M), "cs=%d: allocating 64MB\n", cs);

Print message should be "allocating 16MB"

> +		size = SZ_16M;
> +	}
> +
> +	/* base address should be aligned with address-space size */
> +	if (base & (size - 1)) {
> +		pr_err("base-addr=%x should be aligned to size=%x", base, size);
> +		return -EINVAL;
> +	}
> +
>  	gpmc_cs_disable_mem(cs);
>  	ret = gpmc_cs_delete_mem(cs);
>  	if (ret < 0)
> @@ -1551,7 +1567,7 @@ static int gpmc_probe_generic_child(struct platform_device *pdev,
>  	 * CS to this location. Once DT migration is complete should
>  	 * just make gpmc_cs_request() map a specific address.
>  	 */
> -	ret = gpmc_cs_remap(cs, res.start);
> +	ret = gpmc_cs_remap(cs, res.start, resource_size(&res));
>  	if (ret < 0) {
>  		dev_err(&pdev->dev, "cannot remap GPMC CS %d to %pa\n",
>  			cs, &res.start);
> 

Otherwise it is fine. I can make the changes and resend.

cheers,
-roger

