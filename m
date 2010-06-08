From: "Guzman Lugo, Fernando" <fernando.lugo@ti.com>
Subject: RE: [PATCH v3 4/4] omap: mailbox: convert block api to kfifo
Date: Tue, 8 Jun 2010 12:02:27 -0500
Message-ID: <496565EC904933469F292DDA3F1663E602CBB20226@dlee06.ent.ti.com>
References: <1273073589-2485-5-git-send-email-ohad@wizery.com>
	<4C0D4004.5060303@ti.com>
	<AANLkTik8tLfUzLxcd9tfC_VIgLcRGXbZPLM06nMsMHKz@mail.gmail.com>
 <20100608.064021.71111435.Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:38798 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751385Ab0FHRCc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Jun 2010 13:02:32 -0400
In-Reply-To: <20100608.064021.71111435.Hiroshi.DOYU@nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, "ohad@wizery.com" <ohad@wizery.com>
Cc: "Chitriki Rudramuni, Deepak" <deepak.chitriki@ti.com>, "Ramirez Luna, Omar" <omar.ramirez@ti.com>, "Kanigeri, Hari" <h-kanigeri2@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>



> -----Original Message-----
> From: Hiroshi DOYU [mailto:Hiroshi.DOYU@nokia.com]
> Sent: Monday, June 07, 2010 10:40 PM
> To: ohad@wizery.com
> Cc: Chitriki Rudramuni, Deepak; Guzman Lugo, Fernando; Ramirez Luna, Omar;
> Kanigeri, Hari; linux-omap@vger.kernel.org
> Subject: Re: [PATCH v3 4/4] omap: mailbox: convert block api to kfifo
> 
> From: ext Ohad Ben-Cohen <ohad@wizery.com>
> Subject: Re: [PATCH v3 4/4] omap: mailbox: convert block api to kfifo
> Date: Mon, 7 Jun 2010 23:40:34 +0200
> 
> > Hi Deepak,
> >
> > On Mon, Jun 7, 2010 at 1:52 PM, Deepak Chitriki <deepak.chitriki@ti.com>
> wrote:
> >> With this patch I observed "inconsistent lock state" warning.
> >
> > Thanks for the report!
> >
> >> Kfifo is acccessed in omap_mbox_msg_send() and mbox_tx_tasklet()
> >> functions.In order to protect this critical section we need to protect
> by
> >> using spin_lock_bh() so that the tasklet cannot preempt
> >> omap_mobx_msg_send().
> >
> > This is actually not the problem: it's ok if mbox_tx_tasklet preempts
> > omap_mbox_msg_send. In fact, such a use case is even ok if we don't
> > take a spinlock at all: kfifo is designed in a way that if you have
> > only 1 consumer and 1 producer, they can both access kfifo
> > simultaneously without any locking. That's why we don't take the
> > spinlock in the mbox_tx_tasklet. The reason, btw, that we take a
> > spinlock in omap_mbox_msg_send is to allow multiple simultaneous
> > sending contexts (taking a spinlock there ensures serialization of
> > those multiple simultaneous sending contexts).
> >
> > The problem here lies in the fact (that I've just learnt) that
> > dspbridge also sends mbox messages from a tasklet context
> > (dpc_tasklet). Lockdep identifies that the spinlock is taken in a
> > softirq context (dspbridge's dpc_tasklet) after it was previously
> > taken in a softirq-enabled context. Your proposed fix will solve the
> > lockdep issue here, but:
> >
> > Do we really want to have tasklets in dspbridge ? Are we that
> > performance critical ?
> 
> Can't a whole contents of bridge_msg_get()/bridge_msg_put() be
> replaced with omap mailbox APIs?
> 
> It seems that dspbridge does the same message queueing and deferred
> execution as omap mailbox does in the above 2 functions. At least
> bridge_msg_put() looks similar to omap_mbox_msg_send(). If this works,
> we can reduce the size of dspbridge again;)

Yes, it has a pretty similar method to send the messages. However the messages send by bridge_msg_put() is a shared memory message, which has a cmd fiel and 2 arguments fields and the bridge used a mailbox message just to indicate to the DSP that it has some pending shared memory messages.


Regards,
Fernando.

