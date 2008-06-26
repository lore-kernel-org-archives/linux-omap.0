From: green <greenfreedom10@gmail.com>
Subject: N810 power problems, bootloader upgrade, won't boot
Date: Thu, 26 Jun 2008 18:13:59 -0500
Message-ID: <20080626231358.GD9938@swansys>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Yb+qhiCg54lqZFXW"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.29]:36730 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751424AbYFZXOL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 Jun 2008 19:14:11 -0400
Received: by yw-out-2324.google.com with SMTP id 9so85374ywe.1
        for <linux-omap@vger.kernel.org>; Thu, 26 Jun 2008 16:14:08 -0700 (PDT)
Content-Disposition: inline
Content-Language: en
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux-OMAP List <linux-omap@vger.kernel.org>


--Yb+qhiCg54lqZFXW
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I've been having power problems with my N810.  These problems appear on sta=
rtup=20
(see three links below) and are supposedly fix by a bootloader upgrade, so =
I=20
upgraded using the Maemo Diablo Fiasco image=20
"RX-44_DIABLO_4.2008.23-14_PR_COMBINED_MR0_ARM.bin".  Perhaps this has fixe=
d=20
the problem, but it has caused another: now the N810 won't boot with the=20
kernels I build, nor will it boot with the zImage-n8x0-2008-05-15 test kern=
el=20
that Tony Lindgren provided recently.  By not booting I mean that I see the=
=20
NOKIA splash screen only; nothing else happens.

Any ideas what I need to do?  I'd rather not downgrade because of problems =
I've=20
had with the device suddenly powering off when idle [3].

Thanks.

[1] https://bugs.maemo.org/show_bug.cgi?id=3D2673
[2] http://www.internettablettalk.com/forums/showthread.php?p=3D196185
[3] http://blog.homac.de/?p=3D58

--Yb+qhiCg54lqZFXW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFIZCK2682C+dBP+oQRAisMAKDKF1ZkmUUn36dutPcj/NREgOQnJACgwCoS
gyTUq5UHFN/cDSlD+yW/pg0=
=gEEH
-----END PGP SIGNATURE-----

--Yb+qhiCg54lqZFXW--
