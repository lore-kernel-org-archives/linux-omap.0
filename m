From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH RFC 5/6] ARM: dts: AM335x: prcm node (for reset)
Date: Tue, 8 Oct 2013 11:18:27 -0700
Message-ID: <20131008181827.GH8313@atomide.com>
References: <cover.1378129416.git.afzal@ti.com>
 <00675d65eef61eb4222e6a461ef479ebbd1d4787.1378129416.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <00675d65eef61eb4222e6a461ef479ebbd1d4787.1378129416.git.afzal-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Afzal Mohammed <afzal-l0cyMroinI0@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>, Benoit Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Ian Campbell <ian.campbell-Sxgqhf6Nn4DQT0dZR+AlfA@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Afzal Mohammed <afzal-l0cyMroinI0@public.gmane.org> [130902 07:30]:
> Add AM335x prcm node with reset binding.

Please put the .dts changes into a separate series from
driver changes so the driver maintainers don't accidentally
queue also the .dts changes. This is to avoid pointless
self-inflicted merge conflicts.

Regards,

Tony
 
> Signed-off-by: Afzal Mohammed <afzal-l0cyMroinI0@public.gmane.org>
> ---
>  arch/arm/boot/dts/am33xx.dtsi | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
> index 4701e3c..c2ccf94 100644
> --- a/arch/arm/boot/dts/am33xx.dtsi
> +++ b/arch/arm/boot/dts/am33xx.dtsi
> @@ -530,6 +530,12 @@
>  			#size-cells = <1>;
>  			status = "disabled";
>  		};
> +
> +		prcm: prcm@44e00000 {
> +			compatible = "ti,am3352-prcm";
> +			reg = <0x44e00000 0x1300>;
> +			#reset-cells = <1>;
> +		};
>  	};
>  
>  	clocks {
> -- 
> 1.8.3.4
> 
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
