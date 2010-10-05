From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] ARM: Check for is_smp for tlb_ops and cache_ops
	boardcast
Date: Tue, 5 Oct 2010 23:33:10 +0100
Message-ID: <20101005223310.GA14065@n2100.arm.linux.org.uk>
References: <20100817104414.19061.38999.stgit@baageli.muru.com> <20100906104413.GD20903@n2100.arm.linux.org.uk> <20100906180346.GC20849@atomide.com> <20100908030951.GH22507@atomide.com> <20100908031214.GI22507@atomide.com> <20101005221952.GV3117@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:46992 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754234Ab0JEWeL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Oct 2010 18:34:11 -0400
Content-Disposition: inline
In-Reply-To: <20101005221952.GV3117@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, bryan.wu@canonical.com

On Tue, Oct 05, 2010 at 03:19:52PM -0700, Tony Lindgren wrote:
> * Tony Lindgren <tony@atomide.com> [100907 20:04]:
> > This should not be needed when running on UP systems.
> > 
> > Additionally we will also get an undefined instruction on ARM cores
> > without the extended CPUID registers with CONFIG_SMP_ON_UP.
> > 
> > Also, we can now remove the is_smp() test from mmu.c.
> 
> Just FYI, I've updated this one more time with to use cpus_empty
> instead of !smp_on_up() here as well.

What's the rationale?
