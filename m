From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH] omap3: boot message is not an error
Date: Tue, 17 May 2011 19:33:41 +0200
Message-ID: <1305653621.2694.4.camel@vence>
References: <1305644565-26233-1-git-send-email-premi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:35029 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755703Ab1EQRfQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 17 May 2011 13:35:16 -0400
Received: by mail-ww0-f45.google.com with SMTP id 36so691867wwi.2
        for <linux-omap@vger.kernel.org>; Tue, 17 May 2011 10:35:14 -0700 (PDT)
In-Reply-To: <1305644565-26233-1-git-send-email-premi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sanjeev Premi <premi@ti.com>
Cc: linux-omap@vger.kernel.org

Hi Sanjeev,

On Tue, 2011-05-17 at 20:32 +0530, Sanjeev Premi wrote:
> With current level, it shows up on the console
> despite using 'silent' in bootargs.
> 
> Signed-off-by: Sanjeev Premi <premi@ti.com>
> ---
> 
>  1) Couldn't find better text on commit message.
>     Any suggestions?
> 
>  2) Though pm34xx.x is changed, the change itself
>     is no related to power management. Hence, did
>     annotate "pm:"

Well, it's a change to PM core code, so PM prefix is fine.  How about:

OMAP3: PM: boot message is not an error, use pr_info

Also, please Cc linux-arm-kernel, and I will queue this fix for 2.6.40.

Minor comment below..

>  arch/arm/mach-omap2/pm34xx.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
> index 343027f..7584ba8 100644
> --- a/arch/arm/mach-omap2/pm34xx.c
> +++ b/arch/arm/mach-omap2/pm34xx.c
> @@ -901,7 +901,7 @@ static int __init omap3_pm_init(void)
>  
>  	pm_errata_configure();
>  
> -	printk(KERN_ERR "Power Management for TI OMAP3.\n");
> +	pr_info ("Power Management for TI OMAP3.\n");

Drop space before the opening '('.

>  	/* XXX prcm_setup_regs needs to be before enabling hw
>  	 * supervised mode for powerdomains */

Kevin


