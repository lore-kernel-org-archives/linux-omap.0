From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] Fix the size of twl4030 script
Date: Wed, 13 May 2009 16:40:14 -0700
Message-ID: <20090513234013.GD5593@atomide.com>
References: <4d34a0a70904092130r215f0eb3p6a45c4950c92e5c0@mail.gmail.com> <4d34a0a70905061835u4b6aaaabnb0819584e4d6ed8f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:65410 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753319AbZEMXkT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 13 May 2009 19:40:19 -0400
Content-Disposition: inline
In-Reply-To: <4d34a0a70905061835u4b6aaaabnb0819584e4d6ed8f@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kim Kyuwon <chammoru@gmail.com>, Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>
Cc: OMAP <linux-omap@vger.kernel.org>

* Kim Kyuwon <chammoru@gmail.com> [090506 18:36]:
> Hi All,
>=20
> I sent this patch about 1 month ago.
> Can anybody check I'm sending correct patch?

Peter, care to ack? Any news on sending the scripts part of twl
driver upstream?

Regards,

Tony
=20
> Thanks you!
> Kyuwon.
>=20
> 2009/4/10 Kim Kyuwon <chammoru@gmail.com>:
> > The array size of wrst_seq is ARRAY_SIZE(wrst_seq)
> >
> > Signed-off-by: Kim Kyuwon <q1.kim@samsung.com>
> > ---
> >  arch/arm/mach-omap2/board-3430sdp.c |    2 +-
> >  arch/arm/mach-omap2/board-ldp.c     |    2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/arm/mach-omap2/board-3430sdp.c
> > b/arch/arm/mach-omap2/board-3430sdp.c
> > index 03acac7..38550e2 100644
> > --- a/arch/arm/mach-omap2/board-3430sdp.c
> > +++ b/arch/arm/mach-omap2/board-3430sdp.c
> > @@ -473,7 +473,7 @@ static struct twl4030_ins wrst_seq[] __initdata=
 =3D {
> >  };
> >  static struct twl4030_script wrst_script __initdata =3D {
> >        .script =3D wrst_seq,
> > -       .size   =3D ARRAY_SIZE(wakeup_seq),
> > +       .size   =3D ARRAY_SIZE(wrst_seq),
> >        .flags  =3D TRITON_WRST_SCRIPT,
> >  };
> >
> > diff --git a/arch/arm/mach-omap2/board-ldp.c b/arch/arm/mach-omap2/=
board-ldp.c
> > index 804fd8e..da814d7 100644
> > --- a/arch/arm/mach-omap2/board-ldp.c
> > +++ b/arch/arm/mach-omap2/board-ldp.c
> > @@ -450,7 +450,7 @@ static struct twl4030_ins wrst_seq[] __initdata=
 =3D {
> >
> >  static struct twl4030_script wrst_script __initdata =3D {
> >        .script =3D wrst_seq,
> > -       .size   =3D ARRAY_SIZE(wakeup_seq),
> > +       .size   =3D ARRAY_SIZE(wrst_seq),
> >        .flags  =3D TRITON_WRST_SCRIPT,
> >  };
> >
> > --
> > 1.5.2.5
> >
> > --
> > Kyuwon (=EA=B7=9C=EC=9B=90)
> >
>=20
> --=20
> Kyuwon
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
