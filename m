From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: dts: Revert disabling of smc91x for n900
Date: Wed, 18 Feb 2015 08:33:53 -0800
Message-ID: <20150218163352.GB32521@atomide.com>
References: <20150105230228.GO4081@atomide.com>
 <201502181619.46278@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <201502181619.46278@pali>
Sender: linux-kernel-owner@vger.kernel.org
To: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Cc: linux-omap@vger.kernel.org, Kevin Hilman <khilman@kernel.org>, Aaro Koskinen <aaro.koskinen@iki.fi>, Sebastian Reichel <sre@kernel.org>, Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Nishanth Menon <nm@ti.com>
List-Id: linux-omap@vger.kernel.org

* Pali Roh=C3=A1r <pali.rohar@gmail.com> [150218 07:23]:
> On Tuesday 06 January 2015 00:02:29 Tony Lindgren wrote:
> > Revert "ARM: dts: Disable smc91x on n900 until bootloader
> > dependency is removed". We've now fixed the issues that
> > caused problems with uninitialized hardware depending on
> > the bootloader version. Mostly things got fixed with
> > the following commits:
> >=20
> > 9a894953a97b ("ARM: dts: Fix bootloader version dependencies
> > by muxing n900 smc91x pins") 7d2911c43815 ("net: smc91x: Fix
> > gpios for device tree based booting")
> >=20
> > Note that this only affects the early development boards
> > with Ethernet that we still have in a few automated boot
> > test systems.
> >=20
> > Signed-off-by: Tony Lindgren <tony@atomide.com>
> >=20
> > --- a/arch/arm/boot/dts/omap3-n900.dts
> > +++ b/arch/arm/boot/dts/omap3-n900.dts
> > @@ -702,9 +702,6 @@
> >=20
> >  	ethernet@gpmc {
> >  		compatible =3D "smsc,lan91c94";
> > -
> > -		status =3D "disabled";
> > -
> >  		interrupt-parent =3D <&gpio2>;
> >  		interrupts =3D <22 IRQ_TYPE_LEVEL_HIGH>;	/* gpio54 */
> >  		reg =3D <1 0x300 0xf>;		/* 16 byte IO range at offset 0x300
> > */
>=20
> Hello Tony,
>=20
> to make smc ethernet working in n900 qemu I needed to apply this patc=
h:
>=20
> diff --git a/arch/arm/boot/dts/omap3-n900.dts b/arch/arm/boot/dts/oma=
p3-n900.dts
> index ff36fbe..d96eeb8 100644
> --- a/arch/arm/boot/dts/omap3-n900.dts
> +++ b/arch/arm/boot/dts/omap3-n900.dts
> @@ -770,7 +770,8 @@
>  		compatible =3D "smsc,lan91c94";
>  		interrupt-parent =3D <&gpio2>;
>  		interrupts =3D <22 IRQ_TYPE_LEVEL_HIGH>;	/* gpio54 */
> -		reg =3D <1 0x300 0xf>;		/* 16 byte IO range at offset 0x300 */
> +//		reg =3D <1 0x300 0xf>;		/* 16 byte IO range at offset 0x300 */
> +		reg =3D <1 0x0 0xf>;		/* 16 byte IO range at offset 0x300 */
>  		bank-width =3D <2>;
>  		pinctrl-names =3D "default";
>  		pinctrl-0 =3D <&ethernet_pins>;

Oh cool, the 0x300 offset is there mostly to suppress warnings about
non-standard location.
=20
> With this patch I see in dmesg:
>=20
> [   20.577911] smc91x 2000000.ethernet (unnamed net_device) (uninitia=
lized): smc91x: smc_probe
> [   20.580535] smc91x 2000000.ethernet (unnamed net_device) (uninitia=
lized): smc91x: bank signature probe=20
> returned 0x3300
> [   20.585327] smc91x 2000000.ethernet (unnamed net_device) (uninitia=
lized): smc91x: revision =3D 0x3391
> [   20.590087] smc91x.c: v1.1, sep 22 2004 by Nicolas Pitre <nico@flu=
xnic.net>
> [   20.593627] smc91x 2000000.ethernet (unnamed net_device) (uninitia=
lized): smc_reset
> [   20.596832] smc91x 2000000.ethernet (unnamed net_device) (uninitia=
lized): smc_phy_detect
> [   20.611938] smc91x 2000000.ethernet (unnamed net_device) (uninitia=
lized): smc91x: smc_shutdown
> [   20.615875] smc91x 2000000.ethernet eth0: SMC91C11xFD (rev 1) at d=
08be000 IRQ 166
> [   20.618682]=20
> [   20.621124] smc91x 2000000.ethernet eth0: Ethernet addr: 52:54:00:=
12:34:56
> [   20.624938] smc91x 2000000.ethernet eth0: No PHY found
>=20
> (and eth0 exists in ifconfig)
>=20
> If I do not apply my patch I got this error message:
>=20
> [   22.134704] smc91x 2000300.ethernet (unnamed net_device) (uninitia=
lized): smc91x: bank signature probe=20
> returned 0x0000
> [   22.140014] smc91x: not found (-19).
>=20
> and no ethernet device was registered.
>=20
> With 2.6.28 kernel with N900 patches (but smc91x is unmodified!) ethe=
rnet device is working fine.

OK that's good news. Care to do a patch to set the offset 0x0 with adde=
d
comment that qemu needs it? I'll test to make sure it works on the
real hardware as well.

Regards,

Tony
