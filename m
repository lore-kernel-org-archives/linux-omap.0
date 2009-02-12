From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 1/1] Export notifier register functions for kernel module building
Date: Thu, 12 Feb 2009 09:48:04 -0800
Message-ID: <878wobpmwb.fsf@deeprootsystems.com>
References: <EAF47CD23C76F840A9E7FCE10091EFAB02A40C1020@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f161.google.com ([209.85.218.161]:34386 "EHLO
	mail-bw0-f161.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755348AbZBLRsM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Feb 2009 12:48:12 -0500
Received: by bwz5 with SMTP id 5so1176533bwz.13
        for <linux-omap@vger.kernel.org>; Thu, 12 Feb 2009 09:48:10 -0800 (PST)
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02A40C1020@dbde02.ent.ti.com> (Ramesh Gupta's message of "Thu\, 12 Feb 2009 14\:50\:56 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gupta, Ramesh" <grgupta@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

"Gupta, Ramesh" <grgupta@ti.com> writes:

> This Patch exports symbols clk_notifier_register/unregister
> function for other kernel modules usage.
>
> Signed-off-by: Ramesh Gupta G <grgupta@ti.com>

Thanks, pushed to PM branch.

Kevin

> ---
>  arch/arm/plat-omap/clock.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/plat-omap/clock.c b/arch/arm/plat-omap/clock.c
> index e0940a1..c8d9e96 100644
> --- a/arch/arm/plat-omap/clock.c
> +++ b/arch/arm/plat-omap/clock.c
> @@ -680,6 +680,7 @@ int clk_notifier_register(struct clk *clk, struct notifier_block *nb)
>  
>  	return r;
>  }
> +EXPORT_SYMBOL(clk_notifier_register);
>  
>  /**
>   * clk_notifier_unregister - remove a clock change notifier
> @@ -735,6 +736,7 @@ int clk_notifier_unregister(struct clk *clk, struct notifier_block *nb)
>  
>  	return r;
>  }
> +EXPORT_SYMBOL(clk_notifier_unregister);
>  
>  
>  
> -- 
> 1.5.3.2
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
