From: Tony Lindgren <tony@atomide.com>
Subject: Re: Nokia N900: Broken lirc ir-rx51 driver
Date: Tue, 5 Jan 2016 17:12:50 -0800
Message-ID: <20160106011249.GH12777@atomide.com>
References: <201601021545.35201@pali>
 <20160102170657.GB12622@atomide.com>
 <20160105101841.GI22661@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160105101841.GI22661@pali>
Sender: linux-kernel-owner@vger.kernel.org
To: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Sebastian Reichel <sre@kernel.org>, Pavel Machel <pavel@ucw.cz>, Nishanth Menon <nm@ti.com>, Timo Kokkonen <timo.t.kokkonen@iki.fi>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Pali Roh=C3=A1r <pali.rohar@gmail.com> [160105 02:19]:
> On Saturday 02 January 2016 09:06:57 Tony Lindgren wrote:
> >
> > Yup please take a look at thread "[PATCH 0/3] pwm: omap: Add PWM su=
pport
> > using dual-mode timers". Chances are we still need to set up the dm=
timer
> > code to provide also irqchip functions. That way ir-rx51.c can just=
 do
> > request_irq on the selected dmtimer for interrupts.
>=20
> No I see that patch from that thread uses dmtimer.h from plat-omap. S=
o
> it is really OK?

It's using the header to populate the platform data in mach-omap2 so
that's fine. But we do not want to directly expose the dmtimer function=
s
to device drivers as they are not Linux generic at this point.

Regards,

Tony
