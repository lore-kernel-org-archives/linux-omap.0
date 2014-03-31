From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 04/55] ARM: OMAP3/4: PRM: provide io chain reconfig function through irq setup
Date: Mon, 31 Mar 2014 18:15:43 +0300
Message-ID: <1396278994-12624-5-git-send-email-t-kristo@ti.com>
References: <1396278994-12624-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:54654 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752627AbaCaPRY (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 31 Mar 2014 11:17:24 -0400
In-Reply-To: <1396278994-12624-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tony@atomide.com, paul@pwsan.com
Cc: linux-arm-kernel@lists.infradead.org

This helps to make the PRM registration modular, and also gets rid of a
cpu type check done later.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/prcm-common.h |    2 ++
 arch/arm/mach-omap2/prm3xxx.c     |    1 +
 arch/arm/mach-omap2/prm44xx.c     |    1 +
 arch/arm/mach-omap2/prm_common.c  |    7 +------
 4 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap2/prcm-common.h b/arch/arm/mach-omap2/prcm-common.h
index ee2384a..a8e4b58 100644
--- a/arch/arm/mach-omap2/prcm-common.h
+++ b/arch/arm/mach-omap2/prcm-common.h
@@ -480,6 +480,7 @@ struct omap_prcm_irq {
  * @ocp_barrier: fn ptr to force buffered PRM writes to complete
  * @save_and_clear_irqen: fn ptr to save and clear IRQENABLE regs
  * @restore_irqen: fn ptr to save and clear IRQENABLE regs
+ * @reconfigure_io_chain: fn ptr to reconfigure IO chain
  * @saved_mask: IRQENABLE regs are saved here during suspend
  * @priority_mask: 1 bit per IRQ, set to 1 if omap_prcm_irq.priority = true
  * @base_irq: base dynamic IRQ number, returned from irq_alloc_descs() in init
@@ -501,6 +502,7 @@ struct omap_prcm_irq_setup {
 	void (*ocp_barrier)(void);
 	void (*save_and_clear_irqen)(u32 *saved_mask);
 	void (*restore_irqen)(u32 *saved_mask);
+	void (*reconfigure_io_chain)(void);
 	u32 *saved_mask;
 	u32 *priority_mask;
 	int base_irq;
diff --git a/arch/arm/mach-omap2/prm3xxx.c b/arch/arm/mach-omap2/prm3xxx.c
index 1a39954..dab93f4 100644
--- a/arch/arm/mach-omap2/prm3xxx.c
+++ b/arch/arm/mach-omap2/prm3xxx.c
@@ -45,6 +45,7 @@ static struct omap_prcm_irq_setup omap3_prcm_irq_setup = {
 	.ocp_barrier		= &omap3xxx_prm_ocp_barrier,
 	.save_and_clear_irqen	= &omap3xxx_prm_save_and_clear_irqen,
 	.restore_irqen		= &omap3xxx_prm_restore_irqen,
+	.reconfigure_io_chain	= &omap3xxx_prm_reconfigure_io_chain,
 };
 
 /*
diff --git a/arch/arm/mach-omap2/prm44xx.c b/arch/arm/mach-omap2/prm44xx.c
index be96881..10834cb 100644
--- a/arch/arm/mach-omap2/prm44xx.c
+++ b/arch/arm/mach-omap2/prm44xx.c
@@ -47,6 +47,7 @@ static struct omap_prcm_irq_setup omap4_prcm_irq_setup = {
 	.ocp_barrier		= &omap44xx_prm_ocp_barrier,
 	.save_and_clear_irqen	= &omap44xx_prm_save_and_clear_irqen,
 	.restore_irqen		= &omap44xx_prm_restore_irqen,
+	.reconfigure_io_chain	= &omap44xx_prm_reconfigure_io_chain,
 };
 
 /*
diff --git a/arch/arm/mach-omap2/prm_common.c b/arch/arm/mach-omap2/prm_common.c
index 878ae9f..b3c593b 100644
--- a/arch/arm/mach-omap2/prm_common.c
+++ b/arch/arm/mach-omap2/prm_common.c
@@ -330,12 +330,7 @@ int omap_prcm_register_chain_handler(struct omap_prcm_irq_setup *irq_setup)
 
 	if (of_have_populated_dt()) {
 		int irq = omap_prcm_event_to_irq("io");
-		if (cpu_is_omap34xx())
-			omap_pcs_legacy_init(irq,
-				omap3xxx_prm_reconfigure_io_chain);
-		else
-			omap_pcs_legacy_init(irq,
-				omap44xx_prm_reconfigure_io_chain);
+		omap_pcs_legacy_init(irq, irq_setup->reconfigure_io_chain);
 	}
 
 	return 0;
-- 
1.7.9.5

