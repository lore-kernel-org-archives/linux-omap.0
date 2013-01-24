From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 2/6] i2c: omap: also complete() when stat becomes zero
Date: Thu, 24 Jan 2013 11:13:39 +0200
Message-ID: <20130124091339.GF27304@arwen.pp.htv.fi>
References: <20130123095813.GG3767@nekote.pengutronix.de>
 <1358936588-16375-1-git-send-email-balbi@ti.com>
 <1358936588-16375-3-git-send-email-balbi@ti.com>
 <20130124090511.GB23053@blackmetal.musicnaut.iki.fi>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oPmsXEqKQNHCSXW7"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:44565 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751489Ab3AXJOJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Jan 2013 04:14:09 -0500
Content-Disposition: inline
In-Reply-To: <20130124090511.GB23053@blackmetal.musicnaut.iki.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Felipe Balbi <balbi@ti.com>, w.sang@pengutronix.de, linux-i2c@vger.kernel.org, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>

--oPmsXEqKQNHCSXW7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Jan 24, 2013 at 11:05:11AM +0200, Aaro Koskinen wrote:
> On Wed, Jan 23, 2013 at 12:23:04PM +0200, Felipe Balbi wrote:
> > In case we loop on IRQ handler until stat is
> > finally zero, we would end up in a situation
> > where all I2C transfers would misteriously
> > timeout because we were not calling complete()
> > in that situation.
>=20
> This is wrong, you may still have bytes to transfer,
> but a new interrupt has not arrived yet.
>=20
> This patch also breaks bisection; if you just apply patches 1-2 of
> this series the I2C does not work at all.

probably another n900-thing. What I had seen is that we could endup in a
situation where we wouldn't "break" out of the look, and rather would
fall in the "goto out" when STAT register is zero. In that case, even if
we had transferred all bytes, we wouldn't call complete() and, thus, our
commands would timeout.

Care to send console logs of the error you have seen ? I kinda doubt we
can fall into the situation you described above where IRQ hasn't been
updated to STAT register.

--=20
balbi

--oPmsXEqKQNHCSXW7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRAPtDAAoJEIaOsuA1yqRE0dkP/Rp3FrTjYXbAdOBOxQV+XhTC
5tduItEq2Mb7IXIgjC/RALkGkJMJMkTa6VBg+/OpsCzuTNEVGANYytHQgzHJ9ow4
jpTKSlkBB4dsmDKpzrv41oVpaSG4YlABiFvg6tGTUXSgMJbjI3sYNsnJ+e3iNu3f
pmt19i9M5c2UlF/nIrLoOKdfBhPZUIzrwLqyxyO+Fu2ao2a039pW2aycDVtA5eOh
WxGTtByuXu4pSDdSci4sT1GWzYbQZNX+7D86Vo8kVnXVcnzzp5gQYxCACkmPSw+S
L/X0g+Seqwno42IpX5sjbX1bLpCQ69G/uUlfRtJfE9qM8Y7Y1DP6vy1NTzdqKENW
iYKfaqtzgPEzhiILFT+9nK5ZIRVka9JadLmWF/HiXqSH4mNBf0V8xXuT3jnIJvc5
LQkyZgGSZDcvtvGm/mmffOy9so+6tH1B4KunrHiPM3V88cvc8+0GnWwvhZxa0alh
jcaviqfSO/tPtMsV8G2d5jLxew1Tcqy306Ebz7QIejXyrz/YrbZn49PKanekE0og
PuUElEgGPyhWGozNnjgMfVCvLX/7lu3RoRJd3fSeTtRZUHPIlEi6BTezZHjLLSAb
7kN6xCnGbBMTlzZmmFRamP/uf2/wvnReRHFIVacRi9hX9h4wvWPjyRb/XdWPd7Lr
oGV2Ga0T0vTkp0BT3uSa
=5bbi
-----END PGP SIGNATURE-----

--oPmsXEqKQNHCSXW7--
