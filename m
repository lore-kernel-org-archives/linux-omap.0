From: "C.A, Subramaniam" <subramaniam.ca@ti.com>
Subject: RE: [PATCH 7/10] omap mailbox: expose
 omap_mbox_enable()/disable_irq()
Date: Tue, 17 Nov 2009 18:37:28 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301DE563E00@dbde02.ent.ti.com>
References: <20091114004004.GG3684@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:53721 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750995AbZKQNHF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Nov 2009 08:07:05 -0500
In-Reply-To: <20091114004004.GG3684@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Gupta, Ramesh" <grgupta@ti.com>, "Kanigeri, Hari" <h-kanigeri2@ti.com>, Hiroshi DOYU <Hiroshi.DOYU@Nokia.com>

> -----Original Message-----
> From: Tony Lindgren [mailto:tony@atomide.com] 
> Sent: Saturday, November 14, 2009 6:10 AM
> To: C.A, Subramaniam
> Cc: linux-omap@vger.kernel.org; Gupta, Ramesh; Kanigeri, 
> Hari; Hiroshi DOYU
> Subject: Re: [PATCH 7/10] omap mailbox: expose 
> omap_mbox_enable()/disable_irq()
> 
> * C.A, Subramaniam <subramaniam.ca@ti.com> [091113 04:32]:
> > From 177e2efb7384c03ac445b55e2e4ccf44e2160051 Mon Sep 17 
> 00:00:00 2001
> > From: C A Subramaniam <subramaniam.ca@ti.com>
> > Date: Fri, 13 Nov 2009 15:04:57 +0530
> > Subject: [PATCH 7/10] omap mailbox: expose 
> > omap_mbox_enable()/disable_irq()
> > 
> > Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
> 
> Is this missing a Signed-off-by: C A Subramaniam 
> <subramaniam.ca@ti.com>, or should this be From: Hiroshi DOYU 
> <Hiroshi.DOYU@nokia.com>?
> 
Hi Tony,
The patch is given by Hiroshi. Since it was sent as part of the OMAP4
Mailbox patch series the From has C A Subramaniam <subramaniam.ca@ti.com>


> Regards,
> 
> Tony
> 
> > ---
> >  arch/arm/plat-omap/include/plat/mailbox.h |   12 ++++++++++++
> >  arch/arm/plat-omap/mailbox.c              |   12 ++----------
> >  2 files changed, 14 insertions(+), 10 deletions(-)
> > 
> > diff --git a/arch/arm/plat-omap/include/plat/mailbox.h 
> > b/arch/arm/plat-omap/include/plat/mailbox.h
> > index 8260a3f..bf06953 100644
> > --- a/arch/arm/plat-omap/include/plat/mailbox.h
> > +++ b/arch/arm/plat-omap/include/plat/mailbox.h
> > @@ -92,4 +92,16 @@ static inline void 
> omap_mbox_restore_ctx(struct omap_mbox *mbox)
> >  	mbox->ops->restore_ctx(mbox);
> >  }
> >  
> > +static inline void omap_mbox_enable_irq(struct omap_mbox *mbox,
> > +					omap_mbox_irq_t irq)
> > +{
> > +	mbox->ops->enable_irq(mbox, irq);
> > +}
> > +
> > +static inline void omap_mbox_disable_irq(struct omap_mbox *mbox,
> > +					 omap_mbox_irq_t irq)
> > +{
> > +	mbox->ops->disable_irq(mbox, irq);
> > +}
> > +
> >  #endif /* MAILBOX_H */
> > diff --git a/arch/arm/plat-omap/mailbox.c 
> > b/arch/arm/plat-omap/mailbox.c index eb76df2..d5377a3 100644
> > --- a/arch/arm/plat-omap/mailbox.c
> > +++ b/arch/arm/plat-omap/mailbox.c
> > @@ -50,14 +50,6 @@ static inline int mbox_fifo_full(struct 
> omap_mbox 
> > *mbox)  }
> >  
> >  /* Mailbox IRQ handle functions */
> > -static inline void enable_mbox_irq(struct omap_mbox *mbox, 
> > omap_mbox_irq_t irq) -{
> > -	mbox->ops->enable_irq(mbox, irq);
> > -}
> > -static inline void disable_mbox_irq(struct omap_mbox *mbox, 
> > omap_mbox_irq_t irq) -{
> > -	mbox->ops->disable_irq(mbox, irq);
> > -}
> >  static inline void ack_mbox_irq(struct omap_mbox *mbox, 
> > omap_mbox_irq_t irq)  {
> >  	if (mbox->ops->ack_irq)
> > @@ -144,7 +136,7 @@ static void mbox_tx_work(struct 
> work_struct *work)
> >  
> >  		ret = __mbox_msg_send(mbox, tx_data->msg);
> >  		if (ret) {
> > -			enable_mbox_irq(mbox, IRQ_TX);
> > +			omap_mbox_enable_irq(mbox, IRQ_TX);
> >  			spin_lock(q->queue_lock);
> >  			blk_requeue_request(q, rq);
> >  			spin_unlock(q->queue_lock);
> > @@ -196,7 +188,7 @@ static void mbox_rxq_fn(struct request_queue *q)
> >  
> >  static void __mbox_tx_interrupt(struct omap_mbox *mbox)  {
> > -	disable_mbox_irq(mbox, IRQ_TX);
> > +	omap_mbox_disable_irq(mbox, IRQ_TX);
> >  	ack_mbox_irq(mbox, IRQ_TX);
> >  	schedule_work(&mbox->txq->work);
> >  }
> > --
> > 1.5.3.2
> 
> 