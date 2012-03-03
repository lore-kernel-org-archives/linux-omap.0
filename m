From: Tony Lindgren <tony@atomide.com>
Subject: Re: OMAP totally fucked?
Date: Sat, 3 Mar 2012 12:34:48 -0800
Message-ID: <20120303203448.GD10293@atomide.com>
References: <20120303154650.GA16132@n2100.arm.linux.org.uk>
 <20120303180428.GA10293@atomide.com>
 <20120303183225.GA17710@n2100.arm.linux.org.uk>
 <20120303190140.GB19248@atomide.com>
 <20120303192839.GB17710@n2100.arm.linux.org.uk>
 <20120303200123.GB10293@atomide.com>
 <20120303202810.GC10293@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:20615 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751089Ab2CCUew (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 3 Mar 2012 15:34:52 -0500
Content-Disposition: inline
In-Reply-To: <20120303202810.GC10293@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, linux-omap@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>

* Tony Lindgren <tony@atomide.com> [120303 11:56]:
> * Tony Lindgren <tony@atomide.com> [120303 11:29]:
> > * Russell King - ARM Linux <linux@arm.linux.org.uk> [120303 10:57]:
> > > 
> > > Even with the full config, making oldconfig I get:
> > > 
> > > OMAP2420 support (SOC_OMAP2420) [Y/n] (NEW) 
> > > OMAP2430 support (SOC_OMAP2430) [Y/n] (NEW) 
> > > OMAP3430 support (SOC_OMAP3430) [Y/n] (NEW) 
> > > TI81XX support (SOC_OMAPTI81XX) [Y/n] (NEW) 
> > > AM33XX support (SOC_OMAPAM33XX) [Y/n] (NEW) 
> > > OMAP44XX support (SOC_OMAP44XX) [Y/n] (NEW) 
> > > 
> > > May I remind you of this mail from Linus:
> > > 
> > > 	https://lkml.org/lkml/2012/1/6/354
> > > 
> > > So really this is a rather horrid mess.
> > 
> > Hmm yes. Sounds like we need to remove the defaults and instead
> > add them to omap2plus_defconfig.
> > 
> > I'll do a patch to fix that.
> 
> How about the following patch after we revert commit 72b026a4?
> 
> That still leaves the randconfig not necessarily selecting
> any of ARCH_OMAP2/3/4 issue, but that can be dealt separately
> later on.

Grr, need to look at it more.. Now it leaves out ARCH_OMAP2/3/4
when doing a make oldconfig with some existing .config file.

Regards,

Tony
