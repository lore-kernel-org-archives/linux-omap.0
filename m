From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 2/5] OMAP242x omapdev: add OMAP242x omapdev records
Date: Wed, 10 Dec 2008 20:55:00 -0700 (MST)
Message-ID: <alpine.DEB.2.00.0812102050540.5902@utopia.booyaka.com>
References: <20081018215247.9699.35039.stgit@localhost.localdomain> <20081018215910.9699.13379.stgit@localhost.localdomain> <200810230034.26002.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-212534000-1228967700=:5902"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:52259 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754648AbYLKDzB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Dec 2008 22:55:01 -0500
In-Reply-To: <200810230034.26002.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: linux-omap@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-212534000-1228967700=:5902
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi David,

On Thu, 23 Oct 2008, David Brownell wrote:

> On Saturday 18 October 2008, Paul Walmsley wrote:
> > --- a/arch/arm/mach-omap2/omapdev-common.h
> > +++ b/arch/arm/mach-omap2/omapdev-common.h
> > @@ -21,6 +21,87 @@
> > =A0#include "omapdev3xxx.h"
> > =A0
> > =A0static struct omapdev *omapdevs[] =3D {
> > +
> > +#ifdef CONFIG_ARCH_OMAP2420
> > +=A0=A0=A0=A0=A0=A0=A0&mpu_242x_omapdev,
> > +=A0=A0=A0=A0=A0=A0=A0&iva_242x_omapdev,
> > +=A0=A0=A0=A0=A0=A0=A0&gfx_242x_omapdev,
> >=09...
>=20
> Urgh, this is unpleasant style:  declaration of a large
> static data structure in a header file.
>=20
> Cleaner:  just have some omap2420-specific C file declare
> the struct, and hand it off to whatever code uses it.

Not sure I understand what you'd like to see.  Could you send a short code=
=20
snippet as an example?  One caveat is that whatever we go with here will=20
need to work for a multi-OMAP kernel.


- Paul
--155748971-212534000-1228967700=:5902--
