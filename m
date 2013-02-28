From: "Philip, Avinash" <avinashphilip-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH 06/14] ARM: OMAP2+: Convert NAND to use
 gpmc_cs_program_settings()
Date: Thu, 28 Feb 2013 10:38:56 +0000
Message-ID: <518397C60809E147AF5323E0420B992E3EA8F235@DBDE01.ent.ti.com>
References: <1361899842-30303-1-git-send-email-jon-hunter@ti.com>
 <1361899842-30303-7-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1361899842-30303-7-git-send-email-jon-hunter-l0cyMroinI0@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: "Hunter, Jon" <jon-hunter-l0cyMroinI0@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, "Cousson, Benoit" <b-cousson-l0cyMroinI0@public.gmane.org>
Cc: device-tree <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arm <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Tue, Feb 26, 2013 at 23:00:33, Hunter, Jon wrote:
> Convert the OMAP2+ NAND code to use the gpmc_cs_program_settings()
> function for configuring the various GPMC options instead of directly
> programming the CONFIG1 register.
> 
> This moves the configuration of some GPMC options outside the
> nand_gpmc_retime() because these options should only need to be set once
> regardless of whether the gpmc timing is changing dynamically at runtime.
> The programming of where the wait-pin is also moved slightly, but this
> will not have any impact to existing devices as no boards are currently
> setting the dev_ready variable.
> 
> Signed-off-by: Jon Hunter <jon-hunter-l0cyMroinI0@public.gmane.org>
> ---
>  arch/arm/mach-omap2/gpmc-nand.c |   35 +++++++++++++++++++++++------------
>  1 file changed, 23 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/gpmc-nand.c b/arch/arm/mach-omap2/gpmc-nand.c
> index afc1e8c..4bdfea2 100644
> --- a/arch/arm/mach-omap2/gpmc-nand.c
> +++ b/arch/arm/mach-omap2/gpmc-nand.c
> @@ -43,6 +43,10 @@ static struct platform_device gpmc_nand_device = {
>  	.resource	= gpmc_nand_resource,
>  };
>  
> +static struct gpmc_settings nand_settings = {
> +	.device_nand = true,
> +};
> +

Is it possible to make it local variable?
It would help GPMC to support NAND device on multiple chip select.

Thanks
Avinash

...
> @@ -140,11 +136,26 @@ int gpmc_nand_init(struct omap_nand_platform_data *gpmc_nand_data,
>  			dev_err(dev, "Unable to set gpmc timings: %d\n", err);
>  			return err;
>  		}
> -	}
>  
> -	/* Enable RD PIN Monitoring Reg */
> -	if (gpmc_nand_data->dev_ready) {
> -		gpmc_cs_configure(gpmc_nand_data->cs, GPMC_CONFIG_RDY_BSY, 1);
> +		/* Enable RD PIN Monitoring Reg */
> +		if (gpmc_nand_data->dev_ready) {
> +			nand_settings.wait_on_read = true;
> +			nand_settings.wait_on_write = true;
> +		}
> +
> +		if (gpmc_nand_data->devsize == NAND_BUSWIDTH_16)
> +			nand_settings.device_width = GPMC_DEVWIDTH_16BIT;
> +		else
> +			nand_settings.device_width = GPMC_DEVWIDTH_8BIT;
> +
> +		err = gpmc_cs_program_settings(gpmc_nand_data->cs,
> +					       &nand_settings);
> +		if (IS_ERR_VALUE(err))
> +			goto out_free_cs;
> +
> +		err = gpmc_cs_configure(gpmc_nand_data->cs, GPMC_CONFIG_WP, 0);
> +		if (IS_ERR_VALUE(err))
> +			goto out_free_cs;
>  	}
>  
>  	gpmc_update_nand_reg(&gpmc_nand_data->reg, gpmc_nand_data->cs);
> -- 
> 1.7.10.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
