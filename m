From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v4 3/6] Documentation: DT: Document twl4030-madc-battery
 bindings
Date: Wed, 1 Apr 2015 22:16:05 +0200
Message-ID: <20150401201605.GA11421@amd>
References: <1426022847-30912-1-git-send-email-marek@goldelico.com>
 <1426022847-30912-4-git-send-email-marek@goldelico.com>
 <20150311152414.GX5264@atomide.com>
 <844740CD-C95B-4411-A2C8-4906F58DBEE8@goldelico.com>
 <20150311164442.GA5264@atomide.com>
 <20150331072643.GB30788@amd>
 <BC5A7447-CAD7-4CCE-8F08-8CEFBB5C6905@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:48153 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753052AbbDAUQJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 1 Apr 2015 16:16:09 -0400
Content-Disposition: inline
In-Reply-To: <BC5A7447-CAD7-4CCE-8F08-8CEFBB5C6905@goldelico.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Dr. H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Tony Lindgren <tony@atomide.com>, Marek Belisko <marek@goldelico.com>, Benoit Cousson <bcousson@baylibre.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, linux-omap@vger.kernel.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-pm@vger.kernel.org

Hi!

> > As I explained in some other mail, those tables should not be
> > neccessary at all. They can be computed from li-ion characteristics
> > and internal resistance, and assumed current during charge and
> > discharge.
>=20
> I already explained that we do not know the charging and discharging
> current well enough for such a calculation.
>=20
> And I explained that the =E2=80=9Cinternal resistance=E2=80=9D is a s=
ystem (battery + cables +
> connectors + other circuits) parameter that is not easy to derive or =
measure
> and type into the .dts source code.
>=20
> At least I have no idea how I should find it out for my boards. While=
 I can
> easily determine the curves (and we already have them for the platfor=
m_data
> driver).
>=20
> Please propose your own code doing that so that we can test if it is
> better.

So, how does this look?

It looks to me like you have cca 0.1 Ohm resistance in your system,
and are using cca 75mA while discharging, and charge by cca 1.4A. (And
these are all the coefficients the code should need; rest is battery
characteristics -- common to all li-ions, and charger characteristics
-- that will be common to all cellphones. If current can be measured,
this code should go more precise answers).

pavel@amd:~/g/tui/ofone$ ./liion_maps
Charging
Voltage  4.2 V ; table  100 %  internal voltage 4.18 V current 0.233 A =
computed  97 %
Voltage  4.1 V ; table  75 %  internal voltage 4.08 V current 0.233 A c=
omputed  87 %
Voltage  4.0 V ; table  55 %  internal voltage 3.93 V current 0.700 A c=
omputed  69 %
Voltage  3.9 V ; table  25 %  internal voltage 3.76 V current 1.400 A c=
omputed  26 %
Voltage  3.8 V ; table  5 %  internal voltage 3.66 V current 1.400 A co=
mputed  3 %
Voltage  3.7 V ; table  2 %  internal voltage 3.56 V current 1.400 A co=
mputed  2 %
Voltage  3.6 V ; table  1 %  internal voltage 3.46 V current 1.400 A co=
mputed  1 %
Voltage  3.3 V ; table  0 %  internal voltage 3.16 V current 1.400 A co=
mputed  -1 %
Badness  395.4861761427434
Discharging
Voltage  4.2 V ; table  100 %  internal voltage 4.21 V current -0.075 A=
 computed  100 %
Voltage  4.1 V ; table  95 %  internal voltage 4.11 V current -0.075 A =
computed  91 %
Voltage  4.0 V ; table  70 %  internal voltage 4.01 V current -0.075 A =
computed  79 %
Voltage  3.8 V ; table  50 %  internal voltage 3.81 V current -0.075 A =
computed  46 %
Voltage  3.7 V ; table  10 %  internal voltage 3.71 V current -0.075 A =
computed  3 %
Voltage  3.6 V ; table  5 %  internal voltage 3.61 V current -0.075 A c=
omputed  2 %
Voltage  3.3 V ; table  0 %  internal voltage 3.31 V current -0.075 A c=
omputed  0 %
Badness  171.69576218433212

> > Running below 3.3V.. not really. At that point, the battery is real=
ly
> > _empty_, and voltage is going down really really fast.
>=20
> It is the diffference between 2% and 0% where a fuel indication might
> be most important=E2=80=A6

> > Plus, you are damaging the battery at that point.
>=20
> The power controller will shut down - but the driver should report
> reasonable (but IMHO not necessarily perfect) values until the last
> moment.

It is tricky to do a good job near 0%... or anywhere else. See for
example

http://cseweb.ucsd.edu/~trosing/lectures/battery.pdf

You start a call, percentage goes down, end a call, it will go
back up. I'm pretty sure you will not be able to make a call with "5%"
indication from your code at low battery temperature (say -10C).

Anyway, see above, I think I provide reasonable values even in that ran=
ge.

Signed-off-by: Pavel Machek <pavel@ucw.cz>
									Pavel

#!/usr/bin/python3
import math

def percent_internal(v):
    u =3D 0.0387-(1.4523*(3.7835-v))
    if u < 0:
        # Formula above does gives 19.66% for 3.756, and refuses to
        # work below that. Assume 3.3V is empty battery, and provide
        # linear dependency below that.
        u =3D (v - 3.3) * ((3.756 - 3.3) * 19.66)
        return u
    return (0.1966+math.sqrt(u))*100

charging =3D [ [4200, 100], [4100, 75], [4000, 55], [3900, 25], [3800, =
5], [3700, 2], [3600, 1], [3300, 0] ]

discharging =3D [ [4200, 100], [4100, 95], [4000, 70], [3800, 50], [370=
0, 10], [3600, 5], [3300, 0] ]

# current > 0: charging
def percent_ohm(v, current):
    v_int =3D v - current * 0.1
    print(" internal voltage %1.2f V current %.3f A " % (v_int, current=
), end=3D'')
    return percent_internal(v_int)

def percent(v, charging):
    if charging:
        # Charger model. Chargers will do constant current then
        # constant voltage, so current will go down as voltage
        # approaches 4.2V
        i =3D 2.8
        if v >=3D 4.:
            i =3D i/2
        if v >=3D 4.05:
            i =3D i/3
    else:
        i =3D -0.15

    # With current forced to 0, we get badness 4014 and 258
    # 2.5A, sloped: badness 576
    # +4A -> badness 1293
    # +3A -> badness 890
    # +2.5A ->         339
    # +2.4A -> badness 389
    # +2.3A -> badness 444   =20
    # +2.2A -> badness 504
    # +2A -> badness 634
    # +1A -> badness 1450
    # +0.5A -> badness 2865
    # -0.2A -> badness 252
    # -0.15A -> badness 251.37
    # -0.1A -> badness 252
    # -0.05A -> badness 254
    i/=3D2
    return percent_ohm(v, i)

def compute(map, charging):
    diff =3D 0
    if charging:
        print("Charging")
    else:
        print("Discharging")
    for v, p in map:
        v /=3D 1000.
        print("Voltage ", v, "V ; table ", p, "% ", end=3D'')
        p2 =3D percent(v, charging)
        print("computed ", int(p2), "%")
        diff +=3D (p-p2)*(p-p2)
    print("Badness ", diff)

               =20
#perc =3D percent(volt)
compute(charging, 1)
compute(discharging, 0)

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses=
/blog.html
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
