From: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v4 4/4] cpufreq: dt: Don't use generic platdev driver for
 ti-cpufreq platforms
Date: Wed, 18 Jan 2017 08:47:59 +0530
Message-ID: <20170118031759.GD11478@vireshk-i7>
References: <20170117131808.29798-1-d-gerlach@ti.com>
 <20170117131808.29798-5-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170117131808.29798-5-d-gerlach-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "Rafael J . Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On 17-01-17, 07:18, Dave Gerlach wrote:
> Some TI platforms, specifically those in the am33xx, am43xx, dra7xx, and
> am57xx families of SoCs can make use of the ti-cpufreq driver to
> selectively enable OPPs based on the exact configuration in use. The
> ti-cpufreq is given the responsibility of creating the cpufreq-dt
> platform device when the driver is in use so drop am33xx and dra7xx
> from the cpufreq-dt-platdev driver so it is not created twice.
> 
> Signed-off-by: Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>
> ---
>  drivers/cpufreq/cpufreq-dt-platdev.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
> index 7fcaf26e8f81..921b4a6c3d16 100644
> --- a/drivers/cpufreq/cpufreq-dt-platdev.c
> +++ b/drivers/cpufreq/cpufreq-dt-platdev.c
> @@ -87,8 +87,6 @@ static const struct of_device_id machines[] __initconst = {
>  	{ .compatible = "socionext,uniphier-ld11", },
>  	{ .compatible = "socionext,uniphier-ld20", },
>  
> -	{ .compatible = "ti,am33xx", },
> -	{ .compatible = "ti,dra7", },
>  	{ .compatible = "ti,omap2", },
>  	{ .compatible = "ti,omap3", },
>  	{ .compatible = "ti,omap4", },

Acked-by: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

-- 
viresh
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
