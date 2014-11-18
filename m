From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v4 00/10] ARM: dts: TI: Add CAN support
Date: Tue, 18 Nov 2014 21:42:28 +0100
Message-ID: <546BAF34.1020409@pengutronix.de>
References: <1415881371-4982-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="6B2EaiMVjQkPDP3nq5J23bquDDsQ3Ntbk"
Return-path: <linux-can-owner@vger.kernel.org>
In-Reply-To: <1415881371-4982-1-git-send-email-rogerq@ti.com>
Sender: linux-can-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>, tony@atomide.com
Cc: wg@grandegger.com, wsa@the-dreams.de, mugunthanvnm@ti.com, george.cherian@ti.com, balbi@ti.com, nsekhar@ti.comnm@ti.com, sergei.shtylyov@cogentembedded.com, linux-omap@vger.kernel.org, linux-can@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--6B2EaiMVjQkPDP3nq5J23bquDDsQ3Ntbk
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 11/13/2014 01:22 PM, Roger Quadros wrote:
> Hi Tony,
>=20
> These patches add CAN support for am33xx, am43xx and dra7 platforms.
> They can go in independent of [1] but depend on [1] for functionality.
>=20
> Tested on am335x-evm, am437x-gp-evm and dra7-evm.
>=20
> NOTE:
> - for DCAN to work on DRA7 we need this patch to keep the CAN PHY power=
ed.
> https://lkml.org/lkml/2014/10/21/484
>=20
> - on DRA7 there is another issue which causes undesired behaviour if WK=
UPAON and
> L4CFG clock domains are allowed to HW_AUTO. Undesired behaviour is in t=
he form
> of DCAN1 module being stuck-in-transition when disabled and RAMINIT-don=
e bit
> not getting set as part of RAMINIT mechanism. To address these issues t=
here is a patch
> to prevent these clockdomains from HW_AUTO.
> https://github.com/rogerq/linux/commit/31d6da939dbbaf8ea2ab96ca5680b81c=
d5607e51
> Even without this second patch DCAN seems to work.

FWIW:
Acked-by: Marc Kleine-Budde <mkl@pengutronix.de>

I've send a pull request with the CAN driver changes to David Miller
yesterday, the code is supposed to hit mainline in v3.19.

regards,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--6B2EaiMVjQkPDP3nq5J23bquDDsQ3Ntbk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUa680AAoJECte4hHFiupU40sP/jlltsvv3kadYgAbtX1tAdAy
5A5+HYGa3C8jbQDCSkeLAhBIVYTLetWg3WqP7+BTHSPGcfAbmkSLCqERziVMoJxV
VydE4NGNWolUTSjCaJAVBEtN324uop5rRpi0juG2bGkpe//wlywKJ9qPSqsNrCWt
UwNCbMaYPuIXi4mXreBvh0TS8VkERKB4dowpavRqMqe9gafbZc6I+HwVnikPIvOo
85sb51JD7fRlMzBX3vJ52pLDNXAnNx2vWTAO4Q3FBctKjzypTrk3Ye7DWMKojcMU
fNJrFRm/Lg2PyF6Erzi8v9oGabkBufJm2lSXT0oWZx8xgZ5t/pToRsNH8zOFBXox
K6rNXRz62ifTFOki6hICV6gtbaCtTq3PSO+Qyyv8wsl8OEQsDPbIpB7DgiF5Az+4
7R06J6XVB1IagzV+04z2kfLBYc+hhTDVTyBJRxIkCslUktZMbfRVqrZaq23LHiCC
zUSmE0hqzCDjlvEyjsYAKhH0KGZnm/xzo/rKb3tmtW/HhurbZiPeQuhmtIabl1q6
cC2YVDDhaQup2yicdi/2lMnaJP4oHABXGhcht7VXm6hewXwkFTR/OHV+FB/ynsyF
YyRooL+FOWGlExpk5O1gV1giCsMxycYLw3cLB2wQt0AlJKrK6abWpLxhEuW2BEcD
Kuanu078HgsfOjMLD5G4
=9bBM
-----END PGP SIGNATURE-----

--6B2EaiMVjQkPDP3nq5J23bquDDsQ3Ntbk--
