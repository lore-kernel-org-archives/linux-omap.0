From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RESEND] [PATCH 3.6.0- 5/6] ARM/omap: use
 module_platform_driver macro
Date: Fri, 14 Dec 2012 10:50:34 -0800
Message-ID: <20121214185033.GH4989@atomide.com>
References: <1350025894-30625-1-git-send-email-srinivas.kandagatla@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:11534 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756687Ab2LNSun (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 Dec 2012 13:50:43 -0500
Content-Disposition: inline
In-Reply-To: <1350025894-30625-1-git-send-email-srinivas.kandagatla@st.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Srinivas KANDAGATLA <srinivas.kandagatla@st.com>
Cc: paul@pwsan.com, rnayak@ti.com, Hiroshi.DOYU@nokia.com, linux-omap@vger.kernel.org, tarun.kanti@ti.com, thara@ti.com, grinberg@compulab.co.il, eric.y.miao@gmail.com, linux-arm-kernel@lists.infradead.org, juha.yrjola@nokia.com, linux@arm.linux.org.uk, haojian.zhuang@gmail.com, dsaxena@plexity.net, mpm@selenic.com, herbert@gondor.apana.org.au

* Srinivas KANDAGATLA <srinivas.kandagatla@st.com> [121012 00:14]:
> From: Srinivas Kandagatla <srinivas.kandagatla@st.com>
> 
> This patch removes some code duplication by using
> module_platform_driver.

Thanks, applying this one into omap-for-v3.8/fixes-for-merge-window.
Skipping the mailbox ones as they are getting moved to live
under drivers. And the rng one should go via the rng maintainers.

Regards,

Tony
 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@st.com>
> ---
>  arch/arm/plat-omap/dmtimer.c |   13 +------------
>  1 files changed, 1 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
> index 938b50a..c89fc6a 100644
> --- a/arch/arm/plat-omap/dmtimer.c
> +++ b/arch/arm/plat-omap/dmtimer.c
> @@ -786,19 +786,8 @@ static struct platform_driver omap_dm_timer_driver = {
>  	},
>  };
>  
> -static int __init omap_dm_timer_driver_init(void)
> -{
> -	return platform_driver_register(&omap_dm_timer_driver);
> -}
> -
> -static void __exit omap_dm_timer_driver_exit(void)
> -{
> -	platform_driver_unregister(&omap_dm_timer_driver);
> -}
> -
>  early_platform_init("earlytimer", &omap_dm_timer_driver);
> -module_init(omap_dm_timer_driver_init);
> -module_exit(omap_dm_timer_driver_exit);
> +module_platform_driver(omap_dm_timer_driver);
>  
>  MODULE_DESCRIPTION("OMAP Dual-Mode Timer Driver");
>  MODULE_LICENSE("GPL");
> -- 
> 1.7.0.4
> 
