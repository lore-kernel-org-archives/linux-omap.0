From: Hari Kanigeri <hari.kanigeri@gmail.com>
Subject: Re: [PATCH 4/7] omap:mailbox-send message in process context
Date: Thu, 21 Oct 2010 15:49:10 -0500
Message-ID: <AANLkTi=6fPONRaFmqrWkq8mxZacMCM+9xN9HM9FZJdja@mail.gmail.com>
References: <1287108808-32119-1-git-send-email-h-kanigeri2@ti.com>
	<1287108808-32119-5-git-send-email-h-kanigeri2@ti.com>
	<D2943F03B81C9C458E44DFB213905E02010355C35E@dlee04.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:58642 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757304Ab0JUUtL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 21 Oct 2010 16:49:11 -0400
Received: by gyg4 with SMTP id 4so15564gyg.19
        for <linux-omap@vger.kernel.org>; Thu, 21 Oct 2010 13:49:11 -0700 (PDT)
In-Reply-To: <D2943F03B81C9C458E44DFB213905E02010355C35E@dlee04.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Sapiens, Rene" <rene.sapiens@ti.com>
Cc: "Kanigeri, Hari" <h-kanigeri2@ti.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, linux omap <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Ohad Ben-Cohen <ohad@wizery.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>

Rene,

Thanks for your comment.


>> @@ -92,20 +92,25 @@ int omap_mbox_msg_send(struct omap_mbox *mbox,
>> =A0 =A0 =A0 mbox_msg_t msg) struct omap_mbox_queue *mq =3D mbox->txq=
;
>> =A0 =A0 =A0 int ret =3D 0, len;
>>
>> - =A0 =A0 spin_lock(&mq->lock);
>> + =A0 =A0 spin_lock_bh(&mq->lock);
>>
>
> Please check if this scenario looks valid to you, as discussed and de=
picted
> with Fernando:
>
> Supposing that at this point the hw fifo is full and there are messag=
es in
> the kfifo.
>
>> =A0 =A0 =A0 if (kfifo_avail(&mq->fifo) < sizeof(msg)) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENOMEM;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> =A0 =A0 =A0 }
>>
>
> We reach this point.
>
> In this scenario, the DSP or other Core reads a message from the mbox=
 hw fifo.
> The next happens:
> 1.- The not full interrupt is triggered to the MPU.
> 2.- The mbox's ISR schedules the tasklet to write the message.
> 3.- The ISR is left and returns to here (since we still have the bh l=
ock the
> =A0 =A0tasklet won't run).
>
>> + =A0 =A0 if (!__mbox_poll_for_space(mbox)) {\
>
> 4.- We check for mbox_fifo_full and we have space. so the message is =
written.
>
>> + =A0 =A0 =A0 =A0 =A0 =A0 mbox_fifo_write(mbox, msg);
>
> At this point it looks that the FIFO order is lost. We write this mes=
sage
> before the ones in the kfifo.
>

Good point. I agree.

> A solution for this could be checking if there are messages in the kf=
ifo
> before trying to write directly to the hw fifo, if so, just continue
> scheduling the tasklet.

A change something like this ?

-       if (!__mbox_poll_for_space(mbox)) {
+       if (kfifo_is_empty() && !__mbox_poll_for_space(mbox)) {
                mbox_fifo_write(mbox, msg);

Thank you,
Best regards,
Hari
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
