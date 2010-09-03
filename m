From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 1/6] ARM: Add inline function smp_cpu() for early init
	testing
Date: Fri, 3 Sep 2010 10:02:41 +0100
Message-ID: <20100903090241.GI26319@n2100.arm.linux.org.uk>
References: <20100830225527.GC11597@atomide.com> <20100902133637.GJ26319@n2100.arm.linux.org.uk> <20100902161659.GJ11597@atomide.com> <20100902161846.GK11597@atomide.com> <20100902170830.GW26319@n2100.arm.linux.org.uk> <20100902174244.GU11597@atomide.com> <20100902192659.GW11597@atomide.com> <20100903000817.GG11597@atomide.com> <20100903022201.GI11597@atomide.com> <004601cb4b46$2bf3c120$83db4360$@deacon@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:51711 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752752Ab0ICJCz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Sep 2010 05:02:55 -0400
Content-Disposition: inline
In-Reply-To: <004601cb4b46$2bf3c120$83db4360$@deacon@arm.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>
Cc: 'Tony Lindgren' <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Bryan Wu <bryan.wu@canonical.com>

On Fri, Sep 03, 2010 at 09:58:23AM +0100, Will Deacon wrote:
> Your patches are turning up as attachments here, so I can't comment
> inline. The only problem I can see is for SMP v6 platforms (ARM11MPCore)
> where the MPIDR is actually the `CPU ID register' with bits 31:12 set to
> zero, so we'll say it's a UP core.
> 
> Since 11MPCore is the only ARM SMP v6 processor and you're checking
> the implementor ID anyway, it might be easier to check for the 11MPCore
> explicitly, ((read_cpuid_id() & 0xfff0) == 0xB020) rather than check for v6/v7.
> 
> Or we could just ignore v6 for now.

We can't.  We need to get this correct so the head.S code can also get it
right.
