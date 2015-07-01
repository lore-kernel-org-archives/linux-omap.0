From: Pavel Machek <pavel@ucw.cz>
Subject: Re: n900 in 4.2-rc0: repeating oopses
Date: Wed, 1 Jul 2015 11:59:54 +0200
Message-ID: <20150701095954.GD7969@amd>
References: <20150416093234.GA17423@amd>
 <20150629091146.GA5103@amd>
 <20150630092404.GA19285@amd>
 <20150630095310.GF27720@pali>
 <20150701065932.GS4156@atomide.com>
 <20150701072255.GA17577@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150701072255.GA17577@pali>
Sender: linux-kernel-owner@vger.kernel.org
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, sre@debian.org, sre@ring0.de, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com
List-Id: linux-omap@vger.kernel.org

On Wed 2015-07-01 09:22:55, Pali Roh=E1r wrote:
> On Tuesday 30 June 2015 23:59:33 Tony Lindgren wrote:
> > * Pali Roh=E1r <pali.rohar@gmail.com> [150630 02:55]:
> > >=20
> > > I will try 4.2 at the end of week.
> >=20
> > At least today's 4.1.0-11549-g05a8256 boots just fine on my n900.
> >=20
> > Regards,
> >=20
> > Tony
>=20
> So, Pavel can you re-test? Maybe there can be problem with some drive=
r
> which Tony did not compiled into zImage? Just speculation...

I re-tested with today's git, and it seems to boot. Thanks for help...

Now. "echo mem > /sys/power/state" is broken, as in "returns
immediately in about 50% cases". The messages are

Powerdomain (per_pwrdm) didn't enter target state 1
Powerdomain (core_pwerdm) didn't enter target state 1

Any ideas? Thanks,

									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses=
/blog.html
