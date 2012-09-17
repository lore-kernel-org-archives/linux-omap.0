From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] mfd: Fix compile for twl-core.c by removing
 cpu_is_omap usage
Date: Mon, 17 Sep 2012 15:14:06 -0700
Message-ID: <20120917221406.GG11762@atomide.com>
References: <20120917202943.GV4521@atomide.com>
 <alpine.DEB.2.00.1209172207480.16117@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1209172207480.16117@utopia.booyaka.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Fengguang Wu <fengguang.wu@intel.com>, Stephen Rothwell <sfr@canb.auug.org.au>, Samuel Ortiz <sameo@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, Felipe Balbi <balbi@ti.com>
List-Id: linux-omap@vger.kernel.org

* Paul Walmsley <paul@pwsan.com> [120917 15:09]:
> On Mon, 17 Sep 2012, Tony Lindgren wrote:
> 
> > Commit 7d7e1eba (ARM: OMAP2+: Prepare for irqs.h removal) broke
> > compile for non-omap as include plat/cpu.h was added:
> > 
> > drivers/mfd/twl-core.c:49:22: fatal error: plat/cpu.h: No such file or directory
> > 
> > This header was indirectly included earlier when SPARSE_IRQ was not
> > set, but does not exist on most platforms.
> > 
> > Fix the problem by removing the cpu_is_omap usage that should
> > not exist in drivers at all. We can do this by adding proper
> > clock aliases for the twl-core.c drivers, and drop separate
> > handling for cases when clock framework is not available as
> > the behaviour will stay the same.
> > 
> > Note that we need to add a platform device to avoid using the
> > i2c provided names that may be different on various omaps.
> > 
> > Reported-by: Fengguang Wu <fengguang.wu@intel.com>
> > Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> > Cc: Paul Walmsley <paul@pwsan.com>
> > Cc: Samuel Ortiz <sameo@linux.intel.com>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: Olof Johansson <olof@lixom.net>
> > Signed-off-by: Tony Lindgren <tony@atomide.com>
> > 
> > ---
> > 
> > Samuel, I'd like to queue this via arm-soc as that's where I have
> > the breaking patch is if this patch is OK with you.
> 
> It would be ideal if I could queue this one, due to the clock dependency.  
> Still hoping that we can get the CCF conversion patches in for 3.7.

We need to queue this ASAP and before other patches to fix the
build breakage in linux next. Then you can merge in that commit
too, does that work for you?

Tony
