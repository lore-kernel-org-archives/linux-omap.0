From: green <greenfreedom10@gmail.com>
Subject: Re: Latest git kernel won't build with muru.com N8x0 patch 2
Date: Thu, 26 Jun 2008 14:43:59 -0500
Message-ID: <20080626194359.GB9938@swansys>
References: <20080625035939.GB3703@swansys> <20080625210514.GA9938@swansys> <7B4574D56E4ADF438756313E9A172A8708D67141@dlee01.ent.ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KN5l+BnMqAQyZLvT"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.176]:37798 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752031AbYFZUY6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 Jun 2008 16:24:58 -0400
Received: by py-out-1112.google.com with SMTP id p76so60063pyb.10
        for <linux-omap@vger.kernel.org>; Thu, 26 Jun 2008 13:24:57 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7B4574D56E4ADF438756313E9A172A8708D67141@dlee01.ent.ti.com>
Content-Language: en
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux-OMAP List <linux-omap@vger.kernel.org>


--KN5l+BnMqAQyZLvT
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 2008.06.25, 177, Hunter, Jon wrote:
> > >   CC      drivers/cbus/retu-wdt.o
> > > drivers/cbus/retu-wdt.c: In function 'retu_wdt_ioctl':
> > > drivers/cbus/retu-wdt.c:204: error: implicit declaration of function
> > > 'omap_readw'
> > > make[2]: *** [drivers/cbus/retu-wdt.o] Error 1
> > > make[1]: *** [drivers/cbus] Error 2
> > > make: *** [drivers] Error 2
>=20
>=20
> An implicit declaration of function error would imply that you are missin=
g the appropriate header function. Hence, the compiler sees this as a decla=
ration of a new function, instead of a function that has already been defin=
ed elsewhere.
>=20
> > I removed lines 203-205 of drivers/cbus/retu-wdt.c (after patching); it
> > seems
> > to have fixed the problem for me.
>=20
>=20
> Instead of removing the above lines, try including the header asm/io.h in=
 the file drivers/cbus/retu-wdt.c. For example:
>=20
> #include <asm/io.h>

Okay, this works; thanks.

--KN5l+BnMqAQyZLvT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFIY/F/682C+dBP+oQRAnlFAKDXcCEuVCghLVxmp0xOFQpPRZKqBQCghbiG
aInRMycajDQkEMCZBao/UPA=
=GvUD
-----END PGP SIGNATURE-----

--KN5l+BnMqAQyZLvT--
