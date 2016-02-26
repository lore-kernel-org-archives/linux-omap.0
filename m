From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH] ARM: dts: dra7: Support QSPI MODE-0 operation at 64MHz
Date: Fri, 26 Feb 2016 11:13:43 -0800
Message-ID: <20160226191342.GF13417@atomide.com>
References: <1456375652-14071-1-git-send-email-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1456375652-14071-1-git-send-email-vigneshr-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi,

* Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org> [160224 20:49]:
> According to Data Manual(SPRS915P) of AM57x, TI QSPI controller on
> DRA74(rev 1.1+) can support up to 64MHz in MODE-0, whereas MODE-3 is
> limited to 48MHz. Hence, switch to MODE-0 for better throughput.
> 
> Signed-off-by: Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>
> ---
>  arch/arm/boot/dts/dra7-evm.dts | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/dra7-evm.dts b/arch/arm/boot/dts/dra7-evm.dts
> index cfc24e52244e..15f10bdc8c31 100644
> --- a/arch/arm/boot/dts/dra7-evm.dts
> +++ b/arch/arm/boot/dts/dra7-evm.dts
> @@ -653,15 +653,13 @@
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&qspi1_pins>;
>  
> -	spi-max-frequency = <48000000>;
> +	spi-max-frequency = <64000000>;
>  	m25p80@0 {
>  		compatible = "s25fl256s1";
> -		spi-max-frequency = <48000000>;
> +		spi-max-frequency = <64000000>;
>  		reg = <0>;
>  		spi-tx-bus-width = <1>;
>  		spi-rx-bus-width = <4>;
> -		spi-cpol;
> -		spi-cpha;
>  		#address-cells = <1>;
>  		#size-cells = <1>;
>  

Do we have any earlier pre DRA74(rev 1.1)versions in use too?

What about the spi-cpol and spi-cpha changes? Those should be
at least documented?

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
