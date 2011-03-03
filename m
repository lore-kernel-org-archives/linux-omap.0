From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v2] OMAP2+: fix incorrect computation of autoidle_mask
Date: Thu, 3 Mar 2011 11:22:09 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1103031121290.10981@utopia.booyaka.com>
References: <1294139013-18737-1-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:54691 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758598Ab1CCSWK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Mar 2011 13:22:10 -0500
In-Reply-To: <1294139013-18737-1-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@vger.kernel.org

Hello Tarun,

On Tue, 4 Jan 2011, Tarun Kanti DebBarma wrote:

> Autoidle is a single bit, TIOCP_CFG[0], setting on OMAP1/2/3/4 platforms.
> In _set_module_autoidle() I am seeing 0x3 value where the mask is computed.
> This should be 0x1.
> 
> v2:
> (1) Modified the subject.
> (2) Modified the description with further specific information.
> 
> Baseline:
> git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
> 
> Tested Info:
> Boot tested on OMAP 1/2/3/4.
> 
> Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
> Acked-by: Rajendra Nayak <rnayak@ti.com>
> Acked-by: Benoit Cousson <b-cousson@ti.com>

Thanks, nice catch.  Queued for 2.6.39.


- Paul

> ---
>  arch/arm/mach-omap2/omap_hwmod.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
> index 5a30658..da49b56 100644
> --- a/arch/arm/mach-omap2/omap_hwmod.c
> +++ b/arch/arm/mach-omap2/omap_hwmod.c
> @@ -373,7 +373,7 @@ static int _set_module_autoidle(struct omap_hwmod *oh, u8 autoidle,
>  	}
>  
>  	autoidle_shift = oh->class->sysc->sysc_fields->autoidle_shift;
> -	autoidle_mask = (0x3 << autoidle_shift);
> +	autoidle_mask = (0x1 << autoidle_shift);
>  
>  	*v &= ~autoidle_mask;
>  	*v |= autoidle << autoidle_shift;
> -- 
> 1.6.0.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


