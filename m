From: Pavel Machek <pavel@ucw.cz>
Subject: Re: 4.5-rc0: n900 battery charging reverts to 100mA, indicator turns
 back on
Date: Sat, 23 Jan 2016 13:04:25 +0100
Message-ID: <20160123120424.GA12497@amd>
References: <20160121184234.GA17679@amd>
 <201601212034.07727@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <201601212034.07727@pali>
Sender: linux-kernel-owner@vger.kernel.org
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, sre@kernel.org
List-Id: linux-omap@vger.kernel.org

On Thu 2016-01-21 20:34:07, Pali Roh=E1r wrote:
> On Thursday 21 January 2016 19:42:34 Pavel Machek wrote:
> > Hi!
> >=20
> > In 4.4, n900 battery charging works. If indicator is turned off, it
> > stays off, and if I select 1.8A charge, it sticks. (There may be
> > problems after system suspend and resume. But normal operation seem=
s
> > to be pretty reliable).
>=20
> Hm... right, bq2415x driver does not have support for suspend/resume.=
=20
> Before suspend registers should be stored and after resume restored,=20
> plus check charger auto detection.
>=20
> > In 4.5-rc0 (7fdec82af6a9e190e53d07a1463d2a9ac49a8750) battery
> > charging works for few hours. But then indicator (yellow light on
> > 3color LED) turns back on, and if I ask for 1.8A charge, it goes
> > back to .1A, discharging battery.
> >=20
> > Any ideas?
>=20
> Look into bq24150a sysfs node what changes. Also if there is somethin=
g=20
> in dmesg.

Hmm, seems like I can't reproduce that any more. I now noticed that if
I suspend machine it auto-resumes quickly, so maybe suspend was
responsbile. I'll try running 4.5-rc0 for a while...

Thanks,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses=
/blog.html
