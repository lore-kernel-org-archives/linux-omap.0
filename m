From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] Fix compiler warnings in smartreflex.c
Date: Fri, 17 Oct 2008 15:31:13 -0700
Message-ID: <20081017223112.GI18573@atomide.com>
References: <1223646662-22521-1-git-send-email-premi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:65244 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752855AbYJQWbO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 Oct 2008 18:31:14 -0400
Content-Disposition: inline
In-Reply-To: <1223646662-22521-1-git-send-email-premi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sanjeev Premi <premi@ti.com>
Cc: linux-omap@vger.kernel.org

* Sanjeev Premi <premi@ti.com> [081010 06:51]:
> Fix these compiler warnings:
> smartreflex.c:126: warning: initialization makes integer from pointer without a cast
> smartreflex.c:134: warning: initialization makes integer from pointer without a cast
> 
> Refreshed after updates from Felipe.

Pushing.

Tony

> Signed-off-by: Sanjeev Premi <premi@ti.com>
> ---
>  arch/arm/mach-omap2/smartreflex.c |   14 +++++++-------
>  1 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
> index e54c0fb..33f604d 100644
> --- a/arch/arm/mach-omap2/smartreflex.c
> +++ b/arch/arm/mach-omap2/smartreflex.c
> @@ -49,8 +49,8 @@ struct omap_sr {
>  	u32 		opp1_nvalue, opp2_nvalue, opp3_nvalue, opp4_nvalue;
>  	u32		opp5_nvalue;
>  	u32		senp_mod, senn_mod;
> -	u32		srbase_addr;
> -	u32		vpbase_addr;
> +	void __iomem	*srbase_addr;
> +	void __iomem	*vpbase_addr;
>  };
>  
>  /* Custom clocks to enable SR specific enable/disable functions. */
> @@ -60,15 +60,15 @@ struct sr_custom_clk {
>  	struct omap_sr 	*sr;
>  };
>  
> -#define SR_REGADDR(offs)     (__force void __iomem *)(sr->srbase_addr + offset)
> +#define SR_REGADDR(offs)	(sr->srbase_addr + offset)
>  
> -static inline void sr_write_reg(struct omap_sr *sr, int offset, u32 value)
> +static inline void sr_write_reg(struct omap_sr *sr, unsigned offset, u32 value)
>  {
>  	__raw_writel(value, SR_REGADDR(offset));
>  }
>  
> -static inline void sr_modify_reg(struct omap_sr *sr, int offset, u32 mask,
> -								u32 value)
> +static inline void sr_modify_reg(struct omap_sr *sr, unsigned offset, u32 mask,
> +					u32 value)
>  {
>  	u32 reg_val;
>  
> @@ -79,7 +79,7 @@ static inline void sr_modify_reg(struct omap_sr *sr, int offset, u32 mask,
>  	__raw_writel(reg_val, SR_REGADDR(offset));
>  }
>  
> -static inline u32 sr_read_reg(struct omap_sr *sr, int offset)
> +static inline u32 sr_read_reg(struct omap_sr *sr, unsigned offset)
>  {
>  	return __raw_readl(SR_REGADDR(offset));
>  }
> -- 
> 1.5.6
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
