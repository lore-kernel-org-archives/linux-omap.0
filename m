From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 3/3] arm: boot: dts: am437x-sk: fix lcd enable pin mux
 data
Date: Thu, 4 Dec 2014 08:43:25 -0600
Message-ID: <20141204144325.GA17269@saruman>
References: <1413311335-25083-1-git-send-email-balbi@ti.com>
 <1413311335-25083-3-git-send-email-balbi@ti.com>
 <543E6774.8000406@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BXVAT5kNtrzKuDFl"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:41758 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753975AbaLDOnv (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 4 Dec 2014 09:43:51 -0500
Content-Disposition: inline
In-Reply-To: <543E6774.8000406@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Felipe Balbi <balbi@ti.com>, Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Benoit Cousson <bcousson@baylibre.com>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, linux-fbdev@vger.kernel.org, Darren Etheridge <detheridge@ti.com>

--BXVAT5kNtrzKuDFl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

HI,

On Wed, Oct 15, 2014 at 03:24:20PM +0300, Tomi Valkeinen wrote:
> On 14/10/14 21:28, Felipe Balbi wrote:
> > Caused by a copy & paste error. Note that even with
> > this bug AM437x SK display still works because GPIO
> > mux mode is always enabled. It's still wrong to mux
> > somebody else's pin.
> >=20
> > Luckily ball D25 (offset 0x238 - gpio5_8) on AM437x
> > isn't used for anything.
> >=20
> > Signed-off-by: Felipe Balbi <balbi@ti.com>
> > ---
> >  arch/arm/boot/dts/am437x-sk-evm.dts | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >=20
> > diff --git a/arch/arm/boot/dts/am437x-sk-evm.dts b/arch/arm/boot/dts/am=
437x-sk-evm.dts
> > index 859ff3d..681be00 100644
> > --- a/arch/arm/boot/dts/am437x-sk-evm.dts
> > +++ b/arch/arm/boot/dts/am437x-sk-evm.dts
> > @@ -320,8 +320,7 @@
> > =20
> >  	lcd_pins: lcd_pins {
> >  		pinctrl-single,pins =3D <
> > -			/* GPIO 5_8 to select LCD / HDMI */
> > -			0x238 (PIN_OUTPUT_PULLUP | MUX_MODE7)
> > +			0x1c (PIN_OUTPUT_PULLUP | MUX_MODE7) /* gpcm_ad7.gpio1_7 */
> >  		>;
> >  	};
> >  };
>=20
> I didn't verify the offset, but based on the comments this looks fine to =
me.
>=20
> Acked-by: Tomi Valkeinen <tomi.valkeinen@ti.com>

Tony, are you taking this patch ? Looks like it has been forgotten and
now it needs to be backported to v3.17 and v3.18 (assuming it's too late
for v3.18).

--=20
balbi

--BXVAT5kNtrzKuDFl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUgHMNAAoJEIaOsuA1yqRES1EP/jtI8Mf1qOWlPPiTUX0kRPDJ
YuKe+9wEAr2WtMoq5fRzQAzXiv4GFEews1Ki+F62dgd7nsa4snyGka4JrGYSq1Wd
cZzkeEE/5Yi6PWZs9zhGAtDMlvIywITaBYQej2xP7L+UVjDLXqwVGJf4Op6NWyao
8OCChRFAIc93c1eYgrfAijH1dOwlUqGNrEgYYBp68PBTj1Dnpa27IWhNxmkV4kb2
h/4f7oPqV/yVzU8jTjeiuUB7uPorazuqchwllI9dAbELPS1+AX0qU0ZELV7aGdf2
is9ECtYUNtHaN0eCUKgrMJqa7+f/PwaH2Q9ostnY7yDyXIV/mnpd80pf7fKIdK5I
YjU1KFqZtQ/HztSnK0Y3z4e7GEDRQhNT/2YgUWqfzZk0v5EDzuxzq/7mLbyQaiUF
Fi7ViPj2mnWSqbThKrc5GJab5pjEJ3alwaZxQfvGBHcXtOgNwJhWDmlamCNRCpsK
I+0LNW45odpbO5KFRqYYMHE3AQF8s2Gw4ye0yR9hvhZCaNbFhlPxiFHOVoV5Y7ee
sYrPlChz77azjGw43it8WsirE0ijv+6kui1ZXalLmC6hUEiOL0PSJeqhgBaXERx3
bzRwhffp2WzDx4yCYwgmfDE+MfthNGCDhgD+5zEx8Ug8kg2TryHFVsP1PP3/bF94
5HVPlzVfuUhxKsPetbyc
=sd95
-----END PGP SIGNATURE-----

--BXVAT5kNtrzKuDFl--
