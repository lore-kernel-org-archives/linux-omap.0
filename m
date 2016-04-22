From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Subject: Re: Nokia N900: Broken lirc ir-rx51 driver
Date: Fri, 22 Apr 2016 15:49:29 +0200
Message-ID: <20160422134929.GG29406@pali>
References: <201601021545.35201@pali>
 <20160102170657.GB12622@atomide.com>
 <20160105101841.GI22661@pali>
 <20160106011249.GH12777@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160106011249.GH12777@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Sebastian Reichel <sre@kernel.org>, Pavel Machel <pavel@ucw.cz>, Nishanth Menon <nm@ti.com>, Timo Kokkonen <timo.t.kokkonen@iki.fi>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Tuesday 05 January 2016 17:12:50 Tony Lindgren wrote:
> * Pali Roh=C3=A1r <pali.rohar@gmail.com> [160105 02:19]:
> > On Saturday 02 January 2016 09:06:57 Tony Lindgren wrote:
> > >
> > > Yup please take a look at thread "[PATCH 0/3] pwm: omap: Add PWM =
support
> > > using dual-mode timers". Chances are we still need to set up the =
dmtimer
> > > code to provide also irqchip functions. That way ir-rx51.c can ju=
st do
> > > request_irq on the selected dmtimer for interrupts.
> >=20
> > No I see that patch from that thread uses dmtimer.h from plat-omap.=
 So
> > it is really OK?
>=20
> It's using the header to populate the platform data in mach-omap2 so
> that's fine. But we do not want to directly expose the dmtimer functi=
ons
> to device drivers as they are not Linux generic at this point.
>=20
> Regards,
>=20
> Tony

Hi Tony! Is there any progress for ir-rx51 driver? Months ago we were
waiting for some omap pwm patches... What is current state?

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com
