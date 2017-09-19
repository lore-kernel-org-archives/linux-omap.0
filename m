From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [RESEND PATCH] arm: dts: am33xx: Add spi alias to match SOC
 schematics
Date: Tue, 19 Sep 2017 10:53:14 -0700
Message-ID: <20170919175313.GD5024@atomide.com>
References: <1505111416-21594-1-git-send-email-sunil.m@techveda.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1505111416-21594-1-git-send-email-sunil.m-fINqtvHxh+hg9hUCZPvPmw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: sunil.m-fINqtvHxh+hg9hUCZPvPmw@public.gmane.org
Cc: bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Karthik Tummala <karthik-fINqtvHxh+hg9hUCZPvPmw@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* sunil.m-fINqtvHxh+hg9hUCZPvPmw@public.gmane.org <sunil.m-fINqtvHxh+hg9hUCZPvPmw@public.gmane.org> [170910 23:31]:
> From: Suniel Mahesh <sunil.m-fINqtvHxh+hg9hUCZPvPmw@public.gmane.org>
> 
> Linux bus numbers should match the numbers defined by the chip
> manufacturer. This patch add's spi aliases to acheive that bus
> naming convention.

OK applying into omap-for-v4.14/fixes to follow what we do
already for am4372 and dra7.

Regards,

Tony

> Signed-off-by: Suniel Mahesh <sunil.m-fINqtvHxh+hg9hUCZPvPmw@public.gmane.org>
> Signed-off-by: Karthik Tummala <karthik-fINqtvHxh+hg9hUCZPvPmw@public.gmane.org>
> Tested-by: Karthik Tummala <karthik-fINqtvHxh+hg9hUCZPvPmw@public.gmane.org>
> ---
> Note:
> - Patch was compile tested and built(ARCH=arm) on next-20170911.
> - Patch was hardware tested on AM335x (McSPI controller) with
>   spi flash chips.
> - No build/run-time issues reported.
> - At present bus numbers are represented as spi1 and spi2 in sysfs
>   instead of spi0 and spi1, as defined in SOC schematics.
> - The commit:
> "spi: Pick spi bus number from Linux idr or spi alias"
> (SHA1:9b61e302210eba55768962f2f11e96bb508c2408)
> has introduced bus numbering which happens dynamically either
> via Linux IDR or spi alias for master drivers.
> - The commit:
> "spi: omap: Allocate bus number from spi framework"
> (SHA1:b590782afe0a99fca84f451252ed7e2d64b2f155)
> is now using spi framework to allocate bus numbers.
> ---
>  arch/arm/boot/dts/am33xx.dtsi | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
> index 7d7ca05..e58fab8 100644
> --- a/arch/arm/boot/dts/am33xx.dtsi
> +++ b/arch/arm/boot/dts/am33xx.dtsi
> @@ -36,6 +36,8 @@
>  		phy1 = &usb1_phy;
>  		ethernet0 = &cpsw_emac0;
>  		ethernet1 = &cpsw_emac1;
> +		spi0 = &spi0;
> +		spi1 = &spi1;
>  	};
>  
>  	cpus {
> -- 
> 1.9.1
> 
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
