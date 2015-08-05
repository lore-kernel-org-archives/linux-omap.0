From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v3 3/3] ARM: dts: dra7: Add scm_conf@1c04 node
Date: Wed, 5 Aug 2015 02:42:42 -0700
Message-ID: <20150805094241.GW16878@atomide.com>
References: <1437992850-6008-1-git-send-email-rogerq@ti.com>
 <1437992850-6008-4-git-send-email-rogerq@ti.com>
 <55C08176.4000107@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <55C08176.4000107@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: kishon@ti.com, nm@ti.com, nsekhar@ti.com, balbi@ti.com, grygorii.strashko@ti.com, t-kristo@ti.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Roger Quadros <rogerq@ti.com> [150804 02:13]:
> This region contains CTRL_CORE_SMA_SW2..9 registers which
> are not specific to any domain and can be reasonably
> accessed via syscon driver.
> 
> Signed-off-by: Roger Quadros <rogerq@ti.com>

Applying all three into omap-for-v4.3/dt thanks.

Tony

> ---
> 
> v3: removed #address/size-cells.
> 
>  arch/arm/boot/dts/dra7.dtsi | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
> index 913032b..2cab476 100644
> --- a/arch/arm/boot/dts/dra7.dtsi
> +++ b/arch/arm/boot/dts/dra7.dtsi
> @@ -149,6 +149,11 @@
>  					pinctrl-single,register-width = <32>;
>  					pinctrl-single,function-mask = <0x3fffffff>;
>  				};
> +
> +				scm_conf1: scm_conf@1c04 {
> +					compatible = "syscon";
> +					reg = <0x1c04 0x0020>;
> +				};
>  			};
>  
>  			cm_core_aon: cm_core_aon@5000 {
> -- 
> 2.1.4
> 
> 
