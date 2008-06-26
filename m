From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 2/4] OMAP3 clock: fix omap2_clk_wait_ready() for OMAP3430ES2+
	DSS
Date: Thu, 26 Jun 2008 01:09:13 -0600
Message-ID: <20080626070908.16555.56475.stgit@localhost.localdomain>
References: <20080626070305.16555.96759.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:42958 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752821AbYFZHLm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 Jun 2008 03:11:42 -0400
In-Reply-To: <20080626070305.16555.96759.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: gadiyar@ti.com, k.kooi@student.utwente.nl, dirk.behme@googlemail.com, igor.stoppa@nokia.com, r-woodruff2@ti.com, jouni.hogander@nokia.com

On OMAP3430ES2, DSS has both an initiator standby CM_IDLEST bit, and a
target idle CM_IDLEST bit.  This is a departure from previous silicon,
which only had an initiator standby bit.

This means we need to test the target idle bit after enabling
dss1_alwon_fclk.  Previous clock code has done the wrong thing since ES2
came out: it's either tested the wrong bit, causing

    Clock dss1_alwon_fck failed to enable in 100000 tries

messages, or not tested anything at all, causing crashes during DISPC
initialization with:

    Unhandled fault: external abort on non-linefetch (0x1028)

This patch modifies omap2_clk_wait_ready() to wait for the DSS to become
accessible after dss1_alwon_fclk, dss_l3_iclk, and dss_l4_iclk are enabled.

Thanks to Anand Gadiyar <gadiyar@ti.com> for identifying one of the
problem patches, Koen Kooi <k.kooi@student.utwente.nl> for testing a
previous version of this patch, and Dirk Behme
<dirk.behme@googlemail.com> for review of a previous version.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---

 arch/arm/mach-omap2/clock.c           |   34 +++++++++++++++++++++++++++++----
 arch/arm/mach-omap2/cm-regbits-34xx.h |    4 +++-
 2 files changed, 33 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index 57e3217..343477b 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -246,11 +246,27 @@ static void omap2_clk_wait_ready(struct clk *clk)
 	}
 
 	/* REVISIT: What are the appropriate exclusions for 34XX? */
-	/* OMAP3: ignore DSS-mod clocks */
 	if (cpu_is_omap34xx() &&
-	    (prcm_mod == OMAP34XX_CM_REGADDR(OMAP3430_DSS_MOD, 0) ||
-	     (prcm_mod == OMAP34XX_CM_REGADDR(CORE_MOD, 0) &&
-	      clk->enable_bit == OMAP3430_EN_SSI_SHIFT)))
+	    prcm_mod == OMAP34XX_CM_REGADDR(OMAP3430_DSS_MOD, 0)) {
+
+		/* 3430ES1 DSS has no target idlest bits */
+		if (is_sil_rev_equal_to(OMAP3430_REV_ES1_0))
+			return;
+
+		/*
+		 * For 3430ES2+ DSS, only wait once (dss1_alwon_fclk,
+		 * dss_l3_iclk, dss_l4_iclk) are enabled
+		 */
+		if (clk->enable_bit != OMAP3430_EN_DSS1_SHIFT)
+			return;
+
+	}
+
+	/* REVISIT: SSI has a target idlest bit on OMAP3 */
+	/* REVISIT: This could accidentally exclude other clocks also */
+	if (cpu_is_omap34xx() &&
+	    prcm_mod == OMAP34XX_CM_REGADDR(CORE_MOD, 0) &&
+	    clk->enable_bit == OMAP3430_EN_SSI_SHIFT)
 		return;
 
 	/* Check if both functional and interface clocks
@@ -258,6 +274,16 @@ static void omap2_clk_wait_ready(struct clk *clk)
 	bit = 1 << clk->enable_bit;
 	if (!(__raw_readl((void __iomem *)other_reg) & bit))
 		return;
+
+	/*
+	 * OMAP3430ES2 DSS target idlest bit is at a different shift than
+	 * the corresponding {I,F}CLKEN bits
+	 */
+	if (cpu_is_omap34xx() &&
+	    prcm_mod == OMAP34XX_CM_REGADDR(OMAP3430_DSS_MOD, 0) &&
+	    clk->enable_bit == OMAP3430_EN_DSS1_SHIFT)
+		bit = OMAP3430ES2_ST_DSS_IDLE;
+
 	st_reg = ((other_reg & ~0xf0) | 0x20); /* CM_IDLEST* */
 
 	omap2_wait_clock_ready((void __iomem *)st_reg, bit, clk->name);
diff --git a/arch/arm/mach-omap2/cm-regbits-34xx.h b/arch/arm/mach-omap2/cm-regbits-34xx.h
index 6ec66f4..946c552 100644
--- a/arch/arm/mach-omap2/cm-regbits-34xx.h
+++ b/arch/arm/mach-omap2/cm-regbits-34xx.h
@@ -500,7 +500,9 @@
 #define OMAP3430_CM_ICLKEN_DSS_EN_DSS_SHIFT		0
 
 /* CM_IDLEST_DSS */
-#define OMAP3430_ST_DSS					(1 << 0)
+#define OMAP3430ES2_ST_DSS_IDLE				(1 << 1)
+#define OMAP3430ES2_ST_DSS_STDBY			(1 << 0)
+#define OMAP3430ES1_ST_DSS				(1 << 0)
 
 /* CM_AUTOIDLE_DSS */
 #define OMAP3430_AUTO_DSS				(1 << 0)


