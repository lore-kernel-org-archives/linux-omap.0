From: "Guzman Lugo, Fernando" <fernando.lugo@ti.com>
Subject: RE: [PATCH] mailbox: change full flag per mailbox queue instead of
 	global
Date: Thu, 17 Jun 2010 11:42:41 -0500
Message-ID: <496565EC904933469F292DDA3F1663E602CBC9385B@dlee06.ent.ti.com>
References: <1276534269-19179-1-git-send-email-x0095840@ti.com>
 <AANLkTimQrOIbsvQw7yv2x_KJmsv2p5KfNdcsNk2_DWGm@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:48975 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752795Ab0FQQo2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 17 Jun 2010 12:44:28 -0400
In-Reply-To: <AANLkTimQrOIbsvQw7yv2x_KJmsv2p5KfNdcsNk2_DWGm@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "hiroshi.doyu@nokia.com" <hiroshi.doyu@nokia.com>

Hi Ohad,

> -----Original Message-----
> From: Ohad Ben-Cohen [mailto:ohad@wizery.com]
> Sent: Wednesday, June 16, 2010 4:18 PM
> To: Guzman Lugo, Fernando
> Cc: linux-arm-kernel@lists.infradead.org; linux-omap@vger.kernel.org;
> hiroshi.doyu@nokia.com
> Subject: Re: [PATCH] mailbox: change full flag per mailbox queue inst=
ead
> of global
>=20
> On Mon, Jun 14, 2010 at 11:51 AM, Fernando Guzman Lugo <x0095840@ti.c=
om>
> wrote:
> > As pointed by Ben Ohand, the variable rq_full flag is a global
> > variable, so if there are multiple mailbox users there will be
> > conflics. Now there is a full flag per mailbox queue.
> >
> > Reported-by: Ohad Ben-Cohen <ohad@wizery.com>
> > Signed-off-by: Fernando Guzman Lugo <x0095840@ti.com>
> > ---
> > =A0arch/arm/plat-omap/include/plat/mailbox.h | =A0 =A01 +
> > =A0arch/arm/plat-omap/mailbox.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A0=
7 +++----
> > =A02 files changed, 4 insertions(+), 4 deletions(-)
>=20
>=20
> Thanks, Fernando, it looks good !
>=20
> Since the original patch wasn't merged yet, it might make more sense
> to squash it with this fix into a single patch, instead of introducin=
g
> this fix as a new patch. what do you think ?

Sound good. I will send that patch again then. Please discard this path=
c.

Regards,
=46ernando.

>=20
> >
> > diff --git a/arch/arm/plat-omap/include/plat/mailbox.h b/arch/arm/p=
lat-
> omap/include/plat/mailbox.h
> > index 729166b..a6144b8 100644
> > --- a/arch/arm/plat-omap/include/plat/mailbox.h
> > +++ b/arch/arm/plat-omap/include/plat/mailbox.h
> > @@ -47,6 +47,7 @@ struct omap_mbox_queue {
> > =A0 =A0 =A0 =A0struct tasklet_struct =A0 tasklet;
> > =A0 =A0 =A0 =A0int =A0 =A0 (*callback)(void *);
> > =A0 =A0 =A0 =A0struct omap_mbox =A0 =A0 =A0 =A0*mbox;
> > + =A0 =A0 =A0 bool =A0 =A0full;
> > =A0};
> >
> > =A0struct omap_mbox {
> > diff --git a/arch/arm/plat-omap/mailbox.c b/arch/arm/plat-omap/mail=
box.c
> > index 8d86b0b..a1e274e 100644
> > --- a/arch/arm/plat-omap/mailbox.c
> > +++ b/arch/arm/plat-omap/mailbox.c
> > @@ -30,7 +30,6 @@
> >
> > =A0static struct omap_mbox *mboxes;
> > =A0static DEFINE_RWLOCK(mboxes_lock);
> > -static bool rq_full;
> >
> > =A0static int mbox_configured;
> > =A0static DEFINE_MUTEX(mbox_configured_lock);
> > @@ -140,9 +139,9 @@ static void mbox_rx_work(struct work_struct *wo=
rk)
> > =A0 =A0 =A0 =A0while (1) {
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0spin_lock_irqsave(q->queue_lock, fla=
gs);
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0rq =3D blk_fetch_request(q);
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (rq_full) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (mbox->rxq->full) {
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap_mbox_enable_irq=
(mbox, IRQ_RX);
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 rq_full =3D false;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mbox->rxq->full =3D f=
alse;
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0spin_unlock_irqrestore(q->queue_lock=
, flags);
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (!rq)
> > @@ -183,7 +182,7 @@ static void __mbox_rx_interrupt(struct omap_mbo=
x
> *mbox)
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0rq =3D blk_get_request(q, WRITE, GFP=
_ATOMIC);
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (unlikely(!rq)) {
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap_mbox_disable_ir=
q(mbox, IRQ_RX);
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 rq_full =3D true;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mbox->rxq->full =3D t=
rue;
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto nomem;
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> >
> > --
> > 1.6.3.3
> >
> >
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
