From: "C.A, Subramaniam" <subramaniam.ca@ti.com>
Subject: RE: [PATCH 10/10] omap mailbox: OMAP4 Mailbox-driver Patch to
 support tasklet implementation
Date: Wed, 9 Sep 2009 14:44:21 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301DD74F2F7@dbde02.ent.ti.com>
References: <20090909.120222.85401310.Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:40324 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751872AbZIIJNb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 Sep 2009 05:13:31 -0400
In-Reply-To: <20090909.120222.85401310.Hiroshi.DOYU@nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "rmk@arm.linux.org.uk" <rmk@arm.linux.org.uk>, "Kanigeri, Hari" <h-kanigeri2@ti.com>, "Gupta, Ramesh" <grgupta@ti.com>

 Hi Hiroshi,

> -----Original Message-----
> From: Hiroshi DOYU [mailto:Hiroshi.DOYU@nokia.com] 
> Sent: Wednesday, September 09, 2009 2:32 PM
> To: C.A, Subramaniam
> Cc: linux-omap@vger.kernel.org; tony@atomide.com; 
> rmk@arm.linux.org.uk; Kanigeri, Hari; Gupta, Ramesh
> Subject: Re: [PATCH 10/10] omap mailbox: OMAP4 Mailbox-driver 
> Patch to support tasklet implementation
> 
> Hi Subbu,
> 
> From: "ext C.A, Subramaniam" <subramaniam.ca@ti.com>
> Subject: RE: [PATCH 10/10] omap mailbox: OMAP4 Mailbox-driver 
> Patch to support tasklet implementation
> Date: Tue, 8 Sep 2009 19:43:48 +0200
> 
> [...]
> 
> > > As I described in the comment on [PATCH 8/10], I think 
> that it would 
> > > be better to keep "mach-omap2/mailbox.c" simple and to add some 
> > > additional logic on "plat-omap/mailbox.c".
> > > 
> > > Would it be possbile to move this tasklet implementation to 
> > > "plat-omap/mailbox.c"?
> > 
> > The implementation of the tasklet itself is maintained in 
> > plat-omap/mailbox.c Since, I wanted to maintain a separate 
> tasklet for 
> > each mailbox instance used to send messages from MPU, I had to 
> > associate the the tasklet to the mailbox. Hence, the 
> changes were done 
> > in mach-omap2/mailbox.c
> > 
> > Please give your comments on this approach.
> 
> Wouldn't just converting work_queue to tasklet work like below?
> 
> (I havne't tested this at all, though...)
I will try that out and let you know. Also your approach seems better
as you are replacing the work queue implementaion as well.  
> 
> diff --git a/arch/arm/plat-omap/include/mach/mailbox.h 
> b/arch/arm/plat-omap/include/mach/mailbox.h
> index b7a6991..1f4e53e 100644
> --- a/arch/arm/plat-omap/include/mach/mailbox.h
> +++ b/arch/arm/plat-omap/include/mach/mailbox.h
> @@ -52,6 +52,8 @@ struct omap_mbox {
>  
>  	struct omap_mbox_queue	*txq, *rxq;
>  
> +	struct tasklet_struct	tx_tasklet;
> +
>  	struct omap_mbox_ops	*ops;
>  
>  	mbox_msg_t		seq_snd, seq_rcv;
> diff --git a/arch/arm/plat-omap/mailbox.c 
> b/arch/arm/plat-omap/mailbox.c index 40424ed..37267ca 100644
> --- a/arch/arm/plat-omap/mailbox.c
> +++ b/arch/arm/plat-omap/mailbox.c
> @@ -184,22 +184,17 @@ int omap_mbox_msg_send(struct omap_mbox 
> *mbox, mbox_msg_t msg, void* arg)  }  
> EXPORT_SYMBOL(omap_mbox_msg_send);
>  
> -static void mbox_tx_work(struct work_struct *work)
> +static void mbox_tx_tasklet(unsigned long data)
>  {
>  	int ret;
>  	struct request *rq;
> -	struct omap_mbox_queue *mq = container_of(work,
> -				struct omap_mbox_queue, work);
> -	struct omap_mbox *mbox = mq->queue->queuedata;
> + 	struct omap_mbox *mbox = (struct omap_mbox *)data;
>  	struct request_queue *q = mbox->txq->queue;
>  
>  	while (1) {
>  		struct omap_msg_tx_data *tx_data;
>  
> -		spin_lock(q->queue_lock);
>  		rq = blk_fetch_request(q);
> -		spin_unlock(q->queue_lock);
> -
>  		if (!rq)
>  			break;
>  
> @@ -208,15 +203,10 @@ static void mbox_tx_work(struct 
> work_struct *work)
>  		ret = __mbox_msg_send(mbox, tx_data->msg, tx_data->arg);
>  		if (ret) {
>  			enable_mbox_irq(mbox, IRQ_TX);
> -			spin_lock(q->queue_lock);
>  			blk_requeue_request(q, rq);
> -			spin_unlock(q->queue_lock);
>  			return;
>  		}
> -
> -		spin_lock(q->queue_lock);
>  		__blk_end_request_all(rq, 0);
> -		spin_unlock(q->queue_lock);
>  	}
>  }
>  
> @@ -266,7 +256,7 @@ static void __mbox_tx_interrupt(struct 
> omap_mbox *mbox)  {
>  	disable_mbox_irq(mbox, IRQ_TX);
>  	ack_mbox_irq(mbox, IRQ_TX);
> -	schedule_work(&mbox->txq->work);
> +	tasklet_schedule(&mbox->tx_tasklet);
>  }
>  
>  static void __mbox_rx_interrupt(struct omap_mbox *mbox) @@ 
> -434,7 +424,9 @@ static int omap_mbox_init(struct omap_mbox *mbox)
>  		goto fail_request_irq;
>  	}
>  
> -	mq = mbox_queue_alloc(mbox, mbox_txq_fn, mbox_tx_work);
> +	tasklet_init(&mbox->tx_tasklet, mbox_tx_tasklet, 
> (unsigned long)mbox);
> +
> +	mq = mbox_queue_alloc(mbox, mbox_txq_fn, NULL);
>  	if (!mq) {
>  		ret = -ENOMEM;
>  		goto fail_alloc_txq;
> 
> 