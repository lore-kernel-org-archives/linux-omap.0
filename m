From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [RFC 05/23] i2c: omap: raw read and write endian fix
Date: Tue, 26 Nov 2013 13:42:38 +0100
Message-ID: <20131126124238.GC7427@katana>
References: <1384560086-11994-1-git-send-email-taras.kondratiuk@linaro.org>
 <1384560086-11994-6-git-send-email-taras.kondratiuk@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="69pVuxX8awAiJ7fD"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1384560086-11994-6-git-send-email-taras.kondratiuk-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Taras Kondratiuk <taras.kondratiuk-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linaro-networking-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, Victor Kamensky <victor.kamensky-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--69pVuxX8awAiJ7fD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> @@ -1142,7 +1142,7 @@ omap_i2c_probe(struct platform_device *pdev)
>  	 * Also since the omap_i2c_read_reg uses reg_map_ip_* a
>  	 * raw_readw is done.
>  	 */
> -	rev =3D __raw_readw(dev->base + 0x04);
> +	rev =3D readw_relaxed(dev->base + 0x04);
> =20
>  	dev->scheme =3D OMAP_I2C_SCHEME(rev);
>  	switch (dev->scheme) {

Part of the comment above must be removed, too.


--69pVuxX8awAiJ7fD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJSlJc+AAoJEBQN5MwUoCm23bYP/jslg++Pu5Qt9TwM5gCUcwsq
cuf8jPiddxnZoUAEX2v3e5bas4S/Bv4dRhFskG0UImG2Tj/xOhJXThv0fR0qasso
ymmtO+egkCPHDIiGHXT9SAo5aHPgAT1x6wyKEWdm13s5rw9ywZVug8NIyyKtnnI/
dK3327eD+vuBua1NIt9wrbsBVbQuvmsmM9F3roOR3XBtu+I7lB/S6wdWJuMAPGs5
sUpK9vqffvyHcKyJor4jafHuqXKIGpN1j+vd7rHBonsgQcImXPPYMIeNNj/sJD+r
IqAq9W87xYbaGAzcxR8beLZx6IVW42hrkRevdSLH4IBfYbKd8ersCThkdAd7jArG
mSDzKPeWXSDlTToqY73sNCzZgvUJMDxv1ZB/eDbv6DsYVI2RGtUK9m0FStCVjevC
c5Y3j9Zy2spmcpMjnm9KpfPf/cxN8vhnEBWt1SzO8bt5vgcPiJFA5ydnKkedm/Zr
Z8Cpe4WeOPfef1wsJk9pOpOJ52g9MlkMM4TPzmetwGucwx2bmRJqJ0l5+LBrLSaH
bt5q3gwm6vmtIZMsytNKEQpflfZap9QWc1i6Co8c/Mn5Y8Q1L2eyVHPpxZkjfAhA
7cCcLnsQ4uZYze6iSNNnLZRFnAXcu6rK1iHoA7DSCOS8ZfsHSv/+7d7YTw9kTCQI
o6+7Ller4jE1tiu7AZNT
=oUTt
-----END PGP SIGNATURE-----

--69pVuxX8awAiJ7fD--
