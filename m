From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 1/1] OMAP3:WDT:Enable clk in probe, trigger timer reload
Date: Fri, 12 Jun 2009 09:13:13 -0700
Message-ID: <87my8dig6e.fsf@deeprootsystems.com>
References: <1244822737-20446-1-git-send-email-ubh@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.168]:29822 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754532AbZFLQNP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 12 Jun 2009 12:13:15 -0400
Received: by wf-out-1314.google.com with SMTP id 26so882588wfd.4
        for <linux-omap@vger.kernel.org>; Fri, 12 Jun 2009 09:13:16 -0700 (PDT)
In-Reply-To: <1244822737-20446-1-git-send-email-ubh@ti.com> (Ulrik Bech Hald's message of "Fri\, 12 Jun 2009 11\:05\:37 -0500")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ulrik Bech Hald <ubh@ti.com>
Cc: linux-omap@vger.kernel.org

Ulrik Bech Hald <ubh@ti.com> writes:

> This patch contains two bugfixes:
>
> 1)In omap_wdt_probe() the watchdog is reset and disabled. This
> requires register access and the clks needs to be enabled temporarily
>
> 2)In omap_wdt_open() the timer register needs to be reloaded
> to trigger a new timer value (the default of 60s)
>
> Signed-off-by: Ulrik Bech Hald <ubh@ti.com>

Can you change the subject slightly to something like:

  watchdog: OMAP fixes: enable clock in probe, trigger timer reload

Also add which OMAP platforms you have tested on since this affects
OMAP2, OMAP3 and presuably OMAP4.

After that, you can add

Reviewed-by: Kevin Hilman <khilman@ti.deeprootsystems.com>

And sent to watchdog maintiner, and CC linux-omap, here's excerpt from
MAINTAINERS:

WATCHDOG DEVICE DRIVERS
P:	Wim Van Sebroeck
M:	wim@iguana.be
T:	git git://git.kernel.org/pub/scm/linux/kernel/git/wim/linux-2.6-watchdog.git
S:	Maintained
F:	Documentation/watchdog/
F:	drivers/watchdog/
F:	include/linux/watchdog.h

> ---
>  drivers/watchdog/omap_wdt.c |    7 +++++++
>  1 files changed, 7 insertions(+), 0 deletions(-)
>  mode change 100644 => 100755 drivers/watchdog/omap_wdt.c
>
> diff --git a/drivers/watchdog/omap_wdt.c b/drivers/watchdog/omap_wdt.c
> old mode 100644
> new mode 100755
> index f271385..3ed571a
> --- a/drivers/watchdog/omap_wdt.c
> +++ b/drivers/watchdog/omap_wdt.c
> @@ -159,6 +159,7 @@ static int omap_wdt_open(struct inode *inode, struct file *file)
>  	file->private_data = (void *) wdev;
>  
>  	omap_wdt_set_timeout(wdev);
> +	omap_wdt_ping(wdev); /* trigger loading of new timeout value */
>  	omap_wdt_enable(wdev);
>  
>  	return nonseekable_open(inode, file);
> @@ -313,6 +314,9 @@ static int __devinit omap_wdt_probe(struct platform_device *pdev)
>  
>  	platform_set_drvdata(pdev, wdev);
>  
> +	clk_enable(wdev->ick);
> +	clk_enable(wdev->fck);
> +
>  	omap_wdt_disable(wdev);
>  	omap_wdt_adjust_timeout(timer_margin);
>  
> @@ -332,6 +336,9 @@ static int __devinit omap_wdt_probe(struct platform_device *pdev)
>  	/* autogate OCP interface clock */
>  	__raw_writel(0x01, wdev->base + OMAP_WATCHDOG_SYS_CONFIG);
>  
> +	clk_disable(wdev->ick);
> +	clk_disable(wdev->fck);
> +
>  	omap_wdt_dev = pdev;
>  
>  	return 0;
> -- 
> 1.5.4.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
