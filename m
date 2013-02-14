From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: Re: Build error: OMAP randconfig / mvebu
Date: Thu, 14 Feb 2013 08:03:08 -0300
Message-ID: <20130214110307.GA3059@localhost>
References: <20130208100813.GN17833@n2100.arm.linux.org.uk>
 <2213733.Wbjy3dFgom@wuerfel>
 <5114DC44.7000107@free-electrons.com>
 <4351524.MQWtq16mqg@wuerfel>
 <20130214100926.GO17852@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:54416 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756916Ab3BNLD1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 14 Feb 2013 06:03:27 -0500
Content-Disposition: inline
In-Reply-To: <20130214100926.GO17852@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Arnd Bergmann <arnd@arndb.de>, Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>, arm@kernel.org, Gregory CLEMENT <gregory.clement@free-electrons.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Thu, Feb 14, 2013 at 10:09:26AM +0000, Russell King - ARM Linux wrot=
e:
> On Fri, Feb 08, 2013 at 02:33:29PM +0100, Arnd Bergmann wrote:
> > On Friday 08 February 2013 12:06:44 Gregory CLEMENT wrote:
> > >=20
> > > I don't know what to do here, there is no point to build any of t=
he files
> > > in mach-mvebu if no SoCs are selected. So either we force to have=
 at least
> > > one SoCS selected if ARCH_MVEBU is selected, or we unselect  ARCH=
_MVEB if
> > > no SoCs are selected.
> >=20
> > The latter does not work, because that would introduce a circular
> > dependency in Kconfig.
> >=20
> > I suppose rearranging the mvebu Makefile like this would do.
> >=20
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>=20
> This error is still present in arm-soc.  We're getting close to the n=
ext
> merge window, so either something needs to be dropped from arm-soc, o=
r
> this needs to get fixed.
>=20

Can you point me to where can I get the config your building with?

Thanks,

--=20
Ezequiel Garc=C3=ADa, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
