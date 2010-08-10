From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH 09/10] omap: mailbox: convert block api to kfifo
Date: Tue, 10 Aug 2010 18:01:51 +0300
Message-ID: <AANLkTimhOg0o8m7DhLvDCCKHieyu0i4GRJM51=_WZUcm@mail.gmail.com>
References: <1275546858-29507-1-git-send-email-Hiroshi.DOYU@nokia.com>
	<1275546858-29507-10-git-send-email-Hiroshi.DOYU@nokia.com>
	<D2943F03B81C9C458E44DFB213905E02B6325C6A@dlee04.ent.ti.com>
	<AANLkTik4lW3_xP_e4BStJEYpHlVoNjemEz8zWfIE7gRU@mail.gmail.com>
	<496565EC904933469F292DDA3F1663E602CA4D88F3@dlee06.ent.ti.com>
	<AANLkTikZ2uDpuK1DjJLk_pSiogQyStwJVG952o79_NjX@mail.gmail.com>
	<D2943F03B81C9C458E44DFB213905E02B7328E6C@dlee04.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:65377 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932164Ab0HJPCL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Aug 2010 11:02:11 -0400
Received: by pwj7 with SMTP id 7so1779851pwj.19
        for <linux-omap@vger.kernel.org>; Tue, 10 Aug 2010 08:02:11 -0700 (PDT)
In-Reply-To: <D2943F03B81C9C458E44DFB213905E02B7328E6C@dlee04.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Sapiens, Rene" <rene.sapiens@ti.com>
Cc: "Guzman Lugo, Fernando" <fernando.lugo@ti.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Kanigeri, Hari" <h-kanigeri2@ti.com>

On Tue, Aug 10, 2010 at 6:00 PM, Sapiens, Rene <rene.sapiens@ti.com> wr=
ote:
> Hi Ohad,
>
> Sure I will do it.

Thanks a lot, Rene !
Ohad.


>
> Regards,
> Rene
>
>> -----Original Message-----
>> From: Ohad Ben-Cohen [mailto:ohad@wizery.com]
>> Sent: Tuesday, August 10, 2010 9:43 AM
>> To: Guzman Lugo, Fernando; Sapiens, Rene
>> Cc: Hiroshi DOYU; linux-omap@vger.kernel.org; linux-arm-
>> kernel@lists.infradead.org; Kanigeri, Hari
>> Subject: Re: [PATCH 09/10] omap: mailbox: convert block api to kfifo
>>
>> Hi Rene,
>>
>>
>> On Wed, Jun 9, 2010 at 8:38 AM, Guzman Lugo, Fernando
>> <fernando.lugo@ti.com> wrote:
>> >>On Tue, Jun 8, 2010 at 7:16 PM, Sapiens, Rene <rene.sapiens@ti.com=
>
>> wrote:
>> >>> In mbox_rx_work() you are removing the lines that enable back
>> the =A0mbox irq for the RX case, but inside =A0__mbox_rx_interrupt()=
 this
>> interrupt =A0is disabled in the case that the kfifo for Rx >mailbox =
gets
>> full. So I think that we need to enable it back as soon as there is =
space
>> in this kfifo.
>> >>
>> >>
>> >>Actually these irq on/off lines are not part of my patch; they are
>> >>introduced by patch 05/10 on top of which my patches were rebased.
>> >>
>> >>Nevertheless I agree with you - the kfifo migration patch should n=
ot
>> >>affect that irq on/off behavior. It's probably just a rebase gotch=
a.
>> >>
>> >>But now that you point me to this irq on/off thing, it looks a bit
>> >>broken in terms of multiple concurrent mbox support since it relie=
s on
>> >>a global rq_full state. I guess it'd be better to hold that rq_ful=
l
>> >>state in the relevant mbox queue state itself.
>> >>
>> >>Fernando what do you think ?
>> >
>> > Yes, you are right Ohad. Only should be disable the "new message"
>> interrupt of the mailbox which kfifo is full.
>>
>>
>>
>> Once Fernando's fix will get thru, we will be able to fix the rebase
>> error that you pointed out.
>>
>> Unfortunately I will not have any email access in the next 3 weeks,
>> and I was hoping maybe you could submit a fix for this once Fernando=
's
>> fix is accepted ? I would really like us to fix this early in the da=
ys
>> of 2.6.36, maybe even during the merge window.
>>
>> Thanks a lot,
>> Ohad.
>>
>> >
>> > regards,
>> > Fernando.
>> >
>> >>
>> >>Thanks,
>> >>Ohad.
>> >
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
