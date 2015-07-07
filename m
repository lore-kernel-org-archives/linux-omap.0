From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Subject: Re: rx51-battery.ko incompatiblity: board code vs DT
Date: Tue, 7 Jul 2015 17:15:47 +0200
Message-ID: <20150707151547.GN12087@pali>
References: <201507062144.22911@pali>
 <20150707150230.GB25405@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150707150230.GB25405@earth>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Pavel Machek <pavel@ucw.cz>, Aaro Koskinen <aaro.koskinen@iki.fi>, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Tuesday 07 July 2015 17:02:30 Sebastian Reichel wrote:
> Hi,
>=20
> On Mon, Jul 06, 2015 at 09:44:22PM +0200, Pali Roh=C3=A1r wrote:
> > now I found out that rx51-battery.ko driver register sysnode=20
> > /sys/class/power_supply/rx51-battery/ when booting with legacy boar=
d=20
> > code. But when booting DT kernel it register sysnode with different=
 name=20
> > /sys/class/power_supply/n900-battery/
> >=20
> > Sysfs node for DT kernel comes from Nokia N900 DTS file:=20
> > arch/arm/boot/dts/omap3-n900.dts
> >=20
> > I would propose change which change DTS to "rx51-battery" to have i=
t=20
> > compatible with naming which is for legacy board code. It is just=20
> > because to have compatibility and same naming scheme and also to ma=
ke=20
> > existing programs to work without needing patching them.
> >=20
> > What do you think?
>=20
> Change the driver instead (in rx51_battery_probe):
>=20
> -   di->bat.name =3D dev_name(&pdev->dev);
> +   di->bat.name =3D "rx51-battery"
>=20
> This will keep the DT ABI stable and avoid introducing the term rx51
> in the device tree file.
>=20
> -- Sebastian

Perfect, if it works fine can you send & apply patch?

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com
