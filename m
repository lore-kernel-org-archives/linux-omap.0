From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH v2 04/24] OMAP4: PM: Keep static dep between MPUSS-EMIF and MPUSS-L3/L4 and DUCATI-L3
Date: Sat, 24 Sep 2011 11:44:24 +0530
Message-ID: <1316844884-21700-5-git-send-email-santosh.shilimkar@ti.com>
References: <1316844884-21700-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:44244 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751454Ab1IXGPA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 24 Sep 2011 02:15:00 -0400
In-Reply-To: <1316844884-21700-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, khilman@ti.com, Santosh Shilimkar <santosh.shilimkar@ti.com>, Rajendra Nayak <rnayak@ti.com>

As per OMAP4430 TRM, the dynamic dependency between MPUSS -> EMIF
and MPUSS -> L4PER/L3_* and DUCATI -> L3_* clockdomains is enable
by default. Refer register CM_MPU_DYNAMICDEP description for details.

But these dynamic dependencies doesn't work as expected. The hardware
recommendation is to enable static dependencies for above clockdomains.
Without this, system locks up or randomly crashes.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Acked-by: Paul Walmsley <paul@pwsan.com>
Acked-by: Jean Pihet <j-pihet@ti.com>
Reviewed-by: Kevin Hilman <khilman@ti.com>
Tested-by: Vishwanath BS <vishwanath.bs@ti.com>
---
 arch/arm/mach-omap2/pm44xx.c |   30 ++++++++++++++++++++++++++++++
 1 files changed, 30 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/pm44xx.c b/arch/arm/mach-omap2/pm44xx.c
index 59a870b..348ebf1 100644
--- a/arch/arm/mach-omap2/pm44xx.c
+++ b/arch/arm/mach-omap2/pm44xx.c
@@ -99,6 +99,8 @@ static int __init pwrdms_setup(struct powerdomain *pwrdm, void *unused)
 static int __init omap4_pm_init(void)
 {
 	int ret;
+	struct clockdomain *emif_clkdm, *mpuss_clkdm, *l3_1_clkdm;
+	struct clockdomain *ducati_clkdm, *l3_2_clkdm, *l4_per_clkdm;
 
 	if (!cpu_is_omap44xx())
 		return -ENODEV;
@@ -111,6 +113,34 @@ static int __init omap4_pm_init(void)
 		goto err2;
 	}
 
+	/*
+	 * The dynamic dependency between MPUSS -> MEMIF and
+	 * MPUSS -> L4_PER/L3_* and DUCATI -> L3_* doesn't work as
+	 * expected. The hardware recommendation is to enable static
+	 * dependencies for these to avoid system lock ups or random crashes.
+	 */
+	mpuss_clkdm = clkdm_lookup("mpuss_clkdm");
+	emif_clkdm = clkdm_lookup("l3_emif_clkdm");
+	l3_1_clkdm = clkdm_lookup("l3_1_clkdm");
+	l3_2_clkdm = clkdm_lookup("l3_2_clkdm");
+	l4_per_clkdm = clkdm_lookup("l4_per_clkdm");
+	ducati_clkdm = clkdm_lookup("ducati_clkdm");
+	if ((!mpuss_clkdm) || (!emif_clkdm) || (!l3_1_clkdm) ||
+		(!l3_2_clkdm) || (!ducati_clkdm) || (!l4_per_clkdm))
+		goto err2;
+
+	ret = clkdm_add_wkdep(mpuss_clkdm, emif_clkdm);
+	ret |= clkdm_add_wkdep(mpuss_clkdm, l3_1_clkdm);
+	ret |= clkdm_add_wkdep(mpuss_clkdm, l3_2_clkdm);
+	ret |= clkdm_add_wkdep(mpuss_clkdm, l4_per_clkdm);
+	ret |= clkdm_add_wkdep(ducati_clkdm, l3_1_clkdm);
+	ret |= clkdm_add_wkdep(ducati_clkdm, l3_2_clkdm);
+	if (ret) {
+		pr_err("Failed to add MPUSS -> L3/EMIF/L4PER, DUCATI -> L3 "
+				"wakeup dependency\n");
+		goto err2;
+	}
+
 #ifdef CONFIG_SUSPEND
 	suspend_set_ops(&omap_pm_ops);
 #endif /* CONFIG_SUSPEND */
-- 
1.7.4.1

