From: "Guzman Lugo, Fernando" <fernando.lugo@ti.com>
Subject: RE: [PATCH v3 4/4] omap: mailbox: convert block api to kfifo
Date: Mon, 7 Jun 2010 18:14:41 -0500
Message-ID: <496565EC904933469F292DDA3F1663E602CBA2C97A@dlee06.ent.ti.com>
References: <1273073589-2485-1-git-send-email-ohad@wizery.com>
 	<1273073589-2485-5-git-send-email-ohad@wizery.com>
 <4C0D4004.5060303@ti.com>
 <AANLkTik8tLfUzLxcd9tfC_VIgLcRGXbZPLM06nMsMHKz@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:39440 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753825Ab0FGXOu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Jun 2010 19:14:50 -0400
In-Reply-To: <AANLkTik8tLfUzLxcd9tfC_VIgLcRGXbZPLM06nMsMHKz@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>, "Chitriki Rudramuni, Deepak" <deepak.chitriki@ti.com>, "Ramirez Luna, Omar" <omar.ramirez@ti.com>, "Kanigeri, Hari" <h-kanigeri2@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>



Hi,

> -----Original Message-----
> From: Ohad Ben-Cohen [mailto:ohad@wizery.com]
> Sent: Monday, June 07, 2010 4:41 PM
> To: Chitriki Rudramuni, Deepak; Guzman Lugo, Fernando; Ramirez Luna, Omar;
> Kanigeri, Hari
> Cc: linux-omap@vger.kernel.org; Hiroshi Doyu
> Subject: Re: [PATCH v3 4/4] omap: mailbox: convert block api to kfifo
> 
> Hi Deepak,
> 
> On Mon, Jun 7, 2010 at 1:52 PM, Deepak Chitriki <deepak.chitriki@ti.com>
> wrote:
> > With this patch I observed "inconsistent lock state" warning.
> 
> Thanks for the report!
> 
> > Kfifo is acccessed in omap_mbox_msg_send() and mbox_tx_tasklet()
> > functions.In order to protect this critical section we need to protect
> by
> > using spin_lock_bh() so that the tasklet cannot preempt
> > omap_mobx_msg_send().
> 
> This is actually not the problem: it's ok if mbox_tx_tasklet preempts
> omap_mbox_msg_send. In fact, such a use case is even ok if we don't
> take a spinlock at all: kfifo is designed in a way that if you have
> only 1 consumer and 1 producer, they can both access kfifo
> simultaneously without any locking. That's why we don't take the
> spinlock in the mbox_tx_tasklet. The reason, btw, that we take a
> spinlock in omap_mbox_msg_send is to allow multiple simultaneous
> sending contexts (taking a spinlock there ensures serialization of
> those multiple simultaneous sending contexts).
> 
> The problem here lies in the fact (that I've just learnt) that
> dspbridge also sends mbox messages from a tasklet context
> (dpc_tasklet). Lockdep identifies that the spinlock is taken in a
> softirq context (dspbridge's dpc_tasklet) after it was previously
> taken in a softirq-enabled context. Your proposed fix will solve the
> lockdep issue here, but:

I think the best thing to do here is remove the spinlock, if not, you are preventing that omap_mbox_msg_send be executed from a tasklet or isr context. That maybe in this moment it is not called but it could be needed in the future. The caller of omap_mbox_msg_send should be take care of that function can not be call simultaneously.

> 
> Do we really want to have tasklets in dspbridge ? Are we that
> performance critical ?

We are facing some issues when the DSP send the request for hibernation and we get that message and start processing the request (because it is done in a workqueue and there some latency). I issue had been manage in other ways but maybe we would have that issue it the hibernation request could be handle immediately. Why not remove the workqueue at all and let the mailbox module user be the judge for using tasklet, workqueue or do the job in the same isr (if it is small task and need to be fast)?


> 
> In general I'd prefer to switch to workqueues in both dspbridge and
> mailbox. I'm really not convinced we have to use tasklets in those
> modules, and workqueues are much more system friendly. This way we
> would also not have to stop all bottom halves when sending a mailbox
> message.
> 
> Somewhat relevant note about mailbox performance: omap_mbox_msg_send
> often (i.e. when the kfifo is empty) can just send the message
> directly, without triggering the tasklet to do that. Applying such a
> change will substantially improve the mailbox performance, and will
> make the shift to workqueues even more reasonable. I've got a patch
> for that, I'll post it soon.

What would be really good!

Regards,
Fernando.

> 
> What do you think (looping in Fernando, Omar and Hari) ?
> 
> Thanks,
> Ohad.
