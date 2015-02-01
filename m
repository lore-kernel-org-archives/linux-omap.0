From: Pavel Machek <pavel@ucw.cz>
Subject: Re: bq2415x_charger.c: battery is discharged (fast, 224mA) when it
 should be charged
Date: Sun, 1 Feb 2015 12:38:13 +0100
Message-ID: <20150201113813.GA6570@amd>
References: <20150201094702.GA21628@amd>
 <201502011108.16071@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <201502011108.16071@pali>
Sender: linux-pm-owner@vger.kernel.org
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, linux-pm@vger.kernel.org, sre@debian.org, sre@ring0.de, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com
List-Id: linux-omap@vger.kernel.org

Hi!

On Sun 2015-02-01 11:08:16, Pali Roh=E1r wrote:
> On Sunday 01 February 2015 10:47:02 Pavel Machek wrote:
> > Hi!
> >=20
> > I connected N900 with full battery using USB. For some reason,
> > charge limit was set to 100mA, battery was "full" and was
> > discharging:
> >=20
>=20
> Make sure you have loaded some usb gadget. Without it battery=20
> charging via dedicated wallcharger (and probably also usb host=20
> charger) does not working. g_nokia should be OK.

I had that loaded (was running from root over USB at the moment.)

> Try also compiling kernel with CONFIG_USB_GADGET_VBUS_DRAW=3D500
>=20
> Also for charger autodetection you need to have loaded=20
> isp1704_charer.ko module (or compiled into kernel).
>=20
> And make sure that isp1704_charger is loaded before module=20
> bq2415x_charger (there is some probe defer, no idea if it works=20
> as excepted).

It seems bq2415x_charger is the problem: it all started working when I
did echo reset > mode...=20

Best regards,
								Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses=
/blog.html
