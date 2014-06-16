From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH] ARM: dts: OMAP5: Update CPU OPP table as per final
 production Manual
Date: Mon, 16 Jun 2014 05:00:15 -0700
Message-ID: <20140616120014.GH17845@atomide.com>
References: <1402016986-12508-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1402016986-12508-1-git-send-email-nm-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
Cc: =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Nishanth Menon <nm-l0cyMroinI0@public.gmane.org> [140605 18:11]:
> As per the Final production Data Manual for OMAP5432,
> SWPS050F(APRIL 2014)
> 
> There are only two OPPs - 1GHz and 1.5GHz. the older OPP_LOW has been
> completely descoped. The Nominal voltages are still correct though.
> However, expectation for final production configuration is operation
> with Adaptive Body Bias (ABB) and Adaptive Voltage Scaling Class 0
> operation.
> 
> There are no IDcode or version change information encoded to
> programmatically detect this and software is supposed to NOT use
> OPP_LOW(500MHz) anymore for all devices (legacy and production
> samples).
> 
> Signed-off-by: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>

Thanks applying into omap-for-v3.16/fixes.

Tony

> ---
>  arch/arm/boot/dts/omap5.dtsi |    1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
> index 3bfda16..a4ed549 100644
> --- a/arch/arm/boot/dts/omap5.dtsi
> +++ b/arch/arm/boot/dts/omap5.dtsi
> @@ -45,7 +45,6 @@
>  
>  			operating-points = <
>  				/* kHz    uV */
> -				500000  880000
>  				1000000 1060000
>  				1500000 1250000
>  			>;
> -- 
> 1.7.9.5
> 
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
