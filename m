From: Kevin Hilman <khilman@baylibre.com>
Subject: Re: Missing OMAP PM layer
Date: Mon, 25 Jan 2016 10:16:01 -0800
Message-ID: <7hpowpr0da.fsf@baylibre.com>
References: <201601242123.58871@pali> <20160125163442.GU19432@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160125163442.GU19432@atomide.com> (Tony Lindgren's message of
	"Mon, 25 Jan 2016 08:34:42 -0800")
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Pali =?utf-8?Q?Roh=C3=A1r?= <pali.rohar@gmail.com>, Sebastian Reichel <sre@kernel.org>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Pavel Machek <pavel@ucw.cz>, Aaro Koskinen <aaro.koskinen@iki.fi>, Nishanth Menon <nm@ti.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Tony Lindgren <tony@atomide.com> writes:

> * Pali Roh=C3=A1r <pali.rohar@gmail.com> [160124 12:24]:
>> Hello,
>>=20
>> make menuconfig allows me to choose "OMAP PM layer selection" and th=
e=20
>> only one option is CONFIG_OMAP_PM_NOOP "No-op/debug PM layer".
>>=20
>> What does it mean? Power manager is noop?
>>=20
>> I see that it has only two corresponding files in mainline kernel:
>> arch/arm/mach-omap2/omap-pm.h
>> arch/arm/mach-omap2/omap-pm-noop.c
>>=20
>> Nokia's kernels (for N900 and N950) had also:
>> arch/arm/mach-omap2/omap-pm-srf.c
>>=20
>> Can somebody explain it what happened with omap power management?
>>=20
>> Looks like that omap-pm.h provides some API, but the only implementa=
tion=20
>> is noop which do nothing.
>
> I believe none of that is needed any longer in mainline.
>
> Kevin, care to descrbibe what should be done here?

We had created the OMAP PM layer as a pluggable layer where we could
experiment with different approaches for adding constratints, etc.  I
can't remember anymore what all was in there, but we gutted most of it
after switching to runtime PM.=20

The SRF was a "shared resource framework" that came out of a TI kernel
that was never accepted upstream either, but was one of the
implementation of the OMAP PM layer.

Kevin
