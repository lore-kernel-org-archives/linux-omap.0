From: "Wang Sawsd-A24013" <cqwang@motorola.com>
Subject: RE: [PATCH 1/2] Support OMAP3 VC adaptation with different Power IC
Date: Fri, 26 Jun 2009 00:00:50 +0800
Message-ID: <B00E06E2766C2744B022DE9BAF3C59D5465B7B@zmy16exm69.ds.mot.com>
References: <4A42D208.4060403@android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=gb2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail153.messagelabs.com ([216.82.253.51]:4984 "EHLO
	mail153.messagelabs.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753061AbZFYQBO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Jun 2009 12:01:14 -0400
Received: from il27exr04.cig.mot.com ([10.17.196.73])
	by motgate5.mot.com (8.14.3/8.14.3) with ESMTP id n5PG1GeN009210
	for <linux-omap@vger.kernel.org>; Thu, 25 Jun 2009 09:01:16 -0700 (MST)
Received: from il27vts03 (il27vts03.cig.mot.com [10.17.196.87])
	by il27exr04.cig.mot.com (8.13.1/Vontu) with SMTP id n5PG1FDB029381
	for <linux-omap@vger.kernel.org>; Thu, 25 Jun 2009 11:01:15 -0500 (CDT)
Received: from zmy16exm69.ds.mot.com (zmy16exm69.ap.mot.com [10.179.4.36])
	by il27exr04.cig.mot.com (8.13.1/8.13.0) with ESMTP id n5PG1EkU029365
	for <linux-omap@vger.kernel.org>; Thu, 25 Jun 2009 11:01:15 -0500 (CDT)
Content-class: urn:content-classes:message
In-Reply-To: <4A42D208.4060403@android.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mike Chan <mike@android.com>
Cc: linux-omap@vger.kernel.org

> -----Original Message-----
> From: Mike Chan [mailto:mike@android.com]=20
> Sent: 2009=C4=EA6=D4=C225=C8=D5 9:25
> To: Wang Sawsd-A24013
> Cc: linux-omap@vger.kernel.org
> Subject: Re: [PATCH 1/2] Support OMAP3 VC adaptation with=20
> different Power IC
>=20
> Wang Sawsd-A24013 wrote:
> > From c1aba8ba7af3ddd16346d95795bda71e65baa4d0 Mon Sep 17=20
> 00:00:00 2001
> > From: Chunqiu Wang <cqwang@motorola.com>
> > Date: Wed, 24 Jun 2009 06:48:52 +0800
> > Subject: [PATCH] Support OMAP3 VC adaptation with different Power I=
C
> >
> > Current OMAP SmartReflex driver only supports TI Triton
> > Power IC, add a callback to make it possible to use
> > different PowerIC and use different settings to
> > configure OMAP3 Voltage Controller for DVFS
> >
> > Board file can setup a new function to have different settings
> > on SR to configure their Power IC for voltage scaling
> >
> > Signed-off-by: Chunqiu Wang <cqwang@motorola.com>
> > ---
> >  arch/arm/mach-omap2/smartreflex.c |   13 +++++++++++++
> >  arch/arm/mach-omap2/smartreflex.h |    4 ++++
> >  arch/arm/plat-omap/Kconfig        |    2 +-
> >  3 files changed, 18 insertions(+), 1 deletions(-)
> >
> > diff --git a/arch/arm/mach-omap2/smartreflex.c
> > b/arch/arm/mach-omap2/smartreflex.c
> > index 9d462e3..bacf602 100644
> > --- a/arch/arm/mach-omap2/smartreflex.c
> > +++ b/arch/arm/mach-omap2/smartreflex.c
> > @@ -52,6 +52,8 @@ struct omap_sr {
> > =20
> >  #define SR_REGADDR(offs)	(sr->srbase_addr + offset)
> > =20
> > +static omap3_voltagescale_vcbypass_t omap3_volscale_vcbypass_fun;
> >  =20
> Perhaps use
> static int (*omap3_volscale_vcbypass_fun) (u32, u32, u8, u8);
>=20
> This gets rid of the compiler warning on incompatible pointer=20
> types when=20
> you register a function via omap3_voltagescale_vcbypass_setup().
>=20
> -- Mike
Thanks Mike, but we do not see the warnning with the original
Code, note this patch is slightly different with the one we sent
To you based on K29, this new patch have four parameters
Sinc some change has been made in the
sr_voltagescale_vcbypass to add two more parameters.

Is your warnning caused by this?

Thanks,
Chunqiu
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
