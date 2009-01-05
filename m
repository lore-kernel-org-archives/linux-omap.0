From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH v2 01/23] OMAP2/3 clock: use standard set_rate fn in
	omap2_clk_arch_init()
Date: Sun, 04 Jan 2009 19:34:46 -0700
Message-ID: <20090105023444.12661.85560.stgit@localhost.localdomain>
References: <20090105022953.12661.57701.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:42859 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752167AbZAEDWj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 4 Jan 2009 22:22:39 -0500
In-Reply-To: <20090105022953.12661.57701.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Paul Walmsley <paul@pwsan.com>

Use the standard clk_set_rate() function in omap2_clk_arch_init()
rather than omap2_select_table_rate() -- this will ensure that clock
rates are recalculated and propagated correctly after those operations
are consolidated into clk_set_rate().

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/clock24xx.c |    2 +-
 arch/arm/mach-omap2/clock34xx.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/clock24xx.c b/arch/arm/mach-omap2/clock24xx.c
index ff14d12..8567de2 100644
--- a/arch/arm/mach-omap2/clock24xx.c
+++ b/arch/arm/mach-omap2/clock24xx.c
@@ -501,7 +501,7 @@ static int __init omap2_clk_arch_init(void)
 	if (!mpurate)
 		return -EINVAL;
 
-	if (omap2_select_table_rate(&virt_prcm_set, mpurate))
+	if (clk_set_rate(&virt_prcm_set, mpurate))
 		printk(KERN_ERR "Could not find matching MPU rate\n");
 
 	recalculate_root_clocks();
diff --git a/arch/arm/mach-omap2/clock34xx.c b/arch/arm/mach-omap2/clock34xx.c
index 2c655be..738a029 100644
--- a/arch/arm/mach-omap2/clock34xx.c
+++ b/arch/arm/mach-omap2/clock34xx.c
@@ -665,7 +665,7 @@ static int __init omap2_clk_arch_init(void)
 
 	/* REVISIT: not yet ready for 343x */
 #if 0
-	if (omap2_select_table_rate(&virt_prcm_set, mpurate))
+	if (clk_set_rate(&virt_prcm_set, mpurate))
 		printk(KERN_ERR "Could not find matching MPU rate\n");
 #endif
 


