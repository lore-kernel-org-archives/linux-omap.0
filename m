From: "Guzman Lugo, Fernando" <fernando.lugo@ti.com>
Subject: RE: [PATCH v3 4/4] omap: mailbox: convert block api to kfifo
Date: Tue, 8 Jun 2010 13:49:45 -0500
Message-ID: <496565EC904933469F292DDA3F1663E602CBB202B2@dlee06.ent.ti.com>
References: <496565EC904933469F292DDA3F1663E602CBA2C97A@dlee06.ent.ti.com>
	<20100608.064632.104051482.Hiroshi.DOYU@nokia.com>
	<AANLkTilasmQgcyckgBgpJspRHhsshDlVtdleItZiMp8M@mail.gmail.com>
 <20100608.125539.39172600.Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:33965 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753169Ab0FHStu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Jun 2010 14:49:50 -0400
In-Reply-To: <20100608.125539.39172600.Hiroshi.DOYU@nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, "felipe.contreras@gmail.com" <felipe.contreras@gmail.com>
Cc: "ohad@wizery.com" <ohad@wizery.com>, "Chitriki Rudramuni, Deepak" <deepak.chitriki@ti.com>, "Ramirez Luna, Omar" <omar.ramirez@ti.com>, "Kanigeri, Hari" <h-kanigeri2@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>



> -----Original Message-----
> From: Hiroshi DOYU [mailto:Hiroshi.DOYU@nokia.com]
> Sent: Tuesday, June 08, 2010 4:56 AM
> To: felipe.contreras@gmail.com
> Cc: Guzman Lugo, Fernando; ohad@wizery.com; Chitriki Rudramuni, Deepak;
> Ramirez Luna, Omar; Kanigeri, Hari; linux-omap@vger.kernel.org
> Subject: Re: [PATCH v3 4/4] omap: mailbox: convert block api to kfifo
> 
> From: ext Felipe Contreras <felipe.contreras@gmail.com>
> Subject: Re: [PATCH v3 4/4] omap: mailbox: convert block api to kfifo
> Date: Tue, 8 Jun 2010 11:43:28 +0200
> 
> > On Tue, Jun 8, 2010 at 6:46 AM, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
> wrote:
> >> From: "ext Guzman Lugo, Fernando" <fernando.lugo@ti.com>
> >>> I think the best thing to do here is remove the spinlock, if not,
> >>> you are preventing that omap_mbox_msg_send be executed from a
> >>> tasklet or isr context. That maybe in this moment it is not called
> >>> but it could be needed in the future. The caller of
> >>> omap_mbox_msg_send should be take care of that function can not be
> >>> call simultaneously.
> >>
> >> What about adding another function, omap_mbox_msg_send_sync()?
> >
> > That's exactly what I was thinking about when I heard the problem.
> > Would this function send all the msgs already queued, and then wait
> > for the current one actually be sent?

A function like that could be helpful in some cases I think. Maybe and other one to flush (discard) all pending messages would be good too. So that I can clean the mailbox and would not be needed to do a mbox_put and mbox_get.

> 
> Could be as you said. I haven't thought that much.
> 
> What I just thought was to bypass kfifo and tasklet and to put a
> message directly to H/W fifo. Maily just for the above case which
> Fernando described above.
> 
> Fernando, what do you think on Felipes?

Why don't just bypass the tasklet? I think the kfifo is ok in order to not discard the message in case of full hw fifo. I was thinking in the omap_mbox_msg_send just check if we have messajes in the kfifo or if the hw fifo is full. If so, store the message en the kfifo and enable not full interrupt. Otherwise write the message to hw fifo.


	if (kfifo_len(&mq->fifo) || mbox_fifo_full(mbox)) {
		kfifo_in(&mq->fifo, (unsigned char *)&msg, sizeof(msg));
		omap_mbox_enable_irq(mbox, IRQ_TX);
	} else
		mbox_fifo_write(mbox, msg);


and in the tx isr just send the messages store in the kfifo, reding the messages from the kfifo is very fast and at last we will be able to send 4 messages (most of the cases we will be able to send 1 message), which I think is even faster than just doing the tasklet schedule.


	while (kfifo_len(&mq->fifo) && !mbox_fifo_full(mbox)) {
		kfifo_out(&mq->fifo, (unsigned char *)&msg, sizeof(msg));
		mbox_fifo_write(mbox, msg);
	}
	If (!mbox_fifo_full(mbox))
		omap_mbox_disable_irq(mbox, IRQ_TX);



Regards,
Fernando.


