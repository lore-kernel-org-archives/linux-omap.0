From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 7/7] ARM: dts: am335x-boneblack: Use new binding for
 HDMI
Date: Fri, 6 Mar 2015 07:36:32 -0800
Message-ID: <20150306153632.GL13520@atomide.com>
References: <cover.1425656120.git.jsarha@ti.com>
 <e68f9647bff12fda5c70b3f068d3feb3911bca91.1425656120.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from pmta1.delivery8.ore.mailhop.org ([54.191.158.99]:46090 "EHLO
	pmta1.delivery8.ore.mailhop.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754456AbbCFPnG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 6 Mar 2015 10:43:06 -0500
Content-Disposition: inline
In-Reply-To: <e68f9647bff12fda5c70b3f068d3feb3911bca91.1425656120.git.jsarha@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jyri Sarha <jsarha@ti.com>
Cc: dri-devel@lists.freedesktop.org, airlied@linux.ie, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, bcousson@baylibre.com, tomi.valkeinen@ti.com, rmk+kernel@arm.linux.org.uk, robdclark@gmail.com, moinejf@free.fr

* Jyri Sarha <jsarha@ti.com> [150306 07:37]:
> Use new binding for the external tda19988 HDMI encoder.

Can this be merged separately after the driver code is
merged with things still working?

Otherwise we can have glitches with the output working and
have dependencies between kernel branches.

Regards,

Tony

> Signed-off-by: Jyri Sarha <jsarha@ti.com>
> ---
>  arch/arm/boot/dts/am335x-boneblack.dts | 20 +++++++++++++++-----
>  1 file changed, 15 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/am335x-boneblack.dts b/arch/arm/boot/dts/am335x-boneblack.dts
> index 5c42d25..eadbba3 100644
> --- a/arch/arm/boot/dts/am335x-boneblack.dts
> +++ b/arch/arm/boot/dts/am335x-boneblack.dts
> @@ -68,16 +68,26 @@
>  
>  &lcdc {
>  	status = "okay";
> +	port {
> +		lcdc_0: endpoint@0 {
> +			remote-endpoint = <&hdmi_0>;
> +		};
> +	};
>  };
>  
> -/ {
> -	hdmi {
> -		compatible = "ti,tilcdc,slave";
> -		i2c = <&i2c0>;
> +&i2c0 {
> +	tda19988 {
> +		compatible = "nxp,tda998x";
> +		reg = <0x70>;
>  		pinctrl-names = "default", "off";
>  		pinctrl-0 = <&nxp_hdmi_bonelt_pins>;
>  		pinctrl-1 = <&nxp_hdmi_bonelt_off_pins>;
> -		status = "okay";
> +
> +		port {
> +			hdmi_0: endpoint@0 {
> +				remote-endpoint = <&lcdc_0>;
> +			};
> +		};
>  	};
>  };
>  
> -- 
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
