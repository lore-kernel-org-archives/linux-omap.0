From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 1/2] OMAPDSS: Features: Maintain dss_feats as a list
Date: Mon, 06 Feb 2012 13:28:12 +0200
Message-ID: <1328527692.1997.2.camel@lappy>
References: <1327900959-29198-1-git-send-email-archit@ti.com>
	 <1328524943.1898.38.camel@deskari> <4F2FB86D.2090205@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-Onqe9geXVbzzIgzf3/tf"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:41688 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752502Ab2BFL2Y (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Feb 2012 06:28:24 -0500
In-Reply-To: <4F2FB86D.2090205@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <a0393947@ti.com>
Cc: Archit Taneja <archit@ti.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org


--=-Onqe9geXVbzzIgzf3/tf
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2012-02-06 at 16:54 +0530, Archit Taneja wrote:
> On Monday 06 February 2012 04:12 PM, Tomi Valkeinen wrote:
> > Hi,
> >
> > On Mon, 2012-01-30 at 10:52 +0530, Archit Taneja wrote:
> >> The number of dss_feat_id members has increased to a large value, the =
current
> >> way of assigning a subset of these features (for a particular OMAP) as=
 a mask
> >> is no longer feasible.
> >>
> >> Maintain the subset of features supported as lists. Make the function
> >> dss_has_feature() traverse through this list.
> >
> > I think this makes the code easier to maintain, so in that sense it is
> > good. But I do hesitate a bit, I think many features are checked in
> > often used code paths (the configuration done on each frame when
> > swapping/panning), and bit compare versus finding an item in a list
> > could have performance impact.
> >
> > Then again, I'm purely guessing here, as it could well be that compared
> > to the other code, checking the features is insignificant. Thus, I'm
> > fine with this patch, and we can optimize it later if need be.
> >
> > However, I'm anyway giving a few ideas how this could also be handled:
> >
> > - 64 bit mask. Would be simple, but we'd still have a hard limit there.
> >
> > - Variable length bitmask, i.e. an int or byte array from which a
> > particular bit is checked. There could be a ready made datatype for thi=
s
> > in the kernel.
> >
>=20
> There seems to be a bitmask library:
>=20
> tools/power/cpupower/utils/helpers/bitmask.c
>=20
> I don't know how easy it would be to access this though.
>=20
> > - Lists like in this patch, but in sorted order. Then, if we're looking
> > for a feat which has, say, number 4 assigned to it, we can stop
> > iterating the list when we hit a feat>  4 in the list. Quite simple
> > optimization, but needs extra maintenance to keep the feat lists sorted=
.
>=20
> This sounds fine. It shouldn't be too much of an effort to maintain=20
> sorted lists. We'll just need to ensure that a new feature added has the=
=20
> largest integer value, and is always added at the end of the list(s).

Not necessarily. As we always search the list from index 0 forward, the
most often needed features could be in the beginning of the list so they
are found faster. At least some features are clearly needed only in some
enable/disable paths or similar, and they could clearly be low priority.

 Tomi


--=-Onqe9geXVbzzIgzf3/tf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPL7lMAAoJEPo9qoy8lh71rBEP/2nhgjtmSOcjzAWmjOfWIpDx
Rhqbv7OFwStSZ+7rcDRB9hosFbHF3SEPwi0Ccqt7mXbjy6TwT0RK8/CPunwrhF3z
EqBvwWFyGDTMciezgULW2O0qC4S4vQnBPIPNCEv7hvB3Smt3+PYrZjowWxAhLbJY
SSB4WGKasVmbcPsqQD/QQTwlTJZUDleIS/gcZ61/DJt4tFMIAlIf6HCgJ7p/dBjB
nELPa4wLlUVLOyVj5AuJfnZjHd4P8WZLs/Y8BZKh7c01rKZSWwipWtWb7b7i1YcS
MhD5FLn3zgoXRql475RwFyl/OCRo5rSeurIH5xseD/BkeHGkHid+rH2rbILskyUg
NnlS1SbRUmFx9JqlfaZ1ywVFFe5ysmesQ7jE0OSBagAg9pwYMYnH2SisBuS6Gwyr
ewPWpRP9+KZXS/1Nnz2PaZconBmzOgr81udhfTXLyc0fJ/7EoOvHj9IRYlrk9r6Y
bb6xnPzGW+Ggh1pwN1YjAUlIDzn6U9cUMSdEo3jqkqbD8x08FmIhHyEHsjxHUhsF
Am2WyfgzuiDxmSsk8hJjPyQvDY9/QsiP1WnJIpNP2H/Nn7BWg0ggbeV0o5M/HJsL
ioKrFAToK5VqsDOzPW7w/2zphbM20X/S6pHyy2qN1KVqTfdKB6OeRdEEbxIQ+9Wy
Wyj0CjdnQfZMjZvVQJ3Z
=s8eE
-----END PGP SIGNATURE-----

--=-Onqe9geXVbzzIgzf3/tf--

