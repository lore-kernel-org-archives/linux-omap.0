From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 5/8] ARM: AM43xx: Introduce a separate soc_is function
 for am438x series of SoCs
Date: Wed, 5 Aug 2015 04:16:01 -0700
Message-ID: <20150805111601.GJ16878@atomide.com>
References: <1438771792-12604-1-git-send-email-j-keerthy@ti.com>
 <1438771792-12604-6-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1438771792-12604-6-git-send-email-j-keerthy-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, nm-l0cyMroinI0@public.gmane.org, paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org, t-kristo-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org> [150805 03:53]:
> --- a/arch/arm/mach-omap2/id.c
> +++ b/arch/arm/mach-omap2/id.c
> @@ -228,6 +228,8 @@ static void __init omap3_cpuinfo(void)
>  		cpu_name =  "AM335X";
>  	} else if (soc_is_am437x()) {
>  		cpu_name =  "AM437x";
> +	} else if (soc_is_am438x()) {
> +		cpu_name =  "AM438X";
>  	} else if (cpu_is_ti814x()) {
>  		cpu_name = "TI814X";
>  	} else if (omap3_has_iva() && omap3_has_sgx()) {
> --- a/arch/arm/mach-omap2/soc.h
> +++ b/arch/arm/mach-omap2/soc.h
> @@ -238,6 +238,7 @@ IS_AM_SUBCLASS(437x, 0x437)
>  #define soc_is_am335x()			0
>  #define soc_is_am43xx()			0
>  #define soc_is_am437x()			0
> +#define soc_is_am438x()			0
>  #define cpu_is_omap44xx()		0
>  #define cpu_is_omap443x()		0
>  #define cpu_is_omap446x()		0
> @@ -371,8 +372,10 @@ IS_OMAP_TYPE(3430, 0x3430)
>  #ifdef	CONFIG_SOC_AM43XX
>  # undef soc_is_am43xx
>  # undef soc_is_am437x
> -# define soc_is_am43xx()		is_am43xx()
> -# define soc_is_am437x()		is_am437x()
> +# undef soc_is_am438x
> +# define soc_is_am43xx()		of_machine_is_compatible("ti,am43")
> +# define soc_is_am437x()		of_machine_is_compatible("ti,am4372")
> +# define soc_is_am438x()		of_machine_is_compatible("ti,am438x")
>  #endif
>  
>  # if defined(CONFIG_ARCH_OMAP4)

Nice if we can start getting rid of the early SoC detection. But
With this change to use of_machine_is_compatible we need to make
sure nothing relies on it too early in the init. And we should
then do it for all the SoCs that boot in dts mode to avoid making
them behave in a different way.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
