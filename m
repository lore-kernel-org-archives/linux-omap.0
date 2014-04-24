From: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Subject: Re: [PATCHv3 19/41] OMAPDSS: panel-dpi: Add DT support
Date: Thu, 24 Apr 2014 14:44:10 +0200
Message-ID: <3615191.vG5AEQORWJ@avalon>
References: <1390301833-24944-1-git-send-email-tomi.valkeinen@ti.com> <20140418155107.GB5354@atomide.com> <5358DEEA.1000506@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1719767.D5BMvv66GP"; micalg="pgp-sha1"; protocol="application/pgp-signature"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5358DEEA.1000506-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Joachim Eastwood <manabian-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Archit Taneja <archit-l0cyMroinI0@public.gmane.org>, Darren Etheridge <detheridge-l0cyMroinI0@public.gmane.org>, Stefan Roese <stefan.roese-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Sebastian Reichel <sre-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>, Robert Nelson <robertcnelson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Dr . H . Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>, Marek Belisko <marek-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>, Sebastian Reichel <sre-GFxCN5SEZAc@public.gmane.org>, Javier Martinez Canillas <javier-0uQlZySMnqxg9hUCZPvPmw@public.gmane.org>, Enric Balletbo Serra <eballetbo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Florian Vaussard <florian.vaussard-p8DiymsW2f8@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


--nextPart1719767.D5BMvv66GP
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"

Hi Tomi,

On Thursday 24 April 2014 12:52:42 Tomi Valkeinen wrote:
> On 18/04/14 18:51, Tony Lindgren wrote:
> >> +=09gpio =3D of_get_gpio(node, 0);
> >> +=09if (gpio_is_valid(gpio) || gpio =3D=3D -ENOENT) {
> >> +=09=09ddata->enable_gpio =3D gpio;
> >> +=09} else {
> >> +=09=09dev_err(&pdev->dev, "failed to parse enable gpio\n");
> >> +=09=09return gpio;
> >> +=09}
> >=20
> > We should set the GPIO polarity based on the OF_GPIO_ACTIVE_LOW lik=
e
> > gpio_backlight_probe_dt is doing.
>=20
> Instead of doing it with the old gpio API, and checking the 'active'
> flag everywhere, I think we can use the new gpiod API which handles t=
he
> polarity automatically.
>=20
> I attached prototype patches (based on -rc2) for panel dpi using that=

> approach. It's a bit messier than I'd like, because for non-DT boot w=
e
> need to request the gpio using the old API, and then convert it to
> gpio_desc. We can remove that code when all the boards use DT.

Just FYI, you can use the gpiod API with non-DT platforms if you regist=
er GPIO=20
lookup entries in board code with gpiod_add_lookup_table().

> I've compiled tested this only, as I don't have DPI panels I could us=
e.
> I did try similar approach for TFP410, and it seemed to work fine.

=2D-=20
Regards,

Laurent Pinchart

--nextPart1719767.D5BMvv66GP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJTWQcaAAoJEIkPb2GL7hl1dz4IAKVksmLI0n/ZbMYHnMbcP4+3
7olrT+4pCxqzYLNZOdta1NfSV5OJ58GcieMBrsIErw5RcrIJbws6iP+QOwwSthkT
vPYTVa8+6dLJ2PdNvg8PJIjhRYL+26fHBT/ROKmqPgSf+OqkmRkR3opGXQe+0L+2
keq0GBhKCCVwMmJO210BjlrEdz6fOBL5ZUAhiDjXHcf1KdzzAhiEJUeUFftR85Jv
o70ZoDrz8h/ofHNgi7W3f36TdUP0kr+s5DnwyDUted525efCdd4JgeuBc6rVT1Cf
pWn/AJtgcx5saJZ84//IW6muJswN9yTlK2C2/FMrwUbiR5VTt/c7S7Uy+9ZkQA8=
=G8Ke
-----END PGP SIGNATURE-----

--nextPart1719767.D5BMvv66GP--

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
