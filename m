From: "Guzman Lugo, Fernando" <fernando.lugo@ti.com>
Subject: RE: [PATCH v3 4/4] omap: mailbox: convert block api to kfifo
Date: Wed, 9 Jun 2010 00:16:55 -0500
Message-ID: <496565EC904933469F292DDA3F1663E602CA4D88F2@dlee06.ent.ti.com>
References: <AANLkTik8tLfUzLxcd9tfC_VIgLcRGXbZPLM06nMsMHKz@mail.gmail.com>
	<496565EC904933469F292DDA3F1663E602CBA2C97A@dlee06.ent.ti.com>
	<AANLkTik1OCrni_1Ao0d1qUenn7IAxUaTcQvXU3osjha9@mail.gmail.com>,<20100609.080728.260086205.Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:34968 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751251Ab0FIFTI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 Jun 2010 01:19:08 -0400
In-Reply-To: <20100609.080728.260086205.Hiroshi.DOYU@nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, "ohad@wizery.com" <ohad@wizery.com>
Cc: "Chitriki Rudramuni, Deepak" <deepak.chitriki@ti.com>, "Ramirez Luna, Omar" <omar.ramirez@ti.com>, "Kanigeri, Hari" <h-kanigeri2@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


________________________________________
>From: Hiroshi DOYU [Hiroshi.DOYU@nokia.com]
>Sent: Wednesday, June 09, 2010 12:07 AM
>To: ohad@wizery.com
>Cc: Guzman Lugo, Fernando; Chitriki Rudramuni, Deepak; Ramirez Luna, Omar; Kanigeri, Hari; linux-omap@vger.kernel.org
>Subject: Re: [PATCH v3 4/4] omap: mailbox: convert block api to kfifo
>
>From: ext Ohad Ben-Cohen <ohad@wizery.com>
>Subject: Re: [PATCH v3 4/4] omap: mailbox: convert block api to kfifo
>Date: Tue, 8 Jun 2010 04:54:55 +0200
>
>> On Mon, Jun 7, 2010 at 6:14 PM, Guzman Lugo, Fernando
>> <fernando.lugo@ti.com> wrote:
>>> I think the best thing to do here is remove the spinlock
>>
>> I'm afraid we can't do that: we need it to support OMAP4 syslink IPC
>> use cases which have multiple simultaneous sending contexts.
>>
>>
>>>, if not, you are preventing that omap_mbox_msg_send be executed from a tasklet or isr context.
>>
>>
>> Right. But this is pretty standard - you can't call every kernel API
>> from every possible context - the allowed calling context is part of
>> the API. If later we decide we need to add additional calling
>> contexts, it's ok - it's just like changing the API.
>>
>>
>>> Why not remove the workqueue at all and let the mailbox module user be the judge for using tasklet, workqueue or do the job in the same isr (if it is small task and need to be fast)?
>>
>>
>> hmm I'm not following here - will you please elaborate on this a bit more ?
>
>The abvoe could be something like below:
>
>        Modified arch/arm/plat-omap/mailbox.c
>diff --git a/arch/arm/plat-omap/mailbox.c b/arch/arm/plat-omap/mailbox.c
>index 87e0cde..1b79b32 100644
>--- a/arch/arm/plat-omap/mailbox.c
>+++ b/arch/arm/plat-omap/mailbox.c
>@@ -188,7 +188,7 @@ static void __mbox_rx_interrupt(struct omap_mbox *mbox)
>        /* no more messages in the fifo. clear IRQ source. */
>        ack_mbox_irq(mbox, IRQ_RX);
> nomem:
>-       queue_work(mboxd, &mbox->rxq->work);
>+       mbox->callback(mbox);
> }
>
> static irqreturn_t mbox_interrupt(int irq, void *p)
>
>The user/client of mbox can register its own callback function in
>advance and do its own job(tasklet, workqueue, just func whatever)
>later by itself.
>
>It makes more sense to me than the current workqueue as default.

Yes, this is exactly what I was talking about.

Regards,
Fernando.


