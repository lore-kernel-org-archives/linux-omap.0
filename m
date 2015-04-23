From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] omap: i2c: Add calls for pinctrl state select
Date: Thu, 23 Apr 2015 13:31:13 +0200
Message-ID: <20150423113113.GA19918@katana>
References: <1429283277-28161-1-git-send-email-pascal.huerst@gmail.com>
 <20150422081240.GH1511@katana>
 <553760D4.4020506@gmail.com>
 <20150422102830.GA1523@katana>
 <55377C9E.5090904@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yrj/dFKFPuw6o+aM"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <55377C9E.5090904-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Pascal Huerst <pascal.huerst-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--yrj/dFKFPuw6o+aM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 22, 2015 at 12:49:02PM +0200, Pascal Huerst wrote:
>=20
>=20
> On 22.04.2015 12:28, Wolfram Sang wrote:
> > I assume you have a different kernel config where something is enabled
> > which includes the pinctrl-stuff in another include which is included
> > by these drivers. Although, my .config was arm-allyesconfig. Can you
> > send yours?
>=20
> Sure. See below.

Thanks. device.h includes pinctrl/devinfo.h which includes
pinctrl/consumer.h iff CONFIG_PINCTRL is enabled. So, seems my
build-system didn't pick allyesconfig but another config with PINCTRL
disabled. Will fix the st driver now, thanks for reporting!


--yrj/dFKFPuw6o+aM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVONgBAAoJEBQN5MwUoCm2ngoP/iCpsWrJiQ8Wvu0k39Y4X8b1
rpG7ND3R7njlgQZUCSbCCflmPdNFsTsLfZjbw3DjWRyqlus2VsNkyoyKFTM11bOU
nBQHdbxu5KyvOe+cVX+tJpPY0KuNSS4nfpCckpa62HYzwNRXvEuI3kBwPSdE3UnZ
G3Wf5+JS/M7EV7a7cZGxRROiQpeEEl7EOCMrw+7okraY/vY6E5Y2Nz5py3IsipHd
mC4lwOKCiQHbCRMtfUXFU5lzFatSxDS7yx0MiLxOg4t1oGYVeDRD2UcCoH2nRp3D
dvHIQwuRZgSXgzZUUbXwf5lWY8fbWHzdHD62q8jt3gXI7SN3bCG8MbGXwKQY5o4c
0pI2atS79s5+YtRvv5lJd862WXd0ht2RONLess2fEoYRsYID/JB4teeBA7VKsjXY
UMlBZQr+pKRwYgFBVE2ckZmLOT5gY+9ZLGVTlaEX0Z+bJLTV4Sa+Ln2Nmq1EEMzc
GFWcnsZsjAXEpk9DIa6FutzlVvZLWkcJq8lIbYiilzmV43hweRf4T2/XYzFTyRqN
1stpHbxIVwvFO8HlIS9k9E85gbE4q9pQpqbuV4IHpcaEGXNcEMGmiiF4AU4LYJ+t
e6ueDIg6cKoRb+GJ9yM/hjQHsFo65vSKZ/yt5rVPGkp/fVh3XN3qjFdGEoH7dxRh
UZzpktX+Q/kkVbKJnYHW
=siIk
-----END PGP SIGNATURE-----

--yrj/dFKFPuw6o+aM--
