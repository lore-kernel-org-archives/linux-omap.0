From: Tony Lindgren <tony@atomide.com>
Subject: Re: OMAP totally fucked?
Date: Tue, 6 Mar 2012 13:23:10 -0800
Message-ID: <20120306212310.GX12083@atomide.com>
References: <20120303154650.GA16132@n2100.arm.linux.org.uk>
 <20120303180428.GA10293@atomide.com>
 <201203031829.06992.arnd@arndb.de>
 <20120303210521.GE10293@atomide.com>
 <20120304155909.GA14466@n2100.arm.linux.org.uk>
 <878vjdfpub.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:22425 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755606Ab2CFVXR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Mar 2012 16:23:17 -0500
Content-Disposition: inline
In-Reply-To: <878vjdfpub.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Peter Ujfalusi <peter.ujfalusi@ti.com>, linux-omap@vger.kernel.org, Olof Johansson <olof@lixom.net>

* Kevin Hilman <khilman@ti.com> [120306 11:43]:
> Russell King - ARM Linux <linux@arm.linux.org.uk> writes:
> >
> > arch/arm/mach-omap2/io.c:51: warning: 'omap24xx_io_desc' defined but not used
> > arch/arm/mach-omap2/omap-wakeupgen.c:181: warning: 'wakeupgen_irqmask_all' defined but not used
> 
> And here's a fix for the wakeupgen one.

Thanks, applying into fixes-non-critical-part2. Also posted
a fix for the omap24xx_io_desc warning.

Regards,

Tony
