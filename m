From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: OMAP34xx
Date: Wed, 8 Feb 2012 09:45:58 +0000
Message-ID: <20120208094558.GS1275@n2100.arm.linux.org.uk>
References: <20120204190109.GL20333@atomide.com> <20120204203453.GD17309@n2100.arm.linux.org.uk> <20120205012556.GG1426@atomide.com> <20120205125904.GB11372@n2100.arm.linux.org.uk> <20120205172925.GS20333@atomide.com> <20120205175809.GF17309@n2100.arm.linux.org.uk> <20120205182910.GK1426@atomide.com> <87lioegtk9.fsf@ti.com> <20120207224937.GA16704@lit.local.igalia.com> <8762fijifc.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:57997 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751362Ab2BHJqd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Feb 2012 04:46:33 -0500
Content-Disposition: inline
In-Reply-To: <8762fijifc.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: =?iso-8859-1?Q?V=EDctor_M=2E_J=E1quez_L=2E?= <vjaquez@igalia.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>

On Tue, Feb 07, 2012 at 04:08:23PM -0800, Kevin Hilman wrote:
> V=EDctor M. J=E1quez L. <vjaquez@igalia.com> writes:
> > If it helps, I observed the same issue in a beagleboard rev B6, wit=
h
> > v3.3-rc2
>=20
> Great, thanks.  Can you share your ~/.config?

If it helps, ARM Kautobuild V2 is up and running (assuming I don't brea=
k
the scripts again) at:

  http://www.arm.linux.org.uk/developer/build/

from where the build configs I use (and the exact ones used in those
compiles) are available.  These aren't configs in arch/arm/configs.

The OMAP oldconfig builds represent my test configs that I try to boot =
on
my boards.  This version of Kautobuild not only builds kernels, but it
also packages the built image and modules into a tar file.  Everything
else is discarded.

As of yesterday evening, it also transfers the built image to a TFTP
server ready for boards to fetch for boot testing.

The base kernel which is currently being used for this is whatever stat=
e
my working tree is in when it runs, so it's not _that_ useful externall=
y
at the moment.

Currently, the builds run on my working laptop, targetted at 2am each
night local time (though they're a little more sporadic at the moment.)
The downside to them running on the laptop is that when I take the
laptop away, they won't run.


I also have a program which monitors a tty port, detects the initial
booting of a board, and can talk to the boot loader and kernel to instr=
uct
them to do various things (like telling uboot to load one of the tftp'd
kernels.)

However, there's a few bits missing from being able to finish this syst=
em
off:

(a) properly detecting on machines monitoring boards when a new kernel =
is
    ready for testing.
(b) sorting out how to reliably reboot the various boards in a safe man=
ner
(c) working out where and how to connect all these boards in a safe man=
ner

=46or most boards, switching the mains to their individual power suppli=
es
will work.  For something like the OMAP3430 LDP, it's complicated by it=
s
built-in battery which has to be connected for it to power up at all.
It can't be left plugged in because it drains the battery even with an
external USB charger.

As the OMAP4430 only provides USB, practically it's going to have to be
left out of the automatic stuff because I don't have a machine which it
could be connected to which wouldn't also be part of the boot test farm=
=2E

In other words, the OMAP platforms I have will only be manually boot
tested for the forseeable future.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
