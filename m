From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [RFC] i2c: add deprecation warning for class based instantiation
Date: Wed, 19 Jun 2013 12:15:27 +0200
Message-ID: <20130619101526.GF2950@katana>
References: <20130607090623.GC3428@katana>
 <1370596166-12404-1-git-send-email-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="juZjCTNxrMaZdGZC"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1370596166-12404-1-git-send-email-wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--juZjCTNxrMaZdGZC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 07, 2013 at 11:09:26AM +0200, Wolfram Sang wrote:
> Class based instantiation can cause huge delays when booting. This
> mechanism was used when it was not possible to describe slaves on I2C
> busses. We now have other mechanisms, so most embedded I2C will not need
> classes and it was explicitly not recommended to use them. Add a
> deprecation warning for drivers who want to disable class based in the
> near future to gain boot-up time, so users relying on this technique can
> switch to something better. They really should.
>=20
> Signed-off-by: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>

No reactions on this, pity. Deferring.


--juZjCTNxrMaZdGZC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRwYS+AAoJEBQN5MwUoCm2NIIP/2LbtKw7sFmJ99GyBNDXTjg9
xnN0LJIZkCjxgTXBYoR2/JbHbcxXDbv1NDm4WpL7Ic0bUN7VSaKZjVnLEII/bsla
M0ZgGn74vgtSOFyuEvhYw/OUhTmvx/ICGDY0YC7y5A1jEaZNdYIxF6cNiGmQgZBg
Vhd+m+lDJPhwB9wcBIly8qLBxNzBE57UZqOPsSLRRbPiJIfqHjKGztBYb69B57tS
tVcHsdyL6bal2/nfCWcxUPQBgvYyQhUWPeyffKq2eQHEkjfDu51AIEpyjdpLDnTW
5kx8Vf46am9CyyqVecvhKqgUF2nE38qMcafJ7bK7oKebUwhWS37qTyAdsfGMe+kG
YkNyDjSCPoiF1z7wBHgWu/0KaddNCyN65wS1xyso385jt5EInsFS8G9XQSBiKSJs
jDYDF8UGlHIrcsaPD+S5bR31DBJJuyUrOs3Fzk6SGvSaQ3yqXBHmE/F2MfjTbgmH
1nkJuU91XdS3raOOEQEQRfAY1Gzy6kbCFs5MLXtY6gatKwJRv5cvC9psIpU/MKim
GAOi5Jp8JHBgfIxYDO6clHb2hjhWXWNrWb6NS9vdyynLjQLkF/23PnPiHtfriMZ4
773s6xDWfWJziGCqzxGQ13yKlyE5EJq/GsXkKn6929/P9OSg//dzV0Gcm85/mY76
drK/OVXDyNHKk3Gk+RV0
=R/JS
-----END PGP SIGNATURE-----

--juZjCTNxrMaZdGZC--
