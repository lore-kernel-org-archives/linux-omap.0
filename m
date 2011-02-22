From: Johannes Reif <reif@corscience.de>
Subject: Re: SDHC card affected by preemption model in 2.6.35
Date: Tue, 22 Feb 2011 11:03:14 +0100
Message-ID: <4D6389E2.3090504@corscience.de>
References: <4D62523D.5080203@corscience.de> <AANLkTi=UMbOYFORyTvicCvAMEd=dig7xaROMLdkcfhGW@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:54372 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753617Ab1BVKDS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Feb 2011 05:03:18 -0500
In-Reply-To: <AANLkTi=UMbOYFORyTvicCvAMEd=dig7xaROMLdkcfhGW@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dave Hylands <dhylands@gmail.com>
Cc: "S, Venkatraman" <svenkatr@ti.com>, Mathieu Poirier <mathieu.poirier@canonical.com>, Madhusudhan Chikkature <madhu.cr@ti.com>, Thomas Weber <weber@corscience.de>, linux-omap <linux-omap@vger.kernel.org>

Hi all,

On 22.02.2011 02:43, Dave Hylands wrote:

> Hi guys,
>
> There is a bug in the kernel workqueues. I observed it in 2.6.36.3 (it
> seems to have been introduced in 2.6.36 and is still in 2.6.37.1), One
> of my colleagues was investigating and contacted the author of the
> workqueue code (Tejun Heo). Tejun sent us the following patch:
>
> diff --git a/kernel/workqueue.c b/kernel/workqueue.c
> index 11869fa..90a17ca 100644
> --- a/kernel/workqueue.c
> +++ b/kernel/workqueue.c
> @@ -2047,6 +2047,15 @@ repeat:
>   				move_linked_works(work, scheduled,&n);
>
>   		process_scheduled_works(rescuer);
> +
> +		/*
> +		 * Leave this gcwq.  If keep_working() is %true, notify a
> +		 * regular worker; otherwise, we end up with 0 concurrency
> +		 * and stalling the execution.
> +		 */
> +		if (keep_working(gcwq))
> +			wake_up_worker(gcwq);
> +
>   		spin_unlock_irq(&gcwq->lock);
>   	}
>
>
> For us, this was causing card insertion events to not be processed.
> For us it was a race condition and depended on when the timer tick
> occured in relation to other processing, and since you're talking
> about PREEMPTION making a difference, I thought I would throw this out
> as maybe being relevant.
>
> Dave Hylands

unfortunately the cards didn't work with the patch.

We tried updating from 2.6.37-rc8 to 2.6.38-rc5 and the timeout error still occurs. However the cards get detected after the error and seem to work fine:

[    2.456512] Waiting for root device /dev/mmcblk0p2...
[    4.803375] mmc0: error -110 whilst initialising SD card
[    5.201019] mmc0: new SD card at address aaaa
[    5.206665] mmcblk0: mmc0:aaaa SU02G 1.84 GiB
[    5.214477]  mmcblk0: p1 p2

Regards,
Johannes

