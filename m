From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH 2/4] i2c: omap: implement workaround for handling invalid
 BB-bit values
Date: Sat, 22 Nov 2014 14:23:09 +0100
Message-ID: <20141122132309.GC2679@katana>
References: <1416518925-20679-1-git-send-email-al.kochet@gmail.com>
 <1416518925-20679-3-git-send-email-al.kochet@gmail.com>
 <20141121160808.GM7508@saruman>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XMCwj5IQnwKtuyBG"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20141121160808.GM7508@saruman>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Cc: Alexander Kochetkov <al.kochet-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


--XMCwj5IQnwKtuyBG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 21, 2014 at 10:08:08AM -0600, Felipe Balbi wrote:
> On Fri, Nov 21, 2014 at 01:28:43AM +0400, Alexander Kochetkov wrote:
> > In a multimaster environment, after IP software reset, BB-bit value doe=
sn't
> > correspond to the current bus state. It may happen what BB-bit will be =
0,
> > while the bus is busy due to another I2C master activity.
> >=20
> > Any transfer started when BB=3D0 and bus is busy wouldn't be completed =
by IP
> > and results in controller timeout. More over, in some cases IP could
> > interrupt another master's transfer and corrupt data on wire.
> >=20
> > The commit implement method allowing to prevent IP from entering into
> > "controller timeout" state and from "data corruption" state.
> >=20
> > The one drawback is the need to wait for 10ms before the first transfer.
> >=20
> > Tested on Beagleboard XM C.
> >=20
> > Signed-off-by: Alexander Kochetkov <al.kochet-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>=20
> Tested on BBB and AM437x Starter Kit
>=20
> Tested-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
> Reviewed-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>

Huh, I can't apply this one? Which kernel version is this based on?


--XMCwj5IQnwKtuyBG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUcI49AAoJEBQN5MwUoCm2Ba8P/0imzQrZvoLx7zKI+v5UpV1f
mFRmNH5X7yvAhbt3dao6/hJ3hSs1x7wJp+momIObCXGhNZepzrqEdENPqKNnnx2f
v30nl18b9Gt43D+DjzD7qLNlvlhNleKMUC4auXYnfmi2BuarMbVWY+ug7KcIPL2e
WVyzRUejWoY3nbTkCnuinu9cGTUDH2+R2Ve6WIuIcV5n7uASgNYK+XAJf0Y3wXmu
TeFJwV9tDEWcD32Fmdf0Vmfy1BaO8fz6KGkJ33rXG5E+O+QIH+ps96jKakMS27eZ
pThbihzEs+tMK16Lwbg+qUA8TS3QSyvYLPI6Tk5/OUVs6qDxiWKUHoBynjNMczp8
xtB2rl7YDvg1irwhevuh2ZQjVi+a+ceflejOca7zy9QBgtO2X2dMIM34UwL0OH2H
4ayFM6SSKPWJjvoRcVQIA5dMAX3VZ6hmtxkVuZWAAi0bhvOTvvdqFklshPYbL2um
uIh3uR+b8gRNvnao4LkI/To0LCUaa/8gFHG9UQHT3bb7BPToCH0ZUleJE6paYOx8
TUWf3PmTnS/wd//gaqb7QkPrxd3088HvIGl7lAe0qMeokoTpusUMmrVTRAvm5Zq9
4T75IHh0sE0TgVOAGgbkaELdv9lIiU1Wl52KOEi0MssgFqM93GZyvFangC02MBRI
Exghg2WSfXCYtqwbYWrD
=zLD2
-----END PGP SIGNATURE-----

--XMCwj5IQnwKtuyBG--
