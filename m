From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH 4/4] omap: mailbox: convert block api to kfifo
Date: Wed, 28 Apr 2010 15:03:56 +0300
Message-ID: <l2oda15981b1004280503m1e6ecb88u9667e1fe6364eef9@mail.gmail.com>
References: <t2rda15981b1004280402rc7ce3cc7g622620086439ff90@mail.gmail.com>
	<20100428.141620.59684829.Hiroshi.DOYU@nokia.com> <g2wda15981b1004280425nd095bccelc5ca7d695d9e19b1@mail.gmail.com>
	<20100428.145244.115939340.Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:32946 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751624Ab0D1MES convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 28 Apr 2010 08:04:18 -0400
Received: by gyg13 with SMTP id 13so7208290gyg.19
        for <linux-omap@vger.kernel.org>; Wed, 28 Apr 2010 05:04:17 -0700 (PDT)
In-Reply-To: <20100428.145244.115939340.Hiroshi.DOYU@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: linux-omap@vger.kernel.org, h-kanigeri2@ti.com

On Wed, Apr 28, 2010 at 2:52 PM, Hiroshi DOYU <Hiroshi.DOYU@nokia.com> =
wrote:
> From: ext Ohad Ben-Cohen <ohad@wizery.com>
> Subject: Re: [PATCH 4/4] omap: mailbox: convert block api to kfifo
> Date: Wed, 28 Apr 2010 13:25:41 +0200
>
>> On Wed, Apr 28, 2010 at 2:16 PM, Hiroshi DOYU <Hiroshi.DOYU@nokia.co=
m> wrote:
>>> From: ext Ohad Ben-Cohen <ohad@wizery.com>
>>> Subject: Re: [PATCH 4/4] omap: mailbox: convert block api to kfifo
>>> Date: Wed, 28 Apr 2010 13:02:06 +0200
>>>
>>>>>> diff --git a/arch/arm/plat-omap/mailbox.c b/arch/arm/plat-omap/m=
ailbox.c
>>>>>> index 72b17ad..b1324f3 100644
>>>>>> --- a/arch/arm/plat-omap/mailbox.c
>>>>>> +++ b/arch/arm/plat-omap/mailbox.c
>>>>>> @@ -26,6 +26,7 @@
>>>>>> =A0#include <linux/device.h>
>>>>>> =A0#include <linux/delay.h>
>>>>>> =A0#include <linux/slab.h>
>>>>>> +#include <linux/kfifo.h>
>>>>>>
>>>>>> =A0#include <plat/mailbox.h>
>>>>>>
>>>>>> @@ -67,7 +68,7 @@ static inline int is_mbox_irq(struct omap_mbox=
 *mbox, omap_mbox_irq_t irq)
>>>>>> =A0/*
>>>>>> =A0 * message sender
>>>>>> =A0 */
>>>>>> -static int __mbox_msg_send(struct omap_mbox *mbox, mbox_msg_t m=
sg)
>>>>>> +static int __mbox_poll_for_space(struct omap_mbox *mbox)
>>>>>> =A0{
>>>>>> =A0 =A0 =A0 int ret =3D 0, i =3D 1000;
>>>>>>
>>>>>> @@ -78,49 +79,54 @@ static int __mbox_msg_send(struct omap_mbox =
*mbox, mbox_msg_t msg)
>>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -1;
>>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 udelay(1);
>>>>>> =A0 =A0 =A0 }
>>>>>> - =A0 =A0 mbox_fifo_write(mbox, msg);
>>>>>> =A0 =A0 =A0 return ret;
>>>>>> =A0}
>>>>>>
>>>>>> -
>>>>>> =A0int omap_mbox_msg_send(struct omap_mbox *mbox, mbox_msg_t msg=
)
>>>>>> =A0{
>>>>>> + =A0 =A0 struct omap_mbox_queue *mq =3D mbox->txq;
>>>>>> + =A0 =A0 int ret =3D 0, len;
>>>>>>
>>>>>> - =A0 =A0 struct request *rq;
>>>>>> - =A0 =A0 struct request_queue *q =3D mbox->txq->queue;
>>>>>> + =A0 =A0 spin_lock(&mq->lock);
>>>>>>
>>>>>> - =A0 =A0 rq =3D blk_get_request(q, WRITE, GFP_ATOMIC);
>>>>>> - =A0 =A0 if (unlikely(!rq))
>>>>>> - =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
>>>>>> + =A0 =A0 if (kfifo_avail(&mq->fifo) < sizeof(msg)) {
>>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENOMEM;
>>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>>>>>> + =A0 =A0 }
>>>>>> +
>>>>>> + =A0 =A0 len =3D kfifo_in(&mq->fifo, (unsigned char *)&msg, siz=
eof(msg));
>>>>>> + =A0 =A0 if (unlikely(len !=3D sizeof(msg))) {
>>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 pr_err("%s: kfifo_in anomaly\n", __fun=
c__);
>>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENOMEM;
>>>>>> + =A0 =A0 }
>>>>>>
>>>>>> - =A0 =A0 blk_insert_request(q, rq, 0, (void *) msg);
>>>>>> =A0 =A0 =A0 tasklet_schedule(&mbox->txq->tasklet);
>>>>>>
>>>>>> - =A0 =A0 return 0;
>>>>>> +out:
>>>>>> + =A0 =A0 spin_unlock(&mq->lock);
>>>>>> + =A0 =A0 return ret;
>>>>>> =A0}
>>>>>> =A0EXPORT_SYMBOL(omap_mbox_msg_send);
>>>>>>
>>>>>> =A0static void mbox_tx_tasklet(unsigned long tx_data)
>>>>>> =A0{
>>>>>> - =A0 =A0 int ret;
>>>>>> - =A0 =A0 struct request *rq;
>>>>>> =A0 =A0 =A0 struct omap_mbox *mbox =3D (struct omap_mbox *)tx_da=
ta;
>>>>>> - =A0 =A0 struct request_queue *q =3D mbox->txq->queue;
>>>>>> -
>>>>>> - =A0 =A0 while (1) {
>>>>>> -
>>>>>> - =A0 =A0 =A0 =A0 =A0 =A0 rq =3D blk_fetch_request(q);
>>>>>> -
>>>>>> - =A0 =A0 =A0 =A0 =A0 =A0 if (!rq)
>>>>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>>>>>> + =A0 =A0 struct omap_mbox_queue *mq =3D mbox->txq;
>>>>>> + =A0 =A0 mbox_msg_t msg;
>>>>>> + =A0 =A0 int ret;
>>>>>>
>>>>>> - =A0 =A0 =A0 =A0 =A0 =A0 ret =3D __mbox_msg_send(mbox, (mbox_ms=
g_t)rq->special);
>>>>>> - =A0 =A0 =A0 =A0 =A0 =A0 if (ret) {
>>>>>> + =A0 =A0 while (kfifo_len(&mq->fifo)) {
>>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 if (__mbox_poll_for_space(mbox)) {
>>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_mbox_enable_irq=
(mbox, IRQ_TX);
>>>>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 blk_requeue_request(q,=
 rq);
>>>>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
>>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>>>>>> - =A0 =A0 =A0 =A0 =A0 =A0 blk_end_request_all(rq, 0);
>>>>>> +
>>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D kfifo_out(&mq->fifo, (unsigned=
 char *)&msg,
>>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sizeof(msg));
>>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 if (unlikely(ret !=3D sizeof(msg)))
>>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("%s: kfifo_out =
anomaly\n", __func__);
>>>>>
>>>>> No error recovery? same for other anomalies.
>>>>
>>>> I thought about it too, but eventually I think it doesn't really m=
ake
>>>> a lot of sense:
>>>> The only reason that kfifo_out/kfifo_in can fail here is if there'=
s
>>>> not enough data/space (respectively).
>>>> Since we are checking for the availability of data/space before ca=
lling
>>>> kfifo_out/kfifo_in, it cannot really fail.
>>>> If it does fail, that's a critical bug that we cannot really recov=
er from.
>>>> Only reasonable explanation can be a bug in the code (either ours =
or kfifo's),
>>>> and with such a bug it really feels futile to put some recovery.
>>>> So maybe we should really make this a WARN_ON.
>>>> What do you think ?
>>>
>>> Makes sense. What about BUG_ON if it shouldn't happen theoretically=
?
>>
>> I'm not sure this bug is critical enough to panic and enforce the us=
er
>> to reboot immediately - he can probably still do a clean shutdown he=
re.
>
> I agree that WARN_ON would be enough for this case. I just thought of
> the rareness of this triggering.

Yeah, I was thinking exactly the same, and wanted to put BUG_ON too ini=
tially,
but the combination of its calling panic and its header comment
convinced me otherwise:

/*
 * Don't use BUG() or BUG_ON() unless there's really no way out; one
 * example might be detecting data structure corruption in the middle
 * of an operation that can't be backed out of.  If the (sub)system
 * can somehow continue operating, perhaps with reduced functionality,
 * it's probably not BUG-worthy.
 *
 * If you're tempted to BUG(), think again:  is completely giving up
 * really the *only* solution?  There are usually better options, where
 * users don't need to reboot ASAP and can mostly shut down cleanly.
 */




> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
