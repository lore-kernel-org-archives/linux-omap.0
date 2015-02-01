From: Pavel Machek <pavel@ucw.cz>
Subject: Re: bq2415x_charger.c: battery is discharged (fast, 224mA) when it
 should be charged
Date: Sun, 1 Feb 2015 20:17:50 +0100
Message-ID: <20150201191750.GA27467@amd>
References: <20150201094702.GA21628@amd>
 <201502011108.16071@pali>
 <20150201113813.GA6570@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150201113813.GA6570@amd>
Sender: linux-pm-owner@vger.kernel.org
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, linux-pm@vger.kernel.org, sre@debian.org, sre@ring0.de, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com
List-Id: linux-omap@vger.kernel.org

On Sun 2015-02-01 12:38:13, Pavel Machek wrote:
> Hi!
>=20
> On Sun 2015-02-01 11:08:16, Pali Roh=E1r wrote:
> > On Sunday 01 February 2015 10:47:02 Pavel Machek wrote:
> > > Hi!
> > >=20
> > > I connected N900 with full battery using USB. For some reason,
> > > charge limit was set to 100mA, battery was "full" and was
> > > discharging:
> > >=20
> >=20
> > Make sure you have loaded some usb gadget. Without it battery=20
> > charging via dedicated wallcharger (and probably also usb host=20
> > charger) does not working. g_nokia should be OK.
>=20
> I had that loaded (was running from root over USB at the moment.)
>=20
> > Try also compiling kernel with CONFIG_USB_GADGET_VBUS_DRAW=3D500
> >=20
> > Also for charger autodetection you need to have loaded=20
> > isp1704_charer.ko module (or compiled into kernel).
> >=20
> > And make sure that isp1704_charger is loaded before module=20
> > bq2415x_charger (there is some probe defer, no idea if it works=20
> > as excepted).
>=20
> It seems bq2415x_charger is the problem: it all started working when =
I
> did echo reset > mode...=20

It does not switch from "Full" to "Charging", and it does not seem to
switch from "Charging" to "Full", either...:

root@n900:/my/tui/ofone# ./tefone
Ready.
Battery  4.152 V  4.161 V  95 %  0 %  0 / 0 / 2056 mAh  Charging   40.8=
76 / 650 / 500  mA
Battery  4.152 V  4.161 V  95 %  0 %  0 / 0 / 2056 mAh  Charging   48.1=
95 / 650 / 500  mA
Battery  4.152 V  4.164 V  95 %  0 %  0 / 0 / 2056 mAh  Charging   43.5=
54 / 650 / 500  mA
Battery  4.14 V  4.164 V  94 %  0 %  0 / 0 / 2056 mAh  Charging   40.16=
2 / 650 / 500  mA
Battery  4.158 V  4.172 V  95 %  0 %  0 / 0 / 2056 mAh  Charging   54.6=
21 / 650 / 500  mA
Battery  4.158 V  4.175 V  95 %  0 %  0 / 0 / 2056 mAh  Charging   33.7=
36 / 650 / 500  mA
aHello, world
Battery  4.164 V  4.175 V  96 %  0 %  0 / 0 / 2056 mAh  Charging   2.14=
2 / 650 / 500  mA
Battery  4.164 V  4.177 V  96 %  0 %  0 / 0 / 2056 mAh  Charging   19.9=
92 / 650 / 500  mA
Battery  4.158 V  4.177 V  95 %  0 %  0 / 0 / 2056 mAh  Charging   18.2=
07 / 650 / 500  mA
Battery  4.158 V  4.177 V  95 %  0 %  0 / 0 / 2056 mAh  Charging   17.4=
93 / 650 / 500  mA
Battery  4.164 V  4.177 V  96 %  0 %  0 / 0 / 2056 mAh  Charging   16.2=
43 / 650 / 500  mA
Battery  4.158 V  4.177 V  95 %  0 %  0 / 0 / 2056 mAh  Charging   16.2=
43 / 650 / 500  mA


--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses=
/blog.html
