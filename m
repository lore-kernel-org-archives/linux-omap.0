From: "C.A, Subramaniam" <subramaniam.ca@ti.com>
Subject: RE: [PATCH 10/10] omap mailbox: OMAP4 Mailbox-driver Patch to
 support tasklet implementation
Date: Mon, 14 Sep 2009 17:05:23 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301DD88977A@dbde02.ent.ti.com>
References: <20090910.152845.170101920.Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:36067 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750895AbZINLeZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 14 Sep 2009 07:34:25 -0400
In-Reply-To: <20090910.152845.170101920.Hiroshi.DOYU@nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi DOYU <Hiroshi.DOYU@Nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "rmk@arm.linux.org.uk" <rmk@arm.linux.org.uk>, "Kanigeri, Hari" <h-kanigeri2@ti.com>, "Gupta, Ramesh" <grgupta@ti.com>

Hi Hiroshi,
Sorry for the delayed response. 

> -----Original Message-----
> From: Hiroshi DOYU [mailto:Hiroshi.DOYU@Nokia.com] 
> Sent: Thursday, September 10, 2009 5:59 PM
> To: C.A, Subramaniam
> Cc: linux-omap@vger.kernel.org; tony@atomide.com; 
> rmk@arm.linux.org.uk; Kanigeri, Hari; Gupta, Ramesh
> Subject: Re: [PATCH 10/10] omap mailbox: OMAP4 Mailbox-driver 
> Patch to support tasklet implementation
> 
> From: "ext C.A, Subramaniam" <subramaniam.ca@ti.com>
> Subject: RE: [PATCH 10/10] omap mailbox: OMAP4 Mailbox-driver 
> Patch to support tasklet implementation
> Date: Thu, 10 Sep 2009 13:46:53 +0200
> 
> > 
> >  
> > Hi Hiroshi,
> > 
> > > -----Original Message-----
> > > From: Hiroshi DOYU [mailto:Hiroshi.DOYU@nokia.com]
> > > Sent: Wednesday, September 09, 2009 2:32 PM
> > > To: C.A, Subramaniam
> > > Cc: linux-omap@vger.kernel.org; tony@atomide.com; 
> > > rmk@arm.linux.org.uk; Kanigeri, Hari; Gupta, Ramesh
> > > Subject: Re: [PATCH 10/10] omap mailbox: OMAP4 
> Mailbox-driver Patch 
> > > to support tasklet implementation
> > > 
> > > Hi Subbu,
> > > 
> > > From: "ext C.A, Subramaniam" <subramaniam.ca@ti.com>
> > > Subject: RE: [PATCH 10/10] omap mailbox: OMAP4 
> Mailbox-driver Patch 
> > > to support tasklet implementation
> > > Date: Tue, 8 Sep 2009 19:43:48 +0200
> > > 
> > > [...]
> > > 
> > > > > As I described in the comment on [PATCH 8/10], I think
> > > that it would
> > > > > be better to keep "mach-omap2/mailbox.c" simple and 
> to add some 
> > > > > additional logic on "plat-omap/mailbox.c".
> > > > > 
> > > > > Would it be possbile to move this tasklet implementation to 
> > > > > "plat-omap/mailbox.c"?
> > > > 
> > > > The implementation of the tasklet itself is maintained in 
> > > > plat-omap/mailbox.c Since, I wanted to maintain a separate
> > > tasklet for
> > > > each mailbox instance used to send messages from MPU, I had to 
> > > > associate the the tasklet to the mailbox. Hence, the
> > > changes were done
> > > > in mach-omap2/mailbox.c
> > > > 
> > > > Please give your comments on this approach.
> > > 
> > > Wouldn't just converting work_queue to tasklet work like below?
> > > 
> > > (I havne't tested this at all, though...)
> > > 
> > > diff --git a/arch/arm/plat-omap/include/mach/mailbox.h
> > > b/arch/arm/plat-omap/include/mach/mailbox.h
> > > index b7a6991..1f4e53e 100644
> > > --- a/arch/arm/plat-omap/include/mach/mailbox.h
> > > +++ b/arch/arm/plat-omap/include/mach/mailbox.h
> > > @@ -52,6 +52,8 @@ struct omap_mbox {
> > >  
> > >  	struct omap_mbox_queue	*txq, *rxq;
> > >  
> > > +	struct tasklet_struct	tx_tasklet;
> > > +
> > >  	struct omap_mbox_ops	*ops;
> > >  
> > >  	mbox_msg_t		seq_snd, seq_rcv;
> > 
> > Moved the tasklet structure to the omap_mbox_queue as follows:
> 
> This is better.
> 
> > 
> > @@ -40,7 +43,8 @@ struct omap_mbox_ops {  struct omap_mbox_queue {
> >  	spinlock_t		lock;
> >  	struct request_queue	*queue;
> > -	struct work_struct	work;
> > +	struct work_struct	rx_work;
> > +	struct tasklet_struct	tx_tasklet;
> >  	int	(*callback)(void *);
> >  	struct omap_mbox	*mbox;
> >  };
> 
> 
> I think that "rx_/tx_" prefix may not be necessary if you add 
> tasklet feature in "omap_mbox_queue" as followed since 
> "omap_mbox_queue" can be considered as s/w queue which can 
> evoke workqueue/tasklet accordingly.
> 
> 
> +	struct work_struct	work;
> +	struct tasklet_struct	tasklet;
>  	int	(*callback)(void *);
>  	struct omap_mbox	*mbox;
>  };

This is fine. Will remove rx_ and tx_ prefix.
> 
> 
> > 
> > Also chagned the omap_mbox_msg_send(). Removed the struct 
> omap_msg_tx_data.
> > 
> >  
> >  int omap_mbox_msg_send(struct omap_mbox *mbox, mbox_msg_t msg)  {
> > -	struct omap_msg_tx_data *tx_data;
> > +
> >  	struct request *rq;
> >  	struct request_queue *q = mbox->txq->queue;
> >  
> > -	tx_data = kmalloc(sizeof(*tx_data), GFP_ATOMIC);
> > -	if (unlikely(!tx_data))
> > -		return -ENOMEM;
> > -
> >  	rq = blk_get_request(q, WRITE, GFP_ATOMIC);
> > -	if (unlikely(!rq)) {
> > -		kfree(tx_data);
> > +	if (unlikely(!rq))
> >  		return -ENOMEM;
> > -	}
> >  
> > -	tx_data->msg = msg;
> > -	rq->end_io = omap_msg_tx_end_io;
> > -	blk_insert_request(q, rq, 0, tx_data);
> > +	blk_insert_request(q, rq, 0, (void *) msg);
> > +	tasklet_schedule(&mbox->txq->tx_tasklet);
> >  
> > -	schedule_work(&mbox->txq->work);
> >  	return 0;
> >  }
> >  EXPORT_SYMBOL(omap_mbox_msg_send);
> > 
> > > diff --git a/arch/arm/plat-omap/mailbox.c 
> > > b/arch/arm/plat-omap/mailbox.c index 40424ed..37267ca 100644
> > > --- a/arch/arm/plat-omap/mailbox.c
> > > +++ b/arch/arm/plat-omap/mailbox.c
> > > @@ -184,22 +184,17 @@ int omap_mbox_msg_send(struct 
> omap_mbox *mbox, 
> > > mbox_msg_t msg, void* arg)  } EXPORT_SYMBOL(omap_mbox_msg_send);
> > >  
> > > -static void mbox_tx_work(struct work_struct *work)
> > > +static void mbox_tx_tasklet(unsigned long data)
> > >  {
> > >  	int ret;
> > >  	struct request *rq;
> > > -	struct omap_mbox_queue *mq = container_of(work,
> > > -				struct omap_mbox_queue, work);
> > > -	struct omap_mbox *mbox = mq->queue->queuedata;
> > > + 	struct omap_mbox *mbox = (struct omap_mbox *)data;
> > >  	struct request_queue *q = mbox->txq->queue;
> > >  
> > >  	while (1) {
> > >  		struct omap_msg_tx_data *tx_data;
> > >  
> > > -		spin_lock(q->queue_lock);
> > >  		rq = blk_fetch_request(q);
> > > -		spin_unlock(q->queue_lock);
> > > -
> > >  		if (!rq)
> > >  			break;
> > >  
> > > @@ -208,15 +203,10 @@ static void mbox_tx_work(struct work_struct 
> > > *work)
> > >  		ret = __mbox_msg_send(mbox, tx_data->msg, tx_data->arg);
> > >  		if (ret) {
> > >  			enable_mbox_irq(mbox, IRQ_TX);
> > > -			spin_lock(q->queue_lock);
> > >  			blk_requeue_request(q, rq);
> > > -			spin_unlock(q->queue_lock);
> > >  			return;
> > >  		}
> > > -
> > > -		spin_lock(q->queue_lock);
> > >  		__blk_end_request_all(rq, 0);
> > > -		spin_unlock(q->queue_lock);
> > >  	}
> > >  }
> > >  
> > 
> > Changed the mbox_tx_tasklet as follows:
> > 
> > -static void mbox_tx_work(struct work_struct *work)
> > +static void mbox_tx_tasklet(unsigned long tx_data)
> >  {
> >  	int ret;
> >  	struct request *rq;
> > -	struct omap_mbox_queue *mq = container_of(work,
> > -				struct omap_mbox_queue, work);
> > -	struct omap_mbox *mbox = mq->queue->queuedata;
> > +	struct omap_mbox *mbox = (struct omap_mbox *)tx_data;
> >  	struct request_queue *q = mbox->txq->queue;
> >  
> >  	while (1) {
> > -		struct omap_msg_tx_data *tx_data;
> >  
> > -		spin_lock(q->queue_lock);
> >  		rq = blk_fetch_request(q);
> > -		spin_unlock(q->queue_lock);
> >  
> >  		if (!rq)
> >  			break;
> >  
> > -		tx_data = rq->special;
> > -
> > -		ret = __mbox_msg_send(mbox, tx_data->msg);
> > +		ret = __mbox_msg_send(mbox, (mbox_msg_t)rq->special);
> >  		if (ret) {
> >  			omap_mbox_enable_irq(mbox, IRQ_TX);
> > -			spin_lock(q->queue_lock);
> >  			blk_requeue_request(q, rq);
> > -			spin_unlock(q->queue_lock);
> >  			return;
> >  		}
> > -
> > -		spin_lock(q->queue_lock);
> > -		__blk_end_request_all(rq, 0);
> > -		spin_unlock(q->queue_lock);
> > +		/* FIXME: We get a WARN_ON() if __blk_end_request_all()
> > +		* is used. Not sure if we can remove the queue locks
> > +		* for blk_requeue_request() and blk_fetch_request()
> > +		* calls as well.*/
> > +		blk_end_request_all(rq, 0);
> >  	}
> >  }
> > 
> > While testing I got a WARN_ON() using the __blk_end_request_all(). 
> > Tried using the blk_end_request_all() instead, and that 
> worked fine. 
> > Is it safe to remove the spin lock protection for all the 
> calls inside 
> > the tasklet function as you had suggested?
> > Please comment.
> 
> I think that it's safe since it's being executed in tasklet 
> context, no preemption.
> 
> Which WARN_ON() did you get?
> 

WARNING: at include/linux/blkdev.h:522
WARN_ON_ONCE(!queue_is_locked(q));
The __blk_end_request_all() needs the queue to be locked before making the call.
However, the blk_end_request_all() call does not have this requirement.

> > 
> > > @@ -266,7 +256,7 @@ static void 
> __mbox_tx_interrupt(struct omap_mbox 
> > > *mbox)  {
> > >  	disable_mbox_irq(mbox, IRQ_TX);
> > >  	ack_mbox_irq(mbox, IRQ_TX);
> > > -	schedule_work(&mbox->txq->work);
> > > +	tasklet_schedule(&mbox->tx_tasklet);
> > >  }
> > >  
> > >  static void __mbox_rx_interrupt(struct omap_mbox *mbox) @@
> > > -434,7 +424,9 @@ static int omap_mbox_init(struct omap_mbox *mbox)
> > >  		goto fail_request_irq;
> > >  	}
> > >
> > 
> > Changes in the names used for work queue (rx_work) and tasklet as 
> > tx_tasklet.
> 
> As I explained above, the prefix 'tx_/rx_' isn't necessary.
> 
I will remove the tx_ rx_ as you had suggested.

> > 
> > @@ -157,7 +132,7 @@ static void mbox_tx_work(struct 
> work_struct *work)  
> > static void mbox_rx_work(struct work_struct *work)  {
> >  	struct omap_mbox_queue *mq =
> > -			container_of(work, struct 
> omap_mbox_queue, work);
> > +			container_of(work, struct 
> omap_mbox_queue, rx_work);
> >  	struct omap_mbox *mbox = mq->queue->queuedata;
> >  	struct request_queue *q = mbox->rxq->queue;
> >  	struct request *rq;
> > @@ -192,7 +167,7 @@ static void __mbox_tx_interrupt(struct 
> omap_mbox 
> > *mbox)  {
> >  	omap_mbox_disable_irq(mbox, IRQ_TX);
> >  	ack_mbox_irq(mbox, IRQ_TX);
> > -	schedule_work(&mbox->txq->work);
> > +	tasklet_schedule(&mbox->txq->tx_tasklet);
> >  }
> >  
> >  static void __mbox_rx_interrupt(struct omap_mbox *mbox) @@ -217,7 
> > +192,7 @@ static void __mbox_rx_interrupt(struct omap_mbox *mbox)
> >  	/* no more messages in the fifo. clear IRQ source. */
> >  	ack_mbox_irq(mbox, IRQ_RX);
> >  nomem:
> > -	schedule_work(&mbox->rxq->work);
> > +	schedule_work(&mbox->rxq->rx_work);
> >  }
> > 
> >   
> > > -	mq = mbox_queue_alloc(mbox, mbox_txq_fn, mbox_tx_work);
> > > +	tasklet_init(&mbox->tx_tasklet, mbox_tx_tasklet,
> > > (unsigned long)mbox);
> > > +
> > > +	mq = mbox_queue_alloc(mbox, mbox_txq_fn, NULL);
> > >  	if (!mq) {
> > >  		ret = -ENOMEM;
> > >  		goto fail_alloc_txq;
> > > 
> > > 
> > 
> > Changed the signature of the mbox_queue_alloc function. 
> > The work queue / tasklet initialization is done in the
> > omap_mbox_startup() function.
> 
> why?

The mbox_queue_alloc() currently, takes only the work queue function 
as an argument. With the tasklet introduced, I felt it is better to 
have work queue/ tasklet initializations,done outside the 
mbox_queue_alloc() function. 

Doing the tasklet initializtion in startup looks more like a work-around.
Another option would be to pass both the work_queue and tasklet functions 
as arguments to the mbox_queue_alloc() function.

Please comment.

> 
> >
> > static struct omap_mbox_queue *mbox_queue_alloc(struct 
> omap_mbox *mbox,
> > -					request_fn_proc *proc,
> > -					void (*work) (struct 
> work_struct *))
> > +					request_fn_proc *proc)
> >  {
> >  	struct request_queue *q;
> >  	struct omap_mbox_queue *mq;
> > @@ -252,8 +226,6 @@ static struct omap_mbox_queue 
> *mbox_queue_alloc(struct omap_mbox *mbox,
> >  	q->queuedata = mbox;
> >  	mq->queue = q;
> >  
> > -	INIT_WORK(&mq->work, work);
> > -
> >  	return mq;
> >  error:
> >  	kfree(mq);
> > @@ -292,18 +264,22 @@ static int omap_mbox_startup(struct 
> omap_mbox *mbox)
> >  		goto fail_request_irq;
> >  	}
> >  
> > -	mq = mbox_queue_alloc(mbox, mbox_txq_fn, mbox_tx_work);
> > +	mq = mbox_queue_alloc(mbox, mbox_txq_fn);
> >  	if (!mq) {
> >  		ret = -ENOMEM;
> >  		goto fail_alloc_txq;
> >  	}
> > +
> > +	tasklet_init(&mq->tx_tasklet, mbox_tx_tasklet, 
> (unsigned long)mbox);
> >  	mbox->txq = mq;
> >  
> > -	mq = mbox_queue_alloc(mbox, mbox_rxq_fn, mbox_rx_work);
> > +	mq = mbox_queue_alloc(mbox, mbox_rxq_fn);
> >  	if (!mq) {
> >  		ret = -ENOMEM;
> >  		goto fail_alloc_rxq;
> >  	}
> > +
> > +	INIT_WORK(&mq->rx_work, mbox_rx_work);
> >  	mbox->rxq = mq;
> >  
> >  	return 0;
> > --
> > 
> > Please give your comments on the changes.
> > --
> > To unsubscribe from this list: send the line "unsubscribe 
> linux-omap" 
> > in the body of a message to majordomo@vger.kernel.org More 
> majordomo 
> > info at  http://vger.kernel.org/majordomo-info.html
> 
> 