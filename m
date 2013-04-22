From: Felipe Balbi <balbi@ti.com>
Subject: Re: [RFC/PATCHv2 5/5] arm: omap2+: omap_device: remove
 no_idle_on_suspend
Date: Mon, 22 Apr 2013 17:39:11 +0300
Message-ID: <20130422143911.GF7508@arwen.pp.htv.fi>
References: <1366638237-6880-1-git-send-email-sourav.poddar@ti.com>
 <1366638237-6880-6-git-send-email-sourav.poddar@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NQTVMVnDVuULnIzU"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1366638237-6880-6-git-send-email-sourav.poddar@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sourav Poddar <sourav.poddar@ti.com>
Cc: gregkh@linuxfoundation.org, tony@atomide.com, rmk+kernel@arm.linux.org.uk, khilman@linaro.org, linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, Felipe Balbi <balbi@ti.com>, Rajendra nayak <rnayak@ti.com>, Grygorii Strashko <grygorii.strashko@ti.com>
List-Id: linux-omap@vger.kernel.org

--NQTVMVnDVuULnIzU
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 22, 2013 at 07:13:57PM +0530, Sourav Poddar wrote:
> Remove the "OMAP_DEVICE_NO_IDLE_ON_SUSPEND" check, since=20
> driver should be able to prevent idling of an omap device
> whenever required.
>=20
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: Felipe Balbi <balbi@ti.com>
> Cc: Rajendra nayak <rnayak@ti.com>
> Cc: Grygorii Strashko <grygorii.strashko@ti.com>
> Signed-off-by: Sourav Poddar <sourav.poddar@ti.com>

Looks alright to me:

Reviewed-by: Felipe Balbi <balbi@ti.com>

but let's see what P=E9ter Ujfalusi says before applying this one.

--=20
balbi

--NQTVMVnDVuULnIzU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRdUuPAAoJEIaOsuA1yqRE13cP/1DKk3N1zkj9jhCk+9E9b8cO
fApnCQ0FIhhL5ugtmYBk981GudmY5SU0zx7gLWeskNCVSa2V2eBcbm/H+Fs8JaRq
5+Ybzp08Wlsv6Bk+M9kHbhyJ8xGRkaFCqb5AXr9BRYW2PHn5LMDwx/YzNCrqRwsY
yzCQWLmBjHKbypxYhP5XLSrJF//O3k5y8g74Pi+4m++d5zg76rxVNbrJgFfOLj24
5PYmX6jkJ+Aa8wT0GULDTMiVvkw2SFLfKSUkeQLXLBDuiKrQMFtJjPFEk/mmZJCW
oacT5K+9+VGStXgcTsfRAeo0vShe02lQUPcug4U4KDNmg/WprMNVzA+ahKFowUNB
mq3vEF7CIQ4w2VR1FjnTa2R2W9wdsHbqsWPMml76WoWKk01qtWjPybk/OQ5u0oRe
Fjb8ySrxMHqgg32DSmkMYIvJINPFQs/VlcqdxG/3mEB7m1w9PCI+HcViSbnuHTD/
HkTS/g/AALHl2Ww7x1h7jM8cV4pl6h+mI18uzdIWf0S2sCI3ufWcK0E6mjprnVzW
KlIPuspdcDUeLKsmXZZMy2p2jd3crbTAgMf4fDM5FQhPUdOH2JgyZkCRVjXLKtnf
nG1/JQZP+Lqkn6LzsFlzPqAuBkfwbNg8Tgd0HErpFVd14M2C2PawFiSYXivbRLBL
iKWwVDdoUjvJBaQsjorY
=LgiL
-----END PGP SIGNATURE-----

--NQTVMVnDVuULnIzU--
