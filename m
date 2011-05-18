From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH] OMAP3: pm: Boot message is not an error, remove it
Date: Wed, 18 May 2011 16:40:43 +0200
Message-ID: <87wrhors0k.fsf@ti.com>
References: <1305710080-2647-1-git-send-email-premi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:51444 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757283Ab1EROk5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 18 May 2011 10:40:57 -0400
Received: by mail-ww0-f47.google.com with SMTP id 4so1389082wwk.16
        for <linux-omap@vger.kernel.org>; Wed, 18 May 2011 07:40:56 -0700 (PDT)
In-Reply-To: <1305710080-2647-1-git-send-email-premi@ti.com> (Sanjeev Premi's
	message of "Wed, 18 May 2011 14:44:40 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sanjeev Premi <premi@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, jhnikula@gmail.com

Hi Sanjeev,

Sanjeev Premi <premi@ti.com> writes:

> It shows up on the console despite using "silent"
> in the bootargs.
>
> Signed-off-by: Sanjeev Premi <premi@ti.com>
> Cc: jhnikula@gmail.com

Thanks!  Adding to queue for 2.6.40 (branch: for_2.6.40/pm-cleanup)

Kevin

> ---
>
>  v2: Changed the subject.
>      Removed the print altogether
>
>  v1: Convert printk to pr_info
>
>  arch/arm/mach-omap2/pm34xx.c |    2 --
>  1 files changed, 0 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
> index 343027f..ba6c524 100644
> --- a/arch/arm/mach-omap2/pm34xx.c
> +++ b/arch/arm/mach-omap2/pm34xx.c
> @@ -901,8 +901,6 @@ static int __init omap3_pm_init(void)
>  
>  	pm_errata_configure();
>  
> -	printk(KERN_ERR "Power Management for TI OMAP3.\n");
> -
>  	/* XXX prcm_setup_regs needs to be before enabling hw
>  	 * supervised mode for powerdomains */
>  	prcm_setup_regs();
