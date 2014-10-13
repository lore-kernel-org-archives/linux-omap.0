From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 3/3] arm: dts: omap3-gta04: Extend touchscreen configs
Date: Mon, 13 Oct 2014 09:29:05 -0700
Message-ID: <20141013162905.GC5192@atomide.com>
References: <1412108254-19234-1-git-send-email-marek@goldelico.com>
 <1412108254-19234-4-git-send-email-marek@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1412108254-19234-4-git-send-email-marek@goldelico.com>
Sender: linux-input-owner@vger.kernel.org
To: Marek Belisko <marek@goldelico.com>
Cc: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, bcousson@baylibre.com, linux@arm.linux.org.uk, dmitry.torokhov@gmail.com, hns@goldelico.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Marek Belisko <marek@goldelico.com> [140930 13:19]:
> Adding min/max values for various touschscreen properties.

Assuming no other comments on this patch series, this should be
safe to merge along with the other patches in this series without
causing merge conflicts:

Acked-by: Tony Lindgren <tony@atomide.com>
 
> Signed-off-by: Marek Belisko <marek@goldelico.com>
> ---
>  arch/arm/boot/dts/omap3-gta04.dtsi | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/omap3-gta04.dtsi b/arch/arm/boot/dts/omap3-gta04.dtsi
> index fd34f91..2dafac3b 100644
> --- a/arch/arm/boot/dts/omap3-gta04.dtsi
> +++ b/arch/arm/boot/dts/omap3-gta04.dtsi
> @@ -284,6 +284,12 @@
>  		interrupts = <0 IRQ_TYPE_EDGE_FALLING>;
>  		gpios = <&gpio6 0 GPIO_ACTIVE_LOW>;
>  		ti,x-plate-ohms = <600>;
> +		ti,min-x = <0x100>;
> +		ti,max-x = <0xf00>;
> +		ti,min-y = <0xf00>;
> +		ti,max-y = <0x100>;
> +		ti,min-rt = <0xfff>;
> +		ti,max-rt = <0>;
>  	};
>  };
>  
> -- 
> 1.9.3
> 
