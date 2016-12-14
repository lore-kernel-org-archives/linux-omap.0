From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 12/23] drm: omapdrm: plane: update fifo size on atomic
 update
Date: Wed, 14 Dec 2016 15:03:08 +0100
Message-ID: <20161214140308.bpbykzp6yfghxfn6@earth>
References: <1457455195-1938-1-git-send-email-sre@kernel.org>
 <8209536.SBuD0B7HP3@avalon>
 <4c863692-d6d4-3940-b78e-3e7b9d114cad@ti.com>
 <9003662.GMTnJkJbn3@avalon>
 <a60e0657-e0cd-839c-20ea-d29a73e198ff@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="q6oojez4jsxhx625"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <a60e0657-e0cd-839c-20ea-d29a73e198ff@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, dri-devel@lists.freedesktop.org, Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--q6oojez4jsxhx625
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Dec 14, 2016 at 11:14:32AM +0200, Tomi Valkeinen wrote:
> On 14/12/16 11:10, Laurent Pinchart wrote:
> > Hi Tomi,
> >=20
> > On Wednesday 14 Dec 2016 10:43:18 Tomi Valkeinen wrote:
> >> On 13/12/16 19:35, Laurent Pinchart wrote:
> >>> On Tuesday 08 Mar 2016 17:39:44 Sebastian Reichel wrote:
> >>>> This is a workaround for a hardware bug occuring
> >>>> on OMAP3 with manually updated panels.
> >>>
> >>> Could you please explain what the bug is and how the workaround opera=
tes ?
> >>> Do you have a reference to an errata document ?

FWIW I don't know anything about this bug. I just hit it while
getting omapdrm working on n950 and ported this over from omapfb.

> >> I don't think I ever found out exactly why the problem happens. But on
> >> OMAP3 DSI, the fifo thresholds had to be tuned slightly, otherwise DIS=
PC
> >> would stop. dispc_ovl_compute_fifo_thresholds() does that tuning if
> >> "manual_update" parameter is set on OMAP3.
> >=20
> > I've had a look at dispc_ovl_compute_fifo_thresholds() and the patch ma=
kes=20
> > sense to me. If Sebastian could address the small issues I pointed out,=
 we=20
> > could then merge this. Alternatively I can take care of addressing them.
>=20
> It's only needed with the rest of the DSI manual update series, so I'd
> rather keep it as part of that series.

To be honest I haven't worked on this for some time. From some
comments on the patchset I think the biggest issue is, that omapdrm
does not use generic panel drivers and cannot easily use the
mipi_dsi_driver_register. I simply did not have enough time to
implement such a huge change.

I guess a first step is Peter Ujfalusi's series:
https://lkml.org/lkml/2016/9/1/267

-- Sebastian

--q6oojez4jsxhx625
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlhRURkACgkQ2O7X88g7
+polxxAAlSfZpKDw0R/9r992ce9A/WIM2oEutl9pFR95J5kie0x8WwyjleMzCNg2
qk5T4azqZILwlj6QvkABS+/zsD/yfPU1vCBMyMOowu+9Q5jincAUS/gXRWdf/PoD
DM0IRDlkxWUvJVTnmfDrjjSxqhAQIjMoFWeM2BaiSGIyxgp0OUFDb4YCtANIGzr/
LpXgHvMfm5Yj2AvhfSETRkWmIZXwSVkyjyu1SYtvIGc1k5JsWyS+dc5M5CAY2yP8
oX3ysHQwzO5gzz/PUEDvwHpL+d5OljL1IPWE4Dp0psb6+kS5sJN/d4TQ8wNZoq6t
9qMWC4d5JD+pyHu9LByFR+s3kUj7h+qeBzvFmj5Kk8rHJ+zD5+3e295N9rGV6Q3F
iv8CF3H3cGdADFvbpJJG5W+PU0TCtyF7s7uCkdtNrCmVNiMnBNLHNLA8C5XB36Ab
vINttC6+Z/QjLUBML6vgq0gSkclNPYQR2/DpzpOLfVQLlQYIcUBtDR5X/gCY5x4s
nHLPPG40TQeisUSeSyvHEdaDOLuNcq0A5uZeNbT+KeAtStyMTW1oLZ3pL2g4h8bw
TwTUZUglXs8MA2PknywLbKKUVV2OrqxCGEYYw+TXxxI3xjbY3IFx1o9c+0sFXqfW
WozdT129wax1rHBRvM8qis0PYRXO+sxkZD6+LRIKeBni5hHo15Y=
=MbvC
-----END PGP SIGNATURE-----

--q6oojez4jsxhx625--
