From: Andreas Kemnade <andreas@kemnade.info>
Subject: receiving data from mcbsp1 in master mode
Date: Tue, 21 Aug 2012 07:42:05 +0200
Message-ID: <20120821074205.0a36f648@kemnade.info>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/8Gx4QgdKdx=f7HQSn3PF8pf"; protocol="application/pgp-signature"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from h1355771.stratoserver.net ([85.214.105.140]:34609 "EHLO
	h1355771.stratoserver.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752143Ab2HUFlZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 21 Aug 2012 01:41:25 -0400
Received: from eduroam-pool3-120.wlan.uni-bremen.de ([134.102.232.120] helo=localhost)
	by h1355771.stratoserver.net with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <andreas@kemnade.info>)
	id 1T3hDP-0001wq-8i
	for linux-omap@vger.kernel.org; Tue, 21 Aug 2012 07:41:23 +0200
Received: from localhost ([::1])
	by localhost with esmtp (Exim 4.72)
	(envelope-from <andreas@kemnade.info>)
	id 1T3hEE-00059o-Oa
	for linux-omap@vger.kernel.org; Tue, 21 Aug 2012 07:42:15 +0200
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

--Sig_/8Gx4QgdKdx=f7HQSn3PF8pf
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi,

I tried a couple of times with different kernels to use mcbsp1 of dm3730
in master mode (so that it sends out clocks).
The result always is that I can send data out. but arecord gets no input. It
waits for input but does not get anything, although clocks are generated,
checked that with a scope.=20

I even took a driver which works in master mode on another mcbsp and just c=
hanged
the mcbsp number.
What needs to be done to receive data from mcbsp1?

Greetings
Andreas Kemnade

--Sig_/8Gx4QgdKdx=f7HQSn3PF8pf
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAlAzH60ACgkQvUy8S31NDeYkBQCfQKWwyWF85V0UCxxMbg6wLH3H
o+sAn2n2Mw/JlOa0yJoF5iuqRRk3sTVB
=VZnc
-----END PGP SIGNATURE-----

--Sig_/8Gx4QgdKdx=f7HQSn3PF8pf--
