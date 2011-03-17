From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH] OMAP4: PM: remove redundant #ifdef CONFIG_PM
Date: Thu, 17 Mar 2011 14:43:31 -0700
Message-ID: <878vwdv2ws.fsf@ti.com>
References: <1299987443-27275-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:53513 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755662Ab1CQVng (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 17 Mar 2011 17:43:36 -0400
Received: by mail-iw0-f171.google.com with SMTP id 19so3644810iwr.30
        for <linux-omap@vger.kernel.org>; Thu, 17 Mar 2011 14:43:35 -0700 (PDT)
In-Reply-To: <1299987443-27275-1-git-send-email-nm@ti.com> (Nishanth Menon's
	message of "Sun, 13 Mar 2011 09:07:23 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Martin Etti <ettl.martin@gmx.de>, linux-arm <linux-arm-kernel@lists.infradead.org>, Tony <tony@atomide.com>

Nishanth Menon <nm@ti.com> writes:

> pm44xx.c is built only when CONFIG_PM is setup,
> remove redundant CONFIG_PM check.
>
> This also fixes:
> https://bugzilla.kernel.org/show_bug.cgi?id=25022
>
> Reported-by: Martin Etti <ettl.martin@gmx.de>
>
> Signed-off-by: Nishanth Menon <nm@ti.com>

Thanks, queuing for 2.6.39-rc fixes cycle (branch: for_2.6.39/pm-fixes)

Kevin

> ---
>  arch/arm/mach-omap2/pm44xx.c |    2 --
>  1 files changed, 0 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/pm44xx.c b/arch/arm/mach-omap2/pm44xx.c
> index 76cfff2..59a870b 100644
> --- a/arch/arm/mach-omap2/pm44xx.c
> +++ b/arch/arm/mach-omap2/pm44xx.c
> @@ -105,13 +105,11 @@ static int __init omap4_pm_init(void)
>  
>  	pr_err("Power Management for TI OMAP4.\n");
>  
> -#ifdef CONFIG_PM
>  	ret = pwrdm_for_each(pwrdms_setup, NULL);
>  	if (ret) {
>  		pr_err("Failed to setup powerdomains\n");
>  		goto err2;
>  	}
> -#endif
>  
>  #ifdef CONFIG_SUSPEND
>  	suspend_set_ops(&omap_pm_ops);
