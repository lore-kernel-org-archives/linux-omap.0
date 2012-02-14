From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: OMAP DSS warning in apply.c
Date: Tue, 14 Feb 2012 14:57:49 +0200
Message-ID: <1329224269.1845.99.camel@deskari>
References: <20120214120643.GH15338@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-NV8dsIBcW7fs/LdQBtWc"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog121.obsmtp.com ([74.125.149.145]:55421 "EHLO
	na3sys009aog121.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752977Ab2BNM5y (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 14 Feb 2012 07:57:54 -0500
In-Reply-To: <20120214120643.GH15338@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Archit Taneja <archit@ti.com>, Benoit Cousson <b-cousson@ti.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org


--=-NV8dsIBcW7fs/LdQBtWc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2012-02-14 at 12:06 +0000, Russell King - ARM Linux wrote:
> kautobuildv2 discovered this in its omap4430sdp oldconfig build:
>=20
> drivers/video/omap2/dss/apply.c:350: warning: 'wait_pending_extra_info_up=
dates' defined but not used
>=20
> This looks like a valid warning, because wait_pending_extra_info_updates(=
)
> seems to be completely unreferenced.  Should the function be removed?
> It looks like extra_updated_completion can also be removed as well, as
> that function is the only place it gets initialized and waited for.

The function will be used when the fifo merge series goes in in the next
merge window.

I added the "extra_info" code before fifo merge, as it's will be used by
the fifo merge code and it kinda belonged with the other apply stuff.

The fifo merge code was also supposed to go in in the previous merge
window with the rest of the rewrites, but due to some complications it
was delayed and missed the merge window.

> The function also looks weird - it calls extra_info_update_ongoing() firs=
t
> under a lock, and then outside the lock.  It's not particularly nice API
> wise to have stuff sometimes called under a lock and sometimes not.

The second call is actually extra, it was just added for verification
purposes during development to ensure that the wait logic works
correctly.

I'll remove it.

 Tomi


--=-NV8dsIBcW7fs/LdQBtWc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPOlpNAAoJEPo9qoy8lh71j+AQAIXR9U5/7a4GD20vvzR6B14p
hIx3Ri92QBGF25Du7lKetdcYBzBllBXOX8mi++cOsAJCuRB9bsh4I+y7CmFgkkeb
KI0JMNDF48EkZgkj2rQ4dsHxwyMwyFeAanW2zNYRLYEl9O9kj0IPrsuSZeiLKtcA
gZU4ULN65JUoMIqrWPFIKURxYaJviFeyr0zw0KruApa34+qwhBQVSkybmNZ8MZuC
GUq8Z8rrcubMwp4dR8QPwhFtsV6+Bi8fymWd/1gtsmggiJPhAbf0g/OKH9H8aRi+
0chgdmtbp2/fQBvPYLy5NImaCzESA7ynlsr6lJEFJPMS06x6Me3Y3jvP837hBEwV
fxGurrSiG8yJF4vbbswtosII0Q4Q0FRy4lxvwpbysMz5H9sEAkj/9LEIl9wMUtqS
N2+Pu/iPd5QDI6miiH92j9Hr5EQCiki+Spzvb4XLg0PmwAhy356toWrJH1ZfUP7V
cACw7XMR+jr63bIowRYabbWsR4WtfZyEHUhyPUefEQPheVjftbwErRp+FJ9UDvn8
fE2Cd/oB+K8lQiLcZmLVOuy6IaRQEkyjqTbaMmaJEMoXOz07htZtbgHHY90rXTiw
8YN6N07X99Doun+J3TKrwSj1C1ijLRPjA8ckK31OdTPUAJ144nHBf6MjGKwyOGPM
sdnMd2Hdx+oPZSzgJG+P
=suKx
-----END PGP SIGNATURE-----

--=-NV8dsIBcW7fs/LdQBtWc--

