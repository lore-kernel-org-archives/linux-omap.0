From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 16/19] TEMP: ARM: OMAP4: prevent voltage transitions
Date: Fri, 20 Apr 2012 12:33:49 +0300
Message-ID: <1334914432-26456-17-git-send-email-t-kristo@ti.com>
References: <1334914432-26456-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:51406 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753552Ab2DTJet (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 20 Apr 2012 05:34:49 -0400
In-Reply-To: <1334914432-26456-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, khilman@ti.com, paul@pwsan.com
Cc: linux-arm-kernel@lists.infradead.org

During device off, the off-mode voltage transitions are enabled on reset.
Because the voltage control logic is not still completely functional for
OMAP4, we must disable the voltage transitions for device off for now.
This can only be done by disabling the I2C channel it seems.

This patch does not prevent voltage scaling done by voltdm->scale / DVFS.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/pm44xx.c |   22 ++++++++++++++++++++++
 1 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/pm44xx.c b/arch/arm/mach-omap2/pm44xx.c
index d4d18d9..e678962 100644
--- a/arch/arm/mach-omap2/pm44xx.c
+++ b/arch/arm/mach-omap2/pm44xx.c
@@ -25,6 +25,9 @@
 #include "clockdomain.h"
 #include "powerdomain.h"
 #include "pm.h"
+#include "voltage.h"
+#include "prm44xx.h"
+#include "prm-regbits-44xx.h"
 
 struct power_state {
 	struct powerdomain *pwrdm;
@@ -207,6 +210,7 @@ static int __init omap4_pm_init(void)
 	int ret;
 	struct clockdomain *emif_clkdm, *mpuss_clkdm, *l3_1_clkdm, *l4wkup;
 	struct clockdomain *ducati_clkdm, *l3_2_clkdm, *l4_per_clkdm;
+	struct voltagedomain *mpu_voltdm;
 
 	if (!cpu_is_omap44xx())
 		return -ENODEV;
@@ -279,6 +283,24 @@ static int __init omap4_pm_init(void)
 		goto err2;
 	}
 
+	/*
+	 * XXX: voltage config is not still completely valid for
+	 * OMAP4, and this causes crashes on some platform during
+	 * device off because voltage transitions for device off
+	 * are enabled on reset. Thus, we have to disable the I2C
+	 * channel completely in the VOLTCTRL register to avoid
+	 * trouble. Remove this once voltconfigs are valid.
+	 */
+	mpu_voltdm = voltdm_lookup("mpu");
+	if (!mpu_voltdm) {
+		pr_err("Failed to get MPU voltdm\n");
+		goto err2;
+	}
+	mpu_voltdm->write(OMAP4430_VDD_MPU_I2C_DISABLE_MASK |
+			  OMAP4430_VDD_CORE_I2C_DISABLE_MASK |
+			  OMAP4430_VDD_IVA_I2C_DISABLE_MASK,
+			  OMAP4_PRM_VOLTCTRL_OFFSET);
+
 	ret = omap4_mpuss_init();
 	if (ret) {
 		pr_err("Failed to initialise OMAP4 MPUSS\n");
-- 
1.7.4.1

