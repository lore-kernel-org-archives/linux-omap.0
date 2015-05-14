From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] Show proper respect for Heinrich Hertz by using the
 correct unit for frequency
Date: Thu, 14 May 2015 16:20:32 +0100
Message-ID: <20150514152032.GA29132@n2100.arm.linux.org.uk>
References: <20150511131952.GD2067@n2100.arm.linux.org.uk>
 <5551217C.9090504@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5551217C.9090504@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Mon, May 11, 2015 at 11:39:08PM +0200, Andreas F=E4rber wrote:
> Am 11.05.2015 um 15:19 schrieb Russell King - ARM Linux:
> > The SI unit of frequency is Hertz, named after Heinrich Hertz, and =
is
> > given the symbol "Hz" to denote this.  "hz" is not the unit of freq=
uency,
> > and is in fact meaningless.
> >=20
> > Fix arch/arm to correctly use "Hz", thereby acknowledging Heinrich =
Hertz
> > contribution to the modern world.
> >=20
> > Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
>=20
> Nice. :) Since you're being exact, should it be "Hertz' contribution"=
?
>=20
> > diff --git a/arch/arm/boot/dts/omap3-cm-t3517.dts b/arch/arm/boot/d=
ts/omap3-cm-t3517.dts
> > index f5b5a1d96cd7..53ae04f9104d 100644
> > --- a/arch/arm/boot/dts/omap3-cm-t3517.dts
> > +++ b/arch/arm/boot/dts/omap3-cm-t3517.dts
> > @@ -66,7 +66,7 @@
> > =20
> >  	otg_drv_vbus: pinmux_otg_drv_vbus {
> >  		pinctrl-single,pins =3D <
> > -			OMAP3_CORE1_IOPAD(0x2210, PIN_INPUT_PULLDOWN | MUX_MODE0) /* rm=
ii_50Mhz_clk.usb0_drvvbus */
> > +			OMAP3_CORE1_IOPAD(0x2210, PIN_INPUT_PULLDOWN | MUX_MODE0) /* rm=
ii_50MHz_clk.usb0_drvvbus */
>=20
> This one looks like an identifier - did you check where it comes from
> and whether it needs to be fixed there as well?

There isn't any other reference to it in arch/arm (if there were, the
grep to find these would itself have found it.)

--=20
=46TTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps u=
p
according to speedtest.net.
