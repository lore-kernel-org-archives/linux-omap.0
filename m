From: "Sapiens, Rene" <rene.sapiens@ti.com>
Subject: RE: [PATCH 4/7] omap:mailbox-send message in process context
Date: Thu, 21 Oct 2010 17:30:13 -0500
Message-ID: <D2943F03B81C9C458E44DFB213905E02010355C681@dlee04.ent.ti.com>
References: <1287108808-32119-1-git-send-email-h-kanigeri2@ti.com>
	<1287108808-32119-5-git-send-email-h-kanigeri2@ti.com>
	<D2943F03B81C9C458E44DFB213905E02010355C35E@dlee04.ent.ti.com>
 <AANLkTi=6fPONRaFmqrWkq8mxZacMCM+9xN9HM9FZJdja@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:41862 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751534Ab0JUWa3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 21 Oct 2010 18:30:29 -0400
In-Reply-To: <AANLkTi=6fPONRaFmqrWkq8mxZacMCM+9xN9HM9FZJdja@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hari Kanigeri <hari.kanigeri@gmail.com>
Cc: "Kanigeri, Hari" <h-kanigeri2@ti.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, linux omap <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Ohad Ben-Cohen <ohad@wizery.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>

Hari,

On Thursday, October 21, 2010 3:49 PM Hari Kanigeri wrote:
> Rene,
>=20
> Thanks for your comment.
>=20
>=20
>>> @@ -92,20 +92,25 @@ int omap_mbox_msg_send(struct omap_mbox *mbox,
>>> =A0 =A0 =A0 mbox_msg_t msg) struct omap_mbox_queue *mq =3D mbox->tx=
q;
>>> =A0 =A0 =A0 int ret =3D 0, len;
>>>=20
>>> - =A0 =A0 spin_lock(&mq->lock);
>>> + =A0 =A0 spin_lock_bh(&mq->lock);
>>>=20
>>=20
>> Please check if this scenario looks valid to you, as discussed and d=
epicted
>> with Fernando:
>>=20
>> Supposing that at this point the hw fifo is full and there are messa=
ges in
>> the kfifo.
>>=20
>>> =A0 =A0 =A0 if (kfifo_avail(&mq->fifo) < sizeof(msg)) {
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENOMEM;
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>>> =A0 =A0 =A0 }
>>>=20
>>=20
>> We reach this point.
>>=20
>> In this scenario, the DSP or other Core reads a message from the mbo=
x hw
>> fifo. The next happens:
>> 1.- The not full interrupt is triggered to the MPU.
>> 2.- The mbox's ISR schedules the tasklet to write the message.
>> 3.- The ISR is left and returns to here (since we still have the bh =
lock
>> the =A0 =A0tasklet won't run).
>>=20
>>> + =A0 =A0 if (!__mbox_poll_for_space(mbox)) {\
>>=20
>> 4.- We check for mbox_fifo_full and we have space. so the message is
>> written.=20
>>=20
>>> + =A0 =A0 =A0 =A0 =A0 =A0 mbox_fifo_write(mbox, msg);
>>=20
>> At this point it looks that the FIFO order is lost. We write this me=
ssage
>> before the ones in the kfifo.
>>=20
>=20
> Good point. I agree.
>=20
>> A solution for this could be checking if there are messages in the k=
fifo
>> before trying to write directly to the hw fifo, if so, just continue
>> scheduling the tasklet.
>=20
> A change something like this ?
>=20
> -       if (!__mbox_poll_for_space(mbox)) {
> +       if (kfifo_is_empty() && !__mbox_poll_for_space(mbox)) {

Yes, this looks good to me.

>                 mbox_fifo_write(mbox, msg);

Regards,
Rene--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
