From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 00/23] Nokia N950 display support
Date: Tue, 8 Mar 2016 21:45:11 +0100
Message-ID: <20160308204510.GA31069@earth>
References: <1457455195-1938-1-git-send-email-sre@kernel.org>
 <20160308183908.GA31741@raspberrypi.musicnaut.iki.fi>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fUYQa+Pmc3FrFX/N"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160308183908.GA31741@raspberrypi.musicnaut.iki.fi>
Sender: linux-kernel-owner@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Tony Lindgren <tony@atomide.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, David Airlie <airlied@linux.ie>, linux-omap@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--fUYQa+Pmc3FrFX/N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Mar 08, 2016 at 08:39:08PM +0200, Aaro Koskinen wrote:
> On Tue, Mar 08, 2016 at 05:39:32PM +0100, Sebastian Reichel wrote:
> > This series adds support for the Nokia N950 display.
> > Since the panel is using DSI command mode, it involves
> > adding support for manually updated displays to
> > omapdrm.
>=20
> Works OK, but the picture seems to be upside down?

vertical, upside down is the native panel orientation.

> Also shouldn't the default orientation be landscape?

The N950 vendor kernel contains some code adding DSI
rotation support with half-frame update mechnism to
avoid tearing. It's quite complex and as far as I
understand it also error-prone. Tomi knows more about
that.

I have a simpler patch without the half-frame update
stuff, which works fine for me. I didn't notice any
tearing, but I haven't done any really fast image
updating. Also omapdrm has rotation support using
the DSS hardware, which also seems to work ok. I'm
still checking out what method is most suitable for
mainline.

But yeah, we probably want to change the default
rotation. Especially since touchscreen should have
the same default rotation as the screen. (TS is
horizontal, correct orientation for keyboard usage)

I will have a look at the (default-)rotation when
basic panel support has been ACKed.

-- Sebastian

--fUYQa+Pmc3FrFX/N
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJW3znSAAoJENju1/PIO/qax6AQAJDt5L5aeBxvvy97Hubyat/Z
mM7dyMid895sV0CcptkP6GJTkKhrRKH6Al+FqGMAhw2ewtKBWerR5cwm7fG61eWD
+zUquAWeUH9OT+FIR8WXsUbnPfzprzETpI/9BQlxEBHXvG22KtkWaPSHB0+no7y8
zLLZowyb9cuaXR+ibzry8I1kr74n1SLA2WVTEK1fxnitmGJgr90iiQWJ3GrJjyTE
s4S10GsGm9QVYrOchqd2Cinx3vHg/uazWEBOHPPRWs6QeMEQdUF47OnTcau2DodS
mcw/iSEN5ryFzxMoVDIE71VkSFzQ7nf6a45OSZF4i+uOAoyCzx4svloza9imxBoS
WakCfEa8iucJdHYuV/G+x/LO3BDtzIlYKFxltoZwV6qrLeIAzUqhm9Q+U399jaNS
bhSgLxhHLp6MIJzhjLaUPT0OOqfdyOBjwwznWk88/ChtXjH4ePQIgTJpGfhFA3bq
81E+vQM93zG/aCNyMK9oqObV6cPS8cfHAOYMiPxQyAD78NOyYHlyUlXs78bM7WKy
Vl30sztqTiENqzzLTmiPNO33UUkjVSpUqHCM0T3MCdT0Tr6LBqudrh/Is27e8CTw
hsIISKfC8j0u8q5v+ACR6YPrCQTkhxAjGLrvQF1pWiUiQ3cmFIvQMg/XJYLzEQn7
RLUqipryI4yW6d8tVrKu
=G+Ho
-----END PGP SIGNATURE-----

--fUYQa+Pmc3FrFX/N--
