From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: v3.4-rc4 DSS PM problem (Was: Re: Problems with 3.4-rc5)
Date: Tue, 12 Jun 2012 13:37:04 +0300
Message-ID: <1339497424.2392.22.camel@deskari>
References: <1336483598.5761.45.camel@deskari>
	 <WC20120514073642.6306D7@terrafix.co.uk> <1336982138.2532.32.camel@lappyti>
	 <alpine.DEB.2.00.1205151148440.16649@utopia.booyaka.com>
	 <1337159300.7692.22.camel@deskari>
	 <alpine.DEB.2.00.1205241022180.2572@utopia.booyaka.com>
	 <1337934288.2842.19.camel@deskari>
	 <CAORVsuWrWXFR7cnBGD+R4omKRjCCvkhHhOVhR_tj=gjA0tUyVA@mail.gmail.com>
	 <WC20120612101510.1001B1@terrafix.co.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-MlhNOkc5kdcSwuUxNIuS"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:41615 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751779Ab2FLKhK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 12 Jun 2012 06:37:10 -0400
Received: by lbbgh12 with SMTP id gh12so392829lbb.39
        for <linux-omap@vger.kernel.org>; Tue, 12 Jun 2012 03:37:07 -0700 (PDT)
In-Reply-To: <WC20120612101510.1001B1@terrafix.co.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Joe Woodward <jw@terrafix.co.uk>
Cc: Jean Pihet <jean.pihet@newoldbits.com>, Paul Walmsley <paul@pwsan.com>, khilman@ti.com, Archit Taneja <a0393947@ti.com>, linux-omap@vger.kernel.org


--=-MlhNOkc5kdcSwuUxNIuS
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2012-06-12 at 11:15 +0100, Joe Woodward wrote:
> Was there ever a conclussion to this discussion?
>=20
> I'm assuming this is unlikely to be fixed in 3.5?

If by conclusion you mean full understanding and a proper fix, then no.

But the patch 3568f2a46f2a73bab18c914df06afd98a97e0e0e (OMAPDSS: use
DSI_FIFO_BUG workaround only for manual update displays) has been
merged, and that should circumvent the problem.

Are you still seeing problems?

 Tomi


--=-MlhNOkc5kdcSwuUxNIuS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJP1xvQAAoJEPo9qoy8lh71XYsP/1rcN871h6V9bUWoqp3R4Z7u
duOq3OdzGDEgIoM8XaB1VzHzx7iNm25DO3lk7AFiv2rchFtq4WQjihGnUsDcWulL
KzR09pK/C+w14CnYogKjxBA0rz08Y+QpRdLK3Xs2e8qEp1O9BjeEDC1ZgbllSEME
mUe+TNEH7euckgr6KS2uR8qh1HHfuXiWVu1Odm3l5tGDVOF4h5LBinaaWkYoO8nl
Kgk43opSUuWACmo7Hp4ObuyFpPMENL19VpUhSqYJs4hrZCXDjRWm+8h1+ScTr/TW
MOejgq7kh1UgWKmxCLzvH4Gg8Edudq1/Kl0EN8lhSOIub/iIB/Ch+jNZeSJCqQdN
yIJSHg91uq/oMobv7iLDbhGCfgVOcdcQYDdtxeZL5VZNcZuj4woN/yxY+KXR10D2
mC/q5X3Lgv8I0rar1kRZaMB9h/hHXs+uhBkeHrGb1pyEwhcY18aI4jWcmO3xCuD9
Bv6E/V/4Y4wtR4uxQKvqAaCeyH7HF0ZIj2LwA2B+B+wvK4rSuB/vrscCtVp9gRAN
0g0JL7mUCQJnyv5W0uB/vuC6qsdg0GwLrMLqi/3W8a3l/+YBRvFyhCVKVCY0OFse
OGa868hrOVhWgQ8EgnyycZuiWenbF4bfnZGyDQdsd5ACW9NDBinWtYFBfTHn2mal
HA7FMsnzICS8wk+2nT+F
=peVO
-----END PGP SIGNATURE-----

--=-MlhNOkc5kdcSwuUxNIuS--

