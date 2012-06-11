From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH v5 03/14] ARM: OMAP2+: gpmc: driver migration helper
Date: Mon, 11 Jun 2012 15:30:21 -0500
Message-ID: <4FD6555D.4000508@ti.com>
References: <cover.1339419492.git.afzal@ti.com> <a121156faf6c758d4e37447ab832f6f825cc5bc8.1339419492.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:46783 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751285Ab2FKUa2 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 11 Jun 2012 16:30:28 -0400
In-Reply-To: <a121156faf6c758d4e37447ab832f6f825cc5bc8.1339419492.git.afzal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Afzal Mohammed <afzal@ti.com>
Cc: tony@atomide.com, paul@pwsan.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Afzal,

On 06/11/2012 09:26 AM, Afzal Mohammed wrote:
> A driver is being created out of GPMC code. This is being
> attempted to acheive by not breaking existing interface,
> necessitating requirement of GPMC peripherals being able
> to work with as well as without the help of driver. To not
> break existing, initcall is required as in old interface
> GPMC is configured at arch initcall and GPMC should be
> ready to handle old interface by that time
> 
> Signed-off-by: Afzal Mohammed <afzal@ti.com>
> ---
>  arch/arm/mach-omap2/gpmc.c |   19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
> index b471c2f..6dbddb9 100644
> --- a/arch/arm/mach-omap2/gpmc.c
> +++ b/arch/arm/mach-omap2/gpmc.c
> @@ -902,7 +902,7 @@ postcore_initcall(gpmc_init);
>  __init int omap_gpmc_init(struct gpmc_pdata *pdata)
>  {
>  	struct omap_hwmod *oh;
> -	struct platform_device *pdev;
> +	static struct platform_device *pdev;
>  	char *name = "omap-gpmc";
>  	char *oh_name = "gpmc";
>  
> @@ -912,6 +912,12 @@ __init int omap_gpmc_init(struct gpmc_pdata *pdata)
>  		return -ENODEV;
>  	}
>  
> +	if (pdev != NULL) {
> +		clk_put(gpmc_l3_clk);
> +		omap_device_delete(pdev->archdata.od);
> +		platform_device_unregister(pdev);
> +	}
> +

I am not sure if I am missing something, but it appears that pdev will
always be NULL here as it is a local uninitialised variable.

>  	pdev = omap_device_build(name, -1, oh, pdata,
>  					sizeof(*pdata), NULL, 0, 0);
>  	if (IS_ERR(pdev)) {
> @@ -929,6 +935,17 @@ __init int omap_gpmc_init(struct gpmc_pdata *pdata)
>  	return 0;
>  }
>  
> +static int __init gpmc_pre_init(void)
> +{
> +	static struct gpmc_device_pdata *gpmc_device_data[1];
> +	struct gpmc_pdata gpmc_data = {
> +		.device_pdata	= gpmc_device_data,
> +	};
> +
> +	return omap_gpmc_init(&gpmc_data);
> +}
> +postcore_initcall(gpmc_pre_init);
> +

Not sure I see the point in the above function. Why not declare the
gpmc_device_data struct as static in the file and access it directly
instead of passing it in omap_gpmc_init(). The postcore_init can then
call omap_gpmc_init() directly.

Shouldn't the post_initcall be added in patch #4, when the driver is
created?

Cheers
Jon
