From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [RFC PATCH] Consolidate SRAM support
Date: Fri, 15 Apr 2011 16:26:43 +0100
Message-ID: <20110415152643.GC4423@n2100.arm.linux.org.uk>
References: <20110415130607.GM1611@n2100.arm.linux.org.uk> <4DA84AAB.60601@gmail.com> <201104151640.01040.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:47815 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752732Ab1DOP1O (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 15 Apr 2011 11:27:14 -0400
Content-Disposition: inline
In-Reply-To: <201104151640.01040.arnd@arndb.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, Rob Herring <robherring2@gmail.com>, Kevin Hilman <khilman@ti.com>, davinci-linux-open-source@linux.davincidsp.com, Tony Lindgren <tony@atomide.com>, Sekhar Nori <nsekhar@ti.com>, linux-omap@vger.kernel.org

On Fri, Apr 15, 2011 at 04:40:00PM +0200, Arnd Bergmann wrote:
> On Friday 15 April 2011 15:39:55 Rob Herring wrote:
> 
> > On 04/15/2011 08:06 AM, Russell King - ARM Linux wrote:
> > > This is work in progress.
> > >
> > > We have two SoCs using SRAM, both with their own allocation systems,
> > > and both with their own ways of copying functions into the SRAM.
> > 
> > It's more than that. Several i.MX chips use plat-mxc/iram_alloc.c.
> 
> There are also non-ARM systems doing something like that,
> arch/blackfin/mm/sram-alloc.c comes to mind. On powerpc, the
> ppc7410 also has this feature in hardware, but I believe it was
> never supported in mainline Linux.

Yes, but there's some horrible bits out there.  PPC is one of them
which looks like it doesn't lend itself to consolidating with this
kind of implementation.

> How about putting sram-pool.c into the top-level mm/ directory
> and sram-pool.h into include/linux? They seem to be completely
> generic to me, aside from the dependency on asm/fncpy.h which
> should probably remain arch specific.

I've thought about lib - but first lets see whether other architectures
want to use it first.  I've asked the sh folk off-list about this and
waiting for a reply.

Blackfin and PPC look horrible to sort out though, so they can come at
a later date if they so wish.
