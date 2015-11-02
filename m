From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH] spi: ti-qspi: improve ->remove() callback
Date: Mon, 2 Nov 2015 09:20:11 -0600
Message-ID: <87bnbcctsk.fsf@saruman.tx.rr.com>
References: <1446127050-5957-1-git-send-email-balbi@ti.com> <563778B8.9060109@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-="; micalg=pgp-sha1;
	protocol="application/pgp-signature"
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <563778B8.9060109-l0cyMroinI0@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org> writes:

> On 10/29/2015 03:57 PM, Felipe Balbi wrote:
>> there's no need to call pm_runtime_get_sync()
>> followed by pm_runtime_put(). We should, instead,
>> just call pm_runtime_put_sync() and pm_runtime_disable().
>
> Sry, but why do we need to call pm_runtime_put[_sync]() here?
>
> My be just pm_runtime_disable() will be ok?

and disable with unbalanced pm_runtime_get() ?

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWN38rAAoJEIaOsuA1yqRE19AP/0ETFio+kacunE+/AZj0zKLi
Pne7tmGZpH4hZpSVSISxJ10DUvCk45ZoHxmEPlktTDMnWZOzzAnbX3e2nw/YEYoO
fiAHUnlAg3anI2vrQBwKASAPxqNNtdijeIzAQH0v5CzI0nUvsbklZ0l1cEXi7p05
D2rNjHwAqXm58/LCZy90mu0K9vaZP9M/1/RH2JvC0BkJMI6pU+JfYmB3jndxJmDD
BNhjddvqFe+pKZgyHOcaCbVV7282phTWMKiilyFF8bZUfqKdjeHRZ/eRQG0fzP0i
+vv3/t2KYvgcy5iq9qJuQVzx32bpnArCP4E08a4KZukAJzvjF1mk5iA5poq5cekj
VN1s36UbCUWknxIbzdFhBwh0ZTmAO96aqnZ1Zmz2Mhp64AdYuWtuT6+rmrkwAMEx
g7SuanQrejh4DW6GbpjPnmrUkPW8Cgo0Vg/CDXxVgUmAmXSE6Ga7sKdNmYDy1SsG
OWtqxBkwM7TOCcp5wkgRqEIQKF0k1seYdmeHrxyE+9gKghW2OnHq+u2+XXSU9TU1
7jHQIqbm+mIMnQzQ3wCs68OstuOrvGuqb43+D+wXQHhIu2roLEqGd7Ts2hjwRtNV
XbwSAd5kOmGnW/SJ9klgkd367wt9uqMUMgiQ2U5c8KWn7pnhtWsjtucX/b37cDi0
wKs4KruW57WEIz8fRrFj
=NANm
-----END PGP SIGNATURE-----
--=-=-=--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
