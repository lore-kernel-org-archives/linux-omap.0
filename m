From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v6 1/4] ARM: OMAP2+: cleaned-up DT support of various ECC
 schemes
Date: Wed, 25 Sep 2013 08:46:19 -0500
Message-ID: <20130925134619.GG10746@radagast>
References: <1378986619-26765-1-git-send-email-pekon@ti.com>
 <1378986619-26765-2-git-send-email-pekon@ti.com>
 <20980858CB6D3A4BAE95CA194937D5E73EA15ED7@DBDE04.ent.ti.com>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xjyYRNSh/RebjC6o"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20980858CB6D3A4BAE95CA194937D5E73EA15ED7-yXqyApvAXouIQmiDNMet8wC/G2K4zDHf@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Gupta, Pekon" <pekon-l0cyMroinI0@public.gmane.org>
Cc: "olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org" <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, "benoit.cousson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <benoit.cousson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "arnd-r2nGTMty4D4@public.gmane.org" <arnd-r2nGTMty4D4@public.gmane.org>, "dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org" <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org" <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, "avinashphilipk-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <avinashphilipk-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Balbi, Felipe" <balbi-l0cyMroinI0@public.gmane.org>, "linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "dedekind1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <dedekind1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

--xjyYRNSh/RebjC6o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

+ akpm

On Tue, Sep 24, 2013 at 01:04:05PM -0500, Gupta, Pekon wrote:
>=20
> >=20
> > This patch
> > - updates DT binding for selection of ecc-scheme
> > - updates DT binding for detection of ELM h/w engine
> > - removes following obselete ECC schemes
> > 	OMAP_ECC_HAMMING_CODE_DEFAULT (S/W based 1-bit Hamming
> > ECC)
> > 	OMAP_ECC_HAMMING_CODE_HW_ROMCODE (H/W based 1-bit
> > Hamming ECC scheme)
> > - updates DT binding documentation for mtd/gpmc-nand
> >=20
> > Signed-off-by: Pekon Gupta <pekon-l0cyMroinI0@public.gmane.org>
> > ---
>=20
> Dear Olof and other DT Maintainers,
>=20
> This patch series has missed multiple merge windows, and
> much of the other development work on mtd/nand/omap
> driver is gated due to this.
> So, request you to please review this patch set and Ack it
> if all your mentioned concerns are resolved.

--=20
balbi

--xjyYRNSh/RebjC6o
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJSQukqAAoJEIaOsuA1yqREmG4QAI4Uzvi3VHdrNmTGNjGJz3VN
j3RxXtbD6I1ZvHqfmR841RYk6HwgSpJiU8Wt8ymOJUNSFHRKWMsMheih/L789g7c
NkhNVeHgMpvvROWOUxiQkSGDGI72hOm4bgYT7Y7taRbcQrb7LNQYSg1hwWH4Vt+e
cxlpw58/s6AaOZpCRNstyjUoZvIjVi4OiCxK7rK3HrH9+xZORE4Fz5vYjqHv9Ndu
VubHmK/3D8tMqw4rGQbapLUHzjnpT2eHPwe2vikZ0wjoccdmrDCIA3VgPYSounrY
wsqEpY4+pTgFD/BAXV61tfIj5sKxpFizkGe911dC7E7fCCEIryhZSuT0MY4wk/MJ
peazcFQTlVRFOIRJV/nn9paJXtN64Dkf5vhqu3yjBMenvqMJUZTjezF8+B01+uvr
REd+1EQce5Is649vJpmNLFiihqhp6IKE8tuaRW50b5zY8mC+ip8Sr3+ENmAcBECd
DC/DdVIzizZKknb3v2+ODuBdBvLC/6+/V5I9AqMeNd7PbaIowjGSbb4kLKfGFIq7
P4WsJRJTYzrEbty4+V/i2l1tOJS6iefJ1qGqHusmtNJ5KxFjN3yGIe85KJr3c2Au
pAfWy6h1oJ5wuq746wHfMc1sQB0kExR0yNJyIkeqIVKQLPmjA82yKJh3m6ZWSGwT
woHvdfOmSAzhnUw1rh7w
=gQOf
-----END PGP SIGNATURE-----

--xjyYRNSh/RebjC6o--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
