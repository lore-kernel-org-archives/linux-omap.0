From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] OMAP3: PM: Fix for Silicon bug on Context Restore on OMAP3430
Date: Mon, 05 Oct 2009 10:04:33 -0700
Message-ID: <87ljjpzs9p.fsf@deeprootsystems.com>
References: <1254741761-31546-1-git-send-email-y>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f188.google.com ([209.85.222.188]:61724 "EHLO
	mail-pz0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754114AbZJERFt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 5 Oct 2009 13:05:49 -0400
Received: by pzk26 with SMTP id 26so2923518pzk.4
        for <linux-omap@vger.kernel.org>; Mon, 05 Oct 2009 10:04:36 -0700 (PDT)
In-Reply-To: <1254741761-31546-1-git-send-email-y> (y.'s message of "Mon\,  5 Oct 2009 16\:52\:41 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: y@india.ti.com
Cc: linux-omap@vger.kernel.org, Shweta Gulati <shweta.gulati@ti.com>

y@india.ti.com writes:

> From: Shweta Gulati <shweta.gulati@ti.com>

Please add descriptive changelog, including Erratta number and
summary of the bug.

> Signed-off-by: Shweta Gulati <shweta.gulati@ti.com>
> ---
>  arch/arm/mach-omap2/pm34xx.c |    6 ++++++
>  1 files changed, 6 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
> index a9eda25..38f4781 100644
> --- a/arch/arm/mach-omap2/pm34xx.c
> +++ b/arch/arm/mach-omap2/pm34xx.c
> @@ -140,6 +140,12 @@ static void omap3_core_save_context(void)
>  	omap_ctrl_readl(OMAP343X_CONTROL_PADCONF_OFF);
>  	control_padconf_off |= START_PADCONF_SAVE;
>  	omap_ctrl_writel(control_padconf_off, OMAP343X_CONTROL_PADCONF_OFF);
> +	/* Due to Silicon Bug on context restore it is found
> +	 * that the CONTROL_PAD_CONF_ETK14 register is not saved into
> +	 * scratch pad memory sometimes. To rectify it delay acess by Mpu
> +	 * for 300us for scm to finish saving task
> +	 */
> +	udelay(300);

Why 300 usecs?
Is ETK14 the only register not saved?

>  	/* wait for the save to complete */
>  	while (!omap_ctrl_readl(OMAP343X_CONTROL_GENERAL_PURPOSE_STATUS)
>  			& PADCONF_SAVE_DONE)

And please describe why this loop doesn't work.

Kevin


