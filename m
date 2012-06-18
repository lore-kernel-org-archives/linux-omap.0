From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH v2 2/3] ARM: OMAP2+: onenand: prepare for gpmc driver
 migration
Date: Mon, 18 Jun 2012 11:01:46 -0500
Message-ID: <4FDF50EA.4080506@ti.com>
References: <cover.1339828867.git.afzal@ti.com> <1414767dd444d4ab3998adf957e77ff4f3394f92.1339828867.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:49297 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752545Ab2FRQBv (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 18 Jun 2012 12:01:51 -0400
In-Reply-To: <1414767dd444d4ab3998adf957e77ff4f3394f92.1339828867.git.afzal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Afzal Mohammed <afzal@ti.com>
Cc: tony@atomide.com, paul@pwsan.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Afzal,

Thanks for sending the update.

On 06/16/2012 03:03 AM, Afzal Mohammed wrote:
> Reorganize gpmc-onenand initialization so that changes
> required for gpmc driver migration can be made smooth.
> 
> Ensuring sync read/write are disabled in onenand cannot
> be expected to work properly unless GPMC is setup, this
> has been removed. And invocation of set_async has been
> moved from set_sync to gpmc_onenand_init function; gpmc
> for onenand needs to be initialized to async mode (even
> for sync mode initially). Ensuring that onenand part
> has been setup for async mode has been moved now to
> setup function.
> 
> Thanks to Jon for his suggestions on improving this change.
> 
> Signed-off-by: Afzal Mohammed <afzal@ti.com>
> ---
> 
> v2: Move ensuring that async mode in OneNAND has been setup from
>  set_sync to setup function, improve commit message
> 
>  arch/arm/mach-omap2/gpmc-onenand.c |   25 ++++++++++---------------
>  1 file changed, 10 insertions(+), 15 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/gpmc-onenand.c b/arch/arm/mach-omap2/gpmc-onenand.c
> index 71d7c07..975c1f9 100644
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

Sorry if I was not clear, but I was still thinking that we keep the
above instance of setting async mode.

>  	return 0;
>  }
> @@ -197,13 +187,10 @@ static int omap2_onenand_set_sync_mode(struct omap_onenand_platform_data *cfg,
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
> @@ -385,6 +372,12 @@ static int omap2_onenand_set_sync_mode(struct omap_onenand_platform_data *cfg,
>  static int gpmc_onenand_setup(void __iomem *onenand_base, int *freq_ptr)
>  {
>  	struct device *dev = &gpmc_onenand_device.dev;
> +	u32 reg;
> +
> +	/* Ensure sync read and sync write are disabled */
> +	reg = readw(onenand_base + ONENAND_REG_SYS_CFG1);
> +	reg &= ~ONENAND_SYS_CFG1_SYNC_READ & ~ONENAND_SYS_CFG1_SYNC_WRITE;
> +	writew(reg, onenand_base + ONENAND_REG_SYS_CFG1);

... and here we should just call omap2_onenand_set_async_mode(), ...

>  	/* Set sync timings in GPMC */
>  	if (omap2_onenand_set_sync_mode(gpmc_onenand_data, onenand_base,
> @@ -421,6 +414,8 @@ void __init gpmc_onenand_init(struct omap_onenand_platform_data *_onenand_data)
>  	gpmc_onenand_resource.end = gpmc_onenand_resource.start +
>  							ONENAND_IO_SIZE - 1;
>  
> +	omap2_onenand_set_async_mode(gpmc_onenand_data->cs);
> +

...  then remove the above call.

Cheers
Jon
