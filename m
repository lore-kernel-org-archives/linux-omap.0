From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [pm-core][PATCH v3 20/21] OMAP4: PM: Set static dependency between MPUSS-EMIF and MPUSS-L3_1
Date: Mon, 28 Mar 2011 14:52:36 +0530
Message-ID: <1301304157-2466-21-git-send-email-santosh.shilimkar@ti.com>
References: <1301304157-2466-1-git-send-email-santosh.shilimkar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:40586 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751565Ab1C1JWy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 28 Mar 2011 05:22:54 -0400
In-Reply-To: <1301304157-2466-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@ti.com, rnayak@ti.com, linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <santosh.shilimkar@ti.com>

As per OMAP4430 TRM, the dynamic dependency between MPUSS<->MEMIF
and MPUSS<->L3_MAIN_1 clockdomains is enable by default. Refer
register CM_MPU_DYNAMICDEP description for details.

But it doesn't seems to work as expected and MPUSS doesn't wakeup
from off-mode if the static dependency is not set between
MPUSS<->EMIF and MPUSS<->L3_MAIN_1 clockdomains. At times, CPU
dead-locks with above static dependencies cleared.

The issue is under investigation with hardware team.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Acked-by: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap2/pm44xx.c |   30 ++++++++++++++++++++++++++++++
 1 files changed, 30 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/pm44xx.c b/arch/arm/mach-omap2/pm44xx.c
index b78417c..40a44a9 100644
--- a/arch/arm/mach-omap2/pm44xx.c
+++ b/arch/arm/mach-omap2/pm44xx.c
@@ -182,6 +182,7 @@ static int __init pwrdms_setup(struct powerdomain *pwrdm, void *unused)
 static int __init omap4_pm_init(void)
 {
 	int ret;
+	struct clockdomain *emif_clkdm, *mpuss_clkdm, *l3_1_clkdm;
 
 	if (!cpu_is_omap44xx())
 		return -ENODEV;
@@ -196,6 +197,35 @@ static int __init omap4_pm_init(void)
 
 	(void) clkdm_for_each(clkdms_setup, NULL);
 
+	/*
+	 * FIXME: Remove the MPUSS <-> EMIF static dependency once the
+	 * dynamic dependency issue is root-caused.
+	 * The dynamic dependency between MPUSS <-> MEMIF and MPUSS <-> L3_1
+	 * doesn't seems to work as expected and MPUSS does not wakeup
+	 * from off-mode if the static dependency is not set between them.
+	 * At times CPUs dead-locks with above static dependencies cleared.
+	 */
+	mpuss_clkdm = clkdm_lookup("mpuss_clkdm");
+	emif_clkdm = clkdm_lookup("l3_emif_clkdm");
+	l3_1_clkdm = clkdm_lookup("l3_1_clkdm");
+	if ((!mpuss_clkdm) || (!emif_clkdm) || (!l3_1_clkdm))
+		goto err2;
+
+	ret = clkdm_add_wkdep(mpuss_clkdm, emif_clkdm);
+	if (ret) {
+		pr_err("Failed to add MPUSS <-> EMIF wakeup dependency\n");
+		goto err2;
+	}
+
+	ret = clkdm_add_wkdep(mpuss_clkdm, l3_1_clkdm);
+	if (ret) {
+		pr_err("Failed to add MPUSS <-> L3_MAIN_1 wakeup dependency\n");
+		goto err2;
+	}
+
+	pr_info("OMAP4 PM: Temporary static dependency added between"
+		"MPUSS <-> EMIF and MPUSS <-> L3_MAIN_1.\n");
+
 	ret = omap4_mpuss_init();
 	if (ret) {
 		pr_err("Failed to initialise OMAP4 MPUSS\n");
-- 
1.6.0.4

