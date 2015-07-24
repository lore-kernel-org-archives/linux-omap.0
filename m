From: Dave Young <dyoung@redhat.com>
Subject: Re: linux 4.2-rc1 broken Nokia N900
Date: Fri, 24 Jul 2015 18:39:44 +0800
Message-ID: <20150724103944.GD8405@localhost.localdomain>
References: <201507111405.06048@pali>
 <20150724081809.GB22852@dhcp-128-11.nay.redhat.com>
 <20150724085124.GB8349@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150724085124.GB8349@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, Sebastian Reichel <sre@kernel.org>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 07/24/15 at 10:51am, Pavel Machek wrote:
> On Fri 2015-07-24 16:18:09, Dave Young wrote:
> > On 07/11/15 at 02:05pm, Pali Roh=E1r wrote:
> > > Hello,
> > >=20
> > > now I tested 4.2-rc1 release on Nokia N900 and couple of drivers =
are
> > > broken and cause kernel oops...
> > >=20
> > > Basically wifi, touchscreen and rtc drivers not working...
> > >=20
> >=20
> > Pali, could you tell how do you test mainline kernel on n900?
> >=20
> > I used to use n900 as a usb dbgp gadget with a backport patch to
> > 2.6.28 so that I can get early debug kernel message from my laptop.
> >=20
> > I tried mainline previously with Fedora arm, text mode works but
> > no graphics. Is there a way to use maemo UI with mainline kernel?
>=20
> I'm successfully running MATE desktop from Debian. Even modem works
> with ofono and custom scripts.
>=20
> https://github.com/dderby/debian900
>=20
> https://wiki.debian.org/n900-wheezy-armhf
> https://wiki.debian.org/MaemoAndSqueeze
>=20
> (..and tui project on gitlab).

Pavel, it is very helpful, actually I do not care much about modem.
Will take a look at how Debian works as well. Maybe I should send
private email to ask these and future questions, it is off topic now...

Thanks
Dave
