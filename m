From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP3+: DPLL: stop reparenting to same parent if
 already done
Date: Thu, 13 Feb 2014 15:13:17 -0800
Message-ID: <20140213231317.GN28216@atomide.com>
References: <1391591048-19433-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1391591048-19433-1-git-send-email-nm@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Tero Kristo <t-kristo@ti.com>, Paul Walmsley <paul@pwsan.com>
List-Id: linux-omap@vger.kernel.org

* Nishanth Menon <nm@ti.com> [140205 01:06]:
> omap3_noncore_dpll_set_rate forces a reparent to the same clk_ref
> for every call that takes place. This is an can be done only if a change
> is detected.
> 
> Signed-off-by: Nishanth Menon <nm@ti.com>

Would like to see acks on this too before applying.

Tony

> ---
>  arch/arm/mach-omap2/dpll3xxx.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-omap2/dpll3xxx.c b/arch/arm/mach-omap2/dpll3xxx.c
> index 3185ced..d9bcbf7 100644
> --- a/arch/arm/mach-omap2/dpll3xxx.c
> +++ b/arch/arm/mach-omap2/dpll3xxx.c
> @@ -525,7 +525,7 @@ int omap3_noncore_dpll_set_rate(struct clk_hw *hw, unsigned long rate,
>  	* stuff is inherited for free
>  	*/
>  
> -	if (!ret)
> +	if (!ret && clk_get_parent(hw->clk) != new_parent)
>  		__clk_reparent(hw->clk, new_parent);
>  
>  	return 0;
> -- 
> 1.7.9.5
> 
