From: Pavel Machek <pavel@ucw.cz>
Subject: Re: n900 in 4.2-rc0: repeating oopses
Date: Thu, 2 Jul 2015 22:25:28 +0200
Message-ID: <20150702202528.GA3387@amd>
References: <20150416093234.GA17423@amd>
 <20150629091146.GA5103@amd>
 <20150630092404.GA19285@amd>
 <20150630095310.GF27720@pali>
 <20150701065932.GS4156@atomide.com>
 <20150701072255.GA17577@pali>
 <20150701095954.GD7969@amd>
 <20150701103421.GV4156@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150701103421.GV4156@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, sre@debian.org, sre@ring0.de, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com
List-Id: linux-omap@vger.kernel.org

On Wed 2015-07-01 03:34:22, Tony Lindgren wrote:
> * Pavel Machek <pavel@ucw.cz> [150701 03:02]:
> > On Wed 2015-07-01 09:22:55, Pali Roh=E1r wrote:
> > > On Tuesday 30 June 2015 23:59:33 Tony Lindgren wrote:
> > > > * Pali Roh=E1r <pali.rohar@gmail.com> [150630 02:55]:
> > > > >=20
> > > > > I will try 4.2 at the end of week.
> > > >=20
> > > > At least today's 4.1.0-11549-g05a8256 boots just fine on my n90=
0.
> > > >=20
> > > > Regards,
> > > >=20
> > > > Tony
> > >=20
> > > So, Pavel can you re-test? Maybe there can be problem with some d=
river
> > > which Tony did not compiled into zImage? Just speculation...
> >=20
> > I re-tested with today's git, and it seems to boot. Thanks for help=
=2E..
>=20
> OK good to hear.

Hmm. Tried to toggle brightness on 4.1, and after few changes:

root@n900:~# echo 255 > /sys/class/backlight/acx565akm/brightness
root@n900:~# echo 120 > /sys/class/backlight/acx565akm/brightness
root@n900:~# echo 10 > /sys/class/backlight/acx565akm/brightness
root@n900:~# echo 1 > /sys/class/backlight/acx565akm/brightness



^C^C
^Z

seems like acx565akm hung :-(.
									Pavel
								=09
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses=
/blog.html
