From: green <greenfreedom10@gmail.com>
Subject: Re: N810: external mmc died?
Date: Wed, 29 Jul 2009 14:29:41 -0600
Message-ID: <20090729202941.GR7597@swansys>
References: <20090729182948.GN7597@swansys> <20090729191231.GO7597@swansys>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rE45P3aZNSuYx5ND"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.239]:24227 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755826AbZG2U34 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 29 Jul 2009 16:29:56 -0400
Received: by rv-out-0506.google.com with SMTP id f6so279635rvb.1
        for <linux-omap@vger.kernel.org>; Wed, 29 Jul 2009 13:29:57 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20090729191231.GO7597@swansys>
Content-Language: en
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux-OMAP List <linux-omap@vger.kernel.org>


--rE45P3aZNSuYx5ND
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

green wrote at 2009-07-29 13:12 -0600:
> I was working on moving Debian's root from internal mmc (because it still=
=20
> doesn't work with linux-omap) to external mmc, running standard Maemo and=
=20
> connected by USB to the MMC cards (with the cards mounted), when suddenly=
 the=20
> N810 reset.  I have no idea why, but now external MMC does not work.

I went back to commit 401b285465488f515290e0f9111872b94e1cf922 where both=
=20
internal and external MMC worked, and now I get this error message while=20
booting:

mmc0: error -110 whilst initialising SD card

I have never seen that message before.  It seems that some hardware has bro=
ken. =20
Has this thing decided to start eating MMC cards now?  Can a MMC card not=
=20
handle a reset while mounted (it probably was not being written to)?  If it=
=20
helps, the card is labeled with "Patriot Memory MiniSDHC Class 6 8GB".

Thanks.

--rE45P3aZNSuYx5ND
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkpwsTUACgkQ682C+dBP+oQxiQCeJn7W6arBCsFJgvelkpnHXPJN
H5wAoKQwuEDmnZi4Ktro4+prHviBxcUR
=ZjuX
-----END PGP SIGNATURE-----

--rE45P3aZNSuYx5ND--
