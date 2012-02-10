From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: OMAP34xx
Date: Fri, 10 Feb 2012 11:03:12 +0000
Message-ID: <20120210110312.GA13163@n2100.arm.linux.org.uk>
References: <20120204203453.GD17309@n2100.arm.linux.org.uk> <20120205012556.GG1426@atomide.com> <20120205125904.GB11372@n2100.arm.linux.org.uk> <20120205172925.GS20333@atomide.com> <20120205175809.GF17309@n2100.arm.linux.org.uk> <20120205182910.GK1426@atomide.com> <87lioegtk9.fsf@ti.com> <20120207224937.GA16704@lit.local.igalia.com> <8762fijifc.fsf@ti.com> <20120208094558.GS1275@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:45295 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758670Ab2BJLD5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 10 Feb 2012 06:03:57 -0500
Content-Disposition: inline
In-Reply-To: <20120208094558.GS1275@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: =?iso-8859-1?Q?V=EDctor_M=2E_J=E1quez_L=2E?= <vjaquez@igalia.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>

On Wed, Feb 08, 2012 at 09:45:58AM +0000, Russell King - ARM Linux wrot=
e:
> On Tue, Feb 07, 2012 at 04:08:23PM -0800, Kevin Hilman wrote:
> > V=EDctor M. J=E1quez L. <vjaquez@igalia.com> writes:
> > > If it helps, I observed the same issue in a beagleboard rev B6, w=
ith
> > > v3.3-rc2
> >=20
> > Great, thanks.  Can you share your ~/.config?
>=20
> If it helps, ARM Kautobuild V2 is up and running (assuming I don't br=
eak
> the scripts again) at:
>=20
>   http://www.arm.linux.org.uk/developer/build/
>=20
> from where the build configs I use (and the exact ones used in those
> compiles) are available.  These aren't configs in arch/arm/configs.

=46YI, it now has one boot log for the 4430SDP, which is the only platf=
orm
I've enabled so far, and it requires me to manually power up the board
(so it's not going to happen for every build, which means the boot
results will only be up there for a day until I can sort out a more
automatic solution.)

It's not too good at detecting boots that 'pass' rather than 'fail' - a=
t
the moment, it assumes it passed if it gets to the end of its script, s=
o
this needs to be found from the boot log.  Currently, that means gettin=
g
a login prompt.

If anyone wants to develop a pcre regexp to detect oopses, warnings,
panics and other failures - my current for the page generation are:

errors: /^.*?\b(error|can't register|fail(ed)?)\b.*?$/mi
warnings: /^.*?\bwarning\b.*?$/mi

note that they operate on multi-line strings (hence the 'm' suffix and
the use of non-greedy "*?" as opposed to the greedy "*").  Install pcre
and see pcrepattern(3) for more information on pcre regexps if you're
unfamiliar with these.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
