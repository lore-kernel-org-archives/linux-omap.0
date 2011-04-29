From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH v13 10/11] OMAP: dmtimer: mark clocksource and clockevent
 timers reserved
Date: Fri, 29 Apr 2011 16:10:36 +0530
Message-ID: <4DBA95A4.4080600@ti.com>
References: <1302969063-8231-1-git-send-email-tarun.kanti@ti.com> <1302969063-8231-11-git-send-email-tarun.kanti@ti.com> <5A47E75E594F054BAF48C5E4FC4B92AB037AD277AF@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:33191 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758248Ab1D2KlJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 29 Apr 2011 06:41:09 -0400
Received: by ywl2 with SMTP id 2so1690103ywl.40
        for <linux-omap@vger.kernel.org>; Fri, 29 Apr 2011 03:41:04 -0700 (PDT)
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB037AD277AF@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Tarun,

On 4/25/2011 3:11 PM, DebBarma, Tarun Kanti wrote:
> In driver probe use sys_timer_reserved to identify which all timers
> have already been used for clocksource and clockevent. Mark all those
> timers as reserved so that no one else can use them.
>
> Signed-off-by: Tarun Kanti DebBarma<tarun.kanti@ti.com>
> ---
> Changed CONFIG_ARCH_OMAP2 to CONFIG_ARCH_OMAP2PLUS.
>
>   arch/arm/plat-omap/dmtimer.c |    8 +++++++-
>   1 files changed, 7 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
> index e15b3a8..14d01ec 100644
> --- a/arch/arm/plat-omap/dmtimer.c
> +++ b/arch/arm/plat-omap/dmtimer.c
> @@ -554,7 +554,13 @@ static int __devinit omap_dm_timer_probe(struct platform_device *pdev)
>   	timer->id = pdev->id;
>   	timer->irq = irq->start;
>   	timer->pdev = pdev;
> -	timer->reserved = 0;
> +#if defined(CONFIG_ARCH_OMAP2PLUS)

Do you really need this. You might want to reserve timer on
OMAP1 as well. Avoid #ifdefery

> +	/* Mark clocksource and clockevent timers as reserved */
> +	if ((sys_timer_reserved>>  (pdev->id - 1))&  0x1)
> +		timer->reserved = 1;
> +	else
> +#endif
> +		timer->reserved = 0;
>
>   	 /* Skip pm_runtime_enable for OMAP1 */
>   	if (!pdata->needs_manual_reset)

