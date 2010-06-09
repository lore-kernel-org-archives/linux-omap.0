From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [PATCH v3 4/4] omap: mailbox: convert block api to kfifo
Date: Wed, 09 Jun 2010 08:07:28 +0300 (EEST)
Message-ID: <20100609.080728.260086205.Hiroshi.DOYU@nokia.com>
References: <AANLkTik8tLfUzLxcd9tfC_VIgLcRGXbZPLM06nMsMHKz@mail.gmail.com>
	<496565EC904933469F292DDA3F1663E602CBA2C97A@dlee06.ent.ti.com>
	<AANLkTik1OCrni_1Ao0d1qUenn7IAxUaTcQvXU3osjha9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:22025 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751216Ab0FIFIJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 Jun 2010 01:08:09 -0400
In-Reply-To: <AANLkTik1OCrni_1Ao0d1qUenn7IAxUaTcQvXU3osjha9@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ohad@wizery.com
Cc: fernando.lugo@ti.com, deepak.chitriki@ti.com, omar.ramirez@ti.com, h-kanigeri2@ti.com, linux-omap@vger.kernel.org

From: ext Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH v3 4/4] omap: mailbox: convert block api to kfifo
Date: Tue, 8 Jun 2010 04:54:55 +0200

> On Mon, Jun 7, 2010 at 6:14 PM, Guzman Lugo, Fernando
> <fernando.lugo@ti.com> wrote:
>> I think the best thing to do here is remove the spinlock
> 
> I'm afraid we can't do that: we need it to support OMAP4 syslink IPC
> use cases which have multiple simultaneous sending contexts.
> 
> 
>>, if not, you are preventing that omap_mbox_msg_send be executed from a tasklet or isr context.
> 
> 
> Right. But this is pretty standard - you can't call every kernel API
> from every possible context - the allowed calling context is part of
> the API. If later we decide we need to add additional calling
> contexts, it's ok - it's just like changing the API.
> 
> 
>> Why not remove the workqueue at all and let the mailbox module user be the judge for using tasklet, workqueue or do the job in the same isr (if it is small task and need to be fast)?
> 
> 
> hmm I'm not following here - will you please elaborate on this a bit more ?

The abvoe could be something like below:

	Modified arch/arm/plat-omap/mailbox.c
diff --git a/arch/arm/plat-omap/mailbox.c b/arch/arm/plat-omap/mailbox.c
index 87e0cde..1b79b32 100644
--- a/arch/arm/plat-omap/mailbox.c
+++ b/arch/arm/plat-omap/mailbox.c
@@ -188,7 +188,7 @@ static void __mbox_rx_interrupt(struct omap_mbox *mbox)
 	/* no more messages in the fifo. clear IRQ source. */
 	ack_mbox_irq(mbox, IRQ_RX);
 nomem:
-	queue_work(mboxd, &mbox->rxq->work);
+	mbox->callback(mbox);
 }
 
 static irqreturn_t mbox_interrupt(int irq, void *p)

The user/client of mbox can register its own callback function in
advance and do its own job(tasklet, workqueue, just func whatever)
later by itself.

It makes more sense to me than the current workqueue as default.
