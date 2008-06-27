From: green <greenfreedom10@gmail.com>
Subject: Re: N810 power problems, bootloader upgrade, won't boot
Date: Fri, 27 Jun 2008 12:04:34 -0500
Message-ID: <20080627170434.GF9938@swansys>
References: <20080626231358.GD9938@swansys> <20080627072433.GA20119@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="c7hkjup166d4FzgN"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.249]:29401 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753182AbYF0REu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 27 Jun 2008 13:04:50 -0400
Received: by an-out-0708.google.com with SMTP id d40so123163and.103
        for <linux-omap@vger.kernel.org>; Fri, 27 Jun 2008 10:04:50 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20080627072433.GA20119@atomide.com>
Content-Language: en
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux-OMAP List <linux-omap@vger.kernel.org>


--c7hkjup166d4FzgN
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, 2008.06.27, 179, Tony Lindgren wrote:
> * green <greenfreedom10@gmail.com> [080627 02:14]:
> > I've been having power problems with my N810.  These problems appear on=
 startup=20
> > (see three links below) and are supposedly fix by a bootloader upgrade,=
 so I=20
> > upgraded using the Maemo Diablo Fiasco image=20
> > "RX-44_DIABLO_4.2008.23-14_PR_COMBINED_MR0_ARM.bin".  Perhaps this has =
fixed=20
> > the problem, but it has caused another: now the N810 won't boot with th=
e=20
> > kernels I build, nor will it boot with the zImage-n8x0-2008-05-15 test =
kernel=20
> > that Tony Lindgren provided recently.  By not booting I mean that I see=
 the=20
> > NOKIA splash screen only; nothing else happens.
> >=20
> > Any ideas what I need to do?  I'd rather not downgrade because of probl=
ems I've=20
> > had with the device suddenly powering off when idle [3].
>=20
> You need to leave out the machine id hack patch now, that's no longer
> needed as the diablo image seems to use the official machine id.

Okay, that works.  I should have thought of that myself.  Thanks!

--c7hkjup166d4FzgN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFIZR2i682C+dBP+oQRAvt+AJ4ltNA8+FeAXVmsoMxEpohDU1pMVwCggk+C
pqdMfqjDK9VIaJnRw3wb7TE=
=CUlq
-----END PGP SIGNATURE-----

--c7hkjup166d4FzgN--
