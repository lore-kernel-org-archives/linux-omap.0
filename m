From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCHv2 1/7] i2c: omap: Fix the revision register read
Date: Mon, 5 Nov 2012 11:04:12 +0200
Message-ID: <20121105090412.GA2913@arwen.pp.htv.fi>
References: <1352025873-27492-1-git-send-email-shubhrajyoti@ti.com>
 <1352025873-27492-2-git-send-email-shubhrajyoti@ti.com>
 <20121105075026.GB32468@arwen.pp.htv.fi>
 <50977A30.6040907@ti.com>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0F1p//8PRICkK4MW"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <50977A30.6040907-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shubhrajyoti <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Cc: balbi-l0cyMroinI0@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, b-cousson-l0cyMroinI0@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--0F1p//8PRICkK4MW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Nov 05, 2012 at 02:04:56PM +0530, Shubhrajyoti wrote:
> >> @@ -1155,7 +1187,7 @@ omap_i2c_probe(struct platform_device *pdev)
> >> =20
> >>  		dev->fifo_size =3D (dev->fifo_size / 2);
> >> =20
> >> -		if (dev->rev < OMAP_I2C_REV_ON_3630_4430)
> >> +		if (dev->rev < OMAP_I2C_REV_ON_3630)
> >>  			dev->b_hw =3D 1; /* Enable hardware fixes */
> > looks like this was applicable to 4430 too, what happened ?
> No actually this can be deleted completely once the
> start -> transaction -> stop sequence recommendation is followed.

yes, but we're not there just yet and this patch is changing the
behavior of the driver in ways which don't belong to $SUBJECT.

--=20
balbi

--0F1p//8PRICkK4MW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQl4EMAAoJEIaOsuA1yqREO70P/ivVHQ5h64EIg1pkCfXQtluH
bJ2UMgH8a+FnxpzIlWhQ+c5ffNFMLmGLCji7J4lVUEzVkeUbiAUNC3HgqqX0fbtq
VEMWlmP6ci+8pkFe4zMENmCiibxNUVPKiL5+rVIUuVBcar6J+0Hbv5RlmatgfZhH
D0BBigLpfWLqW4ThfcCL5fAH2A9n/2jMORH9XypoWjPkmkflJwAiOP42762h7OZD
Xb6sz0ZjCtQkaXWeg0Jc3mfUwbajs7oyGgQC5k30ylH7DfDZblDgFkNMF2mEnfk1
qZlPE9vB8/x1tt/xXnBa7YI4BG1fky8MpZpqC6Jikg7TJDt2HKPjwnqhCQbCuJxf
Lzi51DeufmPnSIVtpzUJiEMOsJLDw4appuV02g05iGgIWdNKRVJxe+/PiZnDi4Ml
aRpLVvqjIgxBry6JAZTFnp8emnUefE1YC+uR/+wSCwTozd+v8xH7y/Fqs23VqoC/
fn9x6IIwEguGQYWDrQ0E7Jg5sDtfbMfe3QZaHMffZd6jz0tEi2o7A4xUxYNgB6kM
R6Sv2AnvsneT7qbdkl39yOGnjmIgPQS3NSlQeO0PrV/nnNdG4zcKfephfc43HdL4
528e1zoO32IYHrVdIFPt6JbbDBa+vkcLJ6Q51bZz8bQyC46b9NzUK8j4XcNRf3Xu
tRl2+lyFL9xrGpPlmLYJ
=ZQE6
-----END PGP SIGNATURE-----

--0F1p//8PRICkK4MW--
