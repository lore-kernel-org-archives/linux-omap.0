From: Tony Lindgren <tony@atomide.com>
Subject: Re: Nokia N900: Proper C-states
Date: Mon, 15 Feb 2016 07:25:43 -0800
Message-ID: <20160215152542.GS19432@atomide.com>
References: <201601021526.28687@pali>
 <56884890.9080306@linaro.org>
 <20160209155619.GG19432@atomide.com>
 <56BA1C92.4040202@linaro.org>
 <20160211150221.GA30075@pali>
 <20160211174750.GV19432@atomide.com>
 <20160215101054.GB1476@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160215101054.GB1476@pali>
Sender: linux-kernel-owner@vger.kernel.org
To: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, Jean Pihet <j-pihet@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Kevin Hilman <khilman@ti.com>, Nishanth Menon <nm@ti.com>, Pavel Machel <pavel@ucw.cz>, Aaro Koskinen <aaro.koskinen@iki.fi>, Sebastian Reichel <sre@kernel.org>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>
List-Id: linux-omap@vger.kernel.org

* Pali Roh=C3=A1r <pali.rohar@gmail.com> [160215 02:12]:
> On Thursday 11 February 2016 09:47:50 Tony Lindgren wrote:
> > * Pali Roh=C3=A1r <pali.rohar@gmail.com> [160211 07:03]:
> > > > On 02/09/2016 04:56 PM, Tony Lindgren wrote:
> > > > >I'm almost certain those values are not n900 specific but shou=
ld be
> > > > >used for omap3430 in general.
> > >=20
> > > cpuidle parameters for Nokia N900 were added by this commit:
> > >=20
> > > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/c=
ommit/?id=3D5a1b1d3a9efad6bd53d01ff02e86626d1a51d697
> > >=20
> > > which says:
> > >=20
> > > Numbers based on measurements made in October 2009 for PM optimiz=
ed
> > > kernel with CPU freq enabled.
> > >=20
> > > Tony, do you have any other omap3430 device?
> >=20
> > Yes I can make sure it works for omap3-ldp for a minimal case.
> > That's a 3430 ES 3.0 that's a GP SoC.
> >=20
> > Regards,
> >=20
> > Tony
>=20
> Ok. If it works and you think those values are not Nokia N900 specifi=
c,
> but omap3430, we can add them into kernel.
>=20
> Do you want me to prepare patch? Or will you do it?

Yes please do if you can, I have my hands full with other
regressions in Linux next.

Regards,

Tony
