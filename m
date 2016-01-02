From: Tony Lindgren <tony@atomide.com>
Subject: Re: Nokia N900: twl4030-power different data in DTS and board code
Date: Sat, 2 Jan 2016 09:14:31 -0800
Message-ID: <20160102171430.GC12622@atomide.com>
References: <201601021513.32814@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <201601021513.32814@pali>
Sender: linux-kernel-owner@vger.kernel.org
To: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Cc: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Pavel Machel <pavel@ucw.cz>, Sebastian Reichel <sre@kernel.org>, Nishanth Menon <nm@ti.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Pali Roh=C3=A1r <pali.rohar@gmail.com> [160102 06:14]:
> Hello,
>=20
> now I'm looking at differences between legacy board code and DTS file
> for Nokia N900 and I see some inconsistency for twl4030-power driver.
>=20
> In board code are defined more twl4030 power scripts which override
> defaults defined in twl4030-power code. See:
>=20
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/=
arch/arm/mach-omap2/board-rx51-peripherals.c#n790
>=20
> Next in DTS file is defined just "compatible" keyword, but no custom
> scripts, see:
>=20
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/=
arch/arm/boot/dts/omap3-n900.dts#n416
>=20
> And the last in DTS file is defined line:
>=20
> compatible =3D "ti,twl4030-power-n900"=20
>=20
> which is not in twl4030-power driver itself, see:
>=20
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/=
drivers/mfd/twl4030-power.c#n851
>=20
> So all this stuff looks like some errors when board code was ported t=
o
> DTS. Tony, can you look at this at all?

AFAIK it should work fine with the generic "ti,twl4030-power-idle-osc-o=
ff".
This means reboot works and regulators are cut off during off mode.

The n900 specific code was based on something before the TI generic val=
ues
were available I think. And the last time I looked at it I came to the
conclusion the n900 specific code is no better.

Or did I miss something? Are you seeing some issues with PM with dts ba=
sed
code?

We can certainly add it to twl4030-power if it provides something that
the "ti,twl4030-power-idle-osc-off" does not.

Regards,

Tony
