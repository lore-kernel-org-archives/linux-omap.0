From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [PATCH 10/10] omap mailbox: OMAP4 Mailbox-driver Patch to
 support tasklet implementation
Date: Mon, 14 Sep 2009 15:43:42 +0300 (EEST)
Message-ID: <20090914.154342.71090099.Hiroshi.DOYU@nokia.com>
References: <20090910.152845.170101920.Hiroshi.DOYU@nokia.com>
	<B85A65D85D7EB246BE421B3FB0FBB59301DD88977A@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:30126 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755419AbZINMn4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 14 Sep 2009 08:43:56 -0400
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59301DD88977A@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: subramaniam.ca@ti.com
Cc: linux-omap@vger.kernel.org, tony@atomide.com, rmk@arm.linux.org.uk, h-kanigeri2@ti.com, grgupta@ti.com

Hi Subbu,

From: "ext C.A, Subramaniam" <subramaniam.ca@ti.com>
Subject: RE: [PATCH 10/10] omap mailbox: OMAP4 Mailbox-driver Patch to support tasklet implementation
Date: Mon, 14 Sep 2009 13:35:23 +0200

[...]

> > > -
> > > -           spin_lock(q->queue_lock);
> > > -           __blk_end_request_all(rq, 0);
> > > -           spin_unlock(q->queue_lock);
> > > +           /* FIXME: We get a WARN_ON() if __blk_end_request_all()
> > > +           * is used. Not sure if we can remove the queue locks
> > > +           * for blk_requeue_request() and blk_fetch_request()
> > > +           * calls as well.*/
> > > +           blk_end_request_all(rq, 0);
> > >     }
> > >  }
> > >
> > > While testing I got a WARN_ON() using the __blk_end_request_all().
> > > Tried using the blk_end_request_all() instead, and that
> > worked fine.
> > > Is it safe to remove the spin lock protection for all the
> > calls inside
> > > the tasklet function as you had suggested?
> > > Please comment.
> >
> > I think that it's safe since it's being executed in tasklet
> > context, no preemption.
> >
> > Which WARN_ON() did you get?
> >
> 
> WARNING: at include/linux/blkdev.h:522
> WARN_ON_ONCE(!queue_is_locked(q));
> The __blk_end_request_all() needs the queue to be locked before making the call.
> However, the blk_end_request_all() call does not have this requirement.

Although it's safe without locking, __blk_end_request_all() wasn't
supposed to be used in tasklet context.

Let's use "blk_end_request_all()" until we'll come up with a better
idea while I think that request queue may be a little bit too heavy
for this porpose.

[...]
> > >  static void __mbox_rx_interrupt(struct omap_mbox *mbox) @@ -217,7
> > > +192,7 @@ static void __mbox_rx_interrupt(struct omap_mbox *mbox)
> > >     /* no more messages in the fifo. clear IRQ source. */
> > >     ack_mbox_irq(mbox, IRQ_RX);
> > >  nomem:
> > > -   schedule_work(&mbox->rxq->work);
> > > +   schedule_work(&mbox->rxq->rx_work);
> > >  }
> > >
> > >
> > > > - mq = mbox_queue_alloc(mbox, mbox_txq_fn, mbox_tx_work);
> > > > + tasklet_init(&mbox->tx_tasklet, mbox_tx_tasklet,
> > > > (unsigned long)mbox);
> > > > +
> > > > + mq = mbox_queue_alloc(mbox, mbox_txq_fn, NULL);
> > > >   if (!mq) {
> > > >           ret = -ENOMEM;
> > > >           goto fail_alloc_txq;
> > > >
> > > >
> > >
> > > Changed the signature of the mbox_queue_alloc function.
> > > The work queue / tasklet initialization is done in the
> > > omap_mbox_startup() function.
> >
> > why?
> 
> The mbox_queue_alloc() currently, takes only the work queue function
> as an argument. With the tasklet introduced, I felt it is better to
> have work queue/ tasklet initializations,done outside the
> mbox_queue_alloc() function.
> 
> Doing the tasklet initializtion in startup looks more like a work-around.
> Another option would be to pass both the work_queue and tasklet functions
> as arguments to the mbox_queue_alloc() function.

I second passing tasklet func as argument for mbox_queue_alloc because
mbox_queue_alloc() was originally introduced to avoid repeating the
same initialization steps for rx and tx. For me, doing all
initialization per mbox queue in this function seems to be the way.


