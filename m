From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 0/3] USB: dwc3: Add suspend/resume support
Date: Thu, 11 Oct 2012 10:39:57 +0300
Message-ID: <20121011073957.GI10030@arwen.pp.htv.fi>
References: <1349877949-18872-1-git-send-email-vikas.sajjan@linaro.org>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MFZs98Tklfu0WsCO"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog132.obsmtp.com ([74.125.149.250]:52261 "EHLO
	na3sys009aog132.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757451Ab2JKHpT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 11 Oct 2012 03:45:19 -0400
Received: by mail-la0-f46.google.com with SMTP id h6so1006150lag.19
        for <linux-omap@vger.kernel.org>; Thu, 11 Oct 2012 00:45:17 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1349877949-18872-1-git-send-email-vikas.sajjan@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vikas C Sajjan <vikas.sajjan@linaro.org>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, gregkh@linuxfoundation.org, sarah.a.sharp@linux.intel.com, balbi@ti.com


--MFZs98Tklfu0WsCO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 10, 2012 at 07:35:46PM +0530, Vikas C Sajjan wrote:
> From: Vikas Sajjan <vikas.sajjan@linaro.org>
>=20
> This patchset adds suspend/resume functionality to dwc3-core layer
> and xhci-platform driver. It also adds S2R support to dwc3-exynos
> glue layer.

how has this been tested ? For how long ?

> Based on 'usb-next' branch.
>=20
> Vikas Sajjan (3):
>   usb: dwc3: Add the suspend/resume functionality
>   usb: xhci: Add the suspend/resume functionality
>   exynos5: usb: dwc3: Add the suspend/resume functionality
>=20
>  drivers/usb/dwc3/core.c        |  268 +++++++++++++++++++++++++---------=
------
>  drivers/usb/dwc3/dwc3-exynos.c |   60 +++++++++
>  drivers/usb/host/xhci-plat.c   |   44 +++++++
>  3 files changed, 273 insertions(+), 99 deletions(-)
>=20
> --=20
> 1.7.6.5
>=20

--=20
balbi

--MFZs98Tklfu0WsCO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQdnfNAAoJEIaOsuA1yqREjUcQAKzdNQK7aW/ELbKE2KzRddHP
FLreFAxhciHsdqARheccex2gQ4GID/LLx1YGPO4syGqJpsCY8fy2kGdyPLyGXR/k
Z4bcbum+FYuZIjVhYOXL/0qvFVcwG9h3aKE2YDasjAlJDemG/VrRETWxhln1cJcA
Qixzi+CqksUweHX0nWYvoUoVGa0rpMJCl9F7cWhm18upB8ghQdkqRJvNfkkoglAn
V2lN2cW7HOhRkNH5gQcBAB8Y6V9G2MgkEhII9ZvhrgzZSyY6IJYREc3RR0JsCzvc
2aqIX9eHlj4l4cqcWdhN4Z3ZTo/ZELu3My8e/h+uaMEPfkcWtGhIhhBRvYn3/CRD
pm/lo1D2upiOq7dTWyKKEng7FVGlf6BLTrd0RgdzF+B2LVcQ19dvaMX8hPxcl0t9
UsRcHhJipMKlhMMB3OVLZNf8r64PptvxiRDGff2PvsnrrbFkkbprJQEjx8kVYkW4
ASLrJypWzu1PL0hmxcuZBKyxGaKloq8tyLmm8lB9j5yGXhgRW3SLsE31xF/Jc7Rq
r+2xy0Htz/evtsKSxTxU1YJNNFABIVOZD5dgQhUrtoAnDK8uP0iHt/AVJDLF8ofi
RP3j4WGrZDCF+ZCJbIog4mDP4ChMjd13vY5egTUF3aJ1L1GcbcNaaSHcoATG4eUt
VxMpyC7n+Crf3oTH//1R
=KkPv
-----END PGP SIGNATURE-----

--MFZs98Tklfu0WsCO--
