From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v2] ARM: dts: dra7xx: Fix compatible string for PCF8575
 chip
Date: Fri, 18 Mar 2016 10:47:43 +0200
Message-ID: <56EBC0AF.6080902@ti.com>
References: <1458147150.20441.2.camel@codethink.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1458147150.20441.2.camel-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Hutchings <ben.hutchings-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: CT kernel <linux-kernel-81qHHgoATdFT9dQujB1mzip2UmYkHbXO@public.gmane.org>, Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On 16/03/16 18:52, Ben Hutchings wrote:
> The binding definition for the PCF857x GPIO expanders doesn't mention
> a "ti,pcf8575" compatible string.  This is apparently because TI is
> only a second source - there is no functional difference between
> PCF8575 chips manufactured by TI and NXP, and the same board might be
> populated with either depending on availability.
> 
> This is not a problem in practice because the I2C core uses
> of_modalias_node() before matching drivers and this strips the
> manufacturer name.
> 
> Signed-off-by: Ben Hutchings <ben.hutchings-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org>

Acked-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>

cheers,
-roger

> ---
> v2: Correct the claim that this is a practical problem.
> 
>  arch/arm/boot/dts/dra7-evm.dts  | 2 +-
>  arch/arm/boot/dts/dra72-evm.dts | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/dra7-evm.dts b/arch/arm/boot/dts/dra7-evm.dts
> index cfc24e52244e..3907c9d2c12e 100644
> --- a/arch/arm/boot/dts/dra7-evm.dts
> +++ b/arch/arm/boot/dts/dra7-evm.dts
> @@ -539,7 +539,7 @@
>  	};
>  
>  	pcf_gpio_21: gpio@21 {
> -		compatible = "ti,pcf8575";
> +		compatible = "nxp,pcf8575";
>  		reg = <0x21>;
>  		lines-initial-states = <0x1408>;
>  		gpio-controller;
> diff --git a/arch/arm/boot/dts/dra72-evm.dts b/arch/arm/boot/dts/dra72-evm.dts
> index 00b12002c07c..7ec42bda3afb 100644
> --- a/arch/arm/boot/dts/dra72-evm.dts
> +++ b/arch/arm/boot/dts/dra72-evm.dts
> @@ -422,7 +422,7 @@
>  	};
>  
>  	pcf_gpio_21: gpio@21 {
> -		compatible = "ti,pcf8575";
> +		compatible = "nxp,pcf8575";
>  		reg = <0x21>;
>  		lines-initial-states = <0x1408>;
>  		gpio-controller;
> 
> 
> 
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
