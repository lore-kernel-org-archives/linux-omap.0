From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/4] omap1: remove duplicated #include
Date: Tue, 1 Feb 2011 15:53:28 -0800
Message-ID: <20110201235328.GL3358@atomide.com>
References: <1296223478-728-1-git-send-email-weiyi.huang@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:12699 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751266Ab1BAXxo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Feb 2011 18:53:44 -0500
Content-Disposition: inline
In-Reply-To: <1296223478-728-1-git-send-email-weiyi.huang@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Huang Weiyi <weiyi.huang@gmail.com>
Cc: linux-omap@vger.kernel.org

* Huang Weiyi <weiyi.huang@gmail.com> [110128 06:03]:
> Remove duplicated #include('s) in
>   arch/arm/mach-omap1/time.c
> 
> Signed-off-by: Huang Weiyi <weiyi.huang@gmail.com>
> ---
>  arch/arm/mach-omap1/time.c |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-omap1/time.c b/arch/arm/mach-omap1/time.c
> index f83fc33..6885d2f 100644
> --- a/arch/arm/mach-omap1/time.c
> +++ b/arch/arm/mach-omap1/time.c
> @@ -44,7 +44,6 @@
>  #include <linux/clocksource.h>
>  #include <linux/clockchips.h>
>  #include <linux/io.h>
> -#include <linux/sched.h>
>  
>  #include <asm/system.h>
>  #include <mach/hardware.h>

Thanks queuing this as a fix for the -rc cycle.

Tony
