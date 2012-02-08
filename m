From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: OMAP34xx
Date: Wed, 8 Feb 2012 23:10:56 +0000
Message-ID: <20120208231056.GC25414@n2100.arm.linux.org.uk>
References: <20120205012556.GG1426@atomide.com> <20120205125904.GB11372@n2100.arm.linux.org.uk> <20120205172925.GS20333@atomide.com> <20120205175809.GF17309@n2100.arm.linux.org.uk> <20120205182910.GK1426@atomide.com> <87lioegtk9.fsf@ti.com> <20120207224937.GA16704@lit.local.igalia.com> <8762fijifc.fsf@ti.com> <20120208094558.GS1275@n2100.arm.linux.org.uk> <20120208195529.GF1426@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:49500 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757524Ab2BHXLg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Feb 2012 18:11:36 -0500
Content-Disposition: inline
In-Reply-To: <20120208195529.GF1426@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Kevin Hilman <khilman@ti.com>, =?iso-8859-1?Q?V=EDctor_M=2E_J=E1quez_L=2E?= <vjaquez@igalia.com>, linux-omap@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>

On Wed, Feb 08, 2012 at 11:55:30AM -0800, Tony Lindgren wrote:
> * Russell King - ARM Linux <linux@arm.linux.org.uk> [120208 01:15]:
> > On Tue, Feb 07, 2012 at 04:08:23PM -0800, Kevin Hilman wrote:
> > > V=EDctor M. J=E1quez L. <vjaquez@igalia.com> writes:
> > > > If it helps, I observed the same issue in a beagleboard rev B6,=
 with
> > > > v3.3-rc2
> > >=20
> > > Great, thanks.  Can you share your ~/.config?
> >=20
> > If it helps, ARM Kautobuild V2 is up and running (assuming I don't =
break
> > the scripts again) at:
> >=20
> >   http://www.arm.linux.org.uk/developer/build/
> >=20
> > from where the build configs I use (and the exact ones used in thos=
e
> > compiles) are available.  These aren't configs in arch/arm/configs.
>=20
> Great. How do you generate the allnoconfig there?
>=20
> I tried:
>=20
> ARCH=3Darm make KCONFIG_ALLCONFIG=3Dmy_config allnoconfig
>=20
> But it really does a total ARM noconfig that currently has no chance
> in building currently?

Each of the builds have a seed configuration, even allnoconfig.

The seed configuration for the oldconfig's are a 'make savedefconfig'
version of the build config I've been using.

=46or the allnoconfig, there's a minimal set of configuration symbols
to set - mainly to set the target platform but with CONFIG_MMU=3Dy.

So, for the LDP, it's:

CONFIG_MMU=3Dy
CONFIG_ARCH_OMAP=3Dy
CONFIG_ARCH_OMAP2PLUS=3Dy
CONFIG_ARCH_OMAP3=3Dy
CONFIG_SOC_OMAP3430=3Dy
CONFIG_MACH_OMAP_LDP=3Dy

and 4430SDP:

CONFIG_MMU=3Dy
CONFIG_ARCH_OMAP=3Dy
CONFIG_ARCH_OMAP2PLUS=3Dy
CONFIG_ARCH_OMAP4=3Dy
CONFIG_MACH_OMAP_4430SDP=3Dy
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
