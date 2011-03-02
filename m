From: Colin Cross <ccross@google.com>
Subject: Common suspend and resume with L2 cache on
Date: Tue, 1 Mar 2011 18:23:13 -0800
Message-ID: <AANLkTimxDjSun5+gaU5fMNf2KMVTNbfdq-D=0iU6tYZg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp-out.google.com ([74.125.121.67]:54185 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751754Ab1CBCXR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Mar 2011 21:23:17 -0500
Received: from kpbe16.cbf.corp.google.com (kpbe16.cbf.corp.google.com [172.25.105.80])
	by smtp-out.google.com with ESMTP id p222NFlM009514
	for <linux-omap@vger.kernel.org>; Tue, 1 Mar 2011 18:23:15 -0800
Received: from ywg8 (ywg8.prod.google.com [10.192.7.8])
	by kpbe16.cbf.corp.google.com with ESMTP id p222NDma023646
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <linux-omap@vger.kernel.org>; Tue, 1 Mar 2011 18:23:14 -0800
Received: by ywg8 with SMTP id 8so2173007ywg.20
        for <linux-omap@vger.kernel.org>; Tue, 01 Mar 2011 18:23:13 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Linux Tegra Mailing List <linux-tegra@vger.kernel.org>, linux-omap@vger.kernel.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>

Now that common suspend helpers are in linux-next, I'm going back to
trying to use them with the L2 cache on, which is required when
implementing cpuidle states that put a cpu in reset in an SMP system.

There are a few obvious requirements - the stack pointer, stack
contents, and page tables must be flushed in the L2 during suspend.

There is one trickier problem. The current resume sequence starts from
reset, with cache and MMU off:
   Restore cpu registers, including TTBR0, but not SCTLR
   Rewrite the page table to map the MMU trampoline VA=PA
   Restore SCTLR with dcache bit off (enables MMU)
   Jump to virtual address
   Restore SCTLR with original dcache bit

The page table is rewritten with the temporary mapping with the cache
off, so the write goes directly to memory.  When the MMU is enabled,
the TTBR0 RGN and IRGN bits determine the cachability attributes of
the page table walk memory accesses.  These bits are normally set to
cachable, so when the MMU is turned on, the page table walks can hit
the L2 instead of memory.  If a stale entry for the temporary mapping
is in the L2, which can happen if it is prefetched by the other cpu
during suspend, the page table walk will not see the new mapping.

This could be fixed by restoring the TTBR0 register with caching
disabled, and re-enabling caching after the page table entry is
restored, or by switching to a custom page table prepared during init
to avoid any writes while the cache is off.
