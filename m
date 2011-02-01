From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] arm: mach-omap2: mux: free allocated memory on error
 exit
Date: Tue, 1 Feb 2011 15:52:17 -0800
Message-ID: <20110201235217.GJ3358@atomide.com>
References: <1296226255-5694-1-git-send-email-aaro.koskinen@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:10905 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751307Ab1BAXwh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Feb 2011 18:52:37 -0500
Content-Disposition: inline
In-Reply-To: <1296226255-5694-1-git-send-email-aaro.koskinen@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@nokia.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

* Aaro Koskinen <aaro.koskinen@nokia.com> [110128 06:47]:
> Free allocated memory on error exit.
> 
> Signed-off-by: Aaro Koskinen <aaro.koskinen@nokia.com>
> ---
>  arch/arm/mach-omap2/mux.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/mux.c b/arch/arm/mach-omap2/mux.c
> index df8d2f2..18aea0c 100644
> --- a/arch/arm/mach-omap2/mux.c
> +++ b/arch/arm/mach-omap2/mux.c
> @@ -1000,6 +1000,7 @@ int __init omap_mux_init(const char *name, u32 flags,
>  	if (!partition->base) {
>  		pr_err("%s: Could not ioremap mux partition at 0x%08x\n",
>  			__func__, partition->phys);
> +		kfree(partition);
>  		return -ENODEV;
>  	}

Thanks, adding into devel-fixes for the -rc cycle.

Tony
