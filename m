From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] usb: host: xhci-plat: release mem region while removing
 module
Date: Mon, 24 Jun 2013 17:22:24 +0300
Message-ID: <20130624142224.GI21889@arwen.pp.htv.fi>
References: <1371803348-9807-1-git-send-email-george.cherian@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wZdghQXYJzyo6AGC"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1371803348-9807-1-git-send-email-george.cherian@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: George Cherian <george.cherian@ti.com>
Cc: linux-usb@vger.kernel.org, balbi@ti.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org, sarah.a.sharp@linux.intel.com
List-Id: linux-omap@vger.kernel.org

--wZdghQXYJzyo6AGC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 21, 2013 at 01:59:08PM +0530, George Cherian wrote:
> Do a release_mem_region of the hcd resource. Without this the
> subsequent insertion of module fails in request_mem_region.
>=20
> Signed-off-by: George Cherian <george.cherian@ti.com>

very nice catch.

Acked-by: Felipe Balbi <balbi@ti.com>

You need to resend with:

	Cc: <stable@vger.kernel.org> # v3.4+

Not sure if Sarah wants to take care of the stable tagging, though.

--=20
balbi

--wZdghQXYJzyo6AGC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRyFYgAAoJEIaOsuA1yqRECc0QAKVZ4LpZVhJQ3zo8QFDLEHSQ
RX2Cg+yYsZu14qZthxWAtesZEhMoa0UahmK2BTx+YpkY++vW3vkdm/Np+FFnXyWL
m6ft6zRF6/Q68EzCj9i5gWAMk7JS3YtVuEKlJ2ioWnYHuAkqRrRpGHUsYDeR++gm
/j+SOdYYu0qPJZPUDoBVGWLoL+LFKMq2SctSyOHT+UIX45AHE8llaZRs2AuGrgiZ
vjFeIifbUA5XvarAuowjy+DyhEdqf32NoBkrbjyUobCep1nKD3MD+K2e+aLq0Xad
TRANu2PeqPvM0082P8PJGY9iDwfVrRroS5j9g5OqGsxZa1P8TgAFHie6FmRRVyvk
hVxLTfMk+Zl1ZjtHVaFsUCdEucoCBcGGqL0aZ0pFuQwWLU2KjrpskUlykNPskbGM
ZgdkITRSgGFzObg91oYHCwp1oFq1xJyeV4k1evWj69Nt6lAvQCxfmiv58sqjC35V
X4V5o9UjQY3fPweyhY+0HpnZ61BsNP3Lvy55IgVCFevULIWwroLWAkqrjpc87/Qp
6XvdjvYNO+v/1pRM0JWEEYGpGncUb3kFZFySYPfnq0ziOCbOh1mPduvaKI0Q7nIa
UNNev054I3Kv1T8LvEKiarP30StAXyx9xc1nBCDxz9ZnOYJcAFSzp6N1AiOgy93R
FaNERbA1kpn5Y7ceDrO5
=SyKn
-----END PGP SIGNATURE-----

--wZdghQXYJzyo6AGC--
