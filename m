From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] i2c: omap: fix draining irq handling
Date: Mon, 21 Jan 2013 20:27:38 +0200
Message-ID: <20130121182738.GA10106@arwen.pp.htv.fi>
References: <1358707022-26477-1-git-send-email-aaro.koskinen@iki.fi>
 <20130121084431.GG8777@arwen.pp.htv.fi>
 <20130121180159.GB13174@blackmetal.musicnaut.iki.fi>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="liOOAslEiF7prFVr"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:38388 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752592Ab3AUS2R (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 21 Jan 2013 13:28:17 -0500
Content-Disposition: inline
In-Reply-To: <20130121180159.GB13174@blackmetal.musicnaut.iki.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Felipe Balbi <balbi@ti.com>, Wolfram Sang <w.sang@pengutronix.de>, ben-linux@fluff.org, linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org

--liOOAslEiF7prFVr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jan 21, 2013 at 08:01:59PM +0200, Aaro Koskinen wrote:
> Hi,
>=20
> On Mon, Jan 21, 2013 at 10:44:31AM +0200, Felipe Balbi wrote:
> > On Sun, Jan 20, 2013 at 08:37:02PM +0200, Aaro Koskinen wrote:
> > > Commit 0bdfe0cb803dce699ff337c35d8e97ac355fa417 (i2c: omap: sanitize
> > > exit path) changed the interrupt handler to exit early and complete
> > > the transfer after the draining IRQ is handled. As a result, the ARDY
> > > may not be cleared properly, and it may cause all future I2C transfers
> > > to timeout with "timeout waiting for bus ready". This is reproducible
> > > at least with N900 when twl4030_gpio makes a long write (> FIFO size)
> > > during the probe (http://marc.info/?l=3Dlinux-omap&m=3D13581888261043=
2&w=3D2).
> > >=20
> > > The fix is to continue until we get ARDY interrupt that completes the
> > > transfer. Tested with 3.8-rc4 + N900: 20 boots in a row without error=
s;
> > > without the patch the problem triggers after few reboots.
> >=20
> > fair enough, but ...
> >=20
> > > Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> > > ---
> > >  drivers/i2c/busses/i2c-omap.c |    4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > >=20
> > > diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-o=
map.c
> > > index 832f16e..4cc2f05 100644
> > > --- a/drivers/i2c/busses/i2c-omap.c
> > > +++ b/drivers/i2c/busses/i2c-omap.c
> > > @@ -963,7 +963,7 @@ omap_i2c_isr_thread(int this_irq, void *dev_id)
> > >  				i2c_omap_errata_i207(dev, stat);
> > > =20
> > >  			omap_i2c_ack_stat(dev, OMAP_I2C_STAT_RDR);
> > > -			break;
> > > +			continue;
> >=20
> > ... when we get draining Interrupt, it means we're receiving the last
> > few bytes, meaning that by the time we handle it there's nothing pending
> > to be transferred.
> >=20
> > I would rather wait for ARDY before exiting omap_i2c_xfer_msg() rather
> > than here. Specially since that was the programming model suggested by
> > our IP engineers. Such handling is part of my other patchset and can be
> > easily ported.
> >=20
> > OTOH, we might decide to go with this during this -rc and fix it all up
> > for v3.9 on my other patchset.
>=20
> Completing through ARDY interrupt has been known to work reliably for
> years. So for 3.8-rc I would prefer to just restore the old behaviour.

fair enough, I'll rebase my patchset on top of $SUBJECT

--=20
balbi

--liOOAslEiF7prFVr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQ/YiaAAoJEIaOsuA1yqRELvwP/3peR4zymbPY16Nm2S7O+mpj
HUmXT3XkVIsICL0lQJHY0DzaI7lBqplRACMLq9h/SiaUFtq3OpSSVk90ypKvooCk
zT8QNdhDHWEyJv075KgLFWXn4y7T0zpLuKI/KIJ8eKgcCVB7XRpaQTIQg2Snn0Lb
G52ZGld/NZS+C4IQU5Zyodp+ZRmisgRlatlkpIU77wIVHTQgRJvTI3ombHM+YhFE
8HtKdGkpswqAAwhg9ZLMK2wt7qEgvytMA+iSG4Ngfad7MS5rYj55fuQuHJIFVK2E
bAVPQBGB7VnCaRsmh4LkqzCgFWSj4hgnd/YRS2o6L3JPgHfKd7jeMkvQShMvi8Be
lVdvOujlQJ/WsW/1kq2cH/Wy4I1fJCDAQcStzpLuYNunfSPSVPZimhBTeCwnwHkd
3Ool0NwiDNMRirLVU8IOufv58pTav6Cqw4pGdvDaQaAuMiNkAQGseOsKo+koQcUl
GyCi5R5ohct8FeN+hkrfUkkC2W/rvN/sC23jjMtrLO4y+F3uW0NHS6xpauwHC/6P
Fha0pDWUB+qwNDG31Fysf6At57diAPv0wWXgDVJNfv+Xc9WGvZN+hNt0fT8LohkY
SwC42S3dCollfAwqwqRT/pLluC7oczOk8t4M2IM8AIPPhlXmHYNTwD3z5YhVlZ07
ubNSLIgTQUgHXb0DcEQw
=oN0F
-----END PGP SIGNATURE-----

--liOOAslEiF7prFVr--
