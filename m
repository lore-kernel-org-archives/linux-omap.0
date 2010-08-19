From: "Sapiens, Rene" <rene.sapiens@ti.com>
Subject: RE: [PATCHv2] mailbox: change full flag per mailbox queue instead
 of global
Date: Thu, 19 Aug 2010 11:09:34 -0500
Message-ID: <D2943F03B81C9C458E44DFB213905E02B7637B6D@dlee04.ent.ti.com>
References: <1281489169-15945-1-git-send-email-x0095840@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:51121 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752277Ab0HSQLw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 19 Aug 2010 12:11:52 -0400
In-Reply-To: <1281489169-15945-1-git-send-email-x0095840@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Guzman Lugo, Fernando" <fernando.lugo@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "hiroshi.doyu@nokia.com" <hiroshi.doyu@nokia.com>, "ohad@wizery.com" <ohad@wizery.com>

Hi Ohad,

This patch already contains the missed changes due to previous rebases.
Thanks.

Regards,
Rene

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Guzman Lugo, Fernando
> Sent: Tuesday, August 10, 2010 8:13 PM
> To: linux-arm-kernel@lists.infradead.org; linux-omap@vger.kernel.org
> Cc: hiroshi.doyu@nokia.com; ohad@wizery.com; Guzman Lugo, Fernando
> Subject: [PATCHv2] mailbox: change full flag per mailbox queue instead of
> global
> 
> As pointed by Ohad Ben-Cohen, the variable rq_full flag is a
> global variable, so if there are multiple mailbox users
> there will be conflics. Now there is a full flag per
> mailbox queue.
> 
> Version 2:
> - Rebase to the latest.
> 
> Reported-by: Ohad Ben-Cohen <ohad@wizery.com>
> Signed-off-by: Fernando Guzman Lugo <x0095840@ti.com>
> ---
>  arch/arm/plat-omap/include/plat/mailbox.h |    1 +
>  arch/arm/plat-omap/mailbox.c              |   10 +++++++---
>  2 files changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/plat-omap/include/plat/mailbox.h b/arch/arm/plat-
> omap/include/plat/mailbox.h
> index 9976565..261f6b8 100644
> --- a/arch/arm/plat-omap/include/plat/mailbox.h
> +++ b/arch/arm/plat-omap/include/plat/mailbox.h
> @@ -48,6 +48,7 @@ struct omap_mbox_queue {
>  	struct tasklet_struct	tasklet;
>  	int	(*callback)(void *);
>  	struct omap_mbox	*mbox;
> +	bool	full;
>  };
> 
>  struct omap_mbox {
> diff --git a/arch/arm/plat-omap/mailbox.c b/arch/arm/plat-omap/mailbox.c
> index d2fafb8..c59c9c3 100644
> --- a/arch/arm/plat-omap/mailbox.c
> +++ b/arch/arm/plat-omap/mailbox.c
> @@ -33,7 +33,6 @@
> 
>  static struct workqueue_struct *mboxd;
>  static struct omap_mbox **mboxes;
> -static bool rq_full;
> 
>  static int mbox_configured;
>  static DEFINE_MUTEX(mbox_configured_lock);
> @@ -145,7 +144,12 @@ static void mbox_rx_work(struct work_struct *work)
>  	while (kfifo_len(&mq->fifo) >= sizeof(msg)) {
>  		len = kfifo_out(&mq->fifo, (unsigned char *)&msg,
> sizeof(msg));
>  		WARN_ON(len != sizeof(msg));
> -
> +		spin_lock_irq(&mq->lock);
> +		if (mq->full) {
> +			omap_mbox_enable_irq(mq->mbox, IRQ_RX);
> +			mq->full = false;
> +		}
> +		spin_unlock_irq(&mq->lock);
>  		if (mq->callback)
>  			mq->callback((void *)msg);
>  	}
> @@ -170,7 +174,7 @@ static void __mbox_rx_interrupt(struct omap_mbox
> *mbox)
>  	while (!mbox_fifo_empty(mbox)) {
>  		if (unlikely(kfifo_avail(&mq->fifo) < sizeof(msg))) {
>  			omap_mbox_disable_irq(mbox, IRQ_RX);
> -			rq_full = true;
> +			mq->full = true;
>  			goto nomem;
>  		}
> 
> --
> 1.6.3.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
