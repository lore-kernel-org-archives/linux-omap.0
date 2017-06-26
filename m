From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH] ARM: dts: dra71-evm: mdio: Fix impedance values
Date: Mon, 26 Jun 2017 02:37:18 -0700
Message-ID: <20170626093718.GT3730@atomide.com>
References: <20170621084522.1828-1-lokeshvutla@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170621084522.1828-1-lokeshvutla-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lokesh Vutla <lokeshvutla-l0cyMroinI0@public.gmane.org>
Cc: Device Tree Mailing List <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Lokesh Vutla <lokeshvutla-l0cyMroinI0@public.gmane.org> [170621 01:48]:
> v1 series[1] for dp83867 phy impedance-control support,
> specifies to use ti,impedance-control with a value. These
> properties got updated iduring review to specify whether
> min or max impedance. But the DT still uses the old values
> which never takes effect. Update the DT node by using the
> proper DT properties.

I'll apply this into omap-for-v4.13/dt as it's a fix
even though we're close to merge window opening.

Regards,

Tony

> [1] https://patchwork.kernel.org/patch/9239729/
> 
> Fixes: 9868bc585ae2c ("ARM: dts: Add support for dra718-evm")
> Signed-off-by: Lokesh Vutla <lokeshvutla-l0cyMroinI0@public.gmane.org>
> ---
>  arch/arm/boot/dts/dra71-evm.dts | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/dra71-evm.dts b/arch/arm/boot/dts/dra71-evm.dts
> index 4d57a55473af..a6298eb56978 100644
> --- a/arch/arm/boot/dts/dra71-evm.dts
> +++ b/arch/arm/boot/dts/dra71-evm.dts
> @@ -190,7 +190,7 @@
>  		ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_25_NS>;
>  		ti,tx-internal-delay = <DP83867_RGMIIDCTL_250_PS>;
>  		ti,fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_8_B_NIB>;
> -		ti,impedance-control = <0x1f>;
> +		ti,min-output-impedance;
>  	};
>  
>  	dp83867_1: ethernet-phy@3 {
> @@ -198,7 +198,7 @@
>  		ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_25_NS>;
>  		ti,tx-internal-delay = <DP83867_RGMIIDCTL_250_PS>;
>  		ti,fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_8_B_NIB>;
> -		ti,impedance-control = <0x1f>;
> +		ti,min-output-impedance;
>  	};
>  };
>  
> -- 
> 2.13.0
> 
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
