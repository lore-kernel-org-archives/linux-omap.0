From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v4 3/6] Documentation: DT: Document twl4030-madc-battery
 bindings
Date: Sat, 4 Apr 2015 10:16:56 +0200
Message-ID: <20150404081655.GD31064@amd>
References: <1426022847-30912-1-git-send-email-marek@goldelico.com>
 <1426022847-30912-4-git-send-email-marek@goldelico.com>
 <20150311152414.GX5264@atomide.com>
 <844740CD-C95B-4411-A2C8-4906F58DBEE8@goldelico.com>
 <20150311164442.GA5264@atomide.com>
 <20150331072643.GB30788@amd>
 <BC5A7447-CAD7-4CCE-8F08-8CEFBB5C6905@goldelico.com>
 <20150401201605.GA11421@amd>
 <D659872E-E276-4E00-BAFC-1E461EDA1FA7@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <D659872E-E276-4E00-BAFC-1E461EDA1FA7@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Dr. H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Tony Lindgren <tony@atomide.com>, Marek Belisko <marek@goldelico.com>, Benoit Cousson <bcousson@baylibre.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, linux-omap@vger.kernel.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-pm@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi!

> >> Please propose your own code doing that so that we can test if it =
is
> >> better.
> >=20
> > So, how does this look?
> >=20
> > It looks to me like you have cca 0.1 Ohm resistance in your system,
>=20
> This is completely unknown.
>=20
> > and are using cca 75mA while discharging, and charge by cca 1.4A.
>=20
> Where do you get these figures from?

Least squares fitting of my coefficients to your tables.

> A GTA04 board discharges usually between 50 and 400 mA (depending on =
activities)
> and if you turn on WiFi, it will be up to 600 mA. If you use 3G it ca=
n draw even more
> during operation.

How big battery do you have? According to least squares fitting,
assuming maximum charge of .46A, you were taking about 25mA when
doing the discharge test.

> Total current going in is 500-800 mA (depending on USB negotiations) =
and this is
> split into system operation and charging current. So 1.4A charging cu=
rrent is not
> possible. Rather 200-500 mA.
>=20
> So it might be that the battery is discharged although the system is =
connected
> to a charger.

Yah, and your battery meter will be wrong in such case, as will be
mine, because they are based on same information. The thing is, mine
can be improved without adding more tables.=20

> > It is tricky to do a good job near 0%... or anywhere else. See for
> > example
> >=20
> > http://cseweb.ucsd.edu/~trosing/lectures/battery.pdf
> >=20
> > You start a call, percentage goes down, end a call, it will go
> > back up. I'm pretty sure you will not be able to make a call with "=
5%"
> > indication from your code at low battery temperature (say -10C).
>=20
> The whole system is heating up a little, so that you never have -10C =
for the
> battery.

Umm. When not calling, your phone should not heat itself up. And you
definitely can power it down, leave it in outer pocket, then power it
up. It is actually something people do when they want to preserve batte=
ry...

> I think you are trying to solve situations that don=E2=80=99t exist i=
n practice.
>=20
> And AFAIK, the GTA04 board is the only user of this driver in case th=
e battery
> has no built-in fuel gauge. So why improve it beyond what the GTA04
> users need?

Because then other users can share the same code, and because you
avoid big ugly tables in dts.

> I repeat myself: this driver is not built for highest precision becau=
se there are
> better methods (fuel gauge chip). These might not be available so thi=
s fall-back
> driver has been built.
>=20
> It is definitively better than no driver and worse than the optimum.

And my email suggested solution better than your driver, so why not
just use it?


> > #perc =3D percent(volt)
> > compute(charging, 1)
> > compute(discharging, 0)
>=20
> Please explain what you calculate here. Especially what =E2=80=9CBadn=
ess=E2=80=9D is?

Badness is error in least squares method.

Here are updated tables:

pavel@duo:~/g/tui/ofone$ ./liion_maps
Charging
Voltage  4.2 V ; table  100 %  internal voltage 4.18 V current 0.078 A =
computed  97 %
Voltage  4.1 V ; table  75 %  internal voltage 4.08 V current 0.078 A c=
omputed  87 %
Voltage  4.0 V ; table  55 %  internal voltage 3.93 V current 0.233 A c=
omputed  69 %
Voltage  3.9 V ; table  25 %  internal voltage 3.76 V current 0.467 A c=
omputed  26 %
Voltage  3.8 V ; table  5 %  internal voltage 3.66 V current 0.467 A co=
mputed  3 %
Voltage  3.7 V ; table  2 %  internal voltage 3.56 V current 0.467 A co=
mputed  2 %
Voltage  3.6 V ; table  1 %  internal voltage 3.46 V current 0.467 A co=
mputed  1 %
Voltage  3.3 V ; table  0 %  internal voltage 3.16 V current 0.467 A co=
mputed  -1 %
Badness  395.4861761427434
Discharging
Voltage  4.2 V ; table  100 %  internal voltage 4.21 V current -0.025 A=
 computed  100 %
Voltage  4.1 V ; table  95 %  internal voltage 4.11 V current -0.025 A =
computed  91 %
Voltage  4.0 V ; table  70 %  internal voltage 4.01 V current -0.025 A =
computed  79 %
Voltage  3.8 V ; table  50 %  internal voltage 3.81 V current -0.025 A =
computed  46 %
Voltage  3.7 V ; table  10 %  internal voltage 3.71 V current -0.025 A =
computed  3 %
Voltage  3.6 V ; table  5 %  internal voltage 3.61 V current -0.025 A c=
omputed  2 %
Voltage  3.3 V ; table  0 %  internal voltage 3.31 V current -0.025 A c=
omputed  0 %
Badness  171.69576218433212
pavel@duo:~/g/tui/ofone$ python

									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses=
/blog.html
