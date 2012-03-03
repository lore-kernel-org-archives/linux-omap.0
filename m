From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: OMAP totally fucked?
Date: Sat, 3 Mar 2012 18:32:25 +0000
Message-ID: <20120303183225.GA17710@n2100.arm.linux.org.uk>
References: <20120303154650.GA16132@n2100.arm.linux.org.uk> <20120303180428.GA10293@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:57711 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751790Ab2CCSch (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 3 Mar 2012 13:32:37 -0500
Content-Disposition: inline
In-Reply-To: <20120303180428.GA10293@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, linux-omap@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>

On Sat, Mar 03, 2012 at 10:04:29AM -0800, Tony Lindgren wrote:
> Well 85631d2 builds fine, looks like now some more includes of
> plat/hardware.h are now needed.Have not yet tracked down which
> commit triggers the build errors. Eventually those should become
> local headers too..

It looks like this has happened because you've made stuff far too reliant
on DT.  You rely on asm/irq.h in asm/prom.h.  I've got rid of that, so
because you're missing lots of required includes in your .c files,
things are failing.

And... it seems my config has started to enable all SoCs and boards for
some idiotic reason... I guess this is because you're trying to make
'randconfig' just work without seeding it properly?
