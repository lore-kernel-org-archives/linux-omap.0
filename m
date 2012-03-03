From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: OMAP totally fucked?
Date: Sat, 3 Mar 2012 20:52:00 +0000
Message-ID: <20120303205200.GC17710@n2100.arm.linux.org.uk>
References: <20120303154650.GA16132@n2100.arm.linux.org.uk> <20120303180428.GA10293@atomide.com> <20120303183225.GA17710@n2100.arm.linux.org.uk> <20120303190140.GB19248@atomide.com> <20120303192839.GB17710@n2100.arm.linux.org.uk> <20120303200123.GB10293@atomide.com> <20120303202810.GC10293@atomide.com> <20120303203448.GD10293@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:47457 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751104Ab2CCUwM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 3 Mar 2012 15:52:12 -0500
Content-Disposition: inline
In-Reply-To: <20120303203448.GD10293@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, linux-omap@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>

On Sat, Mar 03, 2012 at 12:34:48PM -0800, Tony Lindgren wrote:
> * Tony Lindgren <tony@atomide.com> [120303 11:56]:
> > * Tony Lindgren <tony@atomide.com> [120303 11:29]:
> > > * Russell King - ARM Linux <linux@arm.linux.org.uk> [120303 10:57]:
> > > > 
> > > > Even with the full config, making oldconfig I get:
> > > > 
> > > > OMAP2420 support (SOC_OMAP2420) [Y/n] (NEW) 
> > > > OMAP2430 support (SOC_OMAP2430) [Y/n] (NEW) 
> > > > OMAP3430 support (SOC_OMAP3430) [Y/n] (NEW) 
> > > > TI81XX support (SOC_OMAPTI81XX) [Y/n] (NEW) 
> > > > AM33XX support (SOC_OMAPAM33XX) [Y/n] (NEW) 
> > > > OMAP44XX support (SOC_OMAP44XX) [Y/n] (NEW) 
> > > > 
> > > > May I remind you of this mail from Linus:
> > > > 
> > > > 	https://lkml.org/lkml/2012/1/6/354
> > > > 
> > > > So really this is a rather horrid mess.
> > > 
> > > Hmm yes. Sounds like we need to remove the defaults and instead
> > > add them to omap2plus_defconfig.
> > > 
> > > I'll do a patch to fix that.
> > 
> > How about the following patch after we revert commit 72b026a4?
> > 
> > That still leaves the randconfig not necessarily selecting
> > any of ARCH_OMAP2/3/4 issue, but that can be dealt separately
> > later on.
> 
> Grr, need to look at it more.. Now it leaves out ARCH_OMAP2/3/4
> when doing a make oldconfig with some existing .config file.

There's also something else wrong:

*
* OMAP Core Type
*
OMAP2420 support (SOC_OMAP2420) [Y/n] (NEW) n
OMAP2430 support (SOC_OMAP2430) [Y/n] (NEW) n
OMAP3430 support (SOC_OMAP3430) [Y/n] (NEW) n
TI81XX support (SOC_OMAPTI81XX) [Y/n] (NEW) n
AM33XX support (SOC_OMAPAM33XX) [Y/n] (NEW) n
OMAP44XX support (SOC_OMAP44XX) [Y/n] (NEW) n
*
* OMAP Board Type
*
Generic OMAP2+ board (MACH_OMAP_GENERIC) [Y/?] y
OMAP3 debugging peripherals (OMAP3_EMU) [N/y/?] (NEW) 
Enable SDRC AC timing register changes (OMAP3_SDRC_AC_TIMING) [N/y/?] (NEW) 

Shouldn't the last two options depend on OMAP3 stuff?

And why do we have:

config ARCH_OMAP2PLUS
	select USE_OF

Do we really _need_ OF, or is it just irqdomain that's required?
