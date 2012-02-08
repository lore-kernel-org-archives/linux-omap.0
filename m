From: Tony Lindgren <tony@atomide.com>
Subject: Re: OMAP34xx
Date: Wed, 8 Feb 2012 11:55:30 -0800
Message-ID: <20120208195529.GF1426@atomide.com>
References: <20120204203453.GD17309@n2100.arm.linux.org.uk>
 <20120205012556.GG1426@atomide.com>
 <20120205125904.GB11372@n2100.arm.linux.org.uk>
 <20120205172925.GS20333@atomide.com>
 <20120205175809.GF17309@n2100.arm.linux.org.uk>
 <20120205182910.GK1426@atomide.com>
 <87lioegtk9.fsf@ti.com>
 <20120207224937.GA16704@lit.local.igalia.com>
 <8762fijifc.fsf@ti.com>
 <20120208094558.GS1275@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:61382 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757247Ab2BHTzg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Feb 2012 14:55:36 -0500
Content-Disposition: inline
In-Reply-To: <20120208094558.GS1275@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Kevin Hilman <khilman@ti.com>, =?utf-8?B?VsOtY3RvciBNLiBKw6FxdWV6IEwu?= <vjaquez@igalia.com>, linux-omap@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>

* Russell King - ARM Linux <linux@arm.linux.org.uk> [120208 01:15]:
> On Tue, Feb 07, 2012 at 04:08:23PM -0800, Kevin Hilman wrote:
> > V=C3=ADctor M. J=C3=A1quez L. <vjaquez@igalia.com> writes:
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

Great. How do you generate the allnoconfig there?

I tried:

ARCH=3Darm make KCONFIG_ALLCONFIG=3Dmy_config allnoconfig

But it really does a total ARM noconfig that currently has no chance
in building currently?

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
