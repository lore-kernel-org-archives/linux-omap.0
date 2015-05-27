From: Tony Lindgren <tony@atomide.com>
Subject: [RFC] Fix omap3 booting with thumb2 compiled kernel
Date: Wed, 27 May 2015 14:55:46 -0700
Message-ID: <20150527215545.GA30984@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:54193 "EHLO muru.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751968AbbE0Vzs (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 27 May 2015 17:55:48 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Kevin Hilman <khilman@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Dave Martin <dave.martin@linaro.org>, linux-arm-kernel@lists.infradead.org

The power management related assembly needs to interact with
ARM mode bootrom code, so we need to keep most of the related
assembly in ARM mode.

Currently we are entering into and ARM mode assembly function
from thumb2 mode, so we need to make sure we switch to ARM
mode. And we need to do that again after the cache flush.

---

Kevin told me about this earlier today.. Anybody got better ideas
for a fix here?

--- a/arch/arm/mach-omap2/sleep34xx.S
+++ b/arch/arm/mach-omap2/sleep34xx.S
@@ -151,6 +151,17 @@ ENTRY(save_secure_ram_context_sz)
  */
 	.align	3
 ENTRY(omap34xx_cpu_suspend)
+
+	/*
+	 * This ARM assembly can also be called from thumb2 kernel code.
+	 * Make sure we switch to ARM mode first.
+	 */
+ THUMB(	.thumb		)
+ THUMB(	.align		)
+ THUMB(	bx	pc	)
+ THUMB(	nop		)
+	.arm
+
 	stmfd	sp!, {r4 - r11, lr}	@ save registers on stack
 
 	/*
@@ -187,6 +198,18 @@ save_context_wfi:
 	bx	r1
 
 	/*
+	 * The kernel doesn't interwork: v7_flush_dcache_all in particluar will
+	 * always return in Thumb state when CONFIG_THUMB2_KERNEL is enabled.
+	 * This sequence switches back to ARM.  Note that .align may insert a
+	 * nop: bx pc needs to be word-aligned in order to work.
+	 */
+ THUMB(	.thumb		)
+ THUMB(	.align		)
+ THUMB(	bx	pc	)
+ THUMB(	nop		)
+	.arm
+
+	/*
 	 * Clear the SCTLR.C bit to prevent further data cache
 	 * allocation. Clearing SCTLR.C would make all the data accesses
 	 * strongly ordered and would not hit the cache.
@@ -203,12 +226,8 @@ save_context_wfi:
 	 */
 	ldr	r1, kernel_flush
 	blx	r1
-	/*
-	 * The kernel doesn't interwork: v7_flush_dcache_all in particluar will
-	 * always return in Thumb state when CONFIG_THUMB2_KERNEL is enabled.
-	 * This sequence switches back to ARM.  Note that .align may insert a
-	 * nop: bx pc needs to be word-aligned in order to work.
-	 */
+
+	/* See the comments above about v7_flush_dcache_all */
  THUMB(	.thumb		)
  THUMB(	.align		)
  THUMB(	bx	pc	)
