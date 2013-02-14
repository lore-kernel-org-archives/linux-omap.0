From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: Build error: OMAP randconfig / mvebu
Date: Thu, 14 Feb 2013 11:08:03 +0000
Message-ID: <20130214110803.GP17852@n2100.arm.linux.org.uk>
References: <20130208100813.GN17833@n2100.arm.linux.org.uk> <2213733.Wbjy3dFgom@wuerfel> <5114DC44.7000107@free-electrons.com> <4351524.MQWtq16mqg@wuerfel> <20130214100926.GO17852@n2100.arm.linux.org.uk> <20130214110307.GA3059@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:42882 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933839Ab3BNLIV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 14 Feb 2013 06:08:21 -0500
Content-Disposition: inline
In-Reply-To: <20130214110307.GA3059@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>, arm@kernel.org, Gregory CLEMENT <gregory.clement@free-electrons.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Thu, Feb 14, 2013 at 08:03:08AM -0300, Ezequiel Garcia wrote:
> On Thu, Feb 14, 2013 at 10:09:26AM +0000, Russell King - ARM Linux wrote:
> > On Fri, Feb 08, 2013 at 02:33:29PM +0100, Arnd Bergmann wrote:
> > > On Friday 08 February 2013 12:06:44 Gregory CLEMENT wrote:
> > > > 
> > > > I don't know what to do here, there is no point to build any of the files
> > > > in mach-mvebu if no SoCs are selected. So either we force to have at least
> > > > one SoCS selected if ARCH_MVEBU is selected, or we unselect  ARCH_MVEB if
> > > > no SoCs are selected.
> > > 
> > > The latter does not work, because that would introduce a circular
> > > dependency in Kconfig.
> > > 
> > > I suppose rearranging the mvebu Makefile like this would do.
> > > 
> > > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > 
> > This error is still present in arm-soc.  We're getting close to the next
> > merge window, so either something needs to be dropped from arm-soc, or
> > this needs to get fixed.
> > 
> 
> Can you point me to where can I get the config your building with?

It's all publically available via my website.
