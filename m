From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: Fix compile after delay page freeing patch
Date: Tue, 22 Feb 2011 12:20:23 -0800
Message-ID: <20110222202023.GS15225@atomide.com>
References: <20110222194332.GQ15225@atomide.com>
 <20110222195929.GA31275@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:65365 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751621Ab1BVUUi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Feb 2011 15:20:38 -0500
Content-Disposition: inline
In-Reply-To: <20110222195929.GA31275@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [110222 11:57]:
> On Tue, Feb 22, 2011 at 11:43:32AM -0800, Tony Lindgren wrote:
> > Commit 06824ba824b3e9f2fedb38bee79af0643198ed7f
> > (ARM: tlb: delay page freeing for SMP and ARMv7 CPUs) causes
> > the following compile error for at least omap1_defconfig:
> > 
> > In file included from arch/arm/mm/init.c:27:
> > arch/arm/include/asm/tlb.h: In function 'tlb_flush_mmu':
> > arch/arm/include/asm/tlb.h:101: error: implicit declaration of function 'release_pages'
> > arch/arm/include/asm/tlb.h: In function 'tlb_remove_page':
> > arch/arm/include/asm/tlb.h:165: error: implicit declaration of function 'page_cache_release'
> 
> Grant already mentioned this to me this evening.
> 
> This happens if you build with CONFIG_SWAP=n, and is something that the
> asm-generic/tlb.h also appears to suffer from.  Why no one else has
> noticed this I've no idea.
> 
> Note that linux/swap.h has this comment:
> 
> /* only sparc can not include linux/pagemap.h in this file
>  * so leave page_cache_release and release_pages undeclared... */
> #define free_page_and_swap_cache(page) \
>         page_cache_release(page)
> #define free_pages_and_swap_cache(pages, nr) \
>         release_pages((pages), (nr), 0);
> 
> which is rather annoying, because it makes the build error dependent on
> the configuration.
> 
> So, we should add linux/pagemap.h to both asm-generic/tlb.h and the ARM
> tlb.h as they both should suffer the same problem.
> 
> Note that arch/x86/mm/init.c and arch/x86/mm/pgtable.c both include
> asm/tlb.h without linux/pagemap.h, and use the generic version.  I bet
> no one's tried building x86 with CONFIG_SWAP=n yet...

Looks like it's in arch/x86/mm/init_[32|64].c and pgtable[32|64].c
though. So maybe we just need to patch either ARM tlb.h. Or patch
the necessary .c files to include pagemap.h.

Regards,

Tony
