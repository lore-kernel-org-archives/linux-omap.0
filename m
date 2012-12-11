From: Felipe Balbi <balbi@ti.com>
Subject: Re: AM335x BeagleBone SPI Issues
Date: Tue, 11 Dec 2012 19:03:14 +0200
Message-ID: <20121211170314.GG2864@arwen.pp.htv.fi>
References: <50C5E23D.5040605@communistcode.co.uk>
 <20121210135337.GA10219@arwen.pp.htv.fi>
 <50C5F6A8.5060701@communistcode.co.uk>
 <20121210145947.GK11038@arwen.pp.htv.fi>
 <50C5FD73.1000408@communistcode.co.uk>
 <20121210183500.GB14303@arwen.pp.htv.fi>
 <50C70846.7010207@communistcode.co.uk>
 <87y5h4r4ul.fsf@gmail.com>
 <50C75E54.2080805@communistcode.co.uk>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="V32M1hWVjliPHW+c"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:47840 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754115Ab2LKRKY (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 11 Dec 2012 12:10:24 -0500
Content-Disposition: inline
In-Reply-To: <50C75E54.2080805@communistcode.co.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jack Mitchell <ml@communistcode.co.uk>
Cc: Ben Gamari <bgamari.foss@gmail.com>, balbi@ti.com, linux-omap@vger.kernel.org, Shubhrajyoti Datta <omaplinuxkernel@gmail.com>

--V32M1hWVjliPHW+c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Dec 11, 2012 at 04:24:52PM +0000, Jack Mitchell wrote:
> On 11/12/12 15:22, Ben Gamari wrote:
> >Jack Mitchell <ml@communistcode.co.uk> writes:
> >
> >>Shubhro, Felipe,
> >>
> >>Thank you, the reordering dma patch fixed the dma issue I was having!
> >>However, the bad news, I now get the same results for the dma and
> >>non-dma spidev test. While the scope shows the SPI clk and data is fine,
> >>the reading from the program still shows 0x00 for all words.
> >>
> >Just to make sure this has been thought of: I've seen this sort of
> >behavior in the past when the CLK pin wasn't configured as an input.
> >
> >Cheers,
> >
> >- Ben
> >
>=20
> Ok, Ben, well spotted indeed! I changed the dtsi to use INPUT_PULLUP
> instead of OUTPUT_PULLUP and wallah!
>=20
>   am3358_pinmux: pinmux@44e10800 {
>     spi0_pins: pinmux_spi0_pins {
>       pinctrl-single,pins =3D <
>         0x150 *0x30*      /* spi0_sclk.gpio0_2, INPUT_PULLUP | MODE0
> */<------------ changed to INPUT
>         0x154 0x30      /* spi0_d0.gpio0_3, INPUT_PULLUP | MODE0 */
>         0x158 0x10      /* spi0_d1.i2c1_sda, OUTPUT_PULLUP | MODE0 */
>         0x15c 0x10      /* spi0_cs0.i2c1_scl, OUTPUT_PULLUP | MODE0 */
>       >;
>     };
>     spi1_pins: pinmux_spi1_pins {
>       pinctrl-single,pins =3D <
>         0x190 *0x33*  /* mcasp0_aclkx.spi1_sclk, INPUT_PULLUP | MODE3
> */ <------------ changed to INPUT
>         0x194 0x33  /* mcasp0_fsx.spi1_d0, INPUT_PULLUP | MODE3 */
>         0x198 0x13  /* mcasp0_axr0.spi1_d1, OUTPUT_PULLUP | MODE3 */
>         0x19c 0x13  /* mcasp0_ahclkr.spi1_cs0, OUTPUT_PULLUP | MODE3 */
>       >;
>     };

funny, I did the same on my pandaboard and it still didn't work :-s

@@ -321,6 +322,10 @@ static struct omap_board_mux board_mux[] __initdata =
=3D {
        OMAP4_MUX(SDMMC5_DAT1, OMAP_MUX_MODE0 | OMAP_PIN_INPUT_PULLUP),
        OMAP4_MUX(SDMMC5_DAT2, OMAP_MUX_MODE0 | OMAP_PIN_INPUT_PULLUP),
        OMAP4_MUX(SDMMC5_DAT3, OMAP_MUX_MODE0 | OMAP_PIN_INPUT_PULLUP),
+
+       /* SPI1 */
+       OMAP4_MUX(MCSPI1_CLK, OMAP_MUX_MODE0 | OMAP_PIN_INPUT_PULLUP),
+
        /* gpio 0 - TFP410 PD */
        OMAP4_MUX(KPD_COL1, OMAP_PIN_OUTPUT | OMAP_MUX_MODE3),
        /* dispc2_data23 */

--=20
balbi

--V32M1hWVjliPHW+c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQx2dSAAoJEIaOsuA1yqREVQwP/04ZAoCTDdi2g/A7fok019MR
zo1mSTtlBHTHkf1HZEHG9tlXwoFItu+3kNfteWk5DUbTQdXbCd3vP+nVIdYKgQot
htYCJP8u1ILNWL+evhThQ1rKw2zyHBe8wSEwdLdnhA5Twm5vTFFKqi8zqCAPXMYc
6rt3cdO5tiTQ35WL2uDrCIMvaGwSfYk2lqTfNP3Z19QclPdao0mZVe3hMqy/KcP/
Ek5EkBHjC/tqXH5FMX53/lmLca53sQFT/qUW951TvYjtwiVXrwChAkKIt9DfCg9R
qmlSz43CtqGd2D+XY2gSeg1R2Ri+vCT0xO32oKz3U56moibbSF4teYw4orAtrbMs
8xDOYufYm0Q6ZZMZBjOrF8pnntYwETq3tyY7It4j145ihoqNkx5QtUU/nrQJ6B8e
d7d4O7W2RiW0qm5l+iEUbCaEWTyuBbfucKFZ7YCOcg9oH88/wGKq2sw9psKWPiNE
on9YC37sboXnrW7m6CdIEJMOnW7pTdJRzR9yxeOgvGgzBPmR/lLFlK9RklE9pxbm
EkdR9MSWBdASVb1gAg7EqSGb2/O5lUGG51G9HSfzA7YTDlGK0zZWyoeiSl3fVoBZ
p3D0vHCeoW/TnESZI06G2uWOeRci4zppzJG2BOOxYxonfTEQ9kxIEKUt2/nHxnda
IOLuGFVXiED66/VwmKTA
=Jrds
-----END PGP SIGNATURE-----

--V32M1hWVjliPHW+c--
