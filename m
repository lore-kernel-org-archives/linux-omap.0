From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH v13 10/11] OMAP: dmtimer: mark clocksource and clockevent
 timers reserved
Date: Sun, 17 Apr 2011 11:42:19 +0530
Message-ID: <4DAA84C3.3080705@ti.com>
References: <1302969063-8231-1-git-send-email-tarun.kanti@ti.com> <1302969063-8231-11-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:50153 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751139Ab1DQGMl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sun, 17 Apr 2011 02:12:41 -0400
Received: by ywi6 with SMTP id 6so1433587ywi.17
        for <linux-omap@vger.kernel.org>; Sat, 16 Apr 2011 23:12:38 -0700 (PDT)
In-Reply-To: <1302969063-8231-11-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: linux-omap@vger.kernel.org

On 4/16/2011 9:21 PM, Tarun Kanti DebBarma wrote:
> In driver probe use sys_timer_reserved to identify which all timers
> have already been used for clocksource and clockevent. Mark all those
> timers as reserved so that no one else can use them.
>
> Signed-off-by: Tarun Kanti DebBarma<tarun.kanti@ti.com>
> ---
>   arch/arm/plat-omap/dmtimer.c |    8 +++++++-
>   1 files changed, 7 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
> index e15b3a8..8b6fd22 100644
> --- a/arch/arm/plat-omap/dmtimer.c
> +++ b/arch/arm/plat-omap/dmtimer.c
> @@ -554,7 +554,13 @@ static int __devinit omap_dm_timer_probe(struct platform_device *pdev)
>   	timer->id = pdev->id;
>   	timer->irq = irq->start;
>   	timer->pdev = pdev;
> -	timer->reserved = 0;
> +#if defined(CONFIG_ARCH_OMAP2)

Do you mean CONFIG_ARCH_OMAP2PLUS here ?

> +	/* Mark clocksource and clockevent timers as reserved */
> +	if ((sys_timer_reserved>>  (pdev->id - 1))&  0x1)
> +		timer->reserved = 1;
> +	else
> +#endif
> +		timer->reserved = 0;
>
>   	 /* Skip pm_runtime_enable for OMAP1 */
>   	if (!pdata->needs_manual_reset)

