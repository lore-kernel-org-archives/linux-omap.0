From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [PATCH v3 4/4] omap: mailbox: convert block api to kfifo
Date: Tue, 08 Jun 2010 06:40:21 +0300 (EEST)
Message-ID: <20100608.064021.71111435.Hiroshi.DOYU@nokia.com>
References: <1273073589-2485-5-git-send-email-ohad@wizery.com>
	<4C0D4004.5060303@ti.com>
	<AANLkTik8tLfUzLxcd9tfC_VIgLcRGXbZPLM06nMsMHKz@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:55248 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752712Ab0FHDkn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Jun 2010 23:40:43 -0400
In-Reply-To: <AANLkTik8tLfUzLxcd9tfC_VIgLcRGXbZPLM06nMsMHKz@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ohad@wizery.com
Cc: deepak.chitriki@ti.com, fernando.lugo@ti.com, omar.ramirez@ti.com, h-kanigeri2@ti.com, linux-omap@vger.kernel.org

From: ext Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH v3 4/4] omap: mailbox: convert block api to kfifo
Date: Mon, 7 Jun 2010 23:40:34 +0200

> Hi Deepak,
> 
> On Mon, Jun 7, 2010 at 1:52 PM, Deepak Chitriki <deepak.chitriki@ti.com> wrote:
>> With this patch I observed "inconsistent lock state" warning.
> 
> Thanks for the report!
> 
>> Kfifo is acccessed in omap_mbox_msg_send() and mbox_tx_tasklet()
>> functions.In order to protect this critical section we need to protect by
>> using spin_lock_bh() so that the tasklet cannot preempt
>> omap_mobx_msg_send().
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
> 
> Do we really want to have tasklets in dspbridge ? Are we that
> performance critical ?

Can't a whole contents of bridge_msg_get()/bridge_msg_put() be
replaced with omap mailbox APIs?

It seems that dspbridge does the same message queueing and deferred
execution as omap mailbox does in the above 2 functions. At least
bridge_msg_put() looks similar to omap_mbox_msg_send(). If this works,
we can reduce the size of dspbridge again;)

