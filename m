From: Thara Gopinath <thara@ti.com>
Subject: [PATCH v3 3/6] OMAP4: PM: Program correct init voltages for scalable VDDs
Date: Wed, 27 Oct 2010 21:46:33 +0530
Message-ID: <1288196196-15469-4-git-send-email-thara@ti.com>
References: <1288196196-15469-1-git-send-email-thara@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:36627 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757614Ab0J0QQo (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 27 Oct 2010 12:16:44 -0400
In-Reply-To: <1288196196-15469-1-git-send-email-thara@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: paul@pwsan.com, khilman@deeprootsystems.com, b-cousson@ti.com, vishwanath.bs@ti.com, sawant@ti.com, Thara Gopinath <thara@ti.com>

By default the system boots up at nominal voltage for every
voltage domain in the system. This patch puts vdd_mpu, vdd_iva
and vdd_core to the correct boot up voltage as per the opp tables
specified. This patch implements this by matching the rate of
the main clock of the voltage domain with the opp table and
picking up the correct voltage.

Signed-off-by: Thara Gopinath <thara@ti.com>
---
 arch/arm/mach-omap2/pm.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
index 353e155..0651667 100644
--- a/arch/arm/mach-omap2/pm.c
+++ b/arch/arm/mach-omap2/pm.c
@@ -211,6 +211,10 @@ static int __init omap2_common_pm_init(void)
 	if (cpu_is_omap34xx()) {
 		omap2_set_init_voltage("mpu", "dpll1_ck", mpu_dev);
 		omap2_set_init_voltage("core", "l3_ick", l3_dev);
+	} else if (cpu_is_omap44xx()) {
+		omap2_set_init_voltage("mpu", "dpll_mpu_ck", mpu_dev);
+		omap2_set_init_voltage("core", "l3_div_ck", l3_dev);
+		omap2_set_init_voltage("iva", "dpll_iva_m5x2_ck", iva_dev);
 	}
 
 	omap_pm_if_init();
-- 
1.7.0.4

