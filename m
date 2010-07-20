From: "Guzman Lugo, Fernando" <fernando.lugo@ti.com>
Subject: RE: [PATCH 2/2] omap:mailbox-provide multiple reader support
Date: Tue, 20 Jul 2010 16:59:17 -0500
Message-ID: <496565EC904933469F292DDA3F1663E602CBFB10BD@dlee06.ent.ti.com>
References: <1279662096-3121-1-git-send-email-h-kanigeri2@ti.com>
 <1279662096-3121-3-git-send-email-h-kanigeri2@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:33664 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756424Ab0GTV7W convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 20 Jul 2010 17:59:22 -0400
In-Reply-To: <1279662096-3121-3-git-send-email-h-kanigeri2@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Kanigeri, Hari" <h-kanigeri2@ti.com>, Linux Omap <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: Ohad Ben-Cohen <ohad@wizery.com>



Hi Hari,

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Kanigeri, Hari
> Sent: Tuesday, July 20, 2010 4:42 PM
> To: Linux Omap; Tony Lindgren; Hiroshi DOYU
> Cc: Ohad Ben-Cohen; Kanigeri, Hari
> Subject: [PATCH 2/2] omap:mailbox-provide multiple reader support
> 
> This patch provides mutiple readers support for a mailbox
> instance.
> 
> Signed-off-by: Hari Kanigeri <h-kanigeri2@ti.com>
> ---
>  arch/arm/plat-omap/include/plat/mailbox.h |    6 ++-
>  arch/arm/plat-omap/mailbox.c              |   63 ++++++++++++++++--------
> ----
>  2 files changed, 40 insertions(+), 29 deletions(-)
> 
> diff --git a/arch/arm/plat-omap/include/plat/mailbox.h b/arch/arm/plat-
> omap/include/plat/mailbox.h
> index 0486d64..c8e47d8 100644
> --- a/arch/arm/plat-omap/include/plat/mailbox.h
> +++ b/arch/arm/plat-omap/include/plat/mailbox.h
> @@ -68,13 +68,15 @@ struct omap_mbox {
>  	void			*priv;
> 
>  	void			(*err_notify)(void);
> +	atomic_t		use_count;
> +	struct blocking_notifier_head	notifier;
>  };
> 
>  int omap_mbox_msg_send(struct omap_mbox *, mbox_msg_t msg);
>  void omap_mbox_init_seq(struct omap_mbox *);
> 
> -struct omap_mbox *omap_mbox_get(const char *);
> -void omap_mbox_put(struct omap_mbox *);
> +struct omap_mbox *omap_mbox_get(const char *, struct notifier_block *nb);
> +void omap_mbox_put(struct omap_mbox *, struct notifier_block *nb);
> 
>  int omap_mbox_register(struct device *parent, struct omap_mbox *);
>  int omap_mbox_unregister(struct omap_mbox *);
> diff --git a/arch/arm/plat-omap/mailbox.c b/arch/arm/plat-omap/mailbox.c
> index baac315..f9f2af4 100644
> --- a/arch/arm/plat-omap/mailbox.c
> +++ b/arch/arm/plat-omap/mailbox.c
> @@ -149,8 +149,8 @@ static void mbox_rx_work(struct work_struct *work)
>  		if (unlikely(len != sizeof(msg)))
>  			pr_err("%s: kfifo_out anomaly detected\n", __func__);
> 
> -		if (mq->callback)
> -			mq->callback((void *)msg);
> +		blocking_notifier_call_chain(&mq->mbox->notifier, len,
> +							(void *)msg);
>  	}
>  }
> 
> @@ -252,28 +252,30 @@ static int omap_mbox_startup(struct omap_mbox *mbox)
>  		}
>  	}
> 
> -	ret = request_irq(mbox->irq, mbox_interrupt, IRQF_SHARED,
> -				mbox->name, mbox);
> -	if (unlikely(ret)) {
> -		printk(KERN_ERR
> -			"failed to register mailbox interrupt:%d\n", ret);
> -		goto fail_request_irq;
> -	}
> +	if (atomic_inc_return(&mbox->use_count) == 1) {

What happen if a thread is preempted by other thread which also uses the same mailbox after doing the atomic_inc?

The second thread also will call atomic_inc_return and in this case the value returned will be 2 and it will not initialize the mbox queues but it will return success status, in this point the second thread  will think it could get the mailbox handle without any issue. However the first thread still can fail and not initialize correctly the mailbox leading second thread to not work properly or crash.

I think all the initialization should be protected and not just the use_count.

Please let me know what you think.


Regards,
Fernando.


> +		ret = request_irq(mbox->irq, mbox_interrupt, IRQF_SHARED,
> +					mbox->name, mbox);
> +		if (unlikely(ret)) {
> +			printk(KERN_ERR "failed to register mailbox interrupt:"
> +								"%d\n", ret);
> +			goto fail_request_irq;
> +		}
> 
> -	mq = mbox_queue_alloc(mbox, NULL, mbox_tx_tasklet);
> -	if (!mq) {
> -		ret = -ENOMEM;
> -		goto fail_alloc_txq;
> -	}
> -	mbox->txq = mq;
> +		mq = mbox_queue_alloc(mbox, NULL, mbox_tx_tasklet);
> +		if (!mq) {
> +			ret = -ENOMEM;
> +			goto fail_alloc_txq;
> +		}
> +		mbox->txq = mq;
> 
> -	mq = mbox_queue_alloc(mbox, mbox_rx_work, NULL);
> -	if (!mq) {
> -		ret = -ENOMEM;
> -		goto fail_alloc_rxq;
> +		mq = mbox_queue_alloc(mbox, mbox_rx_work, NULL);
> +		if (!mq) {
> +			ret = -ENOMEM;
> +			goto fail_alloc_rxq;
> +		}
> +		mbox->rxq = mq;
> +		mq->mbox = mbox;
>  	}
> -	mbox->rxq = mq;
> -
>  	return 0;
> 
>   fail_alloc_rxq:
> @@ -281,6 +283,7 @@ static int omap_mbox_startup(struct omap_mbox *mbox)
>   fail_alloc_txq:
>  	free_irq(mbox->irq, mbox);
>   fail_request_irq:
> +	atomic_dec(&mbox->use_count);
>  	if (likely(mbox->ops->shutdown)) {
>  		if (atomic_dec_return(&mbox_refcount) == 0)
>  			mbox->ops->shutdown(mbox);
> @@ -291,10 +294,12 @@ static int omap_mbox_startup(struct omap_mbox *mbox)
> 
>  static void omap_mbox_fini(struct omap_mbox *mbox)
>  {
> -	mbox_queue_free(mbox->txq);
> -	mbox_queue_free(mbox->rxq);
> 
> -	free_irq(mbox->irq, mbox);
> +	if (atomic_dec_return(&mbox->use_count) == 0) {
> +		mbox_queue_free(mbox->txq);
> +		mbox_queue_free(mbox->rxq);
> +		free_irq(mbox->irq, mbox);
> +	}
> 
>  	if (likely(mbox->ops->shutdown)) {
>  		if (atomic_dec_return(&mbox_refcount) == 0)
> @@ -314,7 +319,7 @@ static struct omap_mbox **find_mboxes(const char
> *name)
>  	return p;
>  }
> 
> -struct omap_mbox *omap_mbox_get(const char *name)
> +struct omap_mbox *omap_mbox_get(const char *name, struct notifier_block
> *nb)
>  {
>  	struct omap_mbox *mbox;
>  	int ret;
> @@ -325,19 +330,21 @@ struct omap_mbox *omap_mbox_get(const char *name)
>  		spin_unlock(&mboxes_lock);
>  		return ERR_PTR(-ENOENT);
>  	}
> -
>  	spin_unlock(&mboxes_lock);
> 
>  	ret = omap_mbox_startup(mbox);
>  	if (ret)
>  		return ERR_PTR(-ENODEV);
> +	if (nb)
> +		blocking_notifier_chain_register(&mbox->notifier, nb);
> 
>  	return mbox;
>  }
>  EXPORT_SYMBOL(omap_mbox_get);
> 
> -void omap_mbox_put(struct omap_mbox *mbox)
> +void omap_mbox_put(struct omap_mbox *mbox, struct notifier_block *nb)
>  {
> +	blocking_notifier_chain_unregister(&mbox->notifier, nb);
>  	omap_mbox_fini(mbox);
>  }
>  EXPORT_SYMBOL(omap_mbox_put);
> @@ -361,6 +368,8 @@ int omap_mbox_register(struct device *parent, struct
> omap_mbox *mbox)
>  	}
>  	*tmp = mbox;
>  	spin_unlock(&mboxes_lock);
> +	BLOCKING_INIT_NOTIFIER_HEAD(&mbox->notifier);
> +	atomic_set(&mbox->use_count, 0);
> 
>  	return 0;
> 
> --
> 1.7.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
