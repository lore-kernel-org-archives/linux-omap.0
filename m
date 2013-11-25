From: =?UTF-8?B?0JjQstCw0LnQu9C+INCU0LjQvNC40YLRgNC+0LI=?=
	<freemangordon@abv.bg>
Subject: Re: [PATCH v2 2/3] bq2415x_charger: Use power_supply notifier for automode
Date: Mon, 25 Nov 2013 19:01:54 +0200 (EET)
Message-ID: <1851041258.29554.1385398914287.JavaMail.apache@mail83.abv.bg>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: pali.rohar@gmail.com, sre@ring0.de, anton@enomsg.org, dwmw2@infradead.org, tony@atomide.com, linux@arm.linux.org.uk, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, aaro.koskinen@iki.fi
List-Id: linux-omap@vger.kernel.org

=20




 >-------- =D0=9E=D1=80=D0=B8=D0=B3=D0=B8=D0=BD=D0=B0=D0=BB=D0=BD=D0=BE=
 =D0=BF=D0=B8=D1=81=D0=BC=D0=BE --------
 >=D0=9E=D1=82:  Pavel Machek=20
 >=D0=9E=D1=82=D0=BD=D0=BE=D1=81=D0=BD=D0=BE: Re: [PATCH v2 2/3] bq2415=
x_charger: Use power_supply notifier for
 automode
 >=D0=94=D0=BE: Pali Roh=C3=A1r=20
 >=D0=98=D0=B7=D0=BF=D1=80=D0=B0=D1=82=D0=B5=D0=BD=D0=BE =D0=BD=D0=B0: =
=D0=9F=D0=BE=D0=BD=D0=B5=D0=B4=D0=B5=D0=BB=D0=BD=D0=B8=D0=BA, 2013, =D0=
=9D=D0=BE=D0=B5=D0=BC=D0=B2=D1=80=D0=B8 25 17:18:39 EET
 >
 >
 >On Mon 2013-11-25 15:10:00, Pali Roh=C3=A1r wrote:
 >> On Monday 25 November 2013 15:01:27 Pavel Machek wrote:
 >> > Where can I get dsme sources?
 >> > 									Pavel
 >>=20
 >> dsme daemon: https://gitorious.org/community-ssu/dsme
 >> dsme thermal plugin: https://gitorious.org/rx51-bme-replacement/dsm=
e-thermalobject-surface
 >>=20
 >> dsme thermal plugin is responsible for checking temperature of=20
 >> battery and send it to dsme damon. dsme daemon itself checking=20
 >> temperature limits and do something (e.g reboot device)
 >
 >Thanks for links!
 >
 >AFAICT.... dsme daemon does some kind of system management, not
 >directly controlling charging, right? It does monitor system temperat=
ure.
 >
 >Now.. Imagine phone left in car in charger (on sun). Likely
 >temperature will reach high values, kernel is charging, dsme will
 >reboot the system, but kernel will start charging again, dsme will
 >reboot again, ...
 >
 >And it is not only high temperatures that are problem for li-ion
 >charging; battery should not be fast charged below 5C and should not
 >be charged below 0C. (Again, both are likely to happen if you leave
 >your phone in car).
 >
 >AFAICT, we should simply disable charging below 5C or above 45C.
 >
 >									Pavel
 >--=20
 >(english) http://www.livejournal.com/~pavelmachek
 >(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/hors=
es/blog.html
 >

AFAIK dsme will not restart it, but power it off, so the above scenario=
 won't happen.

Regards,
Ivo
