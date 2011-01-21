From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [Query] mm: !*pte hit in mm/memory.c:remap_pte_range
Date: Fri, 21 Jan 2011 10:30:05 +0000
Message-ID: <20110121103005.GA14142@n2100.arm.linux.org.uk>
References: <A24693684029E5489D1D202277BE89448521EEAA@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:39511 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752371Ab1AUKaR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 21 Jan 2011 05:30:17 -0500
Content-Disposition: inline
In-Reply-To: <A24693684029E5489D1D202277BE89448521EEAA@dlee02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Aguirre, Sergio" <saaguirre@ti.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Thu, Jan 20, 2011 at 03:06:30PM -0600, Aguirre, Sergio wrote:
> And while debugging further, i realized that the point of stall was
> in mm/memory.c, function:
> 
> static int remap_pte_range(struct mm_struct *mm, pmd_t *pmd,
> 			unsigned long addr, unsigned long end,
> 			unsigned long pfn, pgprot_t prot)
> {
> 	pte_t *pte;
> 	spinlock_t *ptl;
> 
> 	pte = pte_alloc_map_lock(mm, pmd, addr, &ptl);
> 	if (!pte)
> 		return -ENOMEM;
> 	arch_enter_lazy_mmu_mode();
> 	do {
> 
> 
> 		BUG_ON(!pte_none(*pte)); <---******* HERE
> 
> 
> 		set_pte_at(mm, addr, pte, pte_mkspecial(pfn_pte(pfn, prot)));
> 		pfn++;
> 	} while (pte++, addr += PAGE_SIZE, addr != end);
> 	arch_leave_lazy_mmu_mode();
> 	pte_unmap_unlock(pte - 1, ptl);
> 	return 0;
> }
> 
> This is in 2.6.35.6 kernel + TI Android kernel changes. [1]
> 
> How should i interpret this? Does this mean something specific?

It is asserting that the pte we are about to overwrite was empty.  In
other words, there is no existing mapping in place at that virtual
address.

If there was a pre-existing mapping, you're doing something wrong
because you're potentially overwriting something else.
