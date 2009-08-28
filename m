From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] flush the function in sdram is not correct because sram
 is changed.
Date: Fri, 28 Aug 2009 03:15:28 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.0908280314320.15963@utopia.booyaka.com>
References: <af3ea28a0908272256k1743b528pdfb3dcdb88848544@mail.gmail.com>  <alpine.DEB.2.00.0908280229100.15963@utopia.booyaka.com> <af3ea28a0908280210y6d478a1bm340c7766f744df90@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-434110667-1251450928=:15963"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:40085 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751230AbZH1JP1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 28 Aug 2009 05:15:27 -0400
In-Reply-To: <af3ea28a0908280210y6d478a1bm340c7766f744df90@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ye janboe <janboe.ye@gmail.com>
Cc: tony@atomide.com, khilman@deeprootsystems.com, linux-omap@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-434110667-1251450928=:15963
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Janboe,

On Fri, 28 Aug 2009, ye janboe wrote:

> Hi, Paul
>=20
> I resent the patch after fix the format issue.
>=20
> Please help to review it.

Thanks, you fixed one issue, but this other one still needs to be fixed:

> > Your subject line should start with something like "[PATCH] OMAP SRAM:"=
,
> > and you should add a short patch description that describes the bug and
> > why the patch does what it does to fix it.

- Paul

>=20
> Thanks
>=20
> Janboe
>=20
> 2009/8/28 Paul Walmsley <paul@pwsan.com>:
> > Hello janboe,
> >
> > On Fri, 28 Aug 2009, ye janboe wrote:
> >
> >> >From f10090bf307066f1317d7152c6f9a6f395007d4a Mon Sep 17 00:00:00 200=
1
> >> From: janboe <janboe.ye@gmail.com>
> >> Date: Fri, 28 Aug 2009 13:50:57 +0800
> >> Subject: [PATCH] flush the function in sdram is not correct because
> >> sram is changed.
> >>
> >> Signed-off-by: janboe <janboe.ye@gmail.com>
> >
> > The technical part of the patch makes sense, but the patch format needs
> > to be changed.
> >
> > Your subject line should start with something like "[PATCH] OMAP SRAM:"=
,
> > and you should add a short patch description that describes the bug and
> > why the patch does what it does to fix it.
> >
> > Also your post should not include the "From", "Date", and "Subject" lin=
es
> > inside the E-mail. =A0You might wish to consider using 'git send-email'=
 or
> > at least 'git format-patch' if possible.
> >
> >
> > - Paul
> >
> >> ---
> >> =A0arch/arm/plat-omap/sram.c | =A0 =A02 +-
> >> =A01 files changed, 1 insertions(+), 1 deletions(-)
> >>
> >> diff --git a/arch/arm/plat-omap/sram.c b/arch/arm/plat-omap/sram.c
> >> index f2b0fa6..253fcf7 100644
> >> --- a/arch/arm/plat-omap/sram.c
> >> +++ b/arch/arm/plat-omap/sram.c
> >> @@ -270,7 +270,7 @@ void * omap_sram_push(void * start, unsigned long =
size)
> >> =A0 =A0 =A0 =A0 omap_sram_ceil -=3D size;
> >> =A0 =A0 =A0 =A0 omap_sram_ceil =3D ROUND_DOWN(omap_sram_ceil, sizeof(v=
oid *));
> >> =A0 =A0 =A0 =A0 memcpy((void *)omap_sram_ceil, start, size);
> >> - =A0 =A0 =A0 flush_icache_range((unsigned long)start, (unsigned long)=
(start + size));
> >> + =A0 =A0 =A0 flush_icache_range((unsigned long)omap_sram_ceil, (unsig=
ned
> >> long)(omap_sram_ceil + size));
> >>
> >> =A0 =A0 =A0 =A0 return (void *)omap_sram_ceil;
> >> =A0}
> >> --
> >> 1.6.3.3
> >>
> >
> >
> >
>=20


- Paul
--155748971-434110667-1251450928=:15963--
