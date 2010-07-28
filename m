From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH 2/2] omap:mailbox-provide multiple reader support
Date: Wed, 28 Jul 2010 13:33:47 +0300
Message-ID: <AANLkTikfg1=cJSxyx9b1JbnEyGKGd+Uxx0K7ajduJj6y@mail.gmail.com>
References: <1279662096-3121-1-git-send-email-h-kanigeri2@ti.com>
	<1279662096-3121-3-git-send-email-h-kanigeri2@ti.com> <AANLkTi=tHyRBgO79e=LEPOS85z=87TEt1QOvXR+keZHG@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:55479 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754696Ab0G1KeP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 28 Jul 2010 06:34:15 -0400
Received: by wwj40 with SMTP id 40so2224853wwj.1
        for <linux-omap@vger.kernel.org>; Wed, 28 Jul 2010 03:34:13 -0700 (PDT)
In-Reply-To: <AANLkTi=tHyRBgO79e=LEPOS85z=87TEt1QOvXR+keZHG@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hari Kanigeri <h-kanigeri2@ti.com>
Cc: Linux Omap <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, "Guzman Lugo, Fernando" <fernando.lugo@ti.com>

Hi Hari,

On Wed, Jul 28, 2010 at 1:02 AM, Ohad Ben-Cohen <ohad@wizery.com> wrote=
:
> On Wed, Jul 21, 2010 at 12:41 AM, Hari Kanigeri <h-kanigeri2@ti.com> =
wrote:
> > This patch provides mutiple readers support for a mailbox
> > instance.
> >
> > Signed-off-by: Hari Kanigeri <h-kanigeri2@ti.com>
> > ---
> > =A0arch/arm/plat-omap/include/plat/mailbox.h | =A0 =A06 ++-
> > =A0arch/arm/plat-omap/mailbox.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 63=
 ++++++++++++++++------------
> > =A02 files changed, 40 insertions(+), 29 deletions(-)
> >
> > diff --git a/arch/arm/plat-omap/include/plat/mailbox.h b/arch/arm/p=
lat-omap/include/plat/mailbox.h
> > index 0486d64..c8e47d8 100644
> > --- a/arch/arm/plat-omap/include/plat/mailbox.h
> > +++ b/arch/arm/plat-omap/include/plat/mailbox.h
> > @@ -68,13 +68,15 @@ struct omap_mbox {
> > =A0 =A0 =A0 =A0void =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*priv;
> >
> > =A0 =A0 =A0 =A0void =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(*err_no=
tify)(void);
> > + =A0 =A0 =A0 atomic_t =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0use_count;
> > + =A0 =A0 =A0 struct blocking_notifier_head =A0 notifier;
> > =A0};
> >
> > =A0int omap_mbox_msg_send(struct omap_mbox *, mbox_msg_t msg);
> > =A0void omap_mbox_init_seq(struct omap_mbox *);
> >
> > -struct omap_mbox *omap_mbox_get(const char *);
> > -void omap_mbox_put(struct omap_mbox *);
> > +struct omap_mbox *omap_mbox_get(const char *, struct notifier_bloc=
k *nb);
>
> In this context, I'd like to change notifier to support adding a
> cookie which will be passed back to the handler function (unmodified,
> in a similar manner to request_irq's void *dev param).

This can be easily achieved with a simple container_of manipulation,
so please disregard my request : your patch is fine as-is. After it is
accepted, it'd be simple to add this context-get-back to dspbridge.

Thanks,
Ohad.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
