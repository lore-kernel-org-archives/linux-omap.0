From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH 02/12] drivers/i2c/busses: don't use
 devm_pinctrl_get_select_default() in probe
Date: Wed, 7 Aug 2013 17:37:09 +0200
Message-ID: <20130807153708.GJ2978@katana>
References: <1373471889-18107-1-git-send-email-wsa@the-dreams.de>
 <1373471889-18107-2-git-send-email-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tAmVnWIZ6lqEAvSf"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1373471889-18107-2-git-send-email-wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--tAmVnWIZ6lqEAvSf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 10, 2013 at 04:57:37PM +0100, Wolfram Sang wrote:
> Since commit ab78029 (drivers/pinctrl: grab default handles from device c=
ore),
> we can rely on device core for setting the default pins. Compile tested o=
nly.
>=20
> Acked-by: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> (personally at LCE13)
> Signed-off-by: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>

Applied to for-next, thanks!


--tAmVnWIZ6lqEAvSf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJSAmmkAAoJEBQN5MwUoCm2bHoP/iNtk37KWc2nWQT+dGhISokW
xdgW6SKAkGMd+8RNb8l+HHeaOsbRvGIYwvHvJMt1p0lLIVIcI/HfFdE+2wfD3ACd
5Cx0Mq9UJQdctFefyEBwjhCQCkUsKQnLjlj/Q52FWpmBTQDBmMA8lpCG/S9FrLji
gupFMxxTulPVZaf9EYxzWt/M28SOOgpoJdCkeR6g6eYaqG4NSiRRAfQl++oNb7CO
CM8e/g84LD7wdA5n9vEeg2nudUiPZ0z+R77PmGxM815SsA8dYx1cbFECtCy3vybz
Y1/7jY4OlexBlG0qsXcqpF3QMIGiI+eYflqSb37bz3yARYmRr44R6Ti0rX2hF0aq
qYfcbyEEkX9Ilv3jsA/E2kQy3xbPSFgHN/v64MiIHVmwyEn11uz0vuSJgrarJs5k
h6ftDt4PUN57xkuGrMuoux/A9LaWPkSZ8jqYkZd+ezvBr6uz4ukXEie2zg6bxhJ6
nv/vO/zibdq0gz3i00TKXlcZRqnioef9IcoeSf9lSvP2M/Jb5gMJ97wxuEIOCW1t
MO4tW6w5MJ5CW7i3MzCyDu4nJwZtVzBDJ/NeLQDaC44U2gxIJwPkdYxF4i0Hk7+X
BFaGMlzzKkDsYMygsGftl0m0iJELFjOTRLKBG53KfFixLQ+N/FGnfiMQWjkIBZD4
bvNdL3UBgFXN8mn9c2NK
=zKOz
-----END PGP SIGNATURE-----

--tAmVnWIZ6lqEAvSf--
