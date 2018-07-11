From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Vibrations on Droid 4?
Date: Wed, 11 Jul 2018 10:25:50 +0200
Message-ID: <20180711082550.GB21225@amd>
References: <20180709081534.GA6799@amd>
 <20180709214910.tes6u4ivxomd3aja@earth.universe>
 <20180709220211.GA7760@amd>
 <20180710101147.lyu65ro4czvrs2da@earth.universe>
 <20180710133040.GA4391@amd>
 <20180710161123.azym6sbboriuj4yc@earth.universe>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="yNb1oOkm5a9FJOVX"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180710161123.azym6sbboriuj4yc@earth.universe>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, nekit1000@gmail.com, mpartap@gmx.net, merlijn@wizzup.org
List-Id: linux-omap@vger.kernel.org


--yNb1oOkm5a9FJOVX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue 2018-07-10 18:11:23, Sebastian Reichel wrote:
> Hi,
>=20
> On Tue, Jul 10, 2018 at 03:30:40PM +0200, Pavel Machek wrote:
> > On Tue 2018-07-10 12:11:47, Sebastian Reichel wrote:
> > > On Tue, Jul 10, 2018 at 12:02:11AM +0200, Pavel Machek wrote:
> > > > > > Do you have vibrations on d4 working?
> > > > > > I believe I have required drivers enabled, but no luck:
> > > > > >=20
> > > > > > user@devuan:/sys/bus/platform/drivers$ ls pwm-vibrator/
> > > > > > bind  uevent  unbind
> > > > > > user@devuan:/sys/bus/platform/drivers$ ls omap-dmtimer-pwm/
> > > > > > bind  uevent  unbind
> > > > >=20
> > > > > Have you checked probe deferrals?
> > > >=20
> > > > Not really. Is there easier way to do that than adding printks in t=
he
> > > > probe function? (I can go through dmesg tommorow).
> > >=20
> > > Option 1: https://lkml.org/lkml/2018/7/8/63
> >=20
> > I tried this methodq, and no luck.
> >=20
> > static int pwm_omap_dmtimer_probe(struct platform_device *pdev)
> >=20
> > does not seem to be called.
> >=20
> > Its parent is gpio@4805d000 , and that one seems to be present.
> >=20
> > user@devuan:/sys/bus/platform/devices$ ls 4805d000.gpio
> > driver				       driver_override  gpio
> > gpiochip5  modalias  of_node  power  subsystem  uevent
>=20
> Sorry, something went wrong with merging this. The parent
> of ti,omap-dmtimer-pwm and pwm-vibrator should be / and
> not gpio6.

There's still something wrong with pinctrl... I guess.
									Pavel

[    0.973907] phy-mapphone-mdm6600 usb-phy@1: could not find pctldev for n=
ode /ocp/l4@4a000000/sc
m@100000/pinmux@40/pinmux_usb_mdm6600_pins, deferring probe
[    0.990295] pinctrl-single 4a100040.pinmux: 203 pins, size 406
[    0.996643] pinctrl-single 4a31e040.pinmux: 28 pins, size 56
[    1.003234] pinctrl-single 4a31e040.pinmux: mux offset out of range: 0x1=
8e (0x38)
[    1.010986] pinctrl-single 4a31e040.pinmux: could not add functions for =
pinmux_vibrator_directi
on_pin 398x
[    1.020996] dmtimer_probe
[    1.023712] dmtimer_probe: have timer
[    1.027526] omap-dmtimer-pwm dmtimer-pwm-8: dmtimer pdata structure NULL
[    1.034484] pinctrl-single 4a31e040.pinmux: mux offset out of range: 0x1=
90 (0x38)
[    1.042175] pinctrl-single 4a31e040.pinmux: could not add functions for =
pinmux_vibrator_enable_pin 400x
[    1.051910] dmtimer_probe
[    1.054626] dmtimer_probe: have timer
[    1.058441] omap-dmtimer-pwm dmtimer-pwm-9: dmtimer pdata structure NULL
[    1.068725] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[   70.264739] cpcap-usb-phy cpcap-usb-phy.0: connected to USB host
[   80.093811] omap-dmtimer-pwm dmtimer-pwm-9: requested duty cycle: 375005=
7 ns, period: 10000000 ns
[   80.102996] omap-dmtimer-pwm dmtimer-pwm-9: clk rate: 26000000Hz
[   80.109252] omap-dmtimer-pwm dmtimer-pwm-9: effective duty cycle: 375003=
8 ns, period: 10000000 ns
[   80.118530] omap-dmtimer-pwm dmtimer-pwm-9: load value: 0xfffc0860 (-260=
000), match value: 0xfffd853c (-162500)
[   80.129089] omap-dmtimer-pwm dmtimer-pwm-8: requested duty cycle: 100000=
00 ns, period: 10000000 ns
[   80.138336] omap-dmtimer-pwm dmtimer-pwm-8: clk rate: 26000000Hz
[   80.144561] omap-dmtimer-pwm dmtimer-pwm-8: duty cycle 10000000 ns is to=
o long for period 10000000 ns at clock rate 26000000 Hz
[   80.156433] omap-dmtimer-pwm dmtimer-pwm-8: using maximum of 1 clock cyc=
le less than period
[   80.165069] omap-dmtimer-pwm dmtimer-pwm-8: effective duty cycle: 999996=
2 ns, period: 10000000 ns
[   80.174621] omap-dmtimer-pwm dmtimer-pwm-8: load value: 0xfffc0860 (-260=
000), match value: 0xfffffffe (-2)
[  100.344970] cpcap-usb-phy cpcap-usb-phy.0: connected to USB host





--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--yNb1oOkm5a9FJOVX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAltFvw4ACgkQMOfwapXb+vKkuQCdGZDNt8z6ejt8g0NhKRDXkWEo
+S4AnjDvniH99LlLkWRZUI/XeTGQTrnZ
=p1p7
-----END PGP SIGNATURE-----

--yNb1oOkm5a9FJOVX--
