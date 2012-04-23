From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 01/10] OMAPDSS: HDMI: Remove ASoC codec
Date: Mon, 23 Apr 2012 16:17:14 +0300
Message-ID: <1335187034.1535.35.camel@lappy>
References: <1332974305-4578-1-git-send-email-ricardo.neri@ti.com>
	 <1332974305-4578-2-git-send-email-ricardo.neri@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-P2LOglqoYA4YMb+5A99B"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog122.obsmtp.com ([74.125.149.147]:40172 "EHLO
	na3sys009aog122.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752454Ab2DWNRW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 23 Apr 2012 09:17:22 -0400
Received: by lbbgm6 with SMTP id gm6so5641516lbb.13
        for <linux-omap@vger.kernel.org>; Mon, 23 Apr 2012 06:17:19 -0700 (PDT)
In-Reply-To: <1332974305-4578-2-git-send-email-ricardo.neri@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ricardo Neri <ricardo.neri@ti.com>
Cc: mythripk@ti.com, s-chereau@ti.com, x0055901@ti.com, vaibhav.bedia@ti.com, s-guiriec@ti.com, lrg@ti.com, peter.ujfalusi@ti.com, agraf@suse.de, research@ottomaneng.com, linux-omap@vger.kernel.org


--=-P2LOglqoYA4YMb+5A99B
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2012-03-28 at 16:38 -0600, Ricardo Neri wrote:
> Instead of having an ASoC codec embedded into DSS code, use the generic D=
SS
> device driverinterface for audio support. This allows to any potential us=
er,
> including an ASoC driver, take advantage of the HDMI audio functionality.

The description could be improved. The patch removes lots of code from
the hdmi driver, but the description doesn't really describe what's
going on and where the code goes (if anywhere). In fact, it even feels
that the description is about something else. It basically just says
"use generic DSS interface for audio", but the patch doesn't do that, it
removes code.

Also how does this affect the current driver? I presume it effectively
removes HDMI audio support? Does the code still compile with this patch?

 Tomi


--=-P2LOglqoYA4YMb+5A99B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPlVZaAAoJEPo9qoy8lh71szoP/inenR/lNLND3AYJ8usQuIMV
BQFll9WVeMYbkV54C6I9aqfLkvpOjYQHePiUyqV/Lq/6VBeVL7ilxPGS4nY87Nq1
jucYbsmXq7cxOZbkcjr4MXvXFVChNdwkdAxYuO+LwcCF+ySfMPliwo3uc3yKiS0q
cJ8a87bM/CKAwd/K+P9/4+lUpqt90TgGCBUlfEVL3nE8CMFJdNycJvwycjxKaWzL
mqtH2k2anVKXVpWBCf3bLopSqO4wJgtTc8mnhSSrvFLRZHXb2w32XTf5xzis+YlL
hYXyxOocyPAPHB5EbXFu7AO06Fy8dxSx0dbETTxked9LQA0VEBurpxNWDwfdwTFC
pmzOlum83oOylrUjyaAoFnI+Viv8GUskRcDFYU6Ybb7ZJqe5lWs0EGMiaQgGS68h
hMTWgWnYWHMYo5DoKSnMhSEnd0ps0wRtqrIwDC4WoxehF5ZD09C1Jf6ZG9j8qSCc
rQrhTmk2BU2483VhD9pQdCrT7HmFMPQjjEdvJKz8Cxv+qiJk5WrTySTRv/DMriG+
n9fBT+ygEoNmZ0k1QMmHHkZI383ka9wmyQ+e9if+rO5x67ld0kvTUWtOIMfhfYrQ
ASI+695kWMunn/o4EMZCGuv4YbDKLQlmaQOeix0sSHDbF5RPovmxf/phiVMzC3Cv
v4SS3jA7k3L4CauD6LvS
=RhoR
-----END PGP SIGNATURE-----

--=-P2LOglqoYA4YMb+5A99B--

