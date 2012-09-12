From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCHv7 20/23] i2c: omap: switch to threaded IRQ support
Date: Wed, 12 Sep 2012 13:51:43 +0200
Message-ID: <20120912115143.GE2624@pengutronix.de>
References: <1347356538-23835-1-git-send-email-shubhrajyoti@ti.com>
 <1347356538-23835-21-git-send-email-shubhrajyoti@ti.com>
 <20120911215112.GA27031@pengutronix.de>
 <50502AE3.7040300@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZInfyf7laFu/Kiw7"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:39389 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752220Ab2ILLvr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 12 Sep 2012 07:51:47 -0400
Content-Disposition: inline
In-Reply-To: <50502AE3.7040300@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Shubhrajyoti <shubhrajyoti@ti.com>
Cc: linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, ben-linux@fluff.org, tony@atomide.com, Felipe Balbi <balbi@ti.com>


--ZInfyf7laFu/Kiw7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 12, 2012 at 11:55:39AM +0530, Shubhrajyoti wrote:
> On Wednesday 12 September 2012 03:21 AM, Wolfram Sang wrote:
> >> -omap_i2c_isr(int this_irq, void *dev_id)
> >> > +omap_i2c_isr(int irq, void *dev_id)
> >> >  {
> >> >  	struct omap_i2c_dev *dev =3D dev_id;
> >> > +	irqreturn_t ret =3D IRQ_HANDLED;
> > Shouldn't that be IRQ_NONE?
> Actually we are processing it so I thought it to be ok.

Are we processing it? There is nothing acknowledged AFAICS. Anyway, we
can fix that with a later patch.

> Also a similar discussion.
> =20
> http://lists.infradead.org/pipermail/linux-arm-kernel/2012-June/104422.ht=
ml

I totally agree to the things said there.

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--ZInfyf7laFu/Kiw7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAlBQd08ACgkQD27XaX1/VRsWQgCgxO98etvzzFtFQetYwTMH8OMM
5HUAoMRAVircBmhF35JsTKZuHh/9jaR9
=Rl0M
-----END PGP SIGNATURE-----

--ZInfyf7laFu/Kiw7--
