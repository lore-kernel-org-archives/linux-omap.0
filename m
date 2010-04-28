From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH 4/4] omap: mailbox: convert block api to kfifo
Date: Wed, 28 Apr 2010 14:02:06 +0300
Message-ID: <t2rda15981b1004280402rc7ce3cc7g622620086439ff90@mail.gmail.com>
References: <1272390982-14882-1-git-send-email-ohad@wizery.com>
	<1272390982-14882-5-git-send-email-ohad@wizery.com> <20100428.085254.112592556.Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:47872 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751342Ab0D1LC2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 28 Apr 2010 07:02:28 -0400
Received: by gyg13 with SMTP id 13so7187204gyg.19
        for <linux-omap@vger.kernel.org>; Wed, 28 Apr 2010 04:02:26 -0700 (PDT)
In-Reply-To: <20100428.085254.112592556.Hiroshi.DOYU@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: linux-omap@vger.kernel.org, h-kanigeri2@ti.com

Hi Hiroshi,

On Wed, Apr 28, 2010 at 8:52 AM, Hiroshi DOYU <Hiroshi.DOYU@nokia.com> =
wrote:
> Hi Ohad,
>
> From: ext Ohad Ben-Cohen <ohad@wizery.com>
> Subject: [PATCH 4/4] omap: mailbox: convert block api to kfifo
> Date: Tue, 27 Apr 2010 19:56:22 +0200
>
>> The underlying buffering implementation of mailbox
>> is converted from block API to kfifo due to the simplicity
>> and speed of kfifo.
>>
>> Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
>> Signed-off-by: Hari Kanigeri <h-kanigeri2@ti.com>
>> ---
>> =A0arch/arm/plat-omap/include/plat/mailbox.h | =A0 =A05 +-
>> =A0arch/arm/plat-omap/mailbox.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0108 =
+++++++++++++----------------
>> =A02 files changed, 52 insertions(+), 61 deletions(-)
>>
>> diff --git a/arch/arm/plat-omap/include/plat/mailbox.h b/arch/arm/pl=
at-omap/include/plat/mailbox.h
>> index 729166b..014cc58 100644
>> --- a/arch/arm/plat-omap/include/plat/mailbox.h
>> +++ b/arch/arm/plat-omap/include/plat/mailbox.h
>> @@ -7,6 +7,7 @@
>> =A0#include <linux/workqueue.h>
>> =A0#include <linux/blkdev.h>
>> =A0#include <linux/interrupt.h>
>> +#include <linux/kfifo.h>
>>
>> =A0typedef u32 mbox_msg_t;
>> =A0struct omap_mbox;
>> @@ -19,6 +20,8 @@ typedef int __bitwise omap_mbox_type_t;
>> =A0#define OMAP_MBOX_TYPE1 ((__force omap_mbox_type_t) 1)
>> =A0#define OMAP_MBOX_TYPE2 ((__force omap_mbox_type_t) 2)
>>
>> +#define MBOX_KFIFO_SIZE =A0 =A0 =A0(256)
>
> Can this be a module parameter? Then, OEM could set their optimized v=
alue.


Sure.


>
>> +
>> =A0struct omap_mbox_ops {
>> =A0 =A0 =A0 omap_mbox_type_t =A0 =A0 =A0 =A0type;
>> =A0 =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 (*startup)(struct omap_mbox =
*mbox);
>> @@ -42,7 +45,7 @@ struct omap_mbox_ops {
>>
>> =A0struct omap_mbox_queue {
>> =A0 =A0 =A0 spinlock_t =A0 =A0 =A0 =A0 =A0 =A0 =A0lock;
>> - =A0 =A0 struct request_queue =A0 =A0*queue;
>> + =A0 =A0 struct kfifo =A0 =A0 =A0 =A0 =A0 =A0fifo;
>> =A0 =A0 =A0 struct work_struct =A0 =A0 =A0work;
>> =A0 =A0 =A0 struct tasklet_struct =A0 tasklet;
>> =A0 =A0 =A0 int =A0 =A0 (*callback)(void *);
>> diff --git a/arch/arm/plat-omap/mailbox.c b/arch/arm/plat-omap/mailb=
ox.c
>> index 72b17ad..b1324f3 100644
>> --- a/arch/arm/plat-omap/mailbox.c
>> +++ b/arch/arm/plat-omap/mailbox.c
>> @@ -26,6 +26,7 @@
>> =A0#include <linux/device.h>
>> =A0#include <linux/delay.h>
>> =A0#include <linux/slab.h>
>> +#include <linux/kfifo.h>
>>
>> =A0#include <plat/mailbox.h>
>>
>> @@ -67,7 +68,7 @@ static inline int is_mbox_irq(struct omap_mbox *mb=
ox, omap_mbox_irq_t irq)
>> =A0/*
>> =A0 * message sender
>> =A0 */
>> -static int __mbox_msg_send(struct omap_mbox *mbox, mbox_msg_t msg)
>> +static int __mbox_poll_for_space(struct omap_mbox *mbox)
>> =A0{
>> =A0 =A0 =A0 int ret =3D 0, i =3D 1000;
>>
>> @@ -78,49 +79,54 @@ static int __mbox_msg_send(struct omap_mbox *mbo=
x, mbox_msg_t msg)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -1;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 udelay(1);
>> =A0 =A0 =A0 }
>> - =A0 =A0 mbox_fifo_write(mbox, msg);
>> =A0 =A0 =A0 return ret;
>> =A0}
>>
>> -
>> =A0int omap_mbox_msg_send(struct omap_mbox *mbox, mbox_msg_t msg)
>> =A0{
>> + =A0 =A0 struct omap_mbox_queue *mq =3D mbox->txq;
>> + =A0 =A0 int ret =3D 0, len;
>>
>> - =A0 =A0 struct request *rq;
>> - =A0 =A0 struct request_queue *q =3D mbox->txq->queue;
>> + =A0 =A0 spin_lock(&mq->lock);
>>
>> - =A0 =A0 rq =3D blk_get_request(q, WRITE, GFP_ATOMIC);
>> - =A0 =A0 if (unlikely(!rq))
>> - =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
>> + =A0 =A0 if (kfifo_avail(&mq->fifo) < sizeof(msg)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENOMEM;
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 len =3D kfifo_in(&mq->fifo, (unsigned char *)&msg, sizeof(=
msg));
>> + =A0 =A0 if (unlikely(len !=3D sizeof(msg))) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 pr_err("%s: kfifo_in anomaly\n", __func__)=
;
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENOMEM;
>> + =A0 =A0 }
>>
>> - =A0 =A0 blk_insert_request(q, rq, 0, (void *) msg);
>> =A0 =A0 =A0 tasklet_schedule(&mbox->txq->tasklet);
>>
>> - =A0 =A0 return 0;
>> +out:
>> + =A0 =A0 spin_unlock(&mq->lock);
>> + =A0 =A0 return ret;
>> =A0}
>> =A0EXPORT_SYMBOL(omap_mbox_msg_send);
>>
>> =A0static void mbox_tx_tasklet(unsigned long tx_data)
>> =A0{
>> - =A0 =A0 int ret;
>> - =A0 =A0 struct request *rq;
>> =A0 =A0 =A0 struct omap_mbox *mbox =3D (struct omap_mbox *)tx_data;
>> - =A0 =A0 struct request_queue *q =3D mbox->txq->queue;
>> -
>> - =A0 =A0 while (1) {
>> -
>> - =A0 =A0 =A0 =A0 =A0 =A0 rq =3D blk_fetch_request(q);
>> -
>> - =A0 =A0 =A0 =A0 =A0 =A0 if (!rq)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 struct omap_mbox_queue *mq =3D mbox->txq;
>> + =A0 =A0 mbox_msg_t msg;
>> + =A0 =A0 int ret;
>>
>> - =A0 =A0 =A0 =A0 =A0 =A0 ret =3D __mbox_msg_send(mbox, (mbox_msg_t)=
rq->special);
>> - =A0 =A0 =A0 =A0 =A0 =A0 if (ret) {
>> + =A0 =A0 while (kfifo_len(&mq->fifo)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (__mbox_poll_for_space(mbox)) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_mbox_enable_irq(mbo=
x, IRQ_TX);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 blk_requeue_request(q, rq)=
;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> - =A0 =A0 =A0 =A0 =A0 =A0 blk_end_request_all(rq, 0);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D kfifo_out(&mq->fifo, (unsigned cha=
r *)&msg,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sizeof(msg));
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (unlikely(ret !=3D sizeof(msg)))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("%s: kfifo_out anom=
aly\n", __func__);
>
> No error recovery? same for other anomalies.


I thought about it too, but eventually I think it doesn't really make
a lot of sense:
The only reason that kfifo_out/kfifo_in can fail here is if there's
not enough data/space (respectively).
Since we are checking for the availability of data/space before calling
kfifo_out/kfifo_in, it cannot really fail.
If it does fail, that's a critical bug that we cannot really recover fr=
om.
Only reasonable explanation can be a bug in the code (either ours or kf=
ifo's),
and with such a bug it really feels futile to put some recovery.
So maybe we should really make this a WARN_ON.
What do you think ?

Thanks for the review!
Ohad.

>
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 mbox_fifo_write(mbox, msg);
>> =A0 =A0 =A0 }
>> =A0}
>>
>> @@ -131,36 +137,22 @@ static void mbox_rx_work(struct work_struct *w=
ork)
>> =A0{
>> =A0 =A0 =A0 struct omap_mbox_queue *mq =3D
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 container_of(work, struc=
t omap_mbox_queue, work);
>> - =A0 =A0 struct omap_mbox *mbox =3D mq->queue->queuedata;
>> - =A0 =A0 struct request_queue *q =3D mbox->rxq->queue;
>> - =A0 =A0 struct request *rq;
>> =A0 =A0 =A0 mbox_msg_t msg;
>> - =A0 =A0 unsigned long flags;
>> + =A0 =A0 int len;
>>
>> - =A0 =A0 while (1) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 spin_lock_irqsave(q->queue_lock, flags);
>> - =A0 =A0 =A0 =A0 =A0 =A0 rq =3D blk_fetch_request(q);
>> - =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock_irqrestore(q->queue_lock, flag=
s);
>> - =A0 =A0 =A0 =A0 =A0 =A0 if (!rq)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 while (kfifo_len(&mq->fifo) >=3D sizeof(msg)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 len =3D kfifo_out(&mq->fifo, (unsigned cha=
r *)&msg, sizeof(msg));
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (unlikely(len !=3D sizeof(msg)))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("%s: kfifo_out anom=
aly detected\n", __func__);
>>
>> - =A0 =A0 =A0 =A0 =A0 =A0 msg =3D (mbox_msg_t)rq->special;
>> - =A0 =A0 =A0 =A0 =A0 =A0 blk_end_request_all(rq, 0);
>> - =A0 =A0 =A0 =A0 =A0 =A0 mbox->rxq->callback((void *)msg);
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (mq->callback)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mq->callback((void *)msg);
>> =A0 =A0 =A0 }
>> =A0}
>>
>> =A0/*
>> =A0 * Mailbox interrupt handler
>> =A0 */
>> -static void mbox_txq_fn(struct request_queue *q)
>> -{
>> -}
>> -
>> -static void mbox_rxq_fn(struct request_queue *q)
>> -{
>> -}
>> -
>> =A0static void __mbox_tx_interrupt(struct omap_mbox *mbox)
>> =A0{
>> =A0 =A0 =A0 omap_mbox_disable_irq(mbox, IRQ_TX);
>> @@ -170,19 +162,20 @@ static void __mbox_tx_interrupt(struct omap_mb=
ox *mbox)
>>
>> =A0static void __mbox_rx_interrupt(struct omap_mbox *mbox)
>> =A0{
>> - =A0 =A0 struct request *rq;
>> + =A0 =A0 struct omap_mbox_queue *mq =3D mbox->rxq;
>> =A0 =A0 =A0 mbox_msg_t msg;
>> - =A0 =A0 struct request_queue *q =3D mbox->rxq->queue;
>> + =A0 =A0 int len;
>>
>> =A0 =A0 =A0 while (!mbox_fifo_empty(mbox)) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 rq =3D blk_get_request(q, WRITE, GFP_ATOMI=
C);
>> - =A0 =A0 =A0 =A0 =A0 =A0 if (unlikely(!rq))
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (unlikely(kfifo_avail(&mq->fifo) < size=
of(msg)))
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto nomem;
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 msg =3D mbox_fifo_read(mbox);
>>
>>
>> - =A0 =A0 =A0 =A0 =A0 =A0 blk_insert_request(q, rq, 0, (void *)msg);
>> + =A0 =A0 =A0 =A0 =A0 =A0 len =3D kfifo_in(&mq->fifo, (unsigned char=
 *)&msg, sizeof(msg));
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (unlikely(len !=3D sizeof(msg)))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("%s: kfifo_in anoma=
ly detected\n", __func__);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (mbox->ops->type =3D=3D OMAP_MBOX_TYP=
E1)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> =A0 =A0 =A0 }
>> @@ -207,11 +200,9 @@ static irqreturn_t mbox_interrupt(int irq, void=
 *p)
>> =A0}
>>
>> =A0static struct omap_mbox_queue *mbox_queue_alloc(struct omap_mbox =
*mbox,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 request_fn_proc *proc,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 void (*work) (struct work_struct *),
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 void (*tasklet)(unsigned long))
>> =A0{
>> - =A0 =A0 struct request_queue *q;
>> =A0 =A0 =A0 struct omap_mbox_queue *mq;
>>
>> =A0 =A0 =A0 mq =3D kzalloc(sizeof(struct omap_mbox_queue), GFP_KERNE=
L);
>> @@ -220,11 +211,8 @@ static struct omap_mbox_queue *mbox_queue_alloc=
(struct omap_mbox *mbox,
>>
>> =A0 =A0 =A0 spin_lock_init(&mq->lock);
>>
>> - =A0 =A0 q =3D blk_init_queue(proc, &mq->lock);
>> - =A0 =A0 if (!q)
>> + =A0 =A0 if (kfifo_alloc(&mq->fifo, MBOX_KFIFO_SIZE, GFP_KERNEL))
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto error;
>> - =A0 =A0 q->queuedata =3D mbox;
>> - =A0 =A0 mq->queue =3D q;
>>
>> =A0 =A0 =A0 if (work)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 INIT_WORK(&mq->work, work);
>> @@ -239,7 +227,7 @@ error:
>>
>> =A0static void mbox_queue_free(struct omap_mbox_queue *q)
>> =A0{
>> - =A0 =A0 blk_cleanup_queue(q->queue);
>> + =A0 =A0 kfifo_free(&q->fifo);
>> =A0 =A0 =A0 kfree(q);
>> =A0}
>>
>> @@ -269,14 +257,14 @@ static int omap_mbox_startup(struct omap_mbox =
*mbox)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto fail_request_irq;
>> =A0 =A0 =A0 }
>>
>> - =A0 =A0 mq =3D mbox_queue_alloc(mbox, mbox_txq_fn, NULL, mbox_tx_t=
asklet);
>> + =A0 =A0 mq =3D mbox_queue_alloc(mbox, NULL, mbox_tx_tasklet);
>> =A0 =A0 =A0 if (!mq) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENOMEM;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto fail_alloc_txq;
>> =A0 =A0 =A0 }
>> =A0 =A0 =A0 mbox->txq =3D mq;
>>
>> - =A0 =A0 mq =3D mbox_queue_alloc(mbox, mbox_rxq_fn, mbox_rx_work, N=
ULL);
>> + =A0 =A0 mq =3D mbox_queue_alloc(mbox, mbox_rx_work, NULL);
>> =A0 =A0 =A0 if (!mq) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENOMEM;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto fail_alloc_rxq;
>> --
>> 1.6.3.3
>>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
