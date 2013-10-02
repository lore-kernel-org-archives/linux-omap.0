From: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [RFC 00/15] Device Tree schemas and validation
Date: Wed, 2 Oct 2013 18:24:02 +1000
Message-ID: <20131002082402.GE6506@voom.fritz.box>
References: <1380041541-17529-1-git-send-email-bcousson@baylibre.com>
 <524A8289.3050107@baylibre.com>
 <524ACB76.1010001@gmail.com>
 <524AE4FB.4080906@baylibre.com>
 <E1VR1hx-0000C1-6J@jdl.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="//IivP0gvsAy3Can"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ozlabs.org ([203.10.76.45]:38468 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753007Ab3JBJSf (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 2 Oct 2013 05:18:35 -0400
Content-Disposition: inline
In-Reply-To: <E1VR1hx-0000C1-6J@jdl.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Loeliger <jdl@jdl.com>
Cc: Benoit Cousson <bcousson@baylibre.com>, Rob Herring <robherring2@gmail.com>, Mark Rutland <mark.rutland@arm.com>, swarren@wwwdotorg.org, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, olof@lixom.net, devicetree@vger.kernel.org, tomasz.figa@gmail.com, grant.likely@secretlab.ca, khilman@linaro.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, fparent@baylibre.com


--//IivP0gvsAy3Can
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 01, 2013 at 10:17:53AM -0500, Jon Loeliger wrote:
> > Hi Rob,
> >=20
> > On 01/10/2013 15:17, Rob Herring wrote:
> > > On 10/01/2013 03:06 AM, Benoit Cousson wrote:
> > >> + more DT maintainers folks
> > >>
> > >> Hi all,
> > >>
> > >> I know this is mostly boring user space code, but I was expecting a
> > >> little bit of comments about at least the bindings syntax:-(
> > >>
> > >> I'd like to know if this is the right direction and if it worth purs=
uing
> > >> in that direction.
> > >>
> > >> The idea was to have at least some base for further discussion during
> > >> ARM KS 2013.
> > >>
> > >> I feel alone :-(
> > >>
> > >> If you have any comment, go ahead!
>=20
>=20
> Benoit,
>=20
> Sorry, I meant to ask earlier but forgot.
> Shouldn't this development be based on the
> upstream DTC repository and not the in-kernel
> copy of the DTC?

Absolutely.  Please work against upstream dtc.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--//IivP0gvsAy3Can
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBAgAGBQJSS9giAAoJEGw4ysog2bOSLJEQAI5TlHUc2Usu4IN6X46R5Mk3
szZcs6WTYxClXW1JeiOESqwJsTdVGvzv1n9GrmgXg+Vmd/jAPaFymh6XljvCoJOv
socVqYUFcqdfpPOqFjYbYXbAiAkqyJSZVcVX3XZeFM815KzmqUimXEwaYW7UEbEJ
OGE2iy55Bsv7FLQpTBLv22ZTK3KOMimMpOJmVcmwYcqyopB3CUJKxWdNs4IhJlyg
V70SZGcXAWrL6nntWfrhjMmpNNleHaiHEqYiz9eGBqq8/RAlxh4YSyjwknahpOBy
Vo2sPulrxaxeoLhdgbbdOCXtWnBidov98aI++dMo/D5U2w4+A1mTN+/uOEAWg5Xw
p9BUDYv011RPIzffxJAy55Ewhm7E8zJad2zlmRi2FlUQ6fYIb3pfvvc1JMlIguxh
oysUH++RMO4OUWZftUmm5I5/6Q3PBtLOFeTQyLDrJzk8jUMZvd3lTraWLuviSMPA
+rDtLybzfA6edyXA3mEzJTsRq1FF5M7HmAt9p5GXD4MoeqfSEEHhoXvUpQaUrgNQ
kBJACwSN7R80OhVh3e+m7sRV8EbRE2X9HdcKA4fVes2ge07jzqp1OQtK8j+4Nabt
y5wCPHiAO4YLl0EebcPcuHl6Y+frnXcSGNv3uZYn5Ly1eeLlLd6Y7BKx594TAOkM
AZFIy+90Jw7bZj+PO2zK
=cLga
-----END PGP SIGNATURE-----

--//IivP0gvsAy3Can--
