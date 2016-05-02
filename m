From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Nokia N900: Broken lirc ir-rx51 driver
Date: Mon, 2 May 2016 09:06:12 +0200
Message-ID: <20160502070612.GC13215@amd>
References: <201601021545.35201@pali>
 <20160102170657.GB12622@atomide.com>
 <20160105101841.GI22661@pali>
 <20160106011249.GH12777@atomide.com>
 <20160422134929.GG29406@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160422134929.GG29406@pali>
Sender: linux-kernel-owner@vger.kernel.org
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Sebastian Reichel <sre@kernel.org>, Nishanth Menon <nm@ti.com>, Timo Kokkonen <timo.t.kokkonen@iki.fi>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Fri 2016-04-22 15:49:29, Pali Roh=E1r wrote:
> On Tuesday 05 January 2016 17:12:50 Tony Lindgren wrote:
> > * Pali Roh=E1r <pali.rohar@gmail.com> [160105 02:19]:
> > > On Saturday 02 January 2016 09:06:57 Tony Lindgren wrote:
> > > >
> > > > Yup please take a look at thread "[PATCH 0/3] pwm: omap: Add PW=
M support
> > > > using dual-mode timers". Chances are we still need to set up th=
e dmtimer
> > > > code to provide also irqchip functions. That way ir-rx51.c can =
just do
> > > > request_irq on the selected dmtimer for interrupts.
> > >=20
> > > No I see that patch from that thread uses dmtimer.h from plat-oma=
p. So
> > > it is really OK?
> >=20
> > It's using the header to populate the platform data in mach-omap2 s=
o
> > that's fine. But we do not want to directly expose the dmtimer func=
tions
> > to device drivers as they are not Linux generic at this point.
> >=20
> > Regards,
> >=20
> > Tony
>=20
> Hi Tony! Is there any progress for ir-rx51 driver? Months ago we were
> waiting for some omap pwm patches... What is current state?

Tony now posted patch series... it would be good to test them:

Date: Tue, 26 Apr 2016 16:51:47 -0700
=46rom: Tony Lindgren <tony@atomide.com>
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Aaro Koskinen
<aaro.koskinen@iki.fi>, Ivaylo Dimitrov
        <ivo.g.dimitrov.75@gmail.com>, Sebastian Reichel
	<sre@kernel.org>, Pavel Machel
	        <pavel@ucw.cz>, Timo Kokkonen
		<timo.t.kokkonen@iki.fi>, linux-media@vger.kernel.org,
		Mauro
		        Carvalho Chehab <mchehab@osg.samsung.com>,
			Neil Armstrong <narmstrong@baylibre.com>
			Subject: [PATCH 0/2] Fix ir-rx51 by using PWM
			pdata
			X-Mailer: git-send-email 2.8.1


Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses=
/blog.html
