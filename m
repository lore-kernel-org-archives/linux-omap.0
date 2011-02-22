From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] ARM: Fix compile after delay page freeing patch
Date: Tue, 22 Feb 2011 11:43:32 -0800
Message-ID: <20110222194332.GQ15225@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:36870 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752232Ab1BVTno (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Feb 2011 14:43:44 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

Commit 06824ba824b3e9f2fedb38bee79af0643198ed7f
(ARM: tlb: delay page freeing for SMP and ARMv7 CPUs) causes
the following compile error for at least omap1_defconfig:

In file included from arch/arm/mm/init.c:27:
arch/arm/include/asm/tlb.h: In function 'tlb_flush_mmu':
arch/arm/include/asm/tlb.h:101: error: implicit declaration of function 'release_pages'
arch/arm/include/asm/tlb.h: In function 'tlb_remove_page':
arch/arm/include/asm/tlb.h:165: error: implicit declaration of function 'page_cache_release'

Fix this by including pagemap.h.

Signed-off-by: Tony Lindgren <tony@atomide.com>

--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -19,6 +19,7 @@
 #include <linux/gfp.h>
 #include <linux/memblock.h>
 #include <linux/sort.h>
+#include <linux/pagemap.h>
 
 #include <asm/mach-types.h>
 #include <asm/sections.h>
