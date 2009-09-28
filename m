From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] arm: omap: iovmm: add missing mutex_unlock
Date: Mon, 28 Sep 2009 09:51:05 -0700
Message-ID: <87ws3j3tdy.fsf@deeprootsystems.com>
References: <1254001039-27976-1-git-send-email-dwalker@fifo99.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f191.google.com ([209.85.222.191]:45014 "EHLO
	mail-pz0-f191.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751482AbZI1QvF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 28 Sep 2009 12:51:05 -0400
Received: by pzk29 with SMTP id 29so2530591pzk.33
        for <linux-omap@vger.kernel.org>; Mon, 28 Sep 2009 09:51:08 -0700 (PDT)
In-Reply-To: <1254001039-27976-1-git-send-email-dwalker@fifo99.com> (Daniel Walker's message of "Sat\, 26 Sep 2009 14\:37\:19 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Daniel Walker <dwalker@fifo99.com>
Cc: linux-omap@vger.kernel.org, Julia Lawall <julia@diku.dk>, Tony Lindgren <tony@atomide.com>

Daniel Walker <dwalker@fifo99.com> writes:

> I was using Coccinelle with the mutex_unlock semantic patch, and it
> unconvered this problem. It appears to be a valid missing unlock issue.
> This change should correct it by moving the unlock below the label.
>
> This patch is against the mainline kernel.
>
> Cc: Julia Lawall <julia@diku.dk>
> Cc: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Daniel Walker <dwalker@fifo99.com>

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>

> ---
>  arch/arm/plat-omap/iovmm.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/plat-omap/iovmm.c b/arch/arm/plat-omap/iovmm.c
> index 57f7122..9b6cb90 100644
> --- a/arch/arm/plat-omap/iovmm.c
> +++ b/arch/arm/plat-omap/iovmm.c
> @@ -363,8 +363,9 @@ void *da_to_va(struct iommu *obj, u32 da)
>  		goto out;
>  	}
>  	va = area->va;
> -	mutex_unlock(&obj->mmap_lock);
>  out:
> +	mutex_unlock(&obj->mmap_lock);
> +
>  	return va;
>  }
>  EXPORT_SYMBOL_GPL(da_to_va);
> -- 
> 1.6.0.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
