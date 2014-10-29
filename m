From: Sebastian Reichel <sre@ring0.de>
Subject: Re: [PATCH] ARM: OMAP2+: Warn about deprecated legacy booting mode
Date: Wed, 29 Oct 2014 19:59:57 +0100
Message-ID: <20141029185957.GA3723@earth.universe>
References: <20141027200008.GR2560@atomide.com>
 <20141027230138.GB7805@drone.musicnaut.iki.fi>
 <20141028221243.GU2542@atomide.com>
 <5450EEE7.8070801@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="WIyZ46R2i8wDzkSu"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ring0.de ([5.45.105.125]:59363 "EHLO ring0.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751145AbaJ2TAK (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 29 Oct 2014 15:00:10 -0400
Content-Disposition: inline
In-Reply-To: <5450EEE7.8070801@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org


--WIyZ46R2i8wDzkSu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Oct 29, 2014 at 08:43:03AM -0500, Nishanth Menon wrote:
> On 10/28/2014 05:12 PM, Tony Lindgren wrote:
> > * Aaro Koskinen <aaro.koskinen@iki.fi> [141027 16:03]:
> >> Hi,
> >>
> >> On Mon, Oct 27, 2014 at 01:00:09PM -0700, Tony Lindgren wrote:
> >>> +
> >>> +	if (!of_have_populated_dt())
> >>> +		pr_warn("WARNING: legacy booting deprecated, please update to boot=
 with .dts\n");
> >>> +
> >>
> >> Maybe use WARN so that the warning is more verbose and kernel gets tai=
nted?
> >=20
> > Well I was hoping to avoid annoying people with the trace.
> > But can do that if people prefer that, what do others think?
> >=20
>=20
> WARN is better and eye catchy. Also, could we add information on when
> the support will be removed since we call it deprecated?

I also think, that more eye catchy is better.

Apart from that I wonder if we should drop support on a
board-by-board basis and then drop omap3 support completly once all
boards have been dropped.

-- Sebastian

--WIyZ46R2i8wDzkSu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJUUTksAAoJENju1/PIO/qacdsP/jIZvfFQNea0Odp2XIS/WNXZ
c/jMWMrU/DJuwVVrZrsupL9FkvxEcgneFxzCkxn9v3zuiYn/LoAzpPofsaH6Fk0p
1A2ZCcmnaaQS3oQ3CECp8V62w8nsuLoq0ZOWI/YJpsg+lRekIDaOJ/UB6M1GT9+L
RgMYQKkCcYUoV7TRi4Yl0Z5jfRBrukdiM4BWcRWm1Gab900fnbfBrhLANSgZMuCp
q60oMT9iL3JnH0rFUXDztHDFJNH038YayBNyoik0JLK8+ZeEWV24U2smSg5lv+th
ue+1mV6hKSvXulKIAhQVpdcWju46mX/7qDr6qnxUjew5nr5dU1eAdCk3g478QSX7
MdQ6d4YTBUFcGrNPvKE+NUmS5urya/B19jUQM2MSjjpjA10SUjOMgRxhTF1VZFM6
qVveive2XbICXfy1XmMwkx02anLqRcWZKzORDZT7WDg9UxW/pwXwAOM+WH+LDGKv
JQUg6GXCenXg7Nj7sdIC8/PFeA8piSaMYNlr4QGOkKgrs1uaG3/fv9o/NPyaNxbJ
+w1znT/BgV1FdYPEtn7QPZtKw/KUjp/sB4Rhk/PLy4MZlhm3Srg6xTV7zd78VmAl
Bs0Oqmc/oFIeLhhJtl0Cs1LtbEtYcisH5Os6aj82oGYCr7YbgLB20gYhU8YJJTRO
brQWsgKH0lb8c0fRUf+8
=Vv1r
-----END PGP SIGNATURE-----

--WIyZ46R2i8wDzkSu--
