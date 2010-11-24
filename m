From: "Kanigeri, Hari" <h-kanigeri2@ti.com>
Subject: Re: [PATCH v4 1/5] OMAP: mailbox: change full flag per mailbox queue
 instead of global
Date: Wed, 24 Nov 2010 06:47:25 -0600
Message-ID: <AANLkTimQU+wer+mLQPpsaG4r_Jt9HfxKLVVoCpCvpZWG@mail.gmail.com>
References: <1290547617-16640-1-git-send-email-h-kanigeri2@ti.com>
	<1290547617-16640-2-git-send-email-h-kanigeri2@ti.com>
	<AANLkTikORr1tukDhfnJv0XhxCHSzvAP=KqicM5x30HHG@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:41149 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753707Ab0KXMr1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 24 Nov 2010 07:47:27 -0500
Received: by mail-qw0-f50.google.com with SMTP id 2so1365879qwi.23
        for <linux-omap@vger.kernel.org>; Wed, 24 Nov 2010 04:47:25 -0800 (PST)
In-Reply-To: <AANLkTikORr1tukDhfnJv0XhxCHSzvAP=KqicM5x30HHG@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Varadarajan, Charulatha" <charu@ti.com>
Cc: Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, linux omap <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Benoit Cousson <b-cousson@ti.com>, Felipe Balbi <balbi@ti.com>, Fernando Guzman Lugo <x0095840@ti.com>

On Tue, Nov 23, 2010 at 11:21 PM, Varadarajan, Charulatha <charu@ti.com=
> wrote:
> On Wed, Nov 24, 2010 at 02:56, Hari Kanigeri <h-kanigeri2@ti.com> wro=
te:
>> From: Fernando Guzman Lugo <x0095840@ti.com>
>>
>> The variable rq_full flag is a global variable, so if there are mult=
iple
>> mailbox users there will be conflicts. Now there is a full flag per
>> mailbox queue.
>>
>> Reported-by: Ohad Ben-Cohen <ohad@wizery.com>
>> Signed-off-by: Fernando Guzman Lugo <x0095840@ti.com>
>> Signed-off-by: Hari Kanigeri <h-kanigeri2@ti.com>
>> ---
>> =A0arch/arm/plat-omap/include/plat/mailbox.h | =A0 =A01 +
>> =A0arch/arm/plat-omap/mailbox.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A0=
9 +++++++--
>> =A02 files changed, 8 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm/plat-omap/include/plat/mailbox.h b/arch/arm/pl=
at-omap/include/plat/mailbox.h
>> index 9976565..13f2ef3 100644
>> --- a/arch/arm/plat-omap/include/plat/mailbox.h
>> +++ b/arch/arm/plat-omap/include/plat/mailbox.h
>> @@ -48,6 +48,7 @@ struct omap_mbox_queue {
>> =A0 =A0 =A0 =A0struct tasklet_struct =A0 tasklet;
>> =A0 =A0 =A0 =A0int =A0 =A0 (*callback)(void *);
>> =A0 =A0 =A0 =A0struct omap_mbox =A0 =A0 =A0 =A0*mbox;
>> + =A0 =A0 =A0 bool full;
>> =A0};
>>
>> =A0struct omap_mbox {
>> diff --git a/arch/arm/plat-omap/mailbox.c b/arch/arm/plat-omap/mailb=
ox.c
>> index d2fafb8..48e161c 100644
>> --- a/arch/arm/plat-omap/mailbox.c
>> +++ b/arch/arm/plat-omap/mailbox.c
>> @@ -33,7 +33,6 @@
>>
>> =A0static struct workqueue_struct *mboxd;
>> =A0static struct omap_mbox **mboxes;
>> -static bool rq_full;
>>
>> =A0static int mbox_configured;
>> =A0static DEFINE_MUTEX(mbox_configured_lock);
>> @@ -148,6 +147,12 @@ static void mbox_rx_work(struct work_struct *wo=
rk)
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (mq->callback)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mq->callback((void *)=
msg);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_lock_irq(&mq->lock);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (mq->full) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mq->full =3D false;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_mbox_enable_irq(m=
q->mbox, IRQ_RX);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock_irq(&mq->lock);
>> =A0 =A0 =A0 =A0}
>> =A0}
>>
>> @@ -170,7 +175,7 @@ static void __mbox_rx_interrupt(struct omap_mbox=
 *mbox)
>> =A0 =A0 =A0 =A0while (!mbox_fifo_empty(mbox)) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (unlikely(kfifo_avail(&mq->fifo) <=
 sizeof(msg))) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap_mbox_disable_irq=
(mbox, IRQ_RX);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 rq_full =3D true;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mq->full =3D true;
>
> Should this also be inside spin_lock_irq?
>

Not needed. this is already run from interrupt context.

Thank you,
Best regards,
Hari
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
