From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH 2/3] ARM: OMAP2+: onenand: cleanup for gpmc driver conversion
Date: Mon, 11 Jun 2012 13:36:30 -0500
Message-ID: <4FD63AAE.90008@ti.com>
References: <cover.1339419244.git.afzal@ti.com> <2d6f0fb31cde98cd700d7a4268683b4aeeee87f2.1339419244.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:46654 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752610Ab2FKSgj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 11 Jun 2012 14:36:39 -0400
In-Reply-To: <2d6f0fb31cde98cd700d7a4268683b4aeeee87f2.1339419244.git.afzal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Afzal Mohammed <afzal@ti.com>
Cc: tony@atomide.com, paul@pwsan.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Afzal,

On 06/11/2012 09:01 AM, Afzal Mohammed wrote:
> Reorganize gpmc-onenand initialization so that changes
> required for gpmc driver migration can be made smooth.
> 
> Ensuring sync read/write are disabled in onenand cannot be
> expect to work properly unless GPMC is setup, this has been
> removed. 

So I think I see what you are saying, but the above is not 100% clear. I
think that what you are saying is that omap2_onenand_set_async_mode() is
attempting to configure the onenand registers before configuring the
gpmc interface and hence this is not correct.

> Two instances of doing the same has been clubbed
> into one as onenand driver always calls indirectly
> "omap2_onenand_set_sync_mode", and has placed such that
> configuring onenand for async read/write would happen once
> GPMC is setup for async mode (which happens even for sync
> mode, before configuring to sync mode).

It may be clearer to say that _set_sync_mode is always called during
onenand setup and this will call _set_async_mode. So instead of calling
_set_async_mode from _set_sync_mode, just call it directly during the
gpmc_onenand_init().

> Signed-off-by: Afzal Mohammed <afzal@ti.com>
> ---
>  arch/arm/mach-omap2/gpmc-onenand.c |   24 +++++++++---------------
>  1 file changed, 9 insertions(+), 15 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/gpmc-onenand.c b/arch/arm/mach-omap2/gpmc-onenand.c
> index 71d7c07..fd4c48d 100644
> --- a/arch/arm/mach-omap2/gpmc-onenand.c
> +++ b/arch/arm/mach-omap2/gpmc-onenand.c
> @@ -38,10 +38,9 @@ static struct platform_device gpmc_onenand_device = {
>  	.resource	= &gpmc_onenand_resource,
>  };
>  
> -static int omap2_onenand_set_async_mode(int cs, void __iomem *onenand_base)
> +static int omap2_onenand_set_async_mode(int cs)
>  {
>  	struct gpmc_timings t;
> -	u32 reg;
>  	int err;
>  
>  	const int t_cer = 15;
> @@ -55,11 +54,6 @@ static int omap2_onenand_set_async_mode(int cs, void __iomem *onenand_base)
>  	const int t_wpl = 40;
>  	const int t_wph = 30;
>  
> -	/* Ensure sync read and sync write are disabled */
> -	reg = readw(onenand_base + ONENAND_REG_SYS_CFG1);
> -	reg &= ~ONENAND_SYS_CFG1_SYNC_READ & ~ONENAND_SYS_CFG1_SYNC_WRITE;
> -	writew(reg, onenand_base + ONENAND_REG_SYS_CFG1);
> -
>  	memset(&t, 0, sizeof(t));
>  	t.sync_clk = 0;
>  	t.cs_on = 0;
> @@ -95,10 +89,6 @@ static int omap2_onenand_set_async_mode(int cs, void __iomem *onenand_base)
>  	if (err)
>  		return err;
>  
> -	/* Ensure sync read and sync write are disabled */
> -	reg = readw(onenand_base + ONENAND_REG_SYS_CFG1);
> -	reg &= ~ONENAND_SYS_CFG1_SYNC_READ & ~ONENAND_SYS_CFG1_SYNC_WRITE;
> -	writew(reg, onenand_base + ONENAND_REG_SYS_CFG1);

I agree with getting rid of the first instance at the beginning of
_set_async_mode, but why get rid of the above one? Are you assuming that
by default it is in async mode? Could be nice to keep it to be explicit.

>  	return 0;
>  }
> @@ -191,19 +181,21 @@ static int omap2_onenand_set_sync_mode(struct omap_onenand_platform_data *cfg,
>  	u32 reg;
>  	bool clk_dep = false;
>  
> +	/* Ensure sync read and sync write are disabled */
> +	reg = readw(onenand_base + ONENAND_REG_SYS_CFG1);
> +	reg &= ~ONENAND_SYS_CFG1_SYNC_READ & ~ONENAND_SYS_CFG1_SYNC_WRITE;
> +	writew(reg, onenand_base + ONENAND_REG_SYS_CFG1);
> +

Should we only set these after we have checked the flags and depending
on which flags are set?

>  	if (cfg->flags & ONENAND_SYNC_READ) {
>  		sync_read = 1;
>  	} else if (cfg->flags & ONENAND_SYNC_READWRITE) {
>  		sync_read = 1;
>  		sync_write = 1;
>  	} else
> -		return omap2_onenand_set_async_mode(cs, onenand_base);
> +		return 0;
>  
>  	if (!freq) {
>  		/* Very first call freq is not known */
> -		err = omap2_onenand_set_async_mode(cs, onenand_base);
> -		if (err)
> -			return err;
>  		freq = omap2_onenand_get_freq(cfg, onenand_base, &clk_dep);
>  		first_time = 1;
>  	}
> @@ -421,6 +413,8 @@ void __init gpmc_onenand_init(struct omap_onenand_platform_data *_onenand_data)
>  	gpmc_onenand_resource.end = gpmc_onenand_resource.start +
>  							ONENAND_IO_SIZE - 1;
>  
> +	omap2_onenand_set_async_mode(gpmc_onenand_data->cs);
> +

What about putting this in the gpmc_onenand_setup() function before the
call to _set_sync_mode? Seems nice to have these together.

Cheers
Jon
