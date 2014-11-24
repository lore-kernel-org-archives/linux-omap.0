From: Pavel Machek <pavel@ucw.cz>
Subject: Re: v3.18-rc1: n900 battery discharged down to 2.97V
Date: Mon, 24 Nov 2014 20:06:27 +0100
Message-ID: <20141124190627.GA7816@amd>
References: <20141124183130.GA2927@amd>
 <201411241958.34578@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <201411241958.34578@pali>
Sender: linux-kernel-owner@vger.kernel.org
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: sre@debian.org, sre@ring0.de, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, freemangordon@abv.bg
List-Id: linux-omap@vger.kernel.org

On Mon 2014-11-24 19:58:34, Pali Roh=E1r wrote:
> On Monday 24 November 2014 19:31:30 Pavel Machek wrote:
> > Hi!
> >=20
> > I left the machine on usb-networking for extended period of
> > time. Unfortunately, Xfce screensaver kept screen busy, and
> > kernel failed to kill the machine.
> >=20
> > At the end, hardware protections worked (I guess), but result
> > is battery discharged down to 2.97V.
>=20
> So you need some program which will monitor battery status and=20
> when battery status is empty it should turn of device.

And that program should be part of the kernel, because kernel should
protect hardware from damage. (And it should be perfectly ok to boot
into init=3D/bin/bash...)

Anyway, this was just friendly warning, so that you don't
unneccessarily damage your battery...
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses=
/blog.html
