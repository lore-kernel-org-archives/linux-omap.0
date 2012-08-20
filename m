From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: OMAP3 Overo: Crash on boot with Linus' master
Date: Mon, 20 Aug 2012 11:54:30 +0300
Message-ID: <1345452870.2684.8.camel@deskari>
References: <1343903452.2686.15.camel@deskari>
	 <1344249504.12136.3.camel@deskari> <1345450118.2684.3.camel@deskari>
	 <CAMQu2gwFSNFy8oKpnAWiey_bUvkRXOT_x=Ej=KYA+dLN-Q6S9Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-TSGTRDNEekndf9zEufyh"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:37934 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751687Ab2HTIyf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 20 Aug 2012 04:54:35 -0400
Received: by lbbgm13 with SMTP id gm13so3499849lbb.32
        for <linux-omap@vger.kernel.org>; Mon, 20 Aug 2012 01:54:32 -0700 (PDT)
In-Reply-To: <CAMQu2gwFSNFy8oKpnAWiey_bUvkRXOT_x=Ej=KYA+dLN-Q6S9Q@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, tarun.kanti@ti.com, Kevin Hilman <khilman@ti.com>, Arnd Bergmann <arnd@arndb.de>


--=-TSGTRDNEekndf9zEufyh
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, 2012-08-20 at 13:58 +0530, Shilimkar, Santosh wrote:
> Tomi,
>=20
> On Mon, Aug 20, 2012 at 1:38 PM, Tomi Valkeinen <tomi.valkeinen@ti.com> w=
rote:
> > Hi,
> >
> > Anyone ideas what could I do to debug this further? The problem exists
> > on v3.6-rc2.
> >
> Can you try merging [1] {[GIT PULL] arm-soc: bug fixes for v3.6-rc3}
> and see if it helps.
>=20
> Regards
> Santosh
>=20
> [1] https://lkml.org/lkml/2012/8/20/120

Merging that branch seems to fix the issue. Good to know, thanks!

 Tomi


--=-TSGTRDNEekndf9zEufyh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJQMftGAAoJEPo9qoy8lh71gHsP/2+O3AhajzpWy1sIUv2xNoim
6z0JxCpyzxk36QFL87xXjP4XwONJrz6mhwQRPOV8hIac01AVYaw4xkXGV+ApZNss
22QdDJempx8gcsbuiYdAJxOj1QXI7PnfENMyZLE8fJHCYut3CRb8aShYnf0Kzn91
R6QHdJw3nmjPo6vHIbXAdaMvOyBnLQVEeTtHTfQ1oy4QSDZo1aA/Xg9gznopXXus
MSXT/3vg0MKVbrFW/5UdYK9RjH62NS/OUrxjH/7IEpc98wXUPFU/9IV0rC3AZTZK
7PgPWuNOtNjB4ZCTa3m4QJFHz3q+jjq+pNDCyiTXyl5HomkprgU3S1rQSqmU4Jv1
7JC+ZwBeE3lY1Qokbpq8abLrN3bCgeL7haPRsIzSSvolToNXdI/2uYk8puDQ54bC
/vMnl9eThqK1h7KjF4tUpJxTr7/GI5tVNxzuk3HuyzgNAaXifgnhW/xcz1BqpKgm
bZ7/i+r3Fp9FzKfth6JuM7kNYv997Hj208Y6gQ0YhL7Ba8vfCkrkigoW1/YgIUUc
8cPF7AefQWxUTTjPyB6b9Zj1JjEiNr34er4Pvzzv/mPMvRM2Z0HfZZFeKLWE7bxU
ihFVjx+djJ4IYDbUZXE7iIl9wO7u3pbPpaKAX0TCTfOeP9XDMTqFkdZCCdu0YTmj
EdB8i/0QK6vYcS2pSPpv
=qKqT
-----END PGP SIGNATURE-----

--=-TSGTRDNEekndf9zEufyh--

