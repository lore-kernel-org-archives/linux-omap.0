From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH] i2c: omap: implement bus recovery
Date: Mon, 9 Mar 2015 11:39:17 -0500
Message-ID: <20150309163917.GI3739@saruman.tx.rr.com>
References: <1424369209-26735-1-git-send-email-balbi@ti.com>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hABqaeELJqnDDeDE"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1424369209-26735-1-git-send-email-balbi-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Cc: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--hABqaeELJqnDDeDE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 19, 2015 at 12:06:49PM -0600, Felipe Balbi wrote:
> If either SCL or SDA are stuck low, we need to
> recover the bus using the procedure described
> on section 3.1.16 of the I2C specification.
>=20
> Note that we're trying to implement the procedure
> exactly as described by that section. First we
> check which line is stuck low, then implement
> one or the other procedure. If SDA recovery procedure
> fails, we reset our IP in an attempt to make it work.
>=20
> Signed-off-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
> ---
>=20
> Tested with AM437x IDK, AM437x SK, BeagleBoneBlack and Beagle X15 with
> 1000 iterations of i2cdetect on all available buses.
>=20
> That said, I couldn't get any device to hold the bus busy so I could
> see this working. If anybody has any good way of forcing a condition
> so that we need bus recovery, I'd be glad to look at.

ping

--=20
balbi

--hABqaeELJqnDDeDE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJU/cy1AAoJEIaOsuA1yqREZA0QAIZHLPFagtA+SNSdJ5jb97eW
l8HQ3e21MbGAsmGb9i1Moy8sd2DrNbPIWVZmvQqdJnhf7AxEUyffWSPGW9BSxyPm
adMvQUN5q7fjUq+3+pVtLJEcnTOG2BPaTO53Y8S2zN+gL0KG3HqIPom6q3zS42Aw
llnt/8WI3RrpBZ7jt3P3NAR+UdKVIkuWyHzGSzqu0hoQmGSQ+e64dS/+hH3vnT6Q
AYF/rGpYbbTeR5ND+24RUNUQXnMr2nV/uzMQ68Vk04Zlrvd1OWal5dMNzWXcVxSV
aWllaj4kC3s0J+5qUVYjn9/dZcbEFMQXCWNWbGm+PwyLOisYyJSwnMNVD9nbxEHY
g93u+D4r+IOvUha6YEDpRQlNv3DQgYQQZvkp8HCZVM5/bDtjnQx3kBMIjVHLsE5L
6EhvIY27UU8F3HDQbgVZqVkNPL0x5iGfI+PYTHqZd8fq+abgs0Xg7Mwt6MW8rT4S
wwBU6jR2m9VP/MT8lvrlMfrktRBKQAbt1xMRY3xhH7Tp/tJ+JCNDu6jdcqOtZGey
giNfj/9mTJtpfBsRBkJJjHT0UTGcTuP2dW3YKc3jW8kaCjD7yGqeyk1h5P3S1ME2
GuqcwKxUGsqKdVPS8n+I5TC3XXTJhzRDZE77q//gYJZrYnNGpByRl/zF9Ul4d+MX
ihpDJxWOi/6RNIqj9Mdm
=K8CS
-----END PGP SIGNATURE-----

--hABqaeELJqnDDeDE--
