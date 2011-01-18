From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 04/14] ARM: v6k: introduce CPU_V6K option
Date: Tue, 18 Jan 2011 13:35:59 +0000
Message-ID: <20110118133559.GC10997@n2100.arm.linux.org.uk>
References: <20110117192050.GE23331@n2100.arm.linux.org.uk> <E1Peuej-0003SV-Dn@rmk-PC.arm.linux.org.uk> <000601cbb6fb$8465c620$8d315260$@deacon@arm.com> <20110118110922.GB10997@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:35580 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751190Ab1ARNgS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 Jan 2011 08:36:18 -0500
Content-Disposition: inline
In-Reply-To: <20110118110922.GB10997@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Tue, Jan 18, 2011 at 11:09:22AM +0000, Russell King - ARM Linux wrote:
> I'd rather not in this patch - this patch adds CPU_V6K as an alias for
> CPU_V6 - so eveywhere which referenced CPU_V6 becomes (CPU_V6 || CPU_V6K).
> We could remove it in a later patch though.

Here's a follow-up patch to do that.  There's a few other things which
could do with updating now that we have CPU_Vx* straightened out.  I've
also recently noticed that the v6 and v7 cache stuff doesn't use the
direct-call optimization (see commented out bits in cacheflush.h).

That was because my original V6 support used the block cache operations,
which had to be run-time tested for presence, and so modified the
global cpu_cache methods directly.  As the block cache stuff was dropped,
we should re-enable this optimization.

That said, I'd rather not add too much to this series as I think it needs
to go into mainline ASAP - and probably stable as well, even though it's
on the large side - once properly and fully tested.

8<----
Subject: [PATCH] ARM: v6k: DMA_CACHE_RWFO isn't appropriate for non-v6k CPUs

Limit DMA_CACHE_RWFO to only v6k SMP CPUs - V6 CPUs aren't SMP capable,
so the read/write for ownership work-around doesn't apply to them.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mm/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
index 843bc8c..808b832 100644
--- a/arch/arm/mm/Kconfig
+++ b/arch/arm/mm/Kconfig
@@ -775,7 +775,7 @@ config NEEDS_SYSCALL_FOR_CMPXCHG
 
 config DMA_CACHE_RWFO
 	bool "Enable read/write for ownership DMA cache maintenance"
-	depends on (CPU_V6 || CPU_V6K) && SMP
+	depends on CPU_V6K && SMP
 	default y
 	help
 	  The Snoop Control Unit on ARM11MPCore does not detect the
-- 
1.6.2.5


