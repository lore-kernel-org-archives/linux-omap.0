From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c: omap: Clear ARDY bit twice
Date: Thu, 10 Oct 2013 09:55:31 +0200
Message-ID: <20131010075531.GB2638@katana>
References: <1381142519-29382-1-git-send-email-taras.kondratiuk@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uZ3hkaAS1mZxFaxD"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1381142519-29382-1-git-send-email-taras.kondratiuk-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Taras Kondratiuk <taras.kondratiuk-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, steve.mcintyre-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Richard woodruff <r-woodruff2-l0cyMroinI0@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--uZ3hkaAS1mZxFaxD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 07, 2013 at 01:41:59PM +0300, Taras Kondratiuk wrote:
> Initially commit cb527ede1bf6ff2008a025606f25344b8ed7b4ac
> "i2c-omap: Double clear of ARDY status in IRQ handler"
> added a workaround for undocumented errata ProDB0017052.
> But then commit 1d7afc95946487945cc7f5019b41255b72224b70
> "i2c: omap: ack IRQ in parts" refactored code and missed
> one of ARDY clearings. So current code violates errata.
> It causes often i2c bus timeouts on my Pandaboard.
>=20
> This patch adds a second clearing in place.
>=20
> Signed-off-by: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
> Signed-off-by: Taras Kondratiuk <taras.kondratiuk-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

Applied to for-current with stable tag, thanks!


--uZ3hkaAS1mZxFaxD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBAgAGBQJSVl1zAAoJEBQN5MwUoCm2VwAP+gJ4HFNH6QzwEVIyqFU1yT0r
KVn6VA8isQ/DCXfREswOGezJI9pwKSdxpM3yQf5RXKVhazU6A/yTrh2FOj9wYVat
x+Xl7NY6/wptc2cU1kHve4IVyt1x/UcBVBpMI+WRV76ayEiP1O94SwRlIhDd/KnV
Bi9q/hbrHGLeKVMPH++buzOUJ/wuzHgGy1Xcbzq8t5zoOhy8/jWiJIcyT+hLtDbO
BlSdaMnbpq6bMJonb6fx9egxGJR1LFPC8t7c2AQ7KZ1WukddrChcNqo6dicnIJJD
Gv3s4HKC4kE8oJpYTGcEluh75LEn3IwyLljQqlzfLY5VitYgaRnnOrCxyohaG2ga
E1wJn9DsKEDt7D38VxNBeFLSXm5Rq1bIvpcdUbNyOEZZHx0tCWHiROak1CLNrWWa
9F4pL2krPNi1jCyF8VaDKapELXWObDyFMZkt4Oji246dFaWzF1Xx5MSz4VwLuxw0
Tt5QIaJto4bIkgo4NTaLH6kmkT0nf/Kq4rHVnAbYrNn4crp8bvH4QyZtVQthPkbX
ljenEl8BSpQEDuZceMY0KSE5GYnHWQXlOcAtP+i9t0KnjcLKZEVr8+vrYVCvXD0D
x9np9d6vcM4muyjgpojXyya+dhIGSsM32YcHb5jrXKgJl71ZqOhHRcqH2iCeHcc0
8GNmHVBD3P6BNZHqzVpe
=aY2K
-----END PGP SIGNATURE-----

--uZ3hkaAS1mZxFaxD--
