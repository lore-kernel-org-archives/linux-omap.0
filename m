From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAP4: fix return value of omap4_l3_init
Date: Tue, 31 May 2011 04:52:04 -0700
Message-ID: <20110531115204.GA11352@atomide.com>
References: <1304787527-8314-1-git-send-email-rabin@rab.in>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:63399 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753898Ab1EaLwG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 31 May 2011 07:52:06 -0400
Content-Disposition: inline
In-Reply-To: <1304787527-8314-1-git-send-email-rabin@rab.in>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rabin Vincent <rabin@rab.in>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Rabin Vincent <rabin@rab.in> [110507 09:54]:
> Don't PTR_ERR() a non-error pointer:
> 
>  initcall omap4_l3_init+0x0/0xdc returned -544980480 after 0 usecs
>  initcall omap4_l3_init+0x0/0xdc returned with error code -544980480

Adding to fixes thanks.

Tony
 
> Signed-off-by: Rabin Vincent <rabin@rab.in>
> ---
>  arch/arm/mach-omap2/devices.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
> index 7b85585..5b8ca68 100644
> --- a/arch/arm/mach-omap2/devices.c
> +++ b/arch/arm/mach-omap2/devices.c
> @@ -97,7 +97,7 @@ static int __init omap4_l3_init(void)
>  
>  	WARN(IS_ERR(od), "could not build omap_device for %s\n", oh_name);
>  
> -	return PTR_ERR(od);
> +	return IS_ERR(od) ? PTR_ERR(od) : 0;
>  }
>  postcore_initcall(omap4_l3_init);
>  
> -- 
> 1.7.4.1
> 
