From: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 2/2] ARM: dts: DRA7X: drop id property in pcie_phy
Date: Tue, 23 Dec 2014 15:41:12 +0530
Message-ID: <54993FC0.3090705@ti.com>
References: <1418721771-31184-1-git-send-email-vigneshr@ti.com> <1418721771-31184-3-git-send-email-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1418721771-31184-3-git-send-email-vigneshr-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>, Benoit Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org



On Tuesday 16 December 2014 02:52 PM, Vignesh R wrote:
> Since phyid is no longer used by pcie driver, this field can be dropped
> from the DT.
> 
> Signed-off-by: Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>

Acked-by: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
> ---
>  arch/arm/boot/dts/dra7.dtsi | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
> index 63bf99be1762..889e3023e68f 100644
> --- a/arch/arm/boot/dts/dra7.dtsi
> +++ b/arch/arm/boot/dts/dra7.dtsi
> @@ -1111,7 +1111,6 @@
>  					      "wkupclk", "refclk",
>  					      "div-clk", "phy-div";
>  				#phy-cells = <0>;
> -				id = <1>;
>  				ti,hwmods = "pcie1-phy";
>  			};
>  
> @@ -1132,7 +1131,6 @@
>  					      "div-clk", "phy-div";
>  				#phy-cells = <0>;
>  				ti,hwmods = "pcie2-phy";
> -				id = <2>;
>  				status = "disabled";
>  			};
>  		};
> 
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
