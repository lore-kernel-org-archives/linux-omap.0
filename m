From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v2 2/3] bq2415x_charger: Use power_supply notifier for
 automode
Date: Mon, 25 Nov 2013 15:01:27 +0100
Message-ID: <20131125140127.GA24125@amd.pavel.ucw.cz>
References: <1378630239-10006-1-git-send-email-pali.rohar@gmail.com>
 <201311242001.16299@pali>
 <20131124192608.GA11338@earth.universe>
 <201311242041.47075@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <201311242041.47075@pali>
Sender: linux-kernel-owner@vger.kernel.org
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: Sebastian Reichel <sre@ring0.de>, Anton Vorontsov <anton@enomsg.org>, David Woodhouse <dwmw2@infradead.org>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, freemangordon@abv.bg, aaro.koskinen@iki.fi
List-Id: linux-omap@vger.kernel.org

Hi!

On Sun 2013-11-24 20:41:46, Pali Roh=E1r wrote:
> On Sunday 24 November 2013 20:26:09 Sebastian Reichel wrote:
> > On Sun, Nov 24, 2013 at 08:01:16PM +0100, Pali Roh=E1r wrote:
> > > Currently on Maemo 5 this is handled in userspace (with open
> > > source dsme daemon).
> >=20
> > I assume it currently also takes care of the bq2415x watchdog?
> > That means if the daemon dies charging will stop, because the
> > watchdog does no longer trigger.
> >=20
> > When your patch is applied you have introduced a safety issue.
> > When the daemon dies charging will continue and temperature is
> > no longer checked.
> >=20
> > -- Sebastian
>=20
> No dsme checking battery temperature and does not handle bq24510=20
> timer (previously this was in closed bme daemon which=20
> functionality is now in kernel drivers). But dsme daemon also=20
> kicking tlw4030 watchdog, so when daemon dies after 30s tlw4030=20
> reboot device.
>=20
> But right you can implement correctly this in userspace (e.g.=20
> when daemon not running/crashed, you can restart daemon or reboot=20
> system or disable charing, whatever...) and you do not need to=20
> have it in kernel...

Charging handling really should be in kernel.

1st) you want charging to work with init=3D/bin/bash, and you want it
with regular (not n900-specific) debian/arm.

2st) normally hardware, firmware or kernel does the charging. (PCs,
Sharp Zaurus). Yes, it pulls us farther away from Maemo...

Where can I get dsme sources?
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses=
/blog.html
