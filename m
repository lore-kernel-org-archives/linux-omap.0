From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 08/25] OMAP4: PM: Keep static dep between MPUSS-EMIF and MPUSS-L3 and DUCATI-L3
Date: Sun, 4 Sep 2011 19:24:09 +0530
Message-ID: <1315144466-9395-9-git-send-email-santosh.shilimkar@ti.com>
References: <1315144466-9395-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:55663 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754672Ab1IDN4Z (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 4 Sep 2011 09:56:25 -0400
In-Reply-To: <1315144466-9395-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux@arm.linux.org.uk, khilman@ti.com, rnayak@ti.com, Santosh Shilimkar <santosh.shilimkar@ti.com>

As per OMAP4430 TRM, the dynamic dependency between MPUSS -> EMIF
and MPUSS -> L3* and DUCATI -> L3 *clockdomains is enable by default.
Refer register CM_MPU_DYNAMICDEP description for details.

But these dynamic dependencies doesn't work as expected. The hardware
recommendation is to keep above dependencies.
Without this system locks up or randomly crashesh.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Acked-by: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap2/pm44xx.c |   28 ++++++++++++++++++++++++++++
 1 files changed, 28 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/pm44xx.c b/arch/arm/mach-omap2/pm44xx.c
index 4bbc6fe..35ba028 100644
--- a/arch/arm/mach-omap2/pm44xx.c
+++ b/arch/arm/mach-omap2/pm44xx.c
@@ -116,6 +116,8 @@ static void omap_default_idle(void)
 static int __init omap4_pm_init(void)
 {
 	int ret;
+	struct clockdomain *emif_clkdm, *mpuss_clkdm, *l3_1_clkdm;
+	struct clockdomain *ducati_clkdm, *l3_2_clkdm;
 
 	if (!cpu_is_omap44xx())
 		return -ENODEV;
@@ -128,6 +130,32 @@ static int __init omap4_pm_init(void)
 		goto err2;
 	}
 
+	/*
+	 * The dynamic dependency between MPUSS -> MEMIF and
+	 * MPUSS -> L3_* and DUCATI -> doesn't work as expected.
+	 * The hardware recommendation is to keep above dependencies.
+	 * Without this system locks up or randomly crashesh.
+	 */
+	mpuss_clkdm = clkdm_lookup("mpuss_clkdm");
+	emif_clkdm = clkdm_lookup("l3_emif_clkdm");
+	l3_1_clkdm = clkdm_lookup("l3_1_clkdm");
+	l3_2_clkdm = clkdm_lookup("l3_2_clkdm");
+	ducati_clkdm = clkdm_lookup("ducati_clkdm");
+	if ((!mpuss_clkdm) || (!emif_clkdm) || (!l3_1_clkdm) ||
+			(!l3_2_clkdm) || (!ducati_clkdm))
+		goto err2;
+
+	ret = clkdm_add_wkdep(mpuss_clkdm, emif_clkdm);
+	ret |= clkdm_add_wkdep(mpuss_clkdm, l3_1_clkdm);
+	ret |= clkdm_add_wkdep(mpuss_clkdm, l3_2_clkdm);
+	ret |= clkdm_add_wkdep(ducati_clkdm, l3_1_clkdm);
+	ret |= clkdm_add_wkdep(ducati_clkdm, l3_2_clkdm);
+	if (ret) {
+		pr_err("Failed to add MPUSS -> L3/EMIF, DUCATI -> L3 "
+				"wakeup dependency\n");
+		goto err2;
+	}
+
 #ifdef CONFIG_SUSPEND
 	suspend_set_ops(&omap_pm_ops);
 #endif /* CONFIG_SUSPEND */
-- 
1.7.4.1

