From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [PATCH v3 4/4] omap: mailbox: convert block api to kfifo
Date: Mon, 14 Jun 2010 11:58:04 +0300 (EEST)
Message-ID: <20100614.115804.260111776.Hiroshi.DOYU@nokia.com>
References: <AANLkTik1OCrni_1Ao0d1qUenn7IAxUaTcQvXU3osjha9@mail.gmail.com>
	<20100609.080728.260086205.Hiroshi.DOYU@nokia.com>
	<AANLkTinixlUAjtwFZmGIkio4H0Gzy1Moww2ssoLBKQWr@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:17466 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755286Ab0FNI6p convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 14 Jun 2010 04:58:45 -0400
In-Reply-To: <AANLkTinixlUAjtwFZmGIkio4H0Gzy1Moww2ssoLBKQWr@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: fernando.lugo@ti.com, ohad@wizery.com
Cc: deepak.chitriki@ti.com, omar.ramirez@ti.com, h-kanigeri2@ti.com, linux-omap@vger.kernel.org

Hi Ohad,

=46rom: ext Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH v3 4/4] omap: mailbox: convert block api to kfifo
Date: Mon, 14 Jun 2010 01:52:16 +0200

> On Wed, Jun 9, 2010 at 12:07 AM, Hiroshi DOYU <Hiroshi.DOYU@nokia.com=
> wrote:
>> diff --git a/arch/arm/plat-omap/mailbox.c b/arch/arm/plat-omap/mailb=
ox.c
>> index 87e0cde..1b79b32 100644
>> --- a/arch/arm/plat-omap/mailbox.c
>> +++ b/arch/arm/plat-omap/mailbox.c
>> @@ -188,7 +188,7 @@ static void __mbox_rx_interrupt(struct omap_mbox=
 *mbox)
>> =A0 =A0 =A0 =A0/* no more messages in the fifo. clear IRQ source. */
>> =A0 =A0 =A0 =A0ack_mbox_irq(mbox, IRQ_RX);
>> =A0nomem:
>> - =A0 =A0 =A0 queue_work(mboxd, &mbox->rxq->work);
>> + =A0 =A0 =A0 mbox->callback(mbox);
>> =A0}
>=20
> I like this !
>
> It will allow us to easily plug in new IPC mechanisms in the future.

Agree.

> (btw, if we do this, and also introduce omap_mbox_msg_send_sync, do w=
e
> still need a mailbox queuing mechanism at all ? :)

I think that "queuing"(can be called as S/W fifo/buffer?) is basically
necessary it can compensate the shortage of H/W fifo slots under high
load or emergency case. It has only 4 slots. I guess that, DSP usually
responds quickly and 4 H/W slots may be enough, but it might be
safer/more robust to avoid the assumption which depends on other
entity/DSP. From latecy perspective, "s/w fifo" + "tasklet" would be
enough short.

omap_mbox_msg_send_sync() can handle the case for a special message,
like PM, which has to respond at the higher priority than the normal
ones.

> Having said that, this is not going to solve the lockdep warning
> reported by Deepak - that was caused because of dspbridge's sending
> context (and not because of the receiving context). To eliminate that

Does dspbridge really need its own defered work for sending mailbox
messages?

=46or me, the problem here is the unneccesary duplication of tasklet, o=
r
can be said, the unnecessary use of tasklet for _sending_ mailbox
messages in dspbridge.

http://marc.info/?l=3Dlinux-omap&m=3D127601655325416&w=3D2

I thought that bridge_msg_put()/bridge_msg_get() can use omap mbox
APIs directly, with getting rid of its use of its own defered
work/tasklet as pointed out in the above link. Fernando?

=46or recieving, its defered work(tasklet) can be trigered directly in
the above proposed callback, that callback can triger its own
workqueue if necessary, then. I think that, for recieving, some PM
command may has to be sent back immedieately inside of
tasklet. omap_mbox_msg_send_sync() may handle this case.

What do you think?

> issue, I prefer fixing dspbridge to use work queues rather than using
> spin_lock_bh in omap_mbox_msg_send. Disabling system bottom halves
> just to send a mbox msg sounds unjustified (unless bridge really need=
s
> to use tasklets instead of work queues, which I slightly doubt). What
> do you think ?

I think that workqueue is only necessary when it has to sleep,
otherwise tasklet is prefered. For _sending_ a message inside of
dspbridge, I haven't found any reasonable reason to use any defered
work(softirq, tasklet, workqueue) so far.

> Speaking of mailbox I'd like to address some issues that are code rel=
ated:
>=20
> * Let's add mailbox API to set the callback pointer (it feels wrong t=
o
> let users directly manipulate the mbox structure).
>=20
> * We can also safely move the callback field to the main mbox
> structure, since it has no usage in the TX mq; it's pretty global to
> the whole mbox.
>=20
> * Let's make sure no one accidentally registers two receivers on the
> same time (which would result in one overwriting the other's callback
> field).

I'd like to allow mutiple listners in some way, as the flexibility of
mailbox functionalty.

> * mbox_configured is a global variable and that breaks support of
> multiple concurrent mailbox instances. Let's move this logic into the
> instance of mbox.
>=20
> * If we make sure there are no two user of the same mailbox instance
> (see 3rd *), we can eliminate mbox_configured and its locking (not
> that doesn't mean there can't be two concurrent sending contexts, it
> just means they are somewhat related, they have a common receiver,
> which was registered using only a single call to get).
>
> Something like this, pls tell me what you think:

=46or the above 5 proposals, excpet the multiple listeners issue, they
seems ok.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
