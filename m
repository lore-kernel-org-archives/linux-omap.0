From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH] OMAP4: PM: Set static dependency between MPUSS and EMIF
Date: Tue,  8 Mar 2011 20:39:06 +0530
Message-ID: <1299596946-31334-1-git-send-email-santosh.shilimkar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:43761 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754893Ab1CHPJP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Mar 2011 10:09:15 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, Rajendra Nayak <rnayak@ti.com>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@ti.com>

As per OMAP4430 TRM, the dynamic dependency between MEMIF and MPUSS
clockdomains is enable by default. Refer register CM_MPU_DYNAMICDEP
description for details.

But it doesn't seems to work as expected and MPUSS doesn't wakeup
from off-mode if the static dependency is not set between MPUSS and
EMIF clockdomains. i.e CM_MPU_STATICDEP.MEMIF_STATDEP = 0

The issue is under investigation with hardware team.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@ti.com>
---
Patch applies on top of OMAP4 PM series.
Relevant thread on this issue:
http://www.mail-archive.com/linux-omap@vger.kernel.org/msg46173.html

 arch/arm/mach-omap2/pm44xx.c |   21 +++++++++++++++++++++
 1 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/pm44xx.c b/arch/arm/mach-omap2/pm44xx.c
index d4ad31e..877fb99 100644
--- a/arch/arm/mach-omap2/pm44xx.c
+++ b/arch/arm/mach-omap2/pm44xx.c
@@ -198,6 +198,7 @@ void omap4_pm_off_mode_enable(int enable)
 static int __init omap4_pm_init(void)
 {
 	int ret;
+	struct clockdomain *emif_clkdm, *mpuss_clkdm;
 
 	if (!cpu_is_omap44xx())
 		return -ENODEV;
@@ -213,6 +214,26 @@ static int __init omap4_pm_init(void)
 
 	(void) clkdm_for_each(clkdms_setup, NULL);
 
+
+	/*
+	 * FIXME: Remove the MPUSS <-> EMIF static dependency once the
+	 * dynamic dependency issue is root-caused.
+	 * The dynamic dependency between MEMIF and MPUSS doesn't seems to
+	 * work as expected and MPUSS does not wakeup from off-mode if
+	 * the static dependency is not set between them.
+	 * i.e. CM_MPU_STATICDEP.MEMIF_STATDEP = 0
+	 */
+	mpuss_clkdm = clkdm_lookup("mpuss_clkdm");
+	emif_clkdm = clkdm_lookup("l3_emif_clkdm");
+	if ((!mpuss_clkdm) || (!emif_clkdm))
+		goto err2;
+
+	ret = clkdm_add_wkdep(mpuss_clkdm, emif_clkdm);
+	if (ret) {
+		pr_err("Failed to add MPUSS <-> EMIF wakeup dependency\n");
+		goto err2;
+	}
+
 	ret = omap4_mpuss_init();
 	if (ret) {
 		pr_err("Failed to initialise OMAP4 MPUSS\n");
-- 
1.6.0.4

