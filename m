From: "Sapiens, Rene" <rene.sapiens@ti.com>
Subject: RE: [PATCH 09/10] omap: mailbox: convert block api to kfifo
Date: Tue, 10 Aug 2010 10:00:38 -0500
Message-ID: <D2943F03B81C9C458E44DFB213905E02B7328E6C@dlee04.ent.ti.com>
References: <1275546858-29507-1-git-send-email-Hiroshi.DOYU@nokia.com>
 	<1275546858-29507-10-git-send-email-Hiroshi.DOYU@nokia.com>
 	<D2943F03B81C9C458E44DFB213905E02B6325C6A@dlee04.ent.ti.com>
 	<AANLkTik4lW3_xP_e4BStJEYpHlVoNjemEz8zWfIE7gRU@mail.gmail.com>
 	<496565EC904933469F292DDA3F1663E602CA4D88F3@dlee06.ent.ti.com>
 <AANLkTikZ2uDpuK1DjJLk_pSiogQyStwJVG952o79_NjX@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:58334 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932143Ab0HJPAp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Aug 2010 11:00:45 -0400
In-Reply-To: <AANLkTikZ2uDpuK1DjJLk_pSiogQyStwJVG952o79_NjX@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>, "Guzman Lugo, Fernando" <fernando.lugo@ti.com>
Cc: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Kanigeri, Hari" <h-kanigeri2@ti.com>

Hi Ohad,

Sure I will do it.

Regards,
Rene

> -----Original Message-----
> From: Ohad Ben-Cohen [mailto:ohad@wizery.com]
> Sent: Tuesday, August 10, 2010 9:43 AM
> To: Guzman Lugo, Fernando; Sapiens, Rene
> Cc: Hiroshi DOYU; linux-omap@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org; Kanigeri, Hari
> Subject: Re: [PATCH 09/10] omap: mailbox: convert block api to kfifo
>=20
> Hi Rene,
>=20
>=20
> On Wed, Jun 9, 2010 at 8:38 AM, Guzman Lugo, Fernando
> <fernando.lugo@ti.com> wrote:
> >>On Tue, Jun 8, 2010 at 7:16 PM, Sapiens, Rene <rene.sapiens@ti.com>
> wrote:
> >>> In mbox_rx_work() you are removing the lines that enable back
> the =A0mbox irq for the RX case, but inside =A0__mbox_rx_interrupt() =
this
> interrupt =A0is disabled in the case that the kfifo for Rx >mailbox g=
ets
> full. So I think that we need to enable it back as soon as there is s=
pace
> in this kfifo.
> >>
> >>
> >>Actually these irq on/off lines are not part of my patch; they are
> >>introduced by patch 05/10 on top of which my patches were rebased.
> >>
> >>Nevertheless I agree with you - the kfifo migration patch should no=
t
> >>affect that irq on/off behavior. It's probably just a rebase gotcha=
=2E
> >>
> >>But now that you point me to this irq on/off thing, it looks a bit
> >>broken in terms of multiple concurrent mbox support since it relies=
 on
> >>a global rq_full state. I guess it'd be better to hold that rq_full
> >>state in the relevant mbox queue state itself.
> >>
> >>Fernando what do you think ?
> >
> > Yes, you are right Ohad. Only should be disable the "new message"
> interrupt of the mailbox which kfifo is full.
>=20
>=20
>=20
> Once Fernando's fix will get thru, we will be able to fix the rebase
> error that you pointed out.
>=20
> Unfortunately I will not have any email access in the next 3 weeks,
> and I was hoping maybe you could submit a fix for this once Fernando'=
s
> fix is accepted ? I would really like us to fix this early in the day=
s
> of 2.6.36, maybe even during the merge window.
>=20
> Thanks a lot,
> Ohad.
>=20
> >
> > regards,
> > Fernando.
> >
> >>
> >>Thanks,
> >>Ohad.
> >
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
