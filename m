From: Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/2] ARM: AM43XX: HWMOD: Add rtc hwmod
Date: Thu, 18 Feb 2016 06:42:32 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1602180634120.4792@utopia.booyaka.com>
References: <1455773381-11839-1-git-send-email-j-keerthy@ti.com> <1455773381-11839-3-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1455773381-11839-3-git-send-email-j-keerthy-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>
Cc: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi Keerthy

On Thu, 18 Feb 2016, Keerthy wrote:

> The patch adds rtc hwmod. RTC module The RTC module is physically
> present on the AM438x SoC used on AM43X-EPOS-EVM, but it is permanently
> disabled. A secure RTC is used instead on these devices, where needed.
> . Hence adding it selectively using a seprate list to get RTC Module
> functional on the other am43x SoCs used on am437x-gp-evm and
> am437x-sk-evm.
> 
> Signed-off-by: Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>
> ---
> 
> No Public TRM is available for AM438x SoC as of now.
> 
>  arch/arm/mach-omap2/omap_hwmod_43xx_data.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-omap2/omap_hwmod_43xx_data.c b/arch/arm/mach-omap2/omap_hwmod_43xx_data.c
> index e97a894..fcffaf8 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_43xx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_43xx_data.c
> @@ -1020,9 +1020,21 @@ static struct omap_hwmod_ocp_if *am43xx_hwmod_ocp_ifs[] __initdata = {
>  	NULL,
>  };
>  
> +static struct omap_hwmod_ocp_if *am43xx_rtc_hwmod_ocp_ifs[] __initdata = {
> +	&am33xx_l4_wkup__rtc,
> +	NULL,
> +};
> +
>  int __init am43xx_hwmod_init(void)
>  {
> +	int ret;
> +
>  	omap_hwmod_am43xx_reg();
>  	omap_hwmod_init();
> -	return omap_hwmod_register_links(am43xx_hwmod_ocp_ifs);
> +	ret = omap_hwmod_register_links(am43xx_hwmod_ocp_ifs);
> +
> +	if (!(of_machine_is_compatible("ti,am438x")))
> +		ret = omap_hwmod_register_links(am43xx_rtc_hwmod_ocp_ifs);
> +
> +	return ret;
>  }

Could you please invert the test of this case such that the RTC hwmod is 
only registered on AM43xx SoCs where it is specifically known to be 
enabled?

That way, if another AM43xx SoC comes out that doesn't have the RTC 
module, it won't inadvertently be registered.  This seems like a safer 
approach.

- Paul
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
