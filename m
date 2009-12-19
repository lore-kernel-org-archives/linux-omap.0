From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 3/5] arm: Flush TLB entries in setup_mm_for_reboot()
Date: Sat, 19 Dec 2009 09:54:13 -0800
Message-ID: <20091219175413.GB11397@atomide.com>
References: <20091219034151.26198.26570.stgit@localhost>
 <20091219034619.26198.58992.stgit@localhost>
 <20091219090607.GB28047@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="jRHKVT23PllUwdXP"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:49623 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751206AbZLSRy2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 19 Dec 2009 12:54:28 -0500
Content-Disposition: inline
In-Reply-To: <20091219090607.GB28047@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org


--jRHKVT23PllUwdXP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* Russell King - ARM Linux <linux@arm.linux.org.uk> [091219 01:04]:
> On Fri, Dec 18, 2009 at 07:46:19PM -0800, Tony Lindgren wrote:
> > diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
> > index 8c7fbd1..a2802ea 100644
> > --- a/arch/arm/mm/mmu.c
> > +++ b/arch/arm/mm/mmu.c
> > @@ -1068,4 +1068,7 @@ void setup_mm_for_reboot(char mode)
> >  		pmd[1] = __pmd(pmdval + (1 << (PGDIR_SHIFT - 1)));
> >  		flush_pmd_entry(pmd);
> >  	}
> > +
> > +	local_flush_tlb_all();
> > +	flush_cache_all();
> 
> The cache flush is unnecessary.  The caches should be off at this point.

OK, right, cpu_proc_fin() has already disabled caches by then.

Here's the updated version.

Tony

--jRHKVT23PllUwdXP
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: inline; filename="kexec-fix-tlb-flush-v2.patch"

>From f279fdc4c7dc824902d67511bfcb5f18512c8468 Mon Sep 17 00:00:00 2001
From: Tony Lindgren <tony@atomide.com>
Date: Fri, 18 Dec 2009 17:10:51 -0800
Subject: [PATCH] arm: Flush TLB entries in setup_mm_for_reboot()

We need to do that if we tinker with the MMU entries.

This fixes the occasional bug with kexec where the new
fails to uncompress with "crc error". Most likely at
least kexec on v6 and v7 need this fix.

Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index 8c7fbd1..a311080 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -1068,4 +1068,6 @@ void setup_mm_for_reboot(char mode)
 		pmd[1] = __pmd(pmdval + (1 << (PGDIR_SHIFT - 1)));
 		flush_pmd_entry(pmd);
 	}
+
+	local_flush_tlb_all();
 }

--jRHKVT23PllUwdXP--
