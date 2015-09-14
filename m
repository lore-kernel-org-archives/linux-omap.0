From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH] ARM: dts: DRA7: fix a typo in ethernet
Date: Mon, 14 Sep 2015 10:17:18 -0700
Message-ID: <20150914171718.GP4215@atomide.com>
References: <1440529069-7882-1-git-send-email-vishalm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1440529069-7882-1-git-send-email-vishalm-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Vishal Mahaveer <vishalm-l0cyMroinI0@public.gmane.org>
Cc: =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mugunthan V N <mugunthanvnm-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Vishal Mahaveer <vishalm-l0cyMroinI0@public.gmane.org> [150825 12:01]:
> Register address in name of the node is wrong
> 
> Signed-off-by: Vishal Mahaveer <vishalm-l0cyMroinI0@public.gmane.org>
> Acked-by: Mugunthan V N <mugunthanvnm-l0cyMroinI0@public.gmane.org>

Applying into omap-for-v4.3/fixes thanks.

Tony

> ---
>  arch/arm/boot/dts/dra7.dtsi |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
> index 1e29ccf..9a20d46 100644
> --- a/arch/arm/boot/dts/dra7.dtsi
> +++ b/arch/arm/boot/dts/dra7.dtsi
> @@ -1398,7 +1398,7 @@
>  			ti,irqs-safe-map = <0>;
>  		};
>  
> -		mac: ethernet@4a100000 {
> +		mac: ethernet@48484000 {
>  			compatible = "ti,cpsw";
>  			ti,hwmods = "gmac";
>  			clocks = <&dpll_gmac_ck>, <&gmac_gmii_ref_clk_div>;
> -- 
> 1.7.4.1
> 
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
