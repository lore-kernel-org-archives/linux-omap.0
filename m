From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] config: arm: omap2: remove PROVE_LOCKING from defconfig
Date: Thu, 8 Nov 2018 08:59:58 -0800
Message-ID: <20181108165958.GK56134@atomide.com>
References: <CGME20181009153624eucas1p2ad30aea33ad1c869f11bd9ca1156d9af@eucas1p2.samsung.com>
 <20181009153624eucas1p2ad30aea33ad1c869f11bd9ca1156d9af~b_rxQW8J90311703117eucas1p2U@eucas1p2.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181009153624eucas1p2ad30aea33ad1c869f11bd9ca1156d9af~b_rxQW8J90311703117eucas1p2U@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lukasz Luba <l.luba@partner.samsung.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi,

* Lukasz Luba <l.luba@partner.samsung.com> [181009 08:36]:
> PROVE_LOCKING enables LOCKDEP, which causes big overhead on cache and
> bus transactions.
> 
> On some ARM big.LITTLE architecutres (Exynos 5433) the overhead is really big.
> The overhead can be measures using hackbench which will speed up
> by x3 times (11sec -> 3.4sec).
> When you check transaction on cache or buses, the results are way higher
> than normal for the same hackbench test:
> L1d cache invalidations: 26mln vs 4mln
> L2u cache invalidations: 42mln vs 12mln
> bus cyc/access: 30cyc/access vs. 20cyc/access
> context switch is x3 times cheaper
> 
> Enable this option only when you have some locking issue to investigate.

I'm all for this, but this disables also other less intrusive
debug options. It used to be that we'd get locking issues merged
into drivers and I think that's how it originally got enabled.

So we should take a look which ones we can or want to keep.
Or just disable CONFIG_DEBUG completely.

For distros, that's multi_v7_defconfig nowadays for most part
so I think most people using omap2plus_defconfig are developers
working on various devices.

Regards,

Tony


> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
> ---
>  arch/arm/configs/omap2plus_defconfig | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
> index 6491419..1bbfd76 100644
> --- a/arch/arm/configs/omap2plus_defconfig
> +++ b/arch/arm/configs/omap2plus_defconfig
> @@ -536,7 +536,6 @@ CONFIG_DEBUG_INFO_SPLIT=y
>  CONFIG_DEBUG_INFO_DWARF4=y
>  CONFIG_MAGIC_SYSRQ=y
>  CONFIG_SCHEDSTATS=y
> -CONFIG_PROVE_LOCKING=y
>  # CONFIG_DEBUG_BUGVERBOSE is not set
>  CONFIG_SECURITY=y
>  CONFIG_CRYPTO_MICHAEL_MIC=y
> -- 
> 2.7.4
> 
