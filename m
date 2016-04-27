From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v2] OMAPDSS: HDMI5: Change DDC timings
Date: Wed, 27 Apr 2016 08:55:05 +0300
Message-ID: <57205439.3010303@ti.com>
References: <1461196973-20370-1-git-send-email-Linux.HWI@garmin.com>
 <1461259669-5194-1-git-send-email-Linux.HWI@garmin.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="vQJDRJ9xgnGmTNv488hk8E89wJlGnMsls"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1461259669-5194-1-git-send-email-Linux.HWI@garmin.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "J.D. Schroeder" <Linux.HWI@garmin.com>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, misael.lopez@ti.com, Jim Lodes <jim.lodes@garmin.com>, "J.D. Schroeder" <jay.schroeder@garmin.com>
List-Id: linux-omap@vger.kernel.org

--vQJDRJ9xgnGmTNv488hk8E89wJlGnMsls
Content-Type: multipart/mixed; boundary="EV0Et3NakTlT1buS2rRFJpBUd86uVWTAH"
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
To: "J.D. Schroeder" <Linux.HWI@garmin.com>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
 linux-fbdev@vger.kernel.org, misael.lopez@ti.com,
 Jim Lodes <jim.lodes@garmin.com>, "J.D. Schroeder" <jay.schroeder@garmin.com>
Message-ID: <57205439.3010303@ti.com>
Subject: Re: [PATCH v2] OMAPDSS: HDMI5: Change DDC timings
References: <1461196973-20370-1-git-send-email-Linux.HWI@garmin.com>
 <1461259669-5194-1-git-send-email-Linux.HWI@garmin.com>
In-Reply-To: <1461259669-5194-1-git-send-email-Linux.HWI@garmin.com>

--EV0Et3NakTlT1buS2rRFJpBUd86uVWTAH
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 21/04/16 20:27, J.D. Schroeder wrote:
> From: Jim Lodes <jim.lodes@garmin.com>
>=20
> The DDC scl high and low times were set to the minimum values
> from the i2c specification, but the i2c specification takes into
> account the rise time and fall time to calculate the frequency.
> To pass HDMI certification DDC can not exceed 100kHz therefore in
> a system where the rise times and fall times are negligible the high
> and low times for scl need to be 10us.
>=20
> Signed-off-by: Jim Lodes <jim.lodes@garmin.com>
> Signed-off-by: J.D. Schroeder <jay.schroeder@garmin.com>
> ---
>  drivers/gpu/drm/omapdrm/dss/hdmi5_core.c          | 4 ++--
>  drivers/video/fbdev/omap2/omapfb/dss/hdmi5_core.c | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)

Thanks! Queuing this for 4.7.

 Tomi


--EV0Et3NakTlT1buS2rRFJpBUd86uVWTAH--

--vQJDRJ9xgnGmTNv488hk8E89wJlGnMsls
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXIFQ5AAoJEPo9qoy8lh71kkAQAIzgmaUzSgxeCr5E4TSagWbj
HXSlzP33OQY2jUCIi5pYRDeqQBsxQXppq8/7VG/n1R37zu9xKV1fQONwdP9qoLcv
ZMXChren4PztQWn6SWapoFpWrRUP/eVGk6LiIgyuCKPYorN2s6ZFuY7Nj2LnQ17r
p0t5M2Kx21pWtNwiF58IrPbcJof4ajmGwnIz+5iXUeO5tNT+QNqhNavI2z9Ddo2x
HVWqcUQjHCfuxwb5pj0h2trgVmPxgsBzTGUzqPogXEkyNjKcwy5ezcQqVi2whYYF
uCc9oGGJYVATZbpVF8Wk3y5kXEusqJYhNp1nuCbzultvgcJahUruyrbI23XTR0Kd
/cK5Sx9kOu1j1TEGyQbFUJfHWsoDiYHGxXFw/8hMugmEs6wvvTMyX+EelN8zijtw
ITzN4xsVbfLbSEyJQBIOunUISkAjr0AOrBrEtotAgbh+xxb8QRSZFPqO/nnrnouC
bBx2RHipXiqXvTua534lS+SMSyLTXMJDi5n8s/J7C3to8qQ4dLn5Qm9fjbqyl1BK
PYKlr06/VAGWiBTzPL1AYXVFezN30Wy52E5072vkXjRsac6lbF+qzv+ZgPtEP729
VXTDuRyGNxtvdojYuxzEr1sk7Lii/bujXQK3ICFLhaQL6FlhcpNtrB7neKgwKheS
wQCbvcaJY3OdtBz/YatP
=AMEe
-----END PGP SIGNATURE-----

--vQJDRJ9xgnGmTNv488hk8E89wJlGnMsls--
