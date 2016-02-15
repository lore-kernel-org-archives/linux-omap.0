From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Subject: Re: Nokia N900: Proper C-states
Date: Mon, 15 Feb 2016 11:17:11 +0100
Message-ID: <20160215101711.GC1476@pali>
References: <201601021526.28687@pali>
 <56884890.9080306@linaro.org>
 <20160209155619.GG19432@atomide.com>
 <56BA1C92.4040202@linaro.org>
 <20160211150221.GA30075@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160211150221.GA30075@pali>
Sender: linux-kernel-owner@vger.kernel.org
To: Kalle Jokiniemi <kalle.jokiniemi@digia.com>, Kalle Jokiniemi <kalle.jokiniemi@jolla.com>
Cc: Jean Pihet <j-pihet@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Kevin Hilman <khilman@ti.com>, Nishanth Menon <nm@ti.com>, Pavel Machel <pavel@ucw.cz>, Aaro Koskinen <aaro.koskinen@iki.fi>, Sebastian Reichel <sre@kernel.org>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Tony Lindgren <tony@atomide.com>
List-Id: linux-omap@vger.kernel.org

On Thursday 11 February 2016 16:02:21 Pali Roh=C3=A1r wrote:
> On Tuesday 09 February 2016 18:06:26 Daniel Lezcano wrote:
> > On 02/09/2016 04:56 PM, Tony Lindgren wrote:
> > >* Daniel Lezcano <daniel.lezcano@linaro.org> [160102 14:01]:
> > >>On 01/02/2016 03:26 PM, Pali Roh=C3=A1r wrote:
> > >>>Hello,
> > >>>
> > >>>due to this Daniel Lezcano commit (ARM: OMAP3: cpuidle - remove =
rx51
> > >>>cpuidle parameters table)
> > >>>
> > >>>https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/=
commit/?id=3D231900afba52d6faddfb480cde4132d4edc089bc
> > >>>
> > >>>we need patch cpuidle34xx.c code to fix commit for Nokia N900. S=
ee:
> > >>>
> > >>>https://github.com/pali/linux-n900/commit/e147fd4b678f1f3d7a5235=
287910960bd41e04dc
> > >>>
> > >>>As Nokia N900 code is converting from legacy board code to DST, =
I would
> > >>>like to know how to patch correctly omap3_idle_driver in DTS wit=
h
> > >>>correct values measured for Nokia N900. Thanks!
> > >
> > >I'm almost certain those values are not n900 specific but should b=
e
> > >used for omap3430 in general.
> > >
>=20
> cpuidle parameters for Nokia N900 were added by this commit:
>=20
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commi=
t/?id=3D5a1b1d3a9efad6bd53d01ff02e86626d1a51d697
>=20
> which says:
>=20
> Numbers based on measurements made in October 2009 for PM optimized
> kernel with CPU freq enabled.

Adding Kalle Jokiniemi, author of that commit which added cpuidle
parameters for Nokia N900.

Kalle, do you know if cpuidle values measured are Nokia N900 specific o=
r
general omap3430?

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com
