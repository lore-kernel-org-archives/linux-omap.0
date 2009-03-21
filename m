From: green <greenfreedom10@gmail.com>
Subject: Re: n810 internal mmc boot
Date: Sat, 21 Mar 2009 13:33:55 -0600
Message-ID: <20090321193355.GG20072@swansys>
References: <20090228012717.GB4366@swansys>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WIIRZ1HQ6FgrlPgb"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f169.google.com ([209.85.218.169]:38317 "EHLO
	mail-bw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752284AbZCUTeJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 21 Mar 2009 15:34:09 -0400
Received: by bwz17 with SMTP id 17so1258698bwz.37
        for <linux-omap@vger.kernel.org>; Sat, 21 Mar 2009 12:34:06 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20090228012717.GB4366@swansys>
Content-Language: en
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux-OMAP List <linux-omap@vger.kernel.org>


--WIIRZ1HQ6FgrlPgb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

green wrote at 2009-02-27 18:27 -0700:
> Any news on booting n810 from internal mmc?  It hasn't worked for a while.

The kernel detects the external mmc fine (for root=3D), but not the interna=
l...=20
I'm just wondering whether any progress is being made or expected.  Sorry i=
f=20
I'm being a nuisance.

> I've been trying to figure out which commit to blame between=20
> v2.6.28-omap1..cb4befa9201 but no luck: git is still rather new to me.
>=20
> Any tips how to successfully perform a bisect with these crazy-big merges=
? =20
> Commits in the linux merge won't build/work.

--WIIRZ1HQ6FgrlPgb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAknFQSIACgkQ682C+dBP+oTffQCfU/lQfgNmxVq9SH2cCmQtnktT
0aMAn2I2ILaSLD6bfXFfMDHKqjjZsxEY
=0Ooo
-----END PGP SIGNATURE-----

--WIIRZ1HQ6FgrlPgb--
