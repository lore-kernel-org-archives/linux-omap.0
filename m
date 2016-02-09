From: Tony Lindgren <tony@atomide.com>
Subject: Re: Nokia N900: Proper C-states
Date: Tue, 9 Feb 2016 07:56:20 -0800
Message-ID: <20160209155619.GG19432@atomide.com>
References: <201601021526.28687@pali>
 <56884890.9080306@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <56884890.9080306@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>, Jean Pihet <j-pihet@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Kevin Hilman <khilman@ti.com>, Nishanth Menon <nm@ti.com>, Pavel Machel <pavel@ucw.cz>, Aaro Koskinen <aaro.koskinen@iki.fi>, Sebastian Reichel <sre@kernel.org>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>
List-Id: linux-omap@vger.kernel.org

* Daniel Lezcano <daniel.lezcano@linaro.org> [160102 14:01]:
> On 01/02/2016 03:26 PM, Pali Roh=C3=A1r wrote:
> >Hello,
> >
> >due to this Daniel Lezcano commit (ARM: OMAP3: cpuidle - remove rx51
> >cpuidle parameters table)
> >
> >https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/comm=
it/?id=3D231900afba52d6faddfb480cde4132d4edc089bc
> >
> >we need patch cpuidle34xx.c code to fix commit for Nokia N900. See:
> >
> >https://github.com/pali/linux-n900/commit/e147fd4b678f1f3d7a52352879=
10960bd41e04dc
> >
> >As Nokia N900 code is converting from legacy board code to DST, I wo=
uld
> >like to know how to patch correctly omap3_idle_driver in DTS with
> >correct values measured for Nokia N900. Thanks!

I'm almost certain those values are not n900 specific but should be
used for omap3430 in general.

> the conversion to the DT based arm cpuidle driver could be a bit comp=
lex
> with one issue (index 0 !=3D cpu_do_idle()) and one performance regre=
ssion
> (cpu_pm_enter/exit will be called in retention mode, even if this is =
not
> needed).
>=20
> It will result in a PM code only on one side and on the other side, t=
he
> generic cpuidle-arm.c driver will be used instead with the DT definit=
ion. It
> is worth to the conversion because the result will be nice IMO.
>=20
> Added Lorenzo who is initially author of the arm generic driver. We a=
lready
> discussed in the past about those two issues above and I think this i=
s
> something we should improve.

While this conversion process is going on, we could just add
omap3430_idle_driver and set that based on cpu_is_omap3430()
in omap3_idle_init().

This is assuming it really is 3430 specific. The only thing that
could potentially make it n900 specific is the fact that Nokia had
their own bootrom. But AFAIK these latencies are hardware specific
and should not be related to the bootrom.

Regards,

Tony
