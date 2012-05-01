From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH v4 04/39] ARM: OMAP2+: gpmc: Acquire NAND CS value
Date: Tue, 1 May 2012 16:16:02 -0500
Message-ID: <4FA05292.7030902@ti.com>
References: <cover.1335874494.git.afzal@ti.com> <10220de398d22fad5de783d8f58fc55ebac85338.1335874494.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:59898 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753750Ab2EAVQ2 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 1 May 2012 17:16:28 -0400
In-Reply-To: <10220de398d22fad5de783d8f58fc55ebac85338.1335874494.git.afzal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Afzal Mohammed <afzal@ti.com>
Cc: tony@atomide.com, linux@arm.linux.org.uk, khilman@ti.com, balbi@ti.com, dwmw2@infradead.org, kyungmin.park@samsung.com, gregkh@linuxfoundation.org, nm@ti.com, grinberg@compulab.co.il, notasas@gmail.com, artem.bityutskiy@linux.intel.com, vimal.newwork@gmail.com, dbaryshkov@gmail.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org, linux-mtd@lists.infradead.org

Hi Afzal,

On 05/01/2012 07:20 AM, Afzal Mohammed wrote:
> Some boards depend on bootloader to update chip select value for NAND.
> It is felt that Kernel should not depend on bootloader to get CS, as
> for a particular board CS is hardwired and is fixed, hence this can
> directly be updated in Kernel. But as CS value for boards that depend
> on this behaviour is not available, educate gpmc driver to acquire
> chip select value for NAND. this ideally should be removed once CS
> for those boards are available.

Do you know how many boards require this? If so which are those boards?

> Signed-off-by: Afzal Mohammed <afzal@ti.com>
> ---
>  arch/arm/mach-omap2/gpmc.c |   32 +++++++++++++++++++++++++++++++-
>  1 file changed, 31 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
> index 657ce95..ecd3384 100644
> --- a/arch/arm/mach-omap2/gpmc.c
> +++ b/arch/arm/mach-omap2/gpmc.c
> @@ -892,6 +892,30 @@ static int __init gpmc_init(void)
>  }
>  postcore_initcall(gpmc_init);
>  
> +static __devinit int gpmc_acquire_nand_cs(struct gpmc *gpmc,
> +					struct gpmc_device_pdata *gdp)
> +{
> +	int cs = 0;
> +	struct omap_nand_platform_data *nand = gdp->pdata;
> +
> +	if ((nand->cs >= 0) && (nand->cs < GPMC_CS_NUM))
> +		return 0;
> +
> +	while (cs < GPMC_CS_NUM) {
> +		u32 l = gpmc_cs_read_reg(cs, GPMC_CS_CONFIG1);
> +
> +		if ((l & GPMC_CONFIG1_DEVICETYPE(~0)) ==
> +				GPMC_CONFIG1_DEVICETYPE_NAND) {
> +			dev_info(gpmc->dev, "found NAND on CS: %d\n", cs);
> +			nand->cs = cs;
> +			gdp->cs_data->cs = cs;
> +			return 0;
> +		}
> +		cs++;
> +	}
> +	return -ENODEV;
> +}
> +
>  static __devinit void gpmc_update_nand_reg(struct gpmc *gpmc,
>  				struct omap_nand_platform_data *nand)
>  {
> @@ -1450,8 +1474,14 @@ static __devinit int gpmc_probe(struct platform_device *pdev)
>  
>  	for (i = 0, gdq = gp->device_pdata, gd = gpmc->device;
>  			(i < gp->num_device) && (*gdq); i++, gdq++) {
> -		if ((*gdq)->is_nand)
> +		if ((*gdq)->is_nand) {
> +			ret = gpmc_acquire_nand_cs(gpmc, *gdq);
> +			if (IS_ERR_VALUE(ret)) {
> +				dev_err(gpmc->dev, "CS error: %d\n", ret);
> +				continue;
> +			}

Should this code be marked with a FIXME?

Cheers
Jon
