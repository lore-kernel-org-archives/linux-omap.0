From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 1/5] usb: phy: phy-nop: add support for am335x PHY
Date: Thu, 25 Jul 2013 17:24:53 +0300
Message-ID: <20130725142438.GD16106@radagast>
References: <1373031178-8871-1-git-send-email-bigeasy@linutronix.de>
 <1373031178-8871-2-git-send-email-bigeasy@linutronix.de>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bi5JUZtvcfApsciF"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1373031178-8871-2-git-send-email-bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Cc: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, george.cherian-l0cyMroinI0@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Benoit Cousson <benoit.cousson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

--bi5JUZtvcfApsciF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Jul 05, 2013 at 03:32:54PM +0200, Sebastian Andrzej Siewior wrote:
> The am335x PHY code is well hidden in multiple places. The glue layer
> uses the nop and does up/down in the background. This patch copies the
> power on / power off part out of dsps so it can be removed later in
> dsps. At this point I am not sure if it is better to write a new phy
> driver for am335x or just add the missing pieces to this one.
>=20
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>

hmm, if you do all of this then phy-nop doesn't make a lot of sense
anymore. Can you add a few patches to start calling file and functions
phy-generic/usb_phy_gen. Other than that looks good.

--=20
balbi

--bi5JUZtvcfApsciF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJR8TU1AAoJEIaOsuA1yqREmM4P/iS0lvzM1W6RGOZiAohCj+sK
IAzcP6d019ZRMPNG0FN+/l0AsJKHa8Ej2cb6tHPadLzd9iA1rcQPI/5CU+dxHNu5
bBzeMZXqHm7VmnUSgmJAENVnJ3fiAJQiTKmKmRXfnArcW6OpFE1Q3j52MdF6v/m/
nrajAZi0oTNSTrp/DA0GWkrbaXFdswGAJbrCwurvXkzbYcB7Mi9DmfB9RUeF2FUr
UX3wQhRXOMr8eqE+XgPRSCSCTvlgYc3P47a9PHfiy2L5dhly+DlX0HN3hjWz7Xqw
nW97S9PgfqaOTbw0UbGJiCNTBVqXBpQjIXYPYf+0rWbQmUnmuFdQDs5SjKiCphiC
7J7x7nEAY0+hwa+GPZBOtO7MX3tp+g6nWp0uzgemqlvW4e8MZvgWOLEj4CkBS1TE
bYfN0SuqQrhs3hoAx4a1Xky32V5ISjmE9iwjdhrO/O9NsrrSkNmhRD+OA8r9FEQ0
6Ou5ngylktyF4EJpn4khY4OBMZLXZ8iI2BKVnPTKZg4USkVabAf+7yxdkOUnaQzP
r6d6RNPOfOEQy/4wnW4Lx1kYcrIi5MneoxrZBqNLL05aCrRm/Lzq/A4FaxQj22tW
ocPlzwz/RyTcKM2mzPED+Cfp1sBRbnTspv1zFtM2UGGc4OizPs+GOutOuUzrTpWy
/D6bidjwY5rgmuxg2sOy
=UgMM
-----END PGP SIGNATURE-----

--bi5JUZtvcfApsciF--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
