From: Lucas Stach <l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [RFC 5/6] ARM: dts: dra7: add vivante for bb2d module
Date: Fri, 18 Nov 2016 11:55:59 +0100
Message-ID: <1479466559.20533.3.camel@pengutronix.de>
References: <20161118024436.13447-1-robertcnelson@gmail.com>
         <20161118024436.13447-5-robertcnelson@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20161118024436.13447-5-robertcnelson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Robert Nelson <robertcnelson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Julien <jboulnois-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Am Donnerstag, den 17.11.2016, 20:44 -0600 schrieb Robert Nelson:
> Signed-off-by: Robert Nelson <robertcnelson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> CC: Julien <jboulnois-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> CC: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
> CC: Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>
> CC: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
> ---
>  arch/arm/boot/dts/dra7.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
> index 43488b6..22bd0a5 100644
> --- a/arch/arm/boot/dts/dra7.dtsi
> +++ b/arch/arm/boot/dts/dra7.dtsi
> @@ -960,7 +960,7 @@
>  		};
>  
>  		bb2d: bb2d@59000000 {
> -			compatible = "ti,dra7-bb2d";
> +			compatible = "ti,dra7-bb2d","vivante,gc";

This is what the driver expects as a compatible, but it's not consistent
with the DT documentation patch you sent. As the driver can work out the
HW version from the identification registers I would say fix your DT
binding to only require "vivante,gc"

Regards,
Lucas

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
