From: Pavel Machek <pavel@ucw.cz>
Subject: Re: runtime check for omap-aes bus access permission (was: Re:
 3.13-rc3 (commit 7ce93f3) breaks Nokia N900 DT boot)
Date: Wed, 11 Feb 2015 21:43:42 +0100
Message-ID: <20150211204342.GE29636@amd>
References: <20131206213613.GA19648@earth.universe>
 <201501312009.58483@pali>
 <CAALWOA9-wXZCY8QVZmZR7vymEQYupyOm=uJD8bJf-cC7uEfi0A@mail.gmail.com>
 <201502010956.28662@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:53344 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752452AbbBKUnp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Feb 2015 15:43:45 -0500
Content-Disposition: inline
In-Reply-To: <201502010956.28662@pali>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: Matthijs van Duin <matthijsvanduin@gmail.com>, Joel Fernandes <joelf@ti.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, Aaro Koskinen <aaro.koskinen@iki.fi>, Nishanth Menon <nm@ti.com>, Sebastian Reichel <sre@ring0.de>

Hi!

On Sun 2015-02-01 09:56:28, Pali Roh=E1r wrote:
> On Sunday 01 February 2015 02:36:06 Matthijs van Duin wrote:
> > On 31 January 2015 at 20:06, Pali Roh=E1r <pali.rohar@gmail.com>=20
> > wrote:
> > > I have configured two testing N900 devices. One with signed
> > > bootloader which enable omap aes support and one device with
> > > signed bootloader which does not enable omap aes support.
> >=20
> > I'm probably missing some context here, but why not just use
> > the one with aes support? Alternatively, one may argue that
> > it's the bootloader's job to provide the kernel with an
> > accurate device tree. (Though one may equally well argue that
> > it would be nice to avoid having to customize the device tree
> > for every feature-flavor of a processor, especially if this
> > depends on how it's initialized.)
> >=20
>=20
> Nokia X-Loader is closed source and signed. So we cannot modify=20
> it. And it is responsible for configuring L3/L4 firewall.
>=20
> Year ago it was possible to find on internet signed X-Loader for=20
> N900 which enable omap aes support (for testing purpose together=20
> with open source linux kernel modules), but it is unofficial and=20
> I think there only too few people who flashed it into N900 nand.=20
> If somebody needs binaries I have backup all of them.
>=20
> More info about that aes enabled X-Loader:
> http://maemo.org/community/maemo-developers/n900_aes_and_sha1-md5_hw_=
acceleration_drivers/
>=20
> Majority of users use only official X-Loader which does not=20
> enable aes support so we cannot enable kernel modules (cause=20
> crashes). And also we cannot force users to flash some unofficial=20
> binary into their device...

BTW... it would be interesting to know... are you doing some
heavy crypto processing on N900? Are the accelerated drivers faster
than non-accelerated ones? Because the link above says they are
slower...

# Eric Wheeler
# ...
# Hey guys, I have omap-aes compiled for my kernel and appears to be
# working.
#=20
# I do not understand why non-accelerated software-crypto is faster tha=
n
# the omap-aes hardware acceleration:
#=20
# mmcblk0 onboard 32GB: read=3D21.76MB/s write=3D12.97MB/s
# aes_generic crypto: read=3D 8.47 write=3D 5.54
# omap-aes hw crypto: read=3D 6.31 write=3D 5.45
#=20
# mmcblk1 uSD 16GB Class 10: read=3D16.05MB/s write=3D16.47MB/s
# aes_generic crypto: read=3D 7.96 write=3D 7.43
# omap-aes hw crypto: read=3D 6.67 write=3D 7.18

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses=
/blog.html
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
