From: Pavel Machek <pavel@ucw.cz>
Subject: Re: rx51-battery.ko incompatiblity: board code vs DT
Date: Tue, 7 Jul 2015 12:41:50 +0200
Message-ID: <20150707104150.GC13811@amd>
References: <201507062144.22911@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <201507062144.22911@pali>
Sender: linux-kernel-owner@vger.kernel.org
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: Sebastian Reichel <sre@kernel.org>, Tony Lindgren <tony@atomide.com>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Mon 2015-07-06 21:44:22, Pali Roh=E1r wrote:
> Hello,
>=20
> now I found out that rx51-battery.ko driver register sysnode=20
> /sys/class/power_supply/rx51-battery/ when booting with legacy board=20
> code. But when booting DT kernel it register sysnode with different n=
ame=20
> /sys/class/power_supply/n900-battery/
>=20
> Sysfs node for DT kernel comes from Nokia N900 DTS file:=20
> arch/arm/boot/dts/omap3-n900.dts
>=20
> I would propose change which change DTS to "rx51-battery" to have it=20
> compatible with naming which is for legacy board code. It is just=20
> because to have compatibility and same naming scheme and also to make=
=20
> existing programs to work without needing patching them.
>=20
> What do you think?

Makes sense.. along with _big_ comment in the dts why we are doing
this.
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses=
/blog.html
