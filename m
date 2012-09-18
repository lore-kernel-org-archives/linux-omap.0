From: "Maximilian Schwerin" <Maximilian.Schwerin@tigris.de>
Subject: How to disable message "Uncompressing linux..." on kernel start?
Date: Tue, 18 Sep 2012 08:39:53 +0200
Message-ID: <5448984682E7954C9BFF27F747A9C6CA56E308@dolphin.TIGRIS.local>
References: <5448984682E7954C9BFF27F747A9C6CA56E2F0@dolphin.TIGRIS.local>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="=-MYVlnZnaGLXp6lEuSqOK"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from www45.your-server.de ([213.133.104.45]:45610 "EHLO
	www45.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757010Ab2IRHIp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 Sep 2012 03:08:45 -0400
Received: from [77.12.73.83] (helo=IT-AstaroSecurityGateway)
	by www45.your-server.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.74)
	(envelope-from <prvs=06089b056d=maximilian.schwerin@tigris.de>)
	id 1TDrTs-0004TP-5I
	for linux-omap@vger.kernel.org; Tue, 18 Sep 2012 08:40:24 +0200
Received: from [192.168.0.10] (port=4952 helo=dolphin.TIGRIS.local)
	by IT-AstaroSecurityGateway with esmtp (Exim 4.76)
	(envelope-from <Maximilian.Schwerin@tigris.de>)
	id 1TDrTm-0007tI-1S
	for linux-omap@vger.kernel.org; Tue, 18 Sep 2012 08:40:18 +0200
In-Reply-To: <5448984682E7954C9BFF27F747A9C6CA56E2F0@dolphin.TIGRIS.local>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

--=-MYVlnZnaGLXp6lEuSqOK
Content-class: urn:content-classes:message
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi all,

I have been convinced that my patch for disabling the message
"Uncompressing linux..." on kernel start was not all that good an idea.
As the problem still remains an issue for me and I'd like to find a fix
for everyone I'd like to ask for pointers where or how to fix this.

To sum up my problem: I'm using the primary serial port on an OMAP3 as a
debug console for development. In production we set the u-boot silent
option which disables all kernel logging to this serial port. The only
kernel message that remains is "Uncompressing linux..." at the very
beginning. As we connect an external device via this port in production
environments this is not acceptable.

Cheers, m.

--=-MYVlnZnaGLXp6lEuSqOK
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEUEABECAAYFAlBYF1QACgkQ6nqkzTWctv5q+wCgtPoYVFChHE+9XCGwZ31zd6gf
Fy4Al2+BjeojoMfMNR8fhG9x+7I08w0=
=w9uV
-----END PGP SIGNATURE-----

--=-MYVlnZnaGLXp6lEuSqOK--
