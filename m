From: adharmap@codeaurora.org
Subject: [PATCH 4/5] gic: dont disable INT in ack callback
Date: Wed, 27 Jan 2010 11:32:28 -0800
Message-ID: <1264620749-24527-5-git-send-email-adharmap@codeaurora.org>
References: <1264620749-24527-1-git-send-email-adharmap@codeaurora.org>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754725Ab0A0Tc5@vger.kernel.org>
In-Reply-To: <1264620749-24527-1-git-send-email-adharmap@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Russell King <linux@arm.linux.org.uk>, Ingo Molnar <mingo@elte.hu>, Catalin Marinas <catalin.marinas@arm.com>, Yinghai Lu <yinghai@kernel.org>, Tony Lindgren <tony@atomide.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Kalle Valo <kalle.valo@iki.fi>, Jean Pihet <jpihet@mvista.com>, Linus Walleij <linus.walleij@stericsson.com>, Colin Tuckley <colin.tuckley@arm.com>, Philby John <pjohn@in.mvista.com>, Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>, Alessandro Rubini <rubini@unipv.it>, Andrea Gallo <andrea.gallo@stericsson.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Abhijeet Dharmapurikar <adharmap@quicinc.com>
List-Id: linux-omap@vger.kernel.org

From: Abhijeet Dharmapurikar <adharmap@quicinc.com>

Unless gic_ack_irq is called from __do_IRQ, interrupt should not
be disabled in the ack function. Disabling the interrupt causes
handle_edge_irq to never enable it again.

Signed-off-by: Abhijeet Dharmapurikar <adharmap@quicinc.com>
---
 arch/arm/common/gic.c |   29 +++++++++++++++++------------
 1 files changed, 17 insertions(+), 12 deletions(-)

diff --git a/arch/arm/common/gic.c b/arch/arm/common/gic.c
index 709cf53..d47a1d7 100644
--- a/arch/arm/common/gic.c
+++ b/arch/arm/common/gic.c
@@ -67,25 +67,30 @@ static inline unsigned int gic_irq(unsigned int irq)
 
 /*
  * Routines to acknowledge, disable and enable interrupts
- *
- * Linux assumes that when we're done with an interrupt we need to
- * unmask it, in the same way we need to unmask an interrupt when
- * we first enable it.
- *
- * The GIC has a separate notion of "end of interrupt" to re-enable
- * an interrupt after handling, in order to support hardware
- * prioritisation.
- *
- * We can make the GIC behave in the way that Linux expects by making
- * our "acknowledge" routine disable the interrupt, then mark it as
- * complete.
  */
 static void gic_ack_irq(unsigned int irq)
 {
 	u32 mask = 1 << (irq % 32);
 
 	spin_lock(&irq_controller_lock);
+
+#ifndef CONFIG_GENERIC_HARDIRQS_NO__DO_IRQ
+
+	 /*
+	  * Linux assumes that when we're done with an interrupt we need to
+	  * unmask it, in the same way we need to unmask an interrupt when
+	  * we first enable it.
+	  *
+	  * The GIC has a separate notion of "end of interrupt" to re-enable
+	  * an interrupt after handling, in order to support hardware
+	  * prioritisation.
+	  *
+	  * We can make the GIC behave in the way that Linux expects by making
+	  * our "acknowledge" routine disable the interrupt, then mark it as
+	  * complete.
+	  */
 	writel(mask, gic_dist_base(irq) + GIC_DIST_ENABLE_CLEAR + (gic_irq(irq) / 32) * 4);
+#endif
 	writel(gic_irq(irq), gic_cpu_base(irq) + GIC_CPU_EOI);
 	spin_unlock(&irq_controller_lock);
 }
-- 
1.5.6.3
