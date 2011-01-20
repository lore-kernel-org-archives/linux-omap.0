From: "Aguirre, Sergio" <saaguirre@ti.com>
Subject: [Query] mm: !*pte hit in mm/memory.c:remap_pte_range
Date: Thu, 20 Jan 2011 15:06:30 -0600
Message-ID: <A24693684029E5489D1D202277BE89448521EEAA@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:50753 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751093Ab1ATVGe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 20 Jan 2011 16:06:34 -0500
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

WARNING: Linux MM newbie here. Please bare with me a bit.

While debugging a new v4l2 driver that makes use of the OMAP4 Tiler allocators in mmap calls, I found out that
remap_pfn_range was getting completely stalled.

And while debugging further, i realized that the point of stall was in mm/memory.c, function:

static int remap_pte_range(struct mm_struct *mm, pmd_t *pmd,
			unsigned long addr, unsigned long end,
			unsigned long pfn, pgprot_t prot)
{
	pte_t *pte;
	spinlock_t *ptl;

	pte = pte_alloc_map_lock(mm, pmd, addr, &ptl);
	if (!pte)
		return -ENOMEM;
	arch_enter_lazy_mmu_mode();
	do {


		BUG_ON(!pte_none(*pte)); <---******* HERE


		set_pte_at(mm, addr, pte, pte_mkspecial(pfn_pte(pfn, prot)));
		pfn++;
	} while (pte++, addr += PAGE_SIZE, addr != end);
	arch_leave_lazy_mmu_mode();
	pte_unmap_unlock(pte - 1, ptl);
	return 0;
}

This is in 2.6.35.6 kernel + TI Android kernel changes. [1]

How should i interpret this? Does this mean something specific?

Any pointers will be appreciated.

Regards,
Sergio

---

[1] http://git.omapzoom.org/?p=kernel/omap.git;a=shortlog;h=refs/heads/p-android-omap-2.6.35