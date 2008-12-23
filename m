From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 01/22] OMAP2/3 clock: use standard set_rate fn in
	omap2_clk_arch_init()
Date: Mon, 22 Dec 2008 23:38:28 -0700
Message-ID: <20081223063826.8542.3930.stgit@localhost.localdomain>
References: <20081223063709.8542.82882.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:52853 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752121AbYLWGjf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 23 Dec 2008 01:39:35 -0500
In-Reply-To: <20081223063709.8542.82882.stgit@localhost.localdomain>
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
 


