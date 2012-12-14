From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAP2: Fix a typo - replace regist with register.
Date: Fri, 14 Dec 2012 10:52:13 -0800
Message-ID: <20121214185213.GI4989@atomide.com>
References: <201211021445.qA2EjjI5005838@94.43.138.210.xn.2iij.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:23424 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932106Ab2LNSwP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 Dec 2012 13:52:15 -0500
Content-Disposition: inline
In-Reply-To: <201211021445.qA2EjjI5005838@94.43.138.210.xn.2iij.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: YOSHIFUJI Hideaki <yoshfuji@linux-ipv6.org>
Cc: linux-omap@vger.kernel.org

* YOSHIFUJI Hideaki <yoshfuji@linux-ipv6.org> [121102 07:57]:
> Signed-off-by: YOSHIFUJI Hideaki <yoshfuji@linux-ipv6.org>
> ---
>  arch/arm/mach-omap2/control.h |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-omap2/control.h b/arch/arm/mach-omap2/control.h
> index a89e825..5e6886e 100644
> --- a/arch/arm/mach-omap2/control.h
> +++ b/arch/arm/mach-omap2/control.h
> @@ -233,7 +233,7 @@
>  #define OMAP343X_PADCONF_ETK_D14	OMAP343X_PADCONF_ETK(16)
>  #define OMAP343X_PADCONF_ETK_D15	OMAP343X_PADCONF_ETK(17)
>  
> -/* 34xx GENERAL_WKUP regist offsets */
> +/* 34xx GENERAL_WKUP register offsets */
>  #define OMAP343X_CONTROL_WKUP_DEBOBSMUX(i) (OMAP343X_CONTROL_GENERAL_WKUP + \
>  						0x008 + (i))
>  #define OMAP343X_CONTROL_WKUP_DEBOBS0 (OMAP343X_CONTROL_GENERAL_WKUP + 0x008)

Thanks applying into omap-for-v3.8/fixes-for-merge-window
with the subject line also as the description.

Tony
