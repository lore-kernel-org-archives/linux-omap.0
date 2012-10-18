From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH v3] ARM: OMAP: i2c: fix interrupt flood during resume
Date: Thu, 18 Oct 2012 10:11:50 +0300
Message-ID: <20121018071149.GI11137@arwen.pp.htv.fi>
References: <1349871480-25182-1-git-send-email-kalle.jokiniemi@jollamobile.com>
 <87ipag90om.fsf@deeprootsystems.com>
 <20121017160200.GA6567@arwen.pp.htv.fi>
 <1350543073.2014.35.camel@kj-X230>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ibvzjYYg+QDzMCy1"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:33151 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751272Ab2JRHRl (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 18 Oct 2012 03:17:41 -0400
Content-Disposition: inline
In-Reply-To: <1350543073.2014.35.camel@kj-X230>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: kalle.jokiniemi@jolla.com
Cc: balbi@ti.com, Kevin Hilman <khilman@deeprootsystems.com>, linux-i2c@vger.kernel.org, w.sang@pengutronix.de, ben-linux@fluff.org, tony@atomide.com, linux-omap@vger.kernel.org, grygorii.strashko@ti.com, shubhrajyoti@ti.com

--ibvzjYYg+QDzMCy1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Oct 18, 2012 at 09:51:13AM +0300, Kalle Jokiniemi wrote:
> ke, 2012-10-17 kello 19:02 +0300, Felipe Balbi kirjoitti:
> > Hi,
> >=20
> > On Thu, Oct 11, 2012 at 02:08:25PM -0700, Kevin Hilman wrote:
> > > Hi Kalle,
> > >=20
> > > Kalle Jokiniemi <kalle.jokiniemi@jollamobile.com> writes:
> > >=20
> > > > The resume_noirq enables interrupts one-by-one starting from
> > > > first one. Now if the wake up event for suspend came from i2c
> > > > device, the i2c bus irq gets enabled before the threaded
> > > > i2c device irq, causing a flood of i2c bus interrupts as the
> > > > threaded irq that should clear the event is not enabled yet.
> > > >
> > > > Fixed the issue by adding suspend_noirq and resume_early
> > > > functions that keep i2c bus interrupts disabled until
> > > > resume_noirq has run completely.
> > > >
> > > > Issue was detected doing a wake up from autosleep with
> > > > twl4030 power key on N9. Patch tested on N9.
> > > >
> > > > Signed-off-by: Kalle Jokiniemi <kalle.jokiniemi@jollamobile.com>
> > >=20
> > > This version looks good, thanks for the extra comments.
> > >=20
> > > Reviewed-by: Kevin Hilman <khilman@ti.com>
> > > Tested-by: Kevin Hilman <khilman@ti.com>
> > >=20
> > > Wolfram, This should also probably be Cc'd to stable since it affects
> > > earlier kernels as well.  Thanks,
> >=20
> > just to make sure we're not fixing the wrong problem... does [1] help in
> > any way ?
>=20
> Yes, I was fixing the wrong problem, this patch is obsolete. But the
> problem was in the TWL interrupt handling (PIH was run before SIH), not
> in i2c. See my other patch "twl4030: Fix chained irq handling on resume
> from suspend"
>=20
> >=20
> > [1] http://marc.info/?l=3Dlinux-omap&m=3D135048839915719&w=3D2
> >=20
>=20
> Could be related, though if I understood correctly, that runtime pm
> stuff gets run at noirq phase, so it probably does not help.

well, it will be called multiple times actually :-) Since i2c is
forcefully suspend in noirq time, it suspends before e.g. rtc,
twl*-gpio, etc, which means that (at least for) rtc will still do i2c
transfers on its suspend callback which will runtime resume the i2c
controller and later suspend it again :-)

You might be right, however, that it won't help in your case.

cheers

--=20
balbi

--ibvzjYYg+QDzMCy1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQf6u1AAoJEIaOsuA1yqRE4HUP/jP+wkg2wwefSqLWxQ8fYPHJ
80pYsmeQXkMOy/l6aH7Q7Bv4mbvSvL2Y0VpfT5Xf+sotM57nA9fvMt/ffA03OXia
hLfL/hXM7paNVgiuv9k/AKI0W+SjZNT5DR11VTJm2iKGIHoekb48b+FRYC8kcWkb
9H8A4RaJYxn8poPgbtuqH9Gki62kgntjBDFKneRVZ/4auqO+uSQfav6OhnNVZeeJ
GzfmiLn8mtatazu28sFSapvN+GbQxQG7vrZ6s7345LZexN0xK7dz5mLkbZlNewfD
CZapZvrjLurmlHm/sSUtMzFIKoEHnP6oRJEr8e1txJcmm2Ipftz952zDZa6kJE/u
CrtGK/MllM9PNKAk5y6vlwRXVVIbS9KAsczzkchkctPtE1KMmCEG+GOBICzg/vSJ
ic7/I17q+/hj60bgCf8OjXsFEO9jte1jdQThWfsilJDW6TfIVgoHDfOLScfNioI3
ahmjsgZ7IRqkt75i00YlXi72Dcu3Isx2wiuQdB62idKhRR5k2+x6h4/oGUjh1IOP
4NdWTQovr4j/Wbta4T0J3GZ+FRbvTQyLScC+AuexjvJEu8634bjQzv9lZGmRRF4d
0/6L3AjtB4O2r0IwiiqRpKTCBa1kcZEIFiIMEIpgqfL0Y4CKur67u7rkthOLrQFe
HAahLWYVYGSG78AISgxl
=FbTD
-----END PGP SIGNATURE-----

--ibvzjYYg+QDzMCy1--
