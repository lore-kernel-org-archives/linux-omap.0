From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 5/5] i2c: omap: remove omap_i2c_isr() hw irq handler
Date: Fri, 7 Jun 2013 22:07:50 +0300
Message-ID: <20130607190750.GF15295@arwen.pp.htv.fi>
References: <1370630768-4077-1-git-send-email-grygorii.strashko@ti.com>
 <1370630768-4077-6-git-send-email-grygorii.strashko@ti.com>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FoLtEtfbNGMjfgrs"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1370630768-4077-6-git-send-email-grygorii.strashko-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Kevin Hilman <khilman-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

--FoLtEtfbNGMjfgrs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Jun 07, 2013 at 09:46:08PM +0300, Grygorii Strashko wrote:
> The omap_i2c_isr() does the irq check and schedules threaded handler if a=
ny of
> enabled IRQs is active, but currently the I2C IRQs are enabled just once,
> when I2C IP is enabling (transfer started) and they aren't changed after =
that.
> More over, now the I2C INTC IRQ is disabled when I2C IP is idled.
> Thus, I2C IRQs will start coming only when we want that, and there is
> no sense to have omap_i2c_isr() anymore:

so ? we still want to check if this device generated IRQs in hardirq
context. What if the IRQ line is shared ?

--=20
balbi

--FoLtEtfbNGMjfgrs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRsi+GAAoJEIaOsuA1yqREpYgP/3XNmQGoJARh4ov+ef+mEJji
amADqN8daH+YN2dS++G5abnuDnitSFou4jj/wV2/0N/y+I4I8EFkzDwHgURNI0xe
HtKCPxQMPakJuIbWb0Iroug+DnwvUNhdKJgz7ISnjZD4JeriG1B6Xb8cQDtlJEtC
cfLf21nmyOTuVqJbXBZd51rF2uBfXssD2pySVMKAxh9uS9liSDiyW5q8pr15drAR
9krIjH+VzQxO0ZdbYKfFk0jn7oNYHKOrZq65I01A4KYkWJzFxA3Ez8+T0T2u9Dpm
vOaOy7eovdB9HsZuBiC+nxEZOVVn7iq7J+kAjm1hBLyM0DEboycNHTcu/ui2kwfP
HU1nG2f76Hcfv0blysJxUvhKQzUkXTolBR5TBeHm+WT043uZ2RZ9gCzQnMeda25I
XSZClGHOhGuQmM56IPPxxrOuFB1LYvLux0Qvnci+SF4psoU979KqyrRoxcMmEkzC
ZnzvIrzWMjoRQ7J9kOwFAmkdTp+CfIFKNZxgamsu5lOQKHOZVidKwFj4fplNqI57
kKpbsMWm/LtU53Chy38x6VfUubIMdMvktJ/sXYv2dMgD6RUZIW4urw9uOpiun92X
g5VpdvKHR/XqByM23v2fPDMf9GOpFk3RNeRlM8smcOBvcKop+t0ZbjXDB1CRiPfB
0Aix1zMwG3w89uftoU1l
=eUX/
-----END PGP SIGNATURE-----

--FoLtEtfbNGMjfgrs--
