From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/3] ARM: mach-omap2: remove bogus "or_module" from
 rx51-peripherals
Date: Fri, 22 Jul 2016 22:55:24 -0700
Message-ID: <20160723055524.GA28140@atomide.com>
References: <20160720041332.30789-1-paul.gortmaker@windriver.com>
 <20160720041332.30789-2-paul.gortmaker@windriver.com>
 <20160722064101.GW28140@atomide.com>
 <20160722140242.GC11410@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160722140242.GC11410@windriver.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, linux-omap@vger.kernel.org, linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Paul Gortmaker <paul.gortmaker@windriver.com> [160722 07:02]:
> [Re: [PATCH 1/3] ARM: mach-omap2: remove bogus "or_module" from rx51-peripherals] On 21/07/2016 (Thu 23:41) Tony Lindgren wrote:
> 
> > Hi,
> > 
> > * Paul Gortmaker <paul.gortmaker@windriver.com> [160719 21:17]:
> > > During unrelated work, attempting to remove an include of the
> > > linux/module.h in favour of "struct module;" in order to reduce
> > > header entanglement, we found doing so caused a build failure in
> > > this file.
> > 
> > We're planning to drop this file after v4.8-rc1 after I've
> > verified that legacy booting still works at v4.8-rc1.
> > 
> > Are you OK if I pick this patch into my omap-for-v4.8/legacy
> > branch? Or if you have a minimal immutable branch against v4.7-rc1
> > with just this patch I can merge it in no problem.
> 
> Is the legacy branch a contingency plan for the case where legacy
> booting doesn't work?  If so, that should be OK.

Well it's just a branch of omap legacy booting related patches
for v4.8. But looking at it now, looks like I already pushed out the
removal of the last two remaining board files before I took few weeks
off. But I did not add it to Linux next to keep things working
until -rc1.

> Having the patch present, or having the file deleted both take care of
> my concern -- which was was introducing build regressions when adding
> the gpio header cleanup into for-4.9 content.  

OK. As I've already pushed out the board-*.c removal branch, I
suggest we just drop the $subject patch to avoid a merge conflict.

Regards,

Tony
