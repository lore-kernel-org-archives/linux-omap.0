From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 3/3] arm: boot: dts: am437x-sk: fix lcd enable pin mux
 data
Date: Thu, 4 Dec 2014 09:05:38 -0600
Message-ID: <20141204150538.GE18045@saruman>
References: <1413311335-25083-1-git-send-email-balbi@ti.com>
 <1413311335-25083-3-git-send-email-balbi@ti.com>
 <543E6774.8000406@ti.com>
 <20141204144325.GA17269@saruman>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ffoCPvUAPMgSXi6H"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:42820 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754414AbaLDPF7 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 4 Dec 2014 10:05:59 -0500
Content-Disposition: inline
In-Reply-To: <20141204144325.GA17269@saruman>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Benoit Cousson <bcousson@baylibre.com>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, linux-fbdev@vger.kernel.org, Darren Etheridge <detheridge@ti.com>

--ffoCPvUAPMgSXi6H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 04, 2014 at 08:43:25AM -0600, Felipe Balbi wrote:
> HI,
>=20
> On Wed, Oct 15, 2014 at 03:24:20PM +0300, Tomi Valkeinen wrote:
> > On 14/10/14 21:28, Felipe Balbi wrote:
> > > Caused by a copy & paste error. Note that even with
> > > this bug AM437x SK display still works because GPIO
> > > mux mode is always enabled. It's still wrong to mux
> > > somebody else's pin.
> > >=20
> > > Luckily ball D25 (offset 0x238 - gpio5_8) on AM437x
> > > isn't used for anything.
> > >=20
> > > Signed-off-by: Felipe Balbi <balbi@ti.com>
> > > ---
> > >  arch/arm/boot/dts/am437x-sk-evm.dts | 3 +--
> > >  1 file changed, 1 insertion(+), 2 deletions(-)
> > >=20
> > > diff --git a/arch/arm/boot/dts/am437x-sk-evm.dts b/arch/arm/boot/dts/=
am437x-sk-evm.dts
> > > index 859ff3d..681be00 100644
> > > --- a/arch/arm/boot/dts/am437x-sk-evm.dts
> > > +++ b/arch/arm/boot/dts/am437x-sk-evm.dts
> > > @@ -320,8 +320,7 @@
> > > =20
> > >  	lcd_pins: lcd_pins {
> > >  		pinctrl-single,pins =3D <
> > > -			/* GPIO 5_8 to select LCD / HDMI */
> > > -			0x238 (PIN_OUTPUT_PULLUP | MUX_MODE7)
> > > +			0x1c (PIN_OUTPUT_PULLUP | MUX_MODE7) /* gpcm_ad7.gpio1_7 */
> > >  		>;
> > >  	};
> > >  };
> >=20
> > I didn't verify the offset, but based on the comments this looks fine t=
o me.
> >=20
> > Acked-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
>=20
> Tony, are you taking this patch ? Looks like it has been forgotten and
> now it needs to be backported to v3.17 and v3.18 (assuming it's too late
> for v3.18).

I'll send a new version and Cc stable.

--=20
balbi

--ffoCPvUAPMgSXi6H
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUgHhCAAoJEIaOsuA1yqREoAIP/2gojRE9cAW1gCGlsRfyvwJG
aKSB8OhUFrYFA6Bxf57/P0vLeOTCmZh2usa68Yfgc9MqOU6WYkIbP3OXJm++JyX/
t5QlhXA7JqigYAoahGZnBeOZ+fAWFJJkWr3st7WSz2u3a+icmkO5vLdhOZzV63hi
AIG11SJfXvb0t/Fl5Kg9S23MWf3uqsxmQuzrc3k7jIJntW7aMu/zQFXqlchu0W8n
DY/07iF/OiS/NTBJQ9AZ/LdfuB83cwq6sbFYzbAW2gXnilzwuBqLa1DvGPgJkWjB
Ab7Hp+HyMspjS+iXlkVnFQPX4kVemzbJcA8SpoQjHtVgUKXKswY17G/+hY2XiG9L
K71IndkLkEQ9k6bIpHu0hYpU5erDpBftBhAuYJt+nyrbmzUX/A3hn2mNw3aRuhDt
NQp8PivHkRszO24j/qkGymwKkTR/elJdck0jTjudJT0Z1AZYO9pOdrUWzn0t7Kpt
25EUwiXsdRYyyZdg3D4OG7kxLLWSi4QVEHxPBKEIFO7LU7EL+HEjuL5AowO/dM5X
gw73Scl1GHGoPMEvq9yD5MSy17imOz/vuS/IqVVfQUutxQoskEHd2pM/yVR4Xsux
CgatJzlMFOcM5GMYJKi0l7f1x9dnaJf0fkvLENQn6zhLXgADFwtLi3bWRNV7r78K
z59SqGOlqacNOGZXfFyy
=EU5g
-----END PGP SIGNATURE-----

--ffoCPvUAPMgSXi6H--
