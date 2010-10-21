From: "Sapiens, Rene" <rene.sapiens@ti.com>
Subject: RE: [PATCH 4/7] omap:mailbox-send message in process context
Date: Thu, 21 Oct 2010 14:03:50 -0500
Message-ID: <D2943F03B81C9C458E44DFB213905E02010355C35E@dlee04.ent.ti.com>
References: <1287108808-32119-1-git-send-email-h-kanigeri2@ti.com>
 <1287108808-32119-5-git-send-email-h-kanigeri2@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:45243 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756760Ab0JUTEE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 21 Oct 2010 15:04:04 -0400
In-Reply-To: <1287108808-32119-5-git-send-email-h-kanigeri2@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Kanigeri, Hari" <h-kanigeri2@ti.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, linux omap <linux-omap@vger.kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, Ohad Ben-Cohen <ohad@wizery.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>

Hi Hari,

On Thursday, October 14, 2010 9:13 PM Kanigeri, Hari wrote:
> Schedule the Tasklet to send only when mailbox fifo is full, else
> send the message in the Process context. This would avoid
> needless scheduling of Tasklet for every message transfer
> 
> Signed-off-by: Hari Kanigeri <h-kanigeri2@ti.com>
> ---
>  arch/arm/plat-omap/mailbox.c |    9 +++++++--
>  1 files changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/plat-omap/mailbox.c b/arch/arm/plat-omap/mailbox.c
> index ed960c1..a4170c7 100644
> --- a/arch/arm/plat-omap/mailbox.c
> +++ b/arch/arm/plat-omap/mailbox.c
> @@ -92,20 +92,25 @@ int omap_mbox_msg_send(struct omap_mbox *mbox,
>  	mbox_msg_t msg) struct omap_mbox_queue *mq = mbox->txq;
>  	int ret = 0, len;
> 
> -	spin_lock(&mq->lock);
> +	spin_lock_bh(&mq->lock);
> 

Please check if this scenario looks valid to you, as discussed and depicted
with Fernando:

Supposing that at this point the hw fifo is full and there are messages in
the kfifo.

>  	if (kfifo_avail(&mq->fifo) < sizeof(msg)) {
>  		ret = -ENOMEM;
>  		goto out;
>  	}
> 

We reach this point.

In this scenario, the DSP or other Core reads a message from the mbox hw fifo.
The next happens:
1.- The not full interrupt is triggered to the MPU.
2.- The mbox's ISR schedules the tasklet to write the message.
3.- The ISR is left and returns to here (since we still have the bh lock the
    tasklet won't run).

> +	if (!__mbox_poll_for_space(mbox)) {\

4.- We check for mbox_fifo_full and we have space. so the message is written.

> +		mbox_fifo_write(mbox, msg);

At this point it looks that the FIFO order is lost. We write this message
before the ones in the kfifo.

A solution for this could be checking if there are messages in the kfifo
before trying to write directly to the hw fifo, if so, just continue
scheduling the tasklet.

> +		goto out;
> +	}
> +
>  	len = kfifo_in(&mq->fifo, (unsigned char *)&msg, sizeof(msg));
>  	WARN_ON(len != sizeof(msg));
> 
>  	tasklet_schedule(&mbox->txq->tasklet);
> 
>  out:
> -	spin_unlock(&mq->lock);
> +	spin_unlock_bh(&mq->lock);
>  	return ret;
>  }
>  EXPORT_SYMBOL(omap_mbox_msg_send);
> --
> 1.7.0