From: green <greenfreedom10@gmail.com>
Subject: Latest git kernel won't build with muru.com N8x0 patch 2
Date: Tue, 24 Jun 2008 22:59:39 -0500
Message-ID: <20080625035939.GB3703@swansys>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="f2QGlHpHGjS2mn6Y"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.236]:1790 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750841AbYFYD77 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Jun 2008 23:59:59 -0400
Received: by wr-out-0506.google.com with SMTP id 69so2436870wri.5
        for <linux-omap@vger.kernel.org>; Tue, 24 Jun 2008 20:59:58 -0700 (PDT)
Content-Disposition: inline
Content-Language: en
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux-OMAP List <linux-omap@vger.kernel.org>


--f2QGlHpHGjS2mn6Y
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The latest git kernel (6604ac6c8a14d583a463159f3a1601427dab7e05) won't buil=
d=20
with patch 2 applied of the muru.com n8x0-2008-05-20 patches.

The last bit is here:
  CC      drivers/cbus/retu.o
  CC      drivers/cbus/retu-pwrbutton.o
  CC      drivers/cbus/retu-rtc.o
  CC      drivers/cbus/retu-wdt.o
drivers/cbus/retu-wdt.c: In function =E2=80=98retu_wdt_ioctl=E2=80=99:
drivers/cbus/retu-wdt.c:204: error: implicit declaration of function=20
=E2=80=98omap_readw=E2=80=99
make[2]: *** [drivers/cbus/retu-wdt.o] Error 1
make[1]: *** [drivers/cbus] Error 2
make: *** [drivers] Error 2

The config is attached.

The device powers off sporadically and I'm hoping an kernel upgrade will fi=
x=20
it.  The kernel I'm having (the power) problem with is somewhere around=20
2.6.26-rc2; I'd like to catch up and see if it remains.

Thanks.

--f2QGlHpHGjS2mn6Y
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFIYcKr682C+dBP+oQRAugJAJ9oXF5qxhTfuHdkZrOMxgAiuz8qkQCeNs0L
w7DG8/fjUcXuzfhcypuPR9Q=
=R5dx
-----END PGP SIGNATURE-----

--f2QGlHpHGjS2mn6Y--
