From: Pavel Machek <pavel@ucw.cz>
Subject: Re: n900: kernel cmdline from bootloader in DT mode
Date: Wed, 26 Nov 2014 16:22:00 +0100
Message-ID: <20141126152159.GA26123@amd>
References: <201411261354.33652@pali>
 <20141126132800.GA27610@amd>
 <201411261436.42166@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:60491 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753328AbaKZPWD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 26 Nov 2014 10:22:03 -0500
Content-Disposition: inline
In-Reply-To: <201411261436.42166@pali>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: Sebastian Reichel <sre@ring0.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, aaro.koskinen@iki.fi, freemangordon@abv.bg

On Wed 2014-11-26 14:36:42, Pali Roh=E1r wrote:
> On Wednesday 26 November 2014 14:28:01 Pavel Machek wrote:
> > Hi!
> >=20
> > > for some unknown reasons when I compile kernel for n900 in
> > > DT mode it ignore cmdline passed by bootloader. When I
> > > comment
> > >=20
> > > CONFIG_ARM_APPENDED_DTB=3Dy
> > >=20
> > > then it boots into legacy board mode and cmdline is used
> > > from bootloader.
> > >=20
> > > When is problem?
> >=20
> > It seems to work for me, I'm booting using 0xffff, with
> > attached config.
> > 									Pavel
>=20
> Can you try to set some "root=3Dsomething" into CONFIG_CMDLINE and=20
> then add real "root=3D" param via 0xffff?
>=20
> My problem is that I have specified ubifs mtd root in=20
> CONFIG_CMDLINE and when I set correct root via bootloader (from=20
> 0xffff or flasher-3.5) it is ignored and used only what is=20
> specified in CONFIG_CMDLINE.

CONFIG_ARM_ATAG_DTB_COMPAT=3Dy
CONFIG_ARM_ATAG_DTB_COMPAT_CMDLINE_FROM_BOOTLOADER=3Dy
# CONFIG_ARM_ATAG_DTB_COMPAT_CMDLINE_EXTEND is not set                 =
                           =20
CONFIG_CMDLINE=3D"console=3DttyO2,115200 console=3Dtty"

Um.. Internal commandline should be completely ignored for me.

Do you have CONFIG_ARM_ATAG_DTB_COMPAT_CMDLINE_FROM_BOOTLOADER?

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
