From: Tony Lindgren <tony@atomide.com>
Subject: Re: [net-next PATCH 3/3] ARM: dts: am33xx: update cpsw compatible
Date: Thu, 13 Aug 2015 02:56:14 -0700
Message-ID: <20150813095613.GC4215@atomide.com>
References: <1439373175-8650-1-git-send-email-mugunthanvnm@ti.com>
 <1439373175-8650-4-git-send-email-mugunthanvnm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1439373175-8650-4-git-send-email-mugunthanvnm@ti.com>
Sender: netdev-owner@vger.kernel.org
To: Mugunthan V N <mugunthanvnm@ti.com>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, alex.aring@gmail.com
List-Id: linux-omap@vger.kernel.org

* Mugunthan V N <mugunthanvnm@ti.com> [150812 02:56]:
> CPSW driver has been updated with compatibles for enabling errata
> workarounds. So updating cpsw compatibles.
> 
> Signed-off-by: Mugunthan V N <mugunthanvnm@ti.com>

This too:

Acked-by: Tony Lindgren <tony@atomide.com>

> ---
>  arch/arm/boot/dts/am33xx.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
> index 21fcc44..8b59c86 100644
> --- a/arch/arm/boot/dts/am33xx.dtsi
> +++ b/arch/arm/boot/dts/am33xx.dtsi
> @@ -700,7 +700,7 @@
>  		};
>  
>  		mac: ethernet@4a100000 {
> -			compatible = "ti,cpsw";
> +			compatible = "ti,am335x-cpsw","ti,cpsw";
>  			ti,hwmods = "cpgmac0";
>  			clocks = <&cpsw_125mhz_gclk>, <&cpsw_cpts_rft_clk>;
>  			clock-names = "fck", "cpts";
> -- 
> 2.5.0.234.gefc8a62
> 
