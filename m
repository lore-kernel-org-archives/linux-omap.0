From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Subject: Re: linux 4.2-rc1 broken Nokia N900
Date: Tue, 21 Jul 2015 10:04:13 +0200
Message-ID: <20150721080413.GF27290@pali>
References: <201507140002.44119@pali>
 <20150713223607.GA23001@deathray>
 <20150714071412.GA12844@pali>
 <20150714163342.GA8512@deathray>
 <20150714200125.GA26147@amd>
 <20150714201722.GA31356@deathray>
 <20150715194932.GA10967@amd>
 <20150715201048.GA23569@deathray>
 <20150721073127.GA13216@amd>
 <20150721073300.GB13216@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150721073300.GB13216@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Michael Welling <mwelling@ieee.org>, Sebastian Reichel <sre@kernel.org>, Tony Lindgren <tony@atomide.com>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Nishanth Menon <nm@ti.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Tuesday 21 July 2015 09:33:00 Pavel Machek wrote:
> On Tue 2015-07-21 09:31:27, Pavel Machek wrote:
> > On Wed 2015-07-15 15:10:48, Michael Welling wrote:
> > > On Wed, Jul 15, 2015 at 09:49:33PM +0200, Pavel Machek wrote:
> > > > Hi!
> > > >=20
> > > > > > Ok, so:
> > > > > >=20
> > > > > > 4.2-rc1 worked for me, IIRC.
> > > > >=20
> > > > > This does not make sense.
> > > > >=20
> > > > > Nothing has changed in drivers/spi between these versions.
> > > > > Are you sure that 4.2-rc1 worked for you?
> > > >=20
> > > > Tested again: yes, I have 4.2-rc1 booted on the device... based=
 on
> > > > Linus' 1c4c7159ed2468f3ac4ce5a7f08d79663d381a93 . I can push th=
e
> > > > configs and trees to some public place.
> > > >=20
> > >=20
> > > Interesting. Something very strange is happening here.
> > > Send me the links if you push your tree/config to a public repo.=20
> >=20
> > Pushing now. It is on
> > kernel.org:pub/scm/linux/kernel/git/pavel/linux-n900 mini-v4.2
>=20
> Actually, pali, if you have time. I pushed
>=20
> kernel.org:pub/scm/linux/kernel/git/pavel/linux-n900 n900-v4.2
>=20
> too, that one should work. (Modulo gsm and s2ram). If you could
> confirm that, that would be great.
>=20
> Best regards,
> 								Pavel
> 							=09

Ok, I will try it at the weekend... Anyway, can you rebase patches on
top of some linus tree? Because via that git.kernel.org web it is
impossible to list commits or read diff/patches which you applied.

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com
