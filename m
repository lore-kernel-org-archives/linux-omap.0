From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: v3.4-rc4 DSS PM problem (Was: Re: Problems with 3.4-rc5)
Date: Mon, 14 May 2012 10:55:38 +0300
Message-ID: <1336982138.2532.32.camel@lappyti>
References: <1336033721.14378.2.camel@deskari>
	 <WC20120503084938.900446@terrafix.co.uk>
	 <1336050442.14378.10.camel@deskari>
	 <WC20120504091902.970499@terrafix.co.uk> <1336139415.2552.4.camel@deskari>
	 <1336140072.2552.6.camel@deskari> <WC20120504140943.7604D0@terrafix.co.uk>
	 <1336143281.2552.21.camel@deskari> <1336143500.2552.23.camel@deskari>
	 <1336483598.5761.45.camel@deskari> <WC20120514073642.6306D7@terrafix.co.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-YYOR2/St+GOFcVnhhgBf"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog130.obsmtp.com ([74.125.149.143]:33016 "EHLO
	na3sys009aog130.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755095Ab2ENHzo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 14 May 2012 03:55:44 -0400
Received: by lbbgg6 with SMTP id gg6so4368620lbb.22
        for <linux-omap@vger.kernel.org>; Mon, 14 May 2012 00:55:41 -0700 (PDT)
In-Reply-To: <WC20120514073642.6306D7@terrafix.co.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Joe Woodward <jw@terrafix.co.uk>
Cc: Paul Walmsley <paul@pwsan.com>, khilman@ti.com, Archit Taneja <a0393947@ti.com>, linux-omap@vger.kernel.org


--=-YYOR2/St+GOFcVnhhgBf
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable


On Mon, 2012-05-14 at 08:36 +0100, Joe Woodward wrote:
> Any news on this?
>=20
> This thread seems to have gone a little quiet...

Hi,

I've been doing testing to understand the problem, but so far I don't
have any idea why things go wrong. I haven't found out any logic in
which configuration works and which doesn't. Looks to me that for some
reason the PM prevents DSS from getting data fast enough with certain
fifo thresholds.

I have two ways to avoid the problem, but I've been reluctant to make
patches for those because I feel it's just hiding the problem. One way
is to change DISPC SIDLEMODE or MIDLEMODE to disallow idle/standby. The
other is to use certain fifo threshold values, which just seem to work
for unknown reasons.

Considering that we already have a SIDLEMODE hack in DSS for omap3 when
using DSI, I wonder if the omap3 PM + DSS combination is just plain
broken, and we should disallow idle. I'm not quite sure what are the
implications of that.

I'd appreciate comments from the PM people =3D).

 Tomi


--=-YYOR2/St+GOFcVnhhgBf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPsLp6AAoJEPo9qoy8lh717jEP/R6AKDks+MP//OHf2eQwZFoe
vnCzPGg7sk5N/b9jGMMANFtR6Tpr8fN/iE9dc0erXmfyMVwuVviwN4SQQb2275Pa
QY1nBp5O3IXB27xU7i1kGELz3L/fqNZJ2yR0dWOA1BbU+0Z+MSRFIIH/fqzKrTrR
YTnzFPc1Kv84pZu4+oI+GDlNiglaYSZMqtUCWkn8cJG6ZGIF6kJmU1M8SD93B8eZ
gbRIFJtrOqdG/XaODQb/sM/9hAhe3Jz8cVUtOvXcRAg1cXufP2PLHi2X0ZKK747X
RCAPDJb3dTdQeUm9lzMtl+UxPKBp/Kchwb5CXpRWekhoRq5qkeolueG/hWuYIiXr
uIUQYb98P2nq/2faFEnUEgkieZEK31M5FjpHHir7UvmG5gzqQIz3VZBObmUjxCee
QDXubp1mwcdwczA1XPRcYVkBltZZmeYbx9Ed6Txya8CiKg3RuIAZ2obwZJpZjZls
mKNBcDgfTRMmMXMuh6zkLlhfhxtUiNOpjlYr+Yuc1DWVWGju9HI0ydQ+jeD6yN0Z
gEhrlCGj67OrBXh0ta0XnlSfH0UBnA+6kvLy+jUYhvNLcYtT/so22taQ3by6E4Xn
Lj2Lo35JwtoJhPRna+ZLdRrDduAAE23z0CVNlIrGhYDGYeW73S4+8bXfhe1wbSzi
RPHTXi3nFwRcaMRQCrDf
=Kx20
-----END PGP SIGNATURE-----

--=-YYOR2/St+GOFcVnhhgBf--

