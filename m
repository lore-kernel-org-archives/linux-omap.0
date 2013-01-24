From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 5/6] i2c: omap: wait for transfer completion before
 sending STP bit
Date: Thu, 24 Jan 2013 09:35:25 +0200
Message-ID: <20130124073525.GB27304@arwen.pp.htv.fi>
References: <20130123095813.GG3767@nekote.pengutronix.de>
 <1358936588-16375-1-git-send-email-balbi@ti.com>
 <1358936588-16375-6-git-send-email-balbi@ti.com>
 <20130123201031.GF23057@blackmetal.musicnaut.iki.fi>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="eJnRUKwClWJh1Khz"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:47873 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751076Ab3AXHfw (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 24 Jan 2013 02:35:52 -0500
Content-Disposition: inline
In-Reply-To: <20130123201031.GF23057@blackmetal.musicnaut.iki.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Felipe Balbi <balbi@ti.com>, w.sang@pengutronix.de, linux-i2c@vger.kernel.org, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>

--eJnRUKwClWJh1Khz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

HI,

On Wed, Jan 23, 2013 at 10:10:31PM +0200, Aaro Koskinen wrote:
> Hi,
>=20
> Some minor comments/questions:
>=20
> On Wed, Jan 23, 2013 at 12:23:07PM +0200, Felipe Balbi wrote:
> > @@ -639,31 +630,37 @@ static int omap_i2c_xfer_msg(struct i2c_adapter *=
adap,
> >  		dev_err(dev->dev, "controller timed out\n");
> >  		omap_i2c_reset(dev);
> >  		__omap_i2c_init(dev);
> > -		return -ETIMEDOUT;
> > +		ret =3D -ETIMEDOUT;
> > +		goto out;
> >  	}
> > =20
> > -	if (likely(!dev->cmd_err))
> > -		return 0;
> > -
> >  	/* We have an error */
> >  	if (dev->cmd_err & (OMAP_I2C_STAT_AL | OMAP_I2C_STAT_ROVR |
> >  			    OMAP_I2C_STAT_XUDF)) {
> >  		omap_i2c_reset(dev);
> >  		__omap_i2c_init(dev);
> > -		return -EIO;
> > +		ret =3D -EIO;
> > +		goto out;
>=20
> Why change return to goto on these paths? If you reset and re-initialize
> the controller, I think it's unlikely that omap_i2c_wait_for_ardy()
> will ever succeed?

good catch, I'll update.

--=20
balbi

--eJnRUKwClWJh1Khz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRAOQ9AAoJEIaOsuA1yqREBm0QAKqVfohm35FxZk28sAb1WVcO
Xt3BNkryZQMqJeMOSLCUhExkVzFBDzhs5Tkm29kKHuo3fYZvyV+1fuYsHQEl/Q9N
zSPR3OsRpRPHsoBLMoU43P0m58opkzcpnYwoXGZAkMjvNVUlXzwkTYAyKzaNERq2
OVXYOvNk2M41E1eUl0oJ3rd6b7sMA2C09a72mtpLxWNdAMSgq5JQa8NfdN2lQ6Ug
MeDAhKcc02kevRBkdf0wM7oLyVGrtm/gYLc26rXhf+YjmeuTb/LvzUKr1s2qjwUl
6Xr6lhb6ztczjyi47BRKFO11zgZ/aDlp8S5r83yoW8TolzUeVEWmNZ+SWMISG4bl
l/7iNofJPvUqyUrPmWnqU3DPE9QKdBLiP84mZX3L28V1hPJ3bPtjRriLU1BpaNZK
uLioEj4EME3I7SSV2Ybnjq2RJO0ArESVX599y/Vr3ZyQ+s/2xXvz7CDzHmqEqu84
pRv3sRvmzu/TWuxbEfl/H5Ap/qWZOYkIxi3rKnklXUOKhdvD9mWr8753/QoVwvGa
9oaemny3A7IbJ5GqEajYA2K/0JuwP6BYYsePtawawtzdbsAgGP74qcKBgkDjHsNw
AmaRS+2nkb5fFgiDQkoVP4yYjiXlqv0oK1A0rbR+UZdRAvrmsVPe+/fcLvK2nqLd
GfuA50MT287FU/LoCmVq
=tCS7
-----END PGP SIGNATURE-----

--eJnRUKwClWJh1Khz--
