From: Thara Gopinath <thara@ti.com>
Subject: [PATCH v2 06/11] OMAP4: PM: Program correct init voltages for scalable VDDs
Date: Sat, 25 Sep 2010 18:21:21 +0530
Message-ID: <1285419086-13047-7-git-send-email-thara@ti.com>
References: <1285419086-13047-1-git-send-email-thara@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:45504 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752016Ab0IYMvi (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 25 Sep 2010 08:51:38 -0400
In-Reply-To: <1285419086-13047-1-git-send-email-thara@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com, paul@pwsan.com, b-cousson@ti.com, vishwanath.bs@ti.com, sawant@ti.com, Thara Gopinath <thara@ti.com>

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
index 9ba2c5f..0e03ea0 100644
--- a/arch/arm/mach-omap2/pm.c
+++ b/arch/arm/mach-omap2/pm.c
@@ -207,6 +207,10 @@ static int __init omap2_common_pm_init(void)
 		omap3_pm_init_opp_table();
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

