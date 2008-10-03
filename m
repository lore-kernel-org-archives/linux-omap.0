From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: RE: [PATCH v2] OMAP3: Update USBHOST pinmux settings
Date: Fri, 3 Oct 2008 18:50:09 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB02D603E9C2@dbde02.ent.ti.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB02D603E114@dbde02.ent.ti.com>
 <200810022351.04241.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:45405 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750797AbYJCNUV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Oct 2008 09:20:21 -0400
In-Reply-To: <200810022351.04241.david-b@pacbell.net>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>

=20

> -----Original Message-----
> From: David Brownell [mailto:david-b@pacbell.net]=20
> On Tuesday 30 September 2008, Gadiyar, Anand wrote:
> > From: Anand Gadiyar <gadiyar@ti.com>
> >=20
> > Add pin-mux settings for OHCI in PHY mode.
> > Also change settings for EHCI in TLL mode.
> >=20
> > Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
> > ---
> > Fixed comments below. Also fixed one pin that should
> > have been marked output, but was wrongly marked input.
> >=20
> > =A0arch/arm/mach-omap2/mux.c =A0 =A0 =A0 =A0 =A0 =A0 | =A0 67 +++++=
++++++++++++++++++++++-------
> > =A0arch/arm/plat-omap/include/mach/mux.h | =A0 26 ++++++++++++-
> > =A02 files changed, 80 insertions(+), 13 deletions(-)
>=20
> I didn't see anything obvious to complain about, but then I've
> not delved deeply into OMAP3 EHCI.
>=20
> Were you the person who was looking to package the PHY/TLL
> mode setup in platform data?  Any progress on that?

Yup, that was me. Patches coming up over the weekend.

>=20
> (I added EHCI to my Beagle/Overo config, and it came up
> with all kinds of nonsense on the Beagle.  Configured
> several ports, not just one, and in fact this board does
> not even *have* the EHCI transceiver.  So it was very
> obvious that EHCI setup wasn't right yet.  That's even
> apart from the messaging goofs, which have trivial fixes
> I'll send along in a while.)

Yup. It currently assumes all ports are PHY mode or all ports
are TLL mode.

>=20
> - dave
>=20
>=20
> --
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
