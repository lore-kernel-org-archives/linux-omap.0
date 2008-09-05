From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/1] Use pmd_table() MACRO for unmap_area_sections()
Date: Fri, 5 Sep 2008 10:21:33 -0700
Message-ID: <20080905172133.GM24202@atomide.com>
References: <1220420188-22518-1-git-send-email-Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:58550 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751167AbYIERVf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Sep 2008 13:21:35 -0400
Content-Disposition: inline
In-Reply-To: <1220420188-22518-1-git-send-email-Hiroshi.DOYU@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: linux-omap@vger.kernel.org

* Hiroshi DOYU <Hiroshi.DOYU@nokia.com> [080902 22:37]:
> Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

This should be sent to linux-arm-kernel list.

Tony

> ---
>  arch/arm/mm/ioremap.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mm/ioremap.c b/arch/arm/mm/ioremap.c
> index b81dbf9..9ad7614 100644
> --- a/arch/arm/mm/ioremap.c
> +++ b/arch/arm/mm/ioremap.c
> @@ -161,7 +161,7 @@ static void unmap_area_sections(unsigned long virt, unsigned long size)
>  			/*
>  			 * Free the page table, if there was one.
>  			 */
> -			if ((pmd_val(pmd) & PMD_TYPE_MASK) == PMD_TYPE_TABLE)
> +			if ((pmd_table(pmd))
>  				pte_free_kernel(&init_mm, pmd_page_vaddr(pmd));
>  		}
>  
> -- 
> 1.5.5.1.357.g1af8b
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
