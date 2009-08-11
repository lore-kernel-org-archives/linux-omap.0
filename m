From: green <greenfreedom10@gmail.com>
Subject: Re: N810: external mmc died?
Date: Tue, 11 Aug 2009 10:57:28 -0600
Message-ID: <20090811165728.GB29557@swansys>
References: <20090729182948.GN7597@swansys> <20090729191231.GO7597@swansys> <20090729202941.GR7597@swansys>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jq0ap7NbKX2Kqbes"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f228.google.com ([209.85.220.228]:38289 "EHLO
	mail-fx0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752349AbZHKQ6A (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 11 Aug 2009 12:58:00 -0400
Received: by fxm28 with SMTP id 28so1651598fxm.17
        for <linux-omap@vger.kernel.org>; Tue, 11 Aug 2009 09:58:00 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20090729202941.GR7597@swansys>
Content-Language: en
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux-OMAP List <linux-omap@vger.kernel.org>


--jq0ap7NbKX2Kqbes
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

green wrote at 2009-07-29 14:29 -0600:
> green wrote at 2009-07-29 13:12 -0600:
> > I was working on moving Debian's root from internal mmc (because it sti=
ll=20
> > doesn't work with linux-omap) to external mmc, running standard Maemo a=
nd=20
> > connected by USB to the MMC cards (with the cards mounted), when sudden=
ly the=20
> > N810 reset.  I have no idea why, but now external MMC does not work.
>=20
> I went back to commit 401b285465488f515290e0f9111872b94e1cf922 where both=
=20
> internal and external MMC worked, and now I get this error message while=
=20
> booting:
>=20
> mmc0: error -110 whilst initialising SD card
>=20
> I have never seen that message before.  It seems that some hardware has b=
roken. =20
> Has this thing decided to start eating MMC cards now?  Can a MMC card not=
=20
> handle a reset while mounted (it probably was not being written to)?  If =
it=20
> helps, the card is labeled with "Patriot Memory MiniSDHC Class 6 8GB".

I guess I'll look for a replacement and hope it works.

--jq0ap7NbKX2Kqbes
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkqBovgACgkQ682C+dBP+oSZDgCg8qRodKVcnvq2yRmwbaDVWGGJ
KyAAn10+JotO4ZtgwagjKTdGUJITZ4Kh
=cmkn
-----END PGP SIGNATURE-----

--jq0ap7NbKX2Kqbes--
