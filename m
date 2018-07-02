From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/5] ARM: dts: dra7: Disable metastability workaround for
 USB2
Date: Mon, 2 Jul 2018 04:05:29 -0700
Message-ID: <20180702110529.GR112168@atomide.com>
References: <1527584458-6257-1-git-send-email-rogerq@ti.com>
 <1527584458-6257-2-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1527584458-6257-2-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, "[4.16+]" <stable@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

* Roger Quadros <rogerq@ti.com> [180529 02:03]:
> Disable the metastability workaround for USB2. The original
> patch disabled the workaround on the wrong USB port.
> 
> Fixes: b8c9c6fa2002 ("ARM: dts: dra7: Disable USB metastability workaround for USB2")
> Cc: <stable@vger.kernel.org>        [4.16+]
> Signed-off-by: Roger Quadros <rogerq@ti.com>


Sorry for the delay, applying this one into omap-for-v4.18/fixes.

Regards,

Tony

> ---
>  arch/arm/boot/dts/dra7.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
> index f4ddd86..9cace9f 100644
> --- a/arch/arm/boot/dts/dra7.dtsi
> +++ b/arch/arm/boot/dts/dra7.dtsi
> @@ -1582,7 +1582,6 @@
>  				dr_mode = "otg";
>  				snps,dis_u3_susphy_quirk;
>  				snps,dis_u2_susphy_quirk;
> -				snps,dis_metastability_quirk;
>  			};
>  		};
>  
> @@ -1610,6 +1609,7 @@
>  				dr_mode = "otg";
>  				snps,dis_u3_susphy_quirk;
>  				snps,dis_u2_susphy_quirk;
> +				snps,dis_metastability_quirk;
>  			};
>  		};
>  
> -- 
> cheers,
> -roger
> 
> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
> Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
> 
