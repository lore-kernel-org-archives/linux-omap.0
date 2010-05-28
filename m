From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] omap: Fix build break with omap3_defconfig
Date: Fri, 28 May 2010 11:01:38 -0700
Message-ID: <87typrdhx9.fsf@deeprootsystems.com>
References: <1275062022-15067-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f204.google.com ([209.85.222.204]:56725 "EHLO
	mail-pz0-f204.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752930Ab0E1SBm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 28 May 2010 14:01:42 -0400
Received: by pzk42 with SMTP id 42so707890pzk.4
        for <linux-omap@vger.kernel.org>; Fri, 28 May 2010 11:01:42 -0700 (PDT)
In-Reply-To: <1275062022-15067-1-git-send-email-santosh.shilimkar@ti.com> (Santosh Shilimkar's message of "Fri\, 28 May 2010 21\:23\:42 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org

Santosh Shilimkar <santosh.shilimkar@ti.com> writes:

> With latest linus's tip omap3_defconfig is broken.

This subject/shortlog is not terribly useful for git history.  it
should say something like

OMAP: Stalker board: update usage of GPIO debounce API

or something like that.  The changelog should summarize that this
API changed (or was removed) in mainline and the previous change
that updated this API missed this board etc...

All of this can be deduced from reading the current patch and changelog,
but it's better to summarize it in the changelog.

Thanks,

Kevin

> From the commit 8feb337475aaf, board-omap3stalker.c seems to
> be missed out.
>
>  LD      init/built-in.o
>   LD      .tmp_vmlinux1
> arch/arm/mach-omap2/built-in.o: In function `ads7846_dev_init':
> linux-2.6/arch/arm/mach-omap2/board-omap3stalker.c:542: undefined reference to `omap_set_gpio_debounce'
> linux-2.6/arch/arm/mach-omap2/board-omap3stalker.c:543: undefined reference to `omap_set_gpio_debounce_time'
> make: *** [.tmp_vmlinux1] Error 1
>
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> ---
>  arch/arm/mach-omap2/board-omap3stalker.c |    4 +---
>  1 files changed, 1 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/board-omap3stalker.c b/arch/arm/mach-omap2/board-omap3stalker.c
> index f848ba8..a04cffd 100644
> --- a/arch/arm/mach-omap2/board-omap3stalker.c
> +++ b/arch/arm/mach-omap2/board-omap3stalker.c
> @@ -538,9 +538,7 @@ static void ads7846_dev_init(void)
>  		printk(KERN_ERR "can't get ads7846 pen down GPIO\n");
>  
>  	gpio_direction_input(OMAP3_STALKER_TS_GPIO);
> -
> -	omap_set_gpio_debounce(OMAP3_STALKER_TS_GPIO, 1);
> -	omap_set_gpio_debounce_time(OMAP3_STALKER_TS_GPIO, 0xa);
> +	gpio_set_debounce(OMAP3_STALKER_TS_GPIO, 310);
>  }
>  
>  static int ads7846_get_pendown_state(void)
> -- 
> 1.6.0.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
