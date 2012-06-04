From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP4: hwspinlocks_init() should be static
Date: Mon, 4 Jun 2012 00:40:23 -0700
Message-ID: <20120604074022.GX12766@atomide.com>
References: <1336914919-20032-1-git-send-email-ohad@wizery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:21569 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752720Ab2FDHkZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 4 Jun 2012 03:40:25 -0400
Content-Disposition: inline
In-Reply-To: <1336914919-20032-1-git-send-email-ohad@wizery.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Ohad Ben-Cohen <ohad@wizery.com> [120513 06:19]:
> Sparse found out that hwspinlocks_init() wasn't marked static,
> and it should've been.

Looks like this already got fixed by Paul's commit 8c3d4534.

Regards,

Tony
 
> Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
> ---
>  arch/arm/mach-omap2/hwspinlock.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/hwspinlock.c b/arch/arm/mach-omap2/hwspinlock.c
> index 454dfce..8763c85 100644
> --- a/arch/arm/mach-omap2/hwspinlock.c
> +++ b/arch/arm/mach-omap2/hwspinlock.c
> @@ -28,7 +28,7 @@ static struct hwspinlock_pdata omap_hwspinlock_pdata __initdata = {
>  	.base_id = 0,
>  };
>  
> -int __init hwspinlocks_init(void)
> +static int __init hwspinlocks_init(void)
>  {
>  	int retval = 0;
>  	struct omap_hwmod *oh;
> -- 
> 1.7.5.4
> 
