From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v2 3/3] ARM: dts: AM4372: update hdq compatible property
Date: Mon, 16 Mar 2015 15:08:38 -0700
Message-ID: <20150316220837.GN12397@atomide.com>
References: <1425293374-30878-1-git-send-email-vigneshr@ti.com>
 <1425293374-30878-4-git-send-email-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1425293374-30878-4-git-send-email-vigneshr-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Evgeniy Polyakov <zbr-i6C2adt8DTjR7s880joybQ@public.gmane.org>, Jonathan Corbet <corbet-T1hC0tSOHrs@public.gmane.org>, Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, NeilBrown <neilb-l3A5Bk7waGM@public.gmane.org>, Benoit Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org> [150302 02:53]:
> This patch updates hdq node compatible property to "ti,am4372-hdq".
> 
> Signed-off-by: Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>

Looks like this is safe to apply even with the driver changes pending
as the driver is currently only parsing ti,omap3-1w property.
So applying this patch into omap-for-v4.1/dt thanks.

Tony

> ---
>  arch/arm/boot/dts/am4372.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
> index 1943fc333e7c..ae0e8c15a6df 100644
> --- a/arch/arm/boot/dts/am4372.dtsi
> +++ b/arch/arm/boot/dts/am4372.dtsi
> @@ -884,7 +884,7 @@
>  		};
>  
>  		hdq: hdq@48347000 {
> -			compatible = "ti,am43xx-hdq";
> +			compatible = "ti,am4372-hdq";
>  			reg = <0x48347000 0x1000>;
>  			interrupts = <GIC_SPI 139 IRQ_TYPE_LEVEL_HIGH>;
>  			clocks = <&func_12m_clk>;
> -- 
> 1.9.1
> 
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
