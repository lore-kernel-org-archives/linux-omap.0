From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH v3 4/4] omap: mailbox: convert block api to kfifo
Date: Mon, 7 Jun 2010 16:40:34 -0500
Message-ID: <AANLkTik8tLfUzLxcd9tfC_VIgLcRGXbZPLM06nMsMHKz@mail.gmail.com>
References: <1273073589-2485-1-git-send-email-ohad@wizery.com>
	<1273073589-2485-5-git-send-email-ohad@wizery.com> <4C0D4004.5060303@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:40292 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752663Ab0FGVk5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Jun 2010 17:40:57 -0400
Received: by wyi11 with SMTP id 11so2751123wyi.19
        for <linux-omap@vger.kernel.org>; Mon, 07 Jun 2010 14:40:55 -0700 (PDT)
In-Reply-To: <4C0D4004.5060303@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Deepak Chitriki <deepak.chitriki@ti.com>, "Guzman Lugo, Fernando" <fernando.lugo@ti.com>, Omar Ramirez Luna <omar.ramirez@ti.com>, "Kanigeri, Hari" <h-kanigeri2@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>

Hi Deepak,

On Mon, Jun 7, 2010 at 1:52 PM, Deepak Chitriki <deepak.chitriki@ti.com> wrote:
> With this patch I observed "inconsistent lock state" warning.

Thanks for the report!

> Kfifo is acccessed in omap_mbox_msg_send() and mbox_tx_tasklet()
> functions.In order to protect this critical section we need to protect by
> using spin_lock_bh() so that the tasklet cannot preempt
> omap_mobx_msg_send().

This is actually not the problem: it's ok if mbox_tx_tasklet preempts
omap_mbox_msg_send. In fact, such a use case is even ok if we don't
take a spinlock at all: kfifo is designed in a way that if you have
only 1 consumer and 1 producer, they can both access kfifo
simultaneously without any locking. That's why we don't take the
spinlock in the mbox_tx_tasklet. The reason, btw, that we take a
spinlock in omap_mbox_msg_send is to allow multiple simultaneous
sending contexts (taking a spinlock there ensures serialization of
those multiple simultaneous sending contexts).

The problem here lies in the fact (that I've just learnt) that
dspbridge also sends mbox messages from a tasklet context
(dpc_tasklet). Lockdep identifies that the spinlock is taken in a
softirq context (dspbridge's dpc_tasklet) after it was previously
taken in a softirq-enabled context. Your proposed fix will solve the
lockdep issue here, but:

Do we really want to have tasklets in dspbridge ? Are we that
performance critical ?

In general I'd prefer to switch to workqueues in both dspbridge and
mailbox. I'm really not convinced we have to use tasklets in those
modules, and workqueues are much more system friendly. This way we
would also not have to stop all bottom halves when sending a mailbox
message.

Somewhat relevant note about mailbox performance: omap_mbox_msg_send
often (i.e. when the kfifo is empty) can just send the message
directly, without triggering the tasklet to do that. Applying such a
change will substantially improve the mailbox performance, and will
make the shift to workqueues even more reasonable. I've got a patch
for that, I'll post it soon.

What do you think (looping in Fernando, Omar and Hari) ?

Thanks,
Ohad.
