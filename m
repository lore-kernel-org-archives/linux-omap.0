From: Tony Lindgren <tony@atomide.com>
Subject: Re: OMAP totally fucked?
Date: Sat, 3 Mar 2012 11:01:40 -0800
Message-ID: <20120303190140.GB19248@atomide.com>
References: <20120303154650.GA16132@n2100.arm.linux.org.uk>
 <20120303180428.GA10293@atomide.com>
 <20120303183225.GA17710@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:23236 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751940Ab2CCTBp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 3 Mar 2012 14:01:45 -0500
Content-Disposition: inline
In-Reply-To: <20120303183225.GA17710@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, linux-omap@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>

* Russell King - ARM Linux <linux@arm.linux.org.uk> [120303 10:00]:
> On Sat, Mar 03, 2012 at 10:04:29AM -0800, Tony Lindgren wrote:
> > Well 85631d2 builds fine, looks like now some more includes of
> > plat/hardware.h are now needed.Have not yet tracked down which
> > commit triggers the build errors. Eventually those should become
> > local headers too..
> 
> It looks like this has happened because you've made stuff far too reliant
> on DT.  You rely on asm/irq.h in asm/prom.h.  I've got rid of that, so
> because you're missing lots of required includes in your .c files,
> things are failing.

OK, well that's easy to fix.
 
> And... it seems my config has started to enable all SoCs and boards for
> some idiotic reason... I guess this is because you're trying to make
> 'randconfig' just work without seeding it properly?

Hmm that sounds like a bug. A big chunk mach-omap2 randconfigs
were failing because none of ARCH_OMAP2/3/4 were selected.

Sounds like something goes wrong now with make defconfig with
old config files, need to look into it.

Regards,

Tony
