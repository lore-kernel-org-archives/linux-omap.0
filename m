From: Felipe Balbi <balbi@ti.com>
Subject: Re: [RFC/PATCH 03/11] arm: omap2: timer: remove __omap_gptimer_init()
Date: Mon, 5 Oct 2015 10:24:54 -0500
Message-ID: <20151005152454.GC18784@saruman.tx.rr.com>
References: <1443559446-26969-1-git-send-email-balbi@ti.com>
 <1443559446-26969-4-git-send-email-balbi@ti.com>
 <20151005110144.GW23801@atomide.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pZs/OQEoSSbxGlYw"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20151005110144.GW23801@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Felipe Balbi <balbi@ti.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, daniel.lezcano@linaro.org, tglx@linutronix.de
List-Id: linux-omap@vger.kernel.org

--pZs/OQEoSSbxGlYw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 05, 2015 at 04:01:45AM -0700, Tony Lindgren wrote:
> * Felipe Balbi <balbi@ti.com> [150929 13:48]:
> > since now we can reuse __omap_sync32k_timer_init()
> > for OMAP3-like devices, we can safely remove
> > __omap_gptimer_init().
>=20
> There are tons of boards out there that need to use the
> high frequency ocillator source with gptimer because of the
> beagleboard B4 and earlier issue #7. So we need to provide
> both options for the boards. Using the high frequency
> oscillator source blocks deeper idle states in hardware
> so those devices are usable.

have a closer look, that hasn't changed

--=20
balbi

--pZs/OQEoSSbxGlYw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWEpZGAAoJEIaOsuA1yqREVuUP/309ZFdt6tEuM2ArlY4AbPmv
T+A8FLs42RUkbUhzrV2Tq9kM2dH0QBMaPr+cBIhU68kmP/QyH/hnTQTKdX0t1Zw3
4q/yzhMrHH9CwwagZE457A1pquJ6LuIoZMJBggADG2fr8rNGP0Z4HML692aipFOF
V3jLJGp9U8jKifnsJDbpEy1CAJ8sHILce3aQcIKcPcRQ/r78xR9zmsp6OQOZ/hRI
T4ZInLVRpjk/MH0RcDenDGSzphiDXp5Mim3ByDeN3GVTSkQT0qqn197LTJMLzIys
pOckx0n19oXaKq/OFYqOjKeqB2h3tAA18ksjE+ETbmpDZIFswudOXnLV40mExlcJ
Gwlcn9YFFCRNcBU7zudG74dLcbzA2YaDJ7UcyHNC2ajmKRGKkYdZ44YbDfpJg9mM
0MxRQdBY/Hp5IsV6fn2Z8wHIs4qJ6FQeVTWZkfxdzFZq2nOGILFpR75yi8T+87Yj
kNUeobvZDed48HRar89f4XlB8FkB6YXYnONGPPI4h2OX0k3oS8FDrf2ENxkIEDpr
yYDqSIUjXoFY0K+Mx9vbcR2Rk1vTnu9I8dh+xrL6QyBBCOo1g8+zviqegHuXnsmv
Azd3dVb96RvwZs/hcMhDFdKs7g3pXIwHIvv5rWawETZxNL6uQSV5D1QRb+w3WpEy
pZ3UVKW297iSr7952+ju
=SfpS
-----END PGP SIGNATURE-----

--pZs/OQEoSSbxGlYw--
