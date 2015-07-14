From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH 1/3] i2c: omap: switch to dev_get_drvdata()
Date: Tue, 14 Jul 2015 13:02:57 +0200
Message-ID: <20150714110257.GA1517@katana>
References: <20150710172701.GB20408@saruman.tx.rr.com>
 <1436819884-1614-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="r5Pyd7+fXNt84Ff3"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1436819884-1614-1-git-send-email-balbi-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Cc: Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux ARM Kernel Mailing List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


--r5Pyd7+fXNt84Ff3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 13, 2015 at 03:38:02PM -0500, Felipe Balbi wrote:
> there's no need to fetch the platform_device
> in order to dereference it back to the dev
> pointer to access drvdata, we can use
> dev_get_drvdata() instead.
>=20
> Signed-off-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>

All patches applied to for-next, thanks!

Please send new series as a seperate thread, don't reply to the old one!
You could have collected the tags from last version IMO, it was just a
rebase, no code change.


--r5Pyd7+fXNt84Ff3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVpOxhAAoJEBQN5MwUoCm2dTMQALLt47KI8HHgya/BnQy1FStK
nQgBGyh4SCA0pMwlPHMp75ymOOgpOGWwjBJiWtLZZkHdWOWdccK5Zz99NTxoQhID
M0a74qyKKHIE5GMDsZKEI19uMCJrhQMk/TDK1pivxbup+E56tbl4g+QDgy5WwA5m
TsNuLFIstQV7FGC2VMKtO1dF5evtLmSzLxQI5QCs1/dgpqIlbuTmHovFinuoJZP5
ztx39GAtiQxNxf0YtXqslkvYcKNZ6W4APm+lUe1dIJ/M0aCcnjfaIZNgpz5+C9ZN
EJkXJ5Truf5BJloXR/reaNhz5VxoagLyvK30r0N93W4tY8YhFzp+bJapE9E/TMPL
pNIWp+H/kRodMbVujaTACpl3EmJSbjDXf5v6B/GvDxN5RjfkJ7Y9Xgrum8jC0p+6
snT+wg+9HugEbpAEb2KBu5Ei6qXbKP62MgZza0S5T/8QgP9x7sMaHN+o49MJwimV
w5pHoG0xhWjZ1xECQMVnRBf4xHjT3hg6Mapccfo9adR5oOL4BiT+6GuGQtsG90PY
pLr1R7Rrwm0Bm3XA41pPkMihVZsM1MeBJsYs8DPGAN4oNoaivscqvfulZFvFi4wj
3JB9q7cyUj7EYVJo9/fGh+VR6uLqeNcVALsJ8WrIhc7vulvUXFjMMHU15uh21hqu
tsVld82ORmCgK4K0gYqB
=VcAj
-----END PGP SIGNATURE-----

--r5Pyd7+fXNt84Ff3--
