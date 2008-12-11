From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [PATCH 2/5] OMAP242x omapdev: add OMAP242x omapdev records
Date: Thu, 11 Dec 2008 10:10:13 +0200
Message-ID: <20081211081013.GF13287@gandalf.research.nokia.com>
References: <20081018215247.9699.35039.stgit@localhost.localdomain> <20081018215910.9699.13379.stgit@localhost.localdomain> <200810230034.26002.david-b@pacbell.net> <alpine.DEB.2.00.0812102050540.5902@utopia.booyaka.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:53706 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754339AbYLKIKu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Dec 2008 03:10:50 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.0812102050540.5902@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Paul Walmsley <paul@pwsan.com>
Cc: David Brownell <david-b@pacbell.net>, linux-omap@vger.kernel.org

On Wed, Dec 10, 2008 at 08:55:00PM -0700, Paul Walmsley wrote:
> Hi David,
>=20
> On Thu, 23 Oct 2008, David Brownell wrote:
>=20
> > On Saturday 18 October 2008, Paul Walmsley wrote:
> > > --- a/arch/arm/mach-omap2/omapdev-common.h
> > > +++ b/arch/arm/mach-omap2/omapdev-common.h
> > > @@ -21,6 +21,87 @@
> > > =A0#include "omapdev3xxx.h"
> > > =A0
> > > =A0static struct omapdev *omapdevs[] =3D {
> > > +
> > > +#ifdef CONFIG_ARCH_OMAP2420
> > > +=A0=A0=A0=A0=A0=A0=A0&mpu_242x_omapdev,
> > > +=A0=A0=A0=A0=A0=A0=A0&iva_242x_omapdev,
> > > +=A0=A0=A0=A0=A0=A0=A0&gfx_242x_omapdev,
> > >	...
> >=20
> > Urgh, this is unpleasant style:  declaration of a large
> > static data structure in a header file.
> >=20
> > Cleaner:  just have some omap2420-specific C file declare
> > the struct, and hand it off to whatever code uses it.
>=20
> Not sure I understand what you'd like to see.  Could you send a short=
 code=20
> snippet as an example?  One caveat is that whatever we go with here w=
ill=20
> need to work for a multi-OMAP kernel.

I think dave is saying that you could move static struct omapdev to a
C-file and probably have separate tables for each omap version, then yo=
u
can pass a reference to it to a function which would do all the magic.

Something like platform_add_devices(), then you pass the reference to
the table and the table size.

--=20
balbi
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
