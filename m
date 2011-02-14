From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH] omap: dmtimer: Enable autoidle
Date: Mon, 14 Feb 2011 15:28:56 -0800
Message-ID: <87oc6exkjr.fsf@ti.com>
References: <1297704375-25873-1-git-send-email-tero.kristo@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:52626 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751217Ab1BNX3F (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 14 Feb 2011 18:29:05 -0500
Received: by mail-yw0-f43.google.com with SMTP id 5so2322364yws.30
        for <linux-omap@vger.kernel.org>; Mon, 14 Feb 2011 15:29:04 -0800 (PST)
In-Reply-To: <1297704375-25873-1-git-send-email-tero.kristo@nokia.com> (Tero
	Kristo's message of "Mon, 14 Feb 2011 19:26:15 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <tero.kristo@nokia.com>
Cc: linux-omap@vger.kernel.org

Tero Kristo <tero.kristo@nokia.com> writes:

> This will save some power.
>
> Signed-off-by: Tero Kristo <tero.kristo@nokia.com>

Please report which platforms this was tested with.

Also, please Cc linux-arm-kernel.

Thanks,

Kevin

> ---
>  arch/arm/plat-omap/dmtimer.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
> index 1d706cf..949becc 100644
> --- a/arch/arm/plat-omap/dmtimer.c
> +++ b/arch/arm/plat-omap/dmtimer.c
> @@ -341,6 +341,7 @@ static void omap_dm_timer_reset(struct omap_dm_timer *timer)
>  	l = omap_dm_timer_read_reg(timer, OMAP_TIMER_OCP_CFG_REG);
>  	l |= 0x02 << 3;  /* Set to smart-idle mode */
>  	l |= 0x2 << 8;   /* Set clock activity to perserve f-clock on idle */
> +	l |= 0x1 << 0;   /* Set autoidle */
>  
>  	/*
>  	 * Enable wake-up on OMAP2 CPUs.
