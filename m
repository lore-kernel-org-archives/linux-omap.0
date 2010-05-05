From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 3/4] omap: mailbox: fix reverse likeliness
Date: Wed, 5 May 2010 08:21:35 -0700
Message-ID: <20100505152135.GV29604@atomide.com>
References: <1272815071-2827-1-git-send-email-ohad@wizery.com>
 <1272815071-2827-4-git-send-email-ohad@wizery.com>
 <20100503180224.GV29604@atomide.com>
 <s2nda15981b1005040447v335b0d34k1aa812404f478cd4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:57523 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757882Ab0EEPVi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 May 2010 11:21:38 -0400
Content-Disposition: inline
In-Reply-To: <s2nda15981b1005040447v335b0d34k1aa812404f478cd4@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: linux-omap@vger.kernel.org, Kanigeri Hari <h-kanigeri2@ti.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>

* Ohad Ben-Cohen <ohad@wizery.com> [100504 04:42]:
> On Mon, May 3, 2010 at 9:02 PM, Tony Lindgren <tony@atomide.com> wrot=
e:
> > * Ohad Ben-Cohen <ohad@wizery.com> [100502 08:40]:
> >> Fix reverse likeliness
> >>
> >> Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
> >> ---
> >> If you want, you can also reach me at < ohadb at ti dot com >.
> >>
> >> =C2=A0arch/arm/plat-omap/mailbox.c | =C2=A0 =C2=A04 ++--
> >> =C2=A01 files changed, 2 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/arch/arm/plat-omap/mailbox.c b/arch/arm/plat-omap/mai=
lbox.c
> >> index 5140efc..5309213 100644
> >> --- a/arch/arm/plat-omap/mailbox.c
> >> +++ b/arch/arm/plat-omap/mailbox.c
> >> @@ -290,7 +290,7 @@ static int omap_mbox_startup(struct omap_mbox =
*mbox)
> >> =C2=A0 fail_alloc_txq:
> >> =C2=A0 =C2=A0 =C2=A0 free_irq(mbox->irq, mbox);
> >> =C2=A0 fail_request_irq:
> >> - =C2=A0 =C2=A0 if (unlikely(mbox->ops->shutdown))
> >> + =C2=A0 =C2=A0 if (likely(mbox->ops->shutdown))
> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mbox->ops->shutdo=
wn(mbox);
> >>
> >> =C2=A0 =C2=A0 =C2=A0 return ret;
> >> @@ -303,7 +303,7 @@ static void omap_mbox_fini(struct omap_mbox *m=
box)
> >>
> >> =C2=A0 =C2=A0 =C2=A0 free_irq(mbox->irq, mbox);
> >>
> >> - =C2=A0 =C2=A0 if (unlikely(mbox->ops->shutdown)) {
> >> + =C2=A0 =C2=A0 if (likely(mbox->ops->shutdown)) {
> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 spin_lock(&mboxes=
_lock);
> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (mbox_configur=
ed > 0)
> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 mbox_configured--;
> >
> > Does this code path need to be optimized? :)
> >
> > How about just get rid of the (un)likely here?
>=20
> I like this :)
>=20
> If we're at it, there are additional cold-path (un)likely macros I
> want to target:

Looks good to me.

Hiroshi, care to ack/nak all the mailbox and iommu patches you want
me to merge? Or if you have them in some git branch against mainline
-rc6 that would be cool too.

We need to get the ones we want to merge into linux-arm-kernel for
review soon, I don't think they been posted there yet.

Regards,

Tony


=20
> From a921f13dadc02106a2cabb15e3813411d3fcb3a8 Mon Sep 17 00:00:00 200=
1
> From: Ohad Ben-Cohen <ohad@wizery.com>
> Date: Sat, 17 Apr 2010 01:57:43 +0300
> Subject: [PATCH 3/4] omap: mailbox: remove (un)likely macros from col=
d paths
>=20
> Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
> ---
>  arch/arm/plat-omap/mailbox.c |   10 +++++-----
>  1 files changed, 5 insertions(+), 5 deletions(-)
>=20
> diff --git a/arch/arm/plat-omap/mailbox.c b/arch/arm/plat-omap/mailbo=
x.c
> index 5140efc..7c60550 100644
> --- a/arch/arm/plat-omap/mailbox.c
> +++ b/arch/arm/plat-omap/mailbox.c
> @@ -248,12 +248,12 @@ static int omap_mbox_startup(struct omap_mbox *=
mbox)
>         int ret =3D 0;
>         struct omap_mbox_queue *mq;
>=20
> -       if (likely(mbox->ops->startup)) {
> +       if (mbox->ops->startup) {
>                 spin_lock(&mboxes_lock);
>                 if (!mbox_configured)
>                         ret =3D mbox->ops->startup(mbox);
>=20
> -               if (unlikely(ret)) {
> +               if (ret) {
>                         spin_unlock(&mboxes_lock);
>                         return ret;
>                 }
> @@ -263,7 +263,7 @@ static int omap_mbox_startup(struct omap_mbox *mb=
ox)
>=20
>         ret =3D request_irq(mbox->irq, mbox_interrupt, IRQF_SHARED,
>                                 mbox->name, mbox);
> -       if (unlikely(ret)) {
> +       if (ret) {
>                 printk(KERN_ERR
>                         "failed to register mailbox interrupt:%d\n", =
ret);
>                 goto fail_request_irq;
> @@ -290,7 +290,7 @@ static int omap_mbox_startup(struct omap_mbox *mb=
ox)
>   fail_alloc_txq:
>         free_irq(mbox->irq, mbox);
>   fail_request_irq:
> -       if (unlikely(mbox->ops->shutdown))
> +       if (mbox->ops->shutdown)
>                 mbox->ops->shutdown(mbox);
>=20
>         return ret;
> @@ -303,7 +303,7 @@ static void omap_mbox_fini(struct omap_mbox *mbox=
)
>=20
>         free_irq(mbox->irq, mbox);
>=20
> -       if (unlikely(mbox->ops->shutdown)) {
> +       if (mbox->ops->shutdown) {
>                 spin_lock(&mboxes_lock);
>                 if (mbox_configured > 0)
>                         mbox_configured--;
> --=20
> 1.6.3.3
>=20
> I'll wait a day or two for more comments, and send a v3 series.
>=20
> Thanks,
> Ohad.
>=20
> >
> > Regards,
> >
> > Tony
> >
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
