From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH/RESEND #3 6/7] arm: omap: smartreflex: fix IRQ handling
 bug
Date: Thu, 17 Nov 2011 09:08:38 +0200
Message-ID: <20111117070836.GA30936@legolas.emea.dhcp.ti.com>
References: <1321346765-16633-1-git-send-email-balbi@ti.com>
 <1321346765-16633-7-git-send-email-balbi@ti.com>
 <87r51762a7.fsf@ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="y0ulUmNC+osPPQO6"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:36868 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751986Ab1KQHIn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 17 Nov 2011 02:08:43 -0500
Content-Disposition: inline
In-Reply-To: <87r51762a7.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Felipe Balbi <balbi@ti.com>, Tony Lindgren <tony@atomide.com>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>


--y0ulUmNC+osPPQO6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 16, 2011 at 04:06:08PM -0800, Kevin Hilman wrote:
> Felipe Balbi <balbi@ti.com> writes:
>=20
> F> fix a bug which has been on this driver since
> > it was added by the original commit 984aa6db
> > which would never clear IRQSTATUS bits.
> >
> > Signed-off-by: Felipe Balbi <balbi@ti.com>
>=20
> Queuing this fix for v3.2-rc (branch: for_3.2/fixes/pm)

should it go to stable too ??

--=20
balbi

--y0ulUmNC+osPPQO6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJOxLL0AAoJEIaOsuA1yqREvGUQAJKi7TZepPcjm285QCVTqzN0
/sTK9FncxRFOXMlLD2zQGC4SCzaFht92fPmwg6IOIdj02amtkZsFjpLoPSQk5usH
IjDSIuZw2Dm3s0JIrTVobIlhFMu6L5soS0oJwf7FW4rLIwKOvdJUaCOHQQT+kGD4
yUqEqL5oqohVEBco8445AnCyDxwuHMKoZUV7PSCOU0n1d2LgCtYHq9EOVbAiNWoi
1o3IttsWFYRlv40IgAaX/8WqxKwDg1g0uPvBeMC5NIyg5qRk4tC9WGkXrWGbImdh
rR67jGEA0psXb2s2GvWnpx1dvwPHTksf+1rj7j8uL9wWX63vrnsuUa/96aDLLksg
/CiwScdU+hPSDV40hPaILJGYxQH0zi/yS0IuwnF+FpEhD+YyMlWa8RAxfuoz7ycL
HVrU9yDc3KQ0+LsqnBB4oQuR891lVzDIa/UOgR8LP9pMSPrxIiuNFNgmamL45EmG
DzqvY7zA2jjnZywJKLUZ9fNBXW0LBQt7KHjtk92WI6uxQlZc3fTxqiMY5Og2UtZY
KyAGZRQJfsdJ7cEBJppl9G2DL8Y2Tte9B9DLtFU3QO34tq1ZeE5xINFUrIeRB4k+
4d46QqTf4mMVFiy5wG1FCbNFa9qOw0zlGYF0BgGqUVfubJ+oVnmyFo/D6d+j50mQ
gPXl1i7F5b4QbRPk8goR
=b+HO
-----END PGP SIGNATURE-----

--y0ulUmNC+osPPQO6--
