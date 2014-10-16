From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 2/5] OMAPFB: remove wrong __exit and __exit_p()
Date: Thu, 16 Oct 2014 16:23:00 +0300
Message-ID: <543FC6B4.4060304@ti.com>
References: <1413452387-25452-1-git-send-email-tomi.valkeinen@ti.com> <1413452387-25452-2-git-send-email-tomi.valkeinen@ti.com> <20141016131939.GB3480@saruman>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="A14KlWknjRXGN4Cb5cRDr5UPjRlbblcIB"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:48215 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752165AbaJPNXE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 16 Oct 2014 09:23:04 -0400
In-Reply-To: <20141016131939.GB3480@saruman>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org

--A14KlWknjRXGN4Cb5cRDr5UPjRlbblcIB
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 16/10/14 16:19, Felipe Balbi wrote:
> On Thu, Oct 16, 2014 at 12:39:44PM +0300, Tomi Valkeinen wrote:
>> omapfb device can be unbound, so using __exit_p() for the driver's
>> remove callback is wrong.
>>
>> Remove __exit_p() and __exit from the driver's remove.
>>
>> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
>=20
> and why was my version dropped ?
>=20
> http://marc.info/?l=3Dlinux-fbdev&m=3D141331137230988&w=3D2

Oh, sorry, for no reason. I started from scratch as there seemed to be
enough issues there, and didn't remember you had the exact same patch.
I'll use yours instead of my version.

 Tomi



--A14KlWknjRXGN4Cb5cRDr5UPjRlbblcIB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUP8a0AAoJEPo9qoy8lh71UEkP/14mzsSjbdDqJ1Ttfbv0OXnR
bMLvYQ0YlURTo/3NT6xmZRMvLNT8w7q/ujAfjWYFmtFQeYOJAS7OaE8NZQ5MohtT
W5pEYwsHJdI0TXaBWzSQA+NcozAHmX+CxsvlhiNHrqvYasm1h1Z3ReRRLjHJzIJF
2DvddHrkB53MzjWrnK1uHDnwvEgnFYajgc5nYu8jNc2dA1yK180+miqpCHyzeMGg
gmCGx+KzNWvdE2pbTIPj09App6R2KfZn430d1/RFr+CBwLDQBybzj3mcm8dSgZWS
lo/FC+1yp00sA9jpJ3cUFU5bXmvdeLXt7U4CgSE6BwlP0s2TZqzGJAH+3S4n5rHK
myuyBI+qwd8oniwcsNetpQQFcLr47EwSUoZBEfxK69tBcccoJO8NOriZvnev3tW5
yx/hHXgFl8qfIlL21Gm4OS+2Jvcp/CkWFzzWAf+Rxn+20pGQm8VAKksAHZLT5+qa
f20so+V992+42zf7YHTBrnqfMEd+xbi8IXKTpHZWTTwZk8nNtjMQbYZXTayZiube
Ub5xitZu5ohznieqQURXqnWot8zBlTnw+V6Jjbryiscz1z8efotMb8p/6dwgGBbn
aGjWdrrbbiEfAId/rB9XMuCzGBKpRAwNxArCUmtZDoEEa3h79wsL94V2K6TPie4I
Sn91BUlGs1cOMNFgK86R
=PP7L
-----END PGP SIGNATURE-----

--A14KlWknjRXGN4Cb5cRDr5UPjRlbblcIB--
