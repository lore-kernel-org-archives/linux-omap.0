From: =?UTF-8?B?0JjQstCw0LnQu9C+INCU0LjQvNC40YLRgNC+0LI=?=
	<freemangordon@abv.bg>
Subject: Re: [PATCH v2 2/3] bq2415x_charger: Use power_supply notifier for automode
Date: Mon, 25 Nov 2013 20:32:46 +0200 (EET)
Message-ID: <1434978251.31721.1385404366021.JavaMail.apache@mail83.abv.bg>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@ring0.de>
Cc: pavel@ucw.cz, pali.rohar@gmail.com, anton@enomsg.org, dwmw2@infradead.org, tony@atomide.com, linux@arm.linux.org.uk, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, aaro.koskinen@iki.fi
List-Id: linux-omap@vger.kernel.org

  >-------- =D0=9E=D1=80=D0=B8=D0=B3=D0=B8=D0=BD=D0=B0=D0=BB=D0=BD=D0=BE=
 =D0=BF=D0=B8=D1=81=D0=BC=D0=BE --------
 >=D0=9E=D1=82:  Sebastian Reichel=20
 >=D0=9E=D1=82=D0=BD=D0=BE=D1=81=D0=BD=D0=BE: Re: [PATCH v2 2/3] bq2415=
x_charger: Use power_supply notifier for
 automode
 >=D0=94=D0=BE: =D0=98=D0=B2=D0=B0=D0=B9=D0=BB=D0=BE =D0=94=D0=B8=D0=BC=
=D0=B8=D1=82=D1=80=D0=BE=D0=B2=20
 >=D0=98=D0=B7=D0=BF=D1=80=D0=B0=D1=82=D0=B5=D0=BD=D0=BE =D0=BD=D0=B0: =
=D0=9F=D0=BE=D0=BD=D0=B5=D0=B4=D0=B5=D0=BB=D0=BD=D0=B8=D0=BA, 2013, =D0=
=9D=D0=BE=D0=B5=D0=BC=D0=B2=D1=80=D0=B8 25 19:14:21 EET
 >
 >
 >On Mon, Nov 25, 2013 at 07:01:54PM +0200, =D0=98=D0=B2=D0=B0=D0=B9=D0=
=BB=D0=BE =D0=94=D0=B8=D0=BC=D0=B8=D1=82=D1=80=D0=BE=D0=B2 wrote:
 >>> Now.. Imagine phone left in car in charger (on sun). Likely
 >>> temperature will reach high values, kernel is charging, dsme will
 >>> reboot the system, but kernel will start charging again, dsme will
 >>> reboot again, ...
 >>>
 >>> And it is not only high temperatures that are problem for li-ion
 >>> charging; battery should not be fast charged below 5C and should n=
ot
 >>> be charged below 0C. (Again, both are likely to happen if you leav=
e
 >>> your phone in car).
 >>>
 >>> AFAICT, we should simply disable charging below 5C or above 45C.
 >>=20
 >> AFAIK dsme will not restart it, but power it off, so the above
 >> scenario won't happen.
 >
 >Just assume what happens, when dsme does not start (e.g. system boot
 >hangs).
 >
 >If everything is controlled from userspace, charger would not start
 >(-> safe!). If everything is controlled by the kernel, temperature
 >safety checks are taken (-> safe!). But in the currently proposed
 >variant: No safety checks.
 >
 >-- Sebastian
 >
 >

Hmm, you have a point here :)

So, AIUI there are 2 options:

1. charger driver polls the battery driver every n (60?) seconds.
2. battery driver sends PSY_EVENT_PROP_CHANGED on every degree up or
down
=20
In both cases if the temperature is outside of the safe margins, the
charging should be stopped.

2 seems more generic to me, but as rx51-battery is missing the
functionality to send events on temperature change, I guess 1 will
be easier to implement.

And I think there should be some method (sysfs entry?, /dev/bqxxx
opened?) to tell the charger driver to stop polling the battery=20
driver once (and if) the userspace has started to take care of the=20
battery temperature - makes no sense to duplicate the checks IMO.
