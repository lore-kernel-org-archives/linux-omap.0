From: Tony Lindgren <tony@atomide.com>
Subject: Re: OMAP34xx
Date: Wed, 8 Feb 2012 15:27:36 -0800
Message-ID: <20120208232736.GA16877@atomide.com>
References: <20120205125904.GB11372@n2100.arm.linux.org.uk>
 <20120205172925.GS20333@atomide.com>
 <20120205175809.GF17309@n2100.arm.linux.org.uk>
 <20120205182910.GK1426@atomide.com>
 <87lioegtk9.fsf@ti.com>
 <20120207224937.GA16704@lit.local.igalia.com>
 <8762fijifc.fsf@ti.com>
 <20120208094558.GS1275@n2100.arm.linux.org.uk>
 <20120208195529.GF1426@atomide.com>
 <20120208231056.GC25414@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:23598 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757020Ab2BHX1o (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Feb 2012 18:27:44 -0500
Content-Disposition: inline
In-Reply-To: <20120208231056.GC25414@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Kevin Hilman <khilman@ti.com>, =?utf-8?B?VsOtY3RvciBNLiBKw6FxdWV6IEwu?= <vjaquez@igalia.com>, linux-omap@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>

* Russell King - ARM Linux <linux@arm.linux.org.uk> [120208 14:39]:
> On Wed, Feb 08, 2012 at 11:55:30AM -0800, Tony Lindgren wrote:
> > * Russell King - ARM Linux <linux@arm.linux.org.uk> [120208 01:15]:
> > > On Tue, Feb 07, 2012 at 04:08:23PM -0800, Kevin Hilman wrote:
> > > > V=C3=ADctor M. J=C3=A1quez L. <vjaquez@igalia.com> writes:
> > > > > If it helps, I observed the same issue in a beagleboard rev B=
6, with
> > > > > v3.3-rc2
> > > >=20
> > > > Great, thanks.  Can you share your ~/.config?
> > >=20
> > > If it helps, ARM Kautobuild V2 is up and running (assuming I don'=
t break
> > > the scripts again) at:
> > >=20
> > >   http://www.arm.linux.org.uk/developer/build/
> > >=20
> > > from where the build configs I use (and the exact ones used in th=
ose
> > > compiles) are available.  These aren't configs in arch/arm/config=
s.
> >=20
> > Great. How do you generate the allnoconfig there?
> >=20
> > I tried:
> >=20
> > ARCH=3Darm make KCONFIG_ALLCONFIG=3Dmy_config allnoconfig
> >=20
> > But it really does a total ARM noconfig that currently has no chanc=
e
> > in building currently?
>=20
> Each of the builds have a seed configuration, even allnoconfig.
>=20
> The seed configuration for the oldconfig's are a 'make savedefconfig'
> version of the build config I've been using.
>=20
> For the allnoconfig, there's a minimal set of configuration symbols
> to set - mainly to set the target platform but with CONFIG_MMU=3Dy.
>=20
> So, for the LDP, it's:
>=20
> CONFIG_MMU=3Dy
> CONFIG_ARCH_OMAP=3Dy
> CONFIG_ARCH_OMAP2PLUS=3Dy
> CONFIG_ARCH_OMAP3=3Dy
> CONFIG_SOC_OMAP3430=3Dy
> CONFIG_MACH_OMAP_LDP=3Dy
>=20
> and 4430SDP:
>=20
> CONFIG_MMU=3Dy
> CONFIG_ARCH_OMAP=3Dy
> CONFIG_ARCH_OMAP2PLUS=3Dy
> CONFIG_ARCH_OMAP4=3Dy
> CONFIG_MACH_OMAP_4430SDP=3Dy

OK thanks, so no KCONFIG_ALLCONFIG type magic there.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
