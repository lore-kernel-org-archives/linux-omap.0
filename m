From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v3] i2c: omap: improve duty cycle on SCL
Date: Tue, 18 Aug 2015 09:43:47 -0500
Message-ID: <20150818144347.GD9143@saruman.tx.rr.com>
References: <1434569475-17378-1-git-send-email-balbi@ti.com>
 <55827CD7.7030207@nokia.com>
 <20150618172558.GC27790@saruman.tx.rr.com>
 <20150709194241.GF4744@katana>
 <20150710172714.GC20408@saruman.tx.rr.com>
 <20150813143651.GG27560@saruman.tx.rr.com>
 <CAFqkuUbO1CZ8bu8g8O7SsLF-0nUV274GZ08=6J1sVS4Foy+_EA@mail.gmail.com>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ieNMXl1Fr3cevapt"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAFqkuUbO1CZ8bu8g8O7SsLF-0nUV274GZ08=6J1sVS4Foy+_EA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Matt Reimer <mreimer-9nEMHBxvMEgxoycv7ERPSQ@public.gmane.org>
Cc: balbi-l0cyMroinI0@public.gmane.org, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Alexander Sverdlin <alexander.sverdlin-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux ARM Kernel Mailing List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

--ieNMXl1Fr3cevapt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

HI,

On Mon, Aug 17, 2015 at 06:28:11PM -0700, Matt Reimer wrote:
> This doesn't seem to work for higher speeds, like 2.6 MHz. hssclh and
> hsscll end up going negative.
>=20
> My case is an OMAP3 trying to configure i2c1 at 2.6 MHz, on which it talks
> to TPS65950. I end up with the following values:
>=20
>         SCLL 0x0000fd12 SCLH 0x0000fe13
>=20
> The end result is that the high-speed part gets configured way too slow a=
nd
> so the OMAP3 can't talk to the TPS65950.

hmm, indeed. Seems like anything above 1MHz would have an issue. I'll
see what can be done there.

--=20
balbi

--ieNMXl1Fr3cevapt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJV00SjAAoJEIaOsuA1yqREc64P/3tnaj1ziOLUsuzjXdO4Exg4
vjpR66R+YIejNzCp+iD3oHG9nSJ6q9w9rc6V73iwXNbsFLQ9k7w2y0AXZWA9uKHD
9F27nosDqQVaH0BLbOD/o2sYpNnsEz1o9j5y6CGUoCscTCQz4iVk662QLKVhn9P4
/vPR18RcMf9fcRuoC7gR3KfvY7DtKSbRLBurCfXiZvPlkd5Fku56vQDZvGMmy46L
wvytS/cry//dm95U+67lahzar8mr2+twWd1I2OaZ9hKwLXGSTgp4SDRdVRQtPDwd
nYxZ8V4J7wr1BqFOCWKoi3khfDk8CU3cqjDuk/E+Zma+n0H9w7/mEku1/v9hnRgy
P+IOTe/6+NuDU4qsjh5Z4W71ONKWBOwur+PlvT1KNxMNzptCEGhHAl7eDP8AAk8O
1HrEkRybeiW1d1QkFStj66pMVn78wOYT80fJMmCzCKKe7LseXiaAdgfIZfnKXLAZ
Z0J0i1iffiQaFZPcD9C4gQSmP9afJl5UHdHJ52ObazVS0YvLdN94CTK8+hM+z7Vm
FDCr+LxwhD4lipA7ssV+piLOpLy70ScEYEahVWRJxBrM/Uq84e9eJzsJtG9m8RPl
sOP6yg7inEpBUkFhT6jI5ijUILx+KTWPuuE2v+4EPOXf6xwSr99blpoy9vKkvjAJ
y6fxIEtrA74atBScc7t8
=uHuE
-----END PGP SIGNATURE-----

--ieNMXl1Fr3cevapt--
