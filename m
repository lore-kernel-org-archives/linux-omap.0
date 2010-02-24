From: Thara Gopinath <thara@ti.com>
Subject: [PATCH 13/16] OMAP3: PM: Correcting accessing of ERRCONFIG register in smartreflex.c
Date: Wed, 24 Feb 2010 14:59:14 +0530
Message-ID: <1267003757-22456-14-git-send-email-thara@ti.com>
References: <1267003757-22456-1-git-send-email-thara@ti.com>
 <1267003757-22456-2-git-send-email-thara@ti.com>
 <1267003757-22456-3-git-send-email-thara@ti.com>
 <1267003757-22456-4-git-send-email-thara@ti.com>
 <1267003757-22456-5-git-send-email-thara@ti.com>
 <1267003757-22456-6-git-send-email-thara@ti.com>
 <1267003757-22456-7-git-send-email-thara@ti.com>
 <1267003757-22456-8-git-send-email-thara@ti.com>
 <1267003757-22456-9-git-send-email-thara@ti.com>
 <1267003757-22456-10-git-send-email-thara@ti.com>
 <1267003757-22456-11-git-send-email-thara@ti.com>
 <1267003757-22456-12-git-send-email-thara@ti.com>
 <1267003757-22456-13-git-send-email-thara@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:46747 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756163Ab0BXJ3f (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 24 Feb 2010 04:29:35 -0500
In-Reply-To: <1267003757-22456-13-git-send-email-thara@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com, paul@pwsan.com, nm@ti.com, b-cousson@ti.com, vishwanath.bs@ti.com, sawant@ti.com, Thara Gopinath <thara@ti.com>

Smartreflex error config register is special as it contains
certain status bits which if written a 1 into means a clear
of those bits. This patch takes special care during modify of
this register that no status bits in this register are accidently
set to 1.

This issue was first reported by Nishanth Menon.

Signed-off-by: Thara Gopinath <thara@ti.com>
---
 arch/arm/mach-omap2/smartreflex.c |   12 +++++++++++-
 arch/arm/mach-omap2/smartreflex.h |    6 ++++++
 2 files changed, 17 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
index 085dd05..8a4c48b 100644
--- a/arch/arm/mach-omap2/smartreflex.c
+++ b/arch/arm/mach-omap2/smartreflex.c
@@ -68,8 +68,18 @@ static inline void sr_modify_reg(struct omap_sr *sr, unsigned offset, u32 mask,
 
 	reg_val = __raw_readl(SR_REGADDR(offset));
 	reg_val &= ~mask;
-	reg_val |= value;
+	/*
+	 * Smartreflex error config register is special as it contains
+	 * certain status bits which if written a 1 into means a clear
+	 * of those bits. So in order to make sure no accidental write of
+	 * 1 happens to those status bits, do a clear of them in the read
+	 * value. Now if there is an actual reguest to write to these bits
+	 * they will be set in the nex step.
+	 */
+	if (offset == ERRCONFIG)
+		reg_val &= ~ERRCONFIG_STATUS_MASK;
 
+	reg_val |= value;
 	__raw_writel(reg_val, SR_REGADDR(offset));
 }
 
diff --git a/arch/arm/mach-omap2/smartreflex.h b/arch/arm/mach-omap2/smartreflex.h
index f8fc8a4..fbb6bf4 100644
--- a/arch/arm/mach-omap2/smartreflex.h
+++ b/arch/arm/mach-omap2/smartreflex.h
@@ -84,6 +84,12 @@ extern struct dentry *pm_dbg_main_dir;
 #define	ERRCONFIG_MCUDISACKINTEN	BIT(23)
 #define ERRCONFIG_MCUDISACKINTST	BIT(22)
 
+#define ERRCONFIG_STATUS_MASK		(ERRCONFIG_VPBOUNDINTST | \
+					ERRCONFIG_MCUACCUMINTST | \
+					ERRCONFIG_MCUVALIDINTST | \
+					ERRCONFIG_MCUBOUNDINTST | \
+					ERRCONFIG_MCUDISACKINTST)
+
 /* Common Bit values */
 
 #define SRCLKLENGTH_12MHZ_SYSCLK	0x3C
-- 
1.7.0.rc1.33.g07cf0f

