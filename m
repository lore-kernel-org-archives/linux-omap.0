From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 3/5] arm: Flush TLB entries in setup_mm_for_reboot()
Date: Sat, 19 Dec 2009 10:10:16 -0800
Message-ID: <20091219181016.GC11397@atomide.com>
References: <20091219034151.26198.26570.stgit@localhost>
 <20091219034619.26198.58992.stgit@localhost>
 <20091219090607.GB28047@n2100.arm.linux.org.uk>
 <20091219175413.GB11397@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:58531 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750944AbZLSSKb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 19 Dec 2009 13:10:31 -0500
Content-Disposition: inline
In-Reply-To: <20091219175413.GB11397@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [091219 09:53]:
> * Russell King - ARM Linux <linux@arm.linux.org.uk> [091219 01:04]:
> > On Fri, Dec 18, 2009 at 07:46:19PM -0800, Tony Lindgren wrote:
> > > diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
> > > index 8c7fbd1..a2802ea 100644
> > > --- a/arch/arm/mm/mmu.c
> > > +++ b/arch/arm/mm/mmu.c
> > > @@ -1068,4 +1068,7 @@ void setup_mm_for_reboot(char mode)
> > >  		pmd[1] = __pmd(pmdval + (1 << (PGDIR_SHIFT - 1)));
> > >  		flush_pmd_entry(pmd);
> > >  	}
> > > +
> > > +	local_flush_tlb_all();
> > > +	flush_cache_all();
> > 
> > The cache flush is unnecessary.  The caches should be off at this point.
> 
> OK, right, cpu_proc_fin() has already disabled caches by then.
> 
> Here's the updated version.

Hmm, without the flush_cache_all() rebooting with kexec still fails
with crc error eventually.

So it seems like there's a bug somewhere. Maybe something missing from
local_flush_tlb_all()?

I don't see anything obvious in v7_flush_dcache_all that would explain
why it makes local_flush_tlb_all() behave. Like you said caches are
off at this point, and that should also disable the L2 cache.

Regards,
 
Tony



> From f279fdc4c7dc824902d67511bfcb5f18512c8468 Mon Sep 17 00:00:00 2001
> From: Tony Lindgren <tony@atomide.com>
> Date: Fri, 18 Dec 2009 17:10:51 -0800
> Subject: [PATCH] arm: Flush TLB entries in setup_mm_for_reboot()
> 
> We need to do that if we tinker with the MMU entries.
> 
> This fixes the occasional bug with kexec where the new
> fails to uncompress with "crc error". Most likely at
> least kexec on v6 and v7 need this fix.
> 
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> 
> diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
> index 8c7fbd1..a311080 100644
> --- a/arch/arm/mm/mmu.c
> +++ b/arch/arm/mm/mmu.c
> @@ -1068,4 +1068,6 @@ void setup_mm_for_reboot(char mode)
>  		pmd[1] = __pmd(pmdval + (1 << (PGDIR_SHIFT - 1)));
>  		flush_pmd_entry(pmd);
>  	}
> +
> +	local_flush_tlb_all();
>  }

