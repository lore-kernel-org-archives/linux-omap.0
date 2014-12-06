From: Pavel Machek <pavel@ucw.cz>
Subject: Re: N900: fixing MMC at boot
Date: Sat, 6 Dec 2014 19:04:29 +0100
Message-ID: <20141206180429.GA312@amd>
References: <20141206173526.GA7964@amd>
 <201412061840.16157@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <201412061840.16157@pali>
Sender: linux-kernel-owner@vger.kernel.org
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: sre@debian.org, sre@ring0.de, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, freemangordon@abv.bg
List-Id: linux-omap@vger.kernel.org

On Sat 2014-12-06 18:40:16, Pali Roh=E1r wrote:
> On Saturday 06 December 2014 18:35:27 Pavel Machek wrote:
> > Hi!
> >=20
> > For a long time, MMC was not working during boot... (making
> > the box unusable without nfsroot). It seems problem is in the
> > regulators, because with diff below, I was able to mount root
> > on SD card for a first time ... in a long time.
> >=20
>=20
> Hi, do you mean external SD card or internal eMMC (MyDocs)?

I mean u-SD card. But it is strange. I reverted the patch now, and it
still works. Not sure why or what I've done differently.

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses=
/blog.html
