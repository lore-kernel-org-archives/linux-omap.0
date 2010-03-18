From: Thara Gopinath <thara@ti.com>
Subject: [PATCHv2 14/17] OMAP3: PM: Correcting accessing of ERRCONFIG register in smartreflex.c
Date: Thu, 18 Mar 2010 14:45:52 +0530
Message-ID: <1268903755-4151-15-git-send-email-thara@ti.com>
References: <1268903755-4151-1-git-send-email-thara@ti.com>
 <1268903755-4151-2-git-send-email-thara@ti.com>
 <1268903755-4151-3-git-send-email-thara@ti.com>
 <1268903755-4151-4-git-send-email-thara@ti.com>
 <1268903755-4151-5-git-send-email-thara@ti.com>
 <1268903755-4151-6-git-send-email-thara@ti.com>
 <1268903755-4151-7-git-send-email-thara@ti.com>
 <1268903755-4151-8-git-send-email-thara@ti.com>
 <1268903755-4151-9-git-send-email-thara@ti.com>
 <1268903755-4151-10-git-send-email-thara@ti.com>
 <1268903755-4151-11-git-send-email-thara@ti.com>
 <1268903755-4151-12-git-send-email-thara@ti.com>
 <1268903755-4151-13-git-send-email-thara@ti.com>
 <1268903755-4151-14-git-send-email-thara@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:57339 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751107Ab0CRJQJ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 18 Mar 2010 05:16:09 -0400
In-Reply-To: <1268903755-4151-14-git-send-email-thara@ti.com>
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
 arch/arm/mach-omap2/smartreflex.c |   11 +++++++++++
 arch/arm/mach-omap2/smartreflex.h |    6 ++++++
 2 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
index aeb9761..7858113 100644
--- a/arch/arm/mach-omap2/smartreflex.c
+++ b/arch/arm/mach-omap2/smartreflex.c
@@ -71,6 +71,17 @@ static inline void sr_modify_reg(struct omap_sr *sr, unsigned offset, u32 mask,
 
 	reg_val = omap_hwmod_readl(odev->hwmods[0], offset);
 	reg_val &= ~mask;
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
+
 	reg_val |= value;
 
 	omap_hwmod_writel(reg_val, odev->hwmods[0], offset);
diff --git a/arch/arm/mach-omap2/smartreflex.h b/arch/arm/mach-omap2/smartreflex.h
index 52309e0..58681b6 100644
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

