From: Felipe Balbi <balbi@ti.com>
Subject: Re: AM335x BeagleBone SPI Issues
Date: Tue, 11 Dec 2012 19:52:16 +0200
Message-ID: <20121211175216.GA27012@arwen.pp.htv.fi>
References: <50C5E23D.5040605@communistcode.co.uk>
 <20121210135337.GA10219@arwen.pp.htv.fi>
 <50C5F6A8.5060701@communistcode.co.uk>
 <20121210145947.GK11038@arwen.pp.htv.fi>
 <50C5FD73.1000408@communistcode.co.uk>
 <20121210183500.GB14303@arwen.pp.htv.fi>
 <50C70846.7010207@communistcode.co.uk>
 <87y5h4r4ul.fsf@gmail.com>
 <50C75E54.2080805@communistcode.co.uk>
 <20121211170314.GG2864@arwen.pp.htv.fi>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WIyZ46R2i8wDzkSu"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:50158 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753587Ab2LKSBj (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 11 Dec 2012 13:01:39 -0500
Content-Disposition: inline
In-Reply-To: <20121211170314.GG2864@arwen.pp.htv.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Jack Mitchell <ml@communistcode.co.uk>, Ben Gamari <bgamari.foss@gmail.com>, linux-omap@vger.kernel.org, Shubhrajyoti Datta <omaplinuxkernel@gmail.com>

--WIyZ46R2i8wDzkSu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Dec 11, 2012 at 07:03:14PM +0200, Felipe Balbi wrote:
> Hi,
>=20
> On Tue, Dec 11, 2012 at 04:24:52PM +0000, Jack Mitchell wrote:
> > On 11/12/12 15:22, Ben Gamari wrote:
> > >Jack Mitchell <ml@communistcode.co.uk> writes:
> > >
> > >>Shubhro, Felipe,
> > >>
> > >>Thank you, the reordering dma patch fixed the dma issue I was having!
> > >>However, the bad news, I now get the same results for the dma and
> > >>non-dma spidev test. While the scope shows the SPI clk and data is fi=
ne,
> > >>the reading from the program still shows 0x00 for all words.
> > >>
> > >Just to make sure this has been thought of: I've seen this sort of
> > >behavior in the past when the CLK pin wasn't configured as an input.
> > >
> > >Cheers,
> > >
> > >- Ben
> > >
> >=20
> > Ok, Ben, well spotted indeed! I changed the dtsi to use INPUT_PULLUP
> > instead of OUTPUT_PULLUP and wallah!
> >=20
> >   am3358_pinmux: pinmux@44e10800 {
> >     spi0_pins: pinmux_spi0_pins {
> >       pinctrl-single,pins =3D <
> >         0x150 *0x30*      /* spi0_sclk.gpio0_2, INPUT_PULLUP | MODE0
> > */<------------ changed to INPUT
> >         0x154 0x30      /* spi0_d0.gpio0_3, INPUT_PULLUP | MODE0 */
> >         0x158 0x10      /* spi0_d1.i2c1_sda, OUTPUT_PULLUP | MODE0 */
> >         0x15c 0x10      /* spi0_cs0.i2c1_scl, OUTPUT_PULLUP | MODE0 */
> >       >;
> >     };
> >     spi1_pins: pinmux_spi1_pins {
> >       pinctrl-single,pins =3D <
> >         0x190 *0x33*  /* mcasp0_aclkx.spi1_sclk, INPUT_PULLUP | MODE3
> > */ <------------ changed to INPUT
> >         0x194 0x33  /* mcasp0_fsx.spi1_d0, INPUT_PULLUP | MODE3 */
> >         0x198 0x13  /* mcasp0_axr0.spi1_d1, OUTPUT_PULLUP | MODE3 */
> >         0x19c 0x13  /* mcasp0_ahclkr.spi1_cs0, OUTPUT_PULLUP | MODE3 */
> >       >;
> >     };
>=20
> funny, I did the same on my pandaboard and it still didn't work :-s
>=20
> @@ -321,6 +322,10 @@ static struct omap_board_mux board_mux[] __initdata =
=3D {
>         OMAP4_MUX(SDMMC5_DAT1, OMAP_MUX_MODE0 | OMAP_PIN_INPUT_PULLUP),
>         OMAP4_MUX(SDMMC5_DAT2, OMAP_MUX_MODE0 | OMAP_PIN_INPUT_PULLUP),
>         OMAP4_MUX(SDMMC5_DAT3, OMAP_MUX_MODE0 | OMAP_PIN_INPUT_PULLUP),
> +
> +       /* SPI1 */
> +       OMAP4_MUX(MCSPI1_CLK, OMAP_MUX_MODE0 | OMAP_PIN_INPUT_PULLUP),

hehe, I'll reply to my own nonsense. Of course this won't work, I'm not
muxing the other MCSPI pins :-p

I'll do that tomorrow and test, cheers

--=20
balbi

--WIyZ46R2i8wDzkSu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQx3LQAAoJEIaOsuA1yqREyoEP/jPxZnrI6HqpiP+z2FXkz/c4
YoasHDoalnZNcqlwYW7CI0r+copQzCvfiHapVj9FfNH6li+l00+a4GrkbkYx0Lsv
42mFr66znvhp9wcbAde8ZwZ+IubVpUTJJqME6TRoOesPB/4CRUovahUZ/LMkKWFa
CQsnTpJ3NhFEiDhCvaFVqN6khDTAcLaekLsQxzaT2NGTkUnECwwJjSYuuzeT1ybJ
e/5RxcG9e5UbUgsxrmo1ZLWQLaQrcMKyYd3OPSd8AN/fYl/Vha/6GwRqFaqZahRD
wB3xSuCGaEZzgk/NLLc3Lyf5FS1AFfICO89aR6OkDm6I+0cDQWz6CrEynMYmJfuS
0YysFrawoaN5nSF/NE30E3T5Se4UrQOfOy70RciosbzvdoUqk05CqRLJQJ407uNi
KF/dlq9X2TJcfOhHZfhgEC2Ze6c9GFbv7nyJjbFrrz2u9Gjeh2fiaA66I9ITcZvg
/e1+NP2HVfh1QJ0TEePa23zPWXcOXQedl7ijlUCljKYes8d3h2JgX9lfRN9wD5nL
BY09IvlSy46oVCnmxXHkwENG3Gc0IfcXThv40gBYVrhQLJQnl6ZtGoF5vTbMHTbm
bfs0SwBQQ2KemmxHgFtJ3kwGJJnKk6FuTmcUhTH0QbnSqHJFHUGZKJbMQMltcp7J
YEWsbA59XCjIEqkNHyxo
=qOiv
-----END PGP SIGNATURE-----

--WIyZ46R2i8wDzkSu--
