From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: Check for is_smp for tlb_ops and cache_ops
 boardcast
Date: Wed, 6 Oct 2010 07:44:14 -0700
Message-ID: <20101006144414.GA2913@atomide.com>
References: <20100817104414.19061.38999.stgit@baageli.muru.com>
 <20100906104413.GD20903@n2100.arm.linux.org.uk>
 <20100906180346.GC20849@atomide.com>
 <20100908030951.GH22507@atomide.com>
 <20100908031214.GI22507@atomide.com>
 <20101005221952.GV3117@atomide.com>
 <20101005223310.GA14065@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:63360 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932228Ab0JFOoh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 6 Oct 2010 10:44:37 -0400
Content-Disposition: inline
In-Reply-To: <20101005223310.GA14065@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, bryan.wu@canonical.com

* Russell King - ARM Linux <linux@arm.linux.org.uk> [101005 15:24]:
> On Tue, Oct 05, 2010 at 03:19:52PM -0700, Tony Lindgren wrote:
> > * Tony Lindgren <tony@atomide.com> [100907 20:04]:
> > > This should not be needed when running on UP systems.
> > > 
> > > Additionally we will also get an undefined instruction on ARM cores
> > > without the extended CPUID registers with CONFIG_SMP_ON_UP.
> > > 
> > > Also, we can now remove the is_smp() test from mmu.c.
> > 
> > Just FYI, I've updated this one more time with to use cpus_empty
> > instead of !smp_on_up() here as well.
> 
> What's the rationale?

With CPU hotplug if the other SMP cores are unplugged for PM or
other reasons, no need to do the broadcast.

Regards,

Tony
