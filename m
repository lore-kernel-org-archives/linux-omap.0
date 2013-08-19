From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c-omap: always send stop after nack
Date: Mon, 19 Aug 2013 14:11:23 +0200
Message-ID: <20130819121123.GA4540@katana>
References: <51E50217.1000507@yahoo.es>
 <20130716090300.GG8880@arwen.pp.htv.fi>
 <51E5137B.7000302@yahoo.es>
 <20130716094212.GL8880@arwen.pp.htv.fi>
 <51E527F7.4080007@ti.com>
 <20130716112746.GN8880@arwen.pp.htv.fi>
 <51E537A4.40300@ti.com>
 <20130716130058.GD15036@arwen.pp.htv.fi>
 <51E57211.2040001@yahoo.es>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/9DWx/yDrRhgMJTb"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <51E57211.2040001-mRCrAkd8dF0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Hein Tibosch <hein_tibosch-mRCrAkd8dF0@public.gmane.org>
Cc: balbi-l0cyMroinI0@public.gmane.org, Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, linux-i2c <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


--/9DWx/yDrRhgMJTb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

> > Which means your original patch starts to make a lot more sense. I
> > wonder is this is really what we should be doing though - breaking out
> > of the loop, I mean.

Yup, that is fine. I applied the old patch with Acks from Hein and
Felipe to -next. Thanks!

> It looks like TI's i2c-davinci will have the same problem as i2c-omap,
> and will need the same change.

Somebody up for this?


--/9DWx/yDrRhgMJTb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJSEgtrAAoJEBQN5MwUoCm2ttcP/0+JcvKzt55RYxT/w4U3NKq5
IiJ+pQjIKyf//T1FQO2dAdiSq4Z2hXU0Z7+7ZNFkTHLhkXOvSoSDZnRBn3fNJKq3
Z5UfyOu5kIz+DbtoK1X3hXeGGlVoasEihw8Ptq0V3xZu6TpRf779JOlPNDBAZswY
Lg1R3KB/BU4vJ1Gi4w3LYSu0RaFCC4CHwhKT/+ZdSTUuIyWP4tZy8peDH09XWYRi
ZCKo0AdlasaPfRayOWZvcHDr+wdTChIdY+UyMPYgYtqTqTjDCCddgDK+yWPH8Lwi
OiVXxneAFnKRjpGCOsWIu7LSMlcRAkb2uk5BRV07VJxFSkm10fMy/WiGq2wubiqu
B620bTOWRVCjFYMoOvKR2rcGFh9umV42MLqbhBdZVSms2cG6+fkWD8g/LmUMCVc3
kOJkuLiop8k1142vjcMWEqVbhN7SoshP9nYGvRf3MLT/ctM00lRSjeg+kP63F65v
03X0PBF0+pEeXuc07hi5BylUtBE+MpBtMtC5fXnj41KhlzSE0ZBqRk+1EjEzC9uy
VBqK8cOSfoExTSPRp3Xu5C22FmTJwDq2EJEHxAJ3s3GGBIi5c/pYdBW8xbXSOJSG
28uSDL2sFMs99qrCEJQycCJ1p10OQ9RXfXP1KpJXDLszpS7Fesps4gExlo/kpRMs
ssP6gFzfWtigXYEoe0LR
=PZST
-----END PGP SIGNATURE-----

--/9DWx/yDrRhgMJTb--
