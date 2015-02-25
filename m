From: NeilBrown <neilb@suse.de>
Subject: Re: [PATCH] OMAPDSS: restore "name" sysfs entry.
Date: Thu, 26 Feb 2015 09:33:12 +1100
Message-ID: <20150226093312.3a624976@notabene.brown>
References: <20150224203706.1eafa129@notabene.brown>
	<54EC5520.1020105@ti.com>
	<20150225073131.7fbff605@notabene.brown>
	<54ED8CB6.4010308@ti.com>
	<20150225202042.2adaea4f@notabene.brown>
	<54ED96A2.6080300@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 boundary="Sig_/m9r/lce4fKTj7KmgxeD9pge"; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <54ED96A2.6080300@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: "Dr. H. Nikolaus Schaller" <hns@goldelico.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, GTA04 owners <gta04-owner@goldelico.com>
List-Id: linux-omap@vger.kernel.org

--Sig_/m9r/lce4fKTj7KmgxeD9pge
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 25 Feb 2015 11:32:18 +0200 Tomi Valkeinen <tomi.valkeinen@ti.com>
wrote:


> Yep, I don't think so. In any case, all this is to be deprecated, and as
> soon as omapdrm driver works reliably that should be the driver to use.

How close is that?  Is it worth experimenting yet?  Is there an xorg driver
available?  Maybe a wiki page telling me how to set it up?

http://processors.wiki.ti.com/index.php/Linux_Core_DSS_User%27s_Guide

seems to have some useful suggestions, but no mention of Xorg...

Thanks,
NeilBrown

>=20
> So of course we need to keep omapfb working for the years to come, but
> I'd rather not add any new sysfs files for a soon deprecated driver.
>=20
>  Tomi
>=20
>=20


--Sig_/m9r/lce4fKTj7KmgxeD9pge
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIVAwUBVO5NqDnsnt1WYoG5AQK1YA//aXAh432/NgOIPE701MUla5Yd4W/lQ/8B
UmLZw9c2k2UnG0dJ/Lcxl27FtUAbZASSheRmV6OV9rvMGQ4Kabzk3HctEUHlU9K7
ah+51/2sp3MH+swljHCX31ciBldNDMmmloRVTq5w+9DjBbjp6s455dTIAMDLIN/Y
6xgEJqqcCW4XxyjOwh8xZzOmiJHzfH5fE0UbYqr28Ncd+BxAQieEqZYFsFVqVry2
EPooecvQwBtiJw6tlIcW4MW8rW+06lpcLaAc0wIeHl+IM+gnFgiDoztNsUWoXcwt
vRtvVgJl/i8dA2Gz6SwM5h55ziDCiiCcBnPeJuvhOemAASGTGvW2L2PNGgkP/3yj
kZ7VNDRS8nmf8WxNRXjesQsHfTxI6LtLGM0TjBK5JC2lzHBIK0kBtcRU4WMWXLk8
X/dbh7v4Fv+rlEsCr3hczAvVt66NxlywapMtHLKTrJQjr6I9Film7iwffdfD1C3y
CjeM6p9X9+TbSE7EF5XZPv7NN1JT8AQXNHPrx7FOwytUQC9WPr+JdzTwSQCtu/aA
V/vTjpOJBm2SAsJg5CpHlkbHzoBfAtcGNlXJc0qjKqE2q8EcuIb0qcGBeH+KAnnk
ivkR4XIMHRZxK+hvyW8UTo1YHVSZzAOY2RcmY01yDyjeKi9AhXmg5hukzkbM1B/d
qbkW72Jufyo=
=Mc/f
-----END PGP SIGNATURE-----

--Sig_/m9r/lce4fKTj7KmgxeD9pge--
