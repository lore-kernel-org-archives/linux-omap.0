From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v3 5/5] ARM: OMAP3LOGIC: Adding low-level debug support
Date: Fri, 24 Sep 2010 15:59:58 -0700
Message-ID: <20100924225957.GM4211@atomide.com>
References: <1285358338-3403-1-git-send-email-tim.nordell@logicpd.com>
 <1285358338-3403-6-git-send-email-tim.nordell@logicpd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1285358338-3403-6-git-send-email-tim.nordell@logicpd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tim Nordell <tim.nordell@logicpd.com>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Tim Nordell <tim.nordell@logicpd.com> [100924 13:08]:
> Defined UART1 as the low-level debug port for both the
> omap3530_lv_som board and the omap3_torpedo board.

Ah the DEBUG_LL support is here, please merge this one into
the first patch.

Thanks,

Tony
 
> Signed-off-by: Tim Nordell <tim.nordell@logicpd.com>
> ---
>  arch/arm/plat-omap/include/plat/uncompress.h |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/plat-omap/include/plat/uncompress.h b/arch/arm/plat-omap/include/plat/uncompress.h
> index ddf723b..ff9f3a2 100644
> --- a/arch/arm/plat-omap/include/plat/uncompress.h
> +++ b/arch/arm/plat-omap/include/plat/uncompress.h
> @@ -139,6 +139,8 @@ static inline void __arch_decomp_setup(unsigned long arch_id)
>  		DEBUG_LL_OMAP2(1, omap3evm);
>  		DEBUG_LL_OMAP3(1, omap_3430sdp);
>  		DEBUG_LL_OMAP3(1, omap_3630sdp);
> +		DEBUG_LL_OMAP3(1, omap3530_lv_som);
> +		DEBUG_LL_OMAP3(1, omap3_torpedo);
>  
>  		/* omap3 based boards using UART3 */
>  		DEBUG_LL_OMAP3(3, cm_t35);
> -- 
> 1.7.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
