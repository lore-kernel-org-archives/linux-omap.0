From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL 2/2] omap1 sparse irq support for v4.2
Date: Thu, 21 May 2015 14:47:11 -0700
Message-ID: <20150521214710.GX10274@atomide.com>
References: <80194352.chs4cqVdmg@wuerfel>
 <20150521165413.GS10274@atomide.com>
 <20150521183629.GT10274@atomide.com>
 <6774083.RmPqVFIumd@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:52924 "EHLO muru.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755180AbbEUVrN (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 21 May 2015 17:47:13 -0400
Content-Disposition: inline
In-Reply-To: <6774083.RmPqVFIumd@wuerfel>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, arm@kernel.org, linux-omap@vger.kernel.org

* Arnd Bergmann <arnd@arndb.de> [150521 14:35]:
> On Thursday 21 May 2015 11:36:30 Tony Lindgren wrote:
> > > 
> > > OK got it triggered here too with randconfig builds now.
> > > This seems to be related to not selecting some omap1 SoCs or
> > > boards. I'll try to do a minimal fix for it today.
> > > 
> > > It seems the include changes you posted would be better done
> > > by replacing the the dependencies to mach/irqs.h where possible
> > > rather than adding more includes?
> 
> Yes, I guess we can do that too. FWIW, almost all the problems
> were uses of cpu_is_omap*(), omap_read*() and omap_write*().
> 
> There are quite a lot of them overall, but at least they are
> easy to grep for, and there should be an obvious fix for each
> of them, following what you did on OMAP2 a couple of years ago.

Yeah then that can be done one driver at a time.
 
> > OK figured it out. We now rely on an indirect include selected
> > with ARCH_OMAP15XX. Here's what I suggest as a fix for this
> > issue, obviously the real fix is to fix the legacy drivers to not 
> > #include <mach/*.h>.
> 
> Ok, I've put this patch in my randconfig build setup to replace
> my older patch, let's see if there are still some corner cases
> left. So far, everything looks good (50 random mach-omap1 builds
> done). Can you send an updated pull request with the fix folded in?

OK will do. I'll also include the secion warning I posted earlier
today as that seems to get triggered with some randconfigs because
of the __init_or_module.

Regards,

Tony
