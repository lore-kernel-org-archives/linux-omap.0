From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 4/5] omap2plus: voltage: Trivial linking fix 'undefined reference'
Date: Tue,  4 Jan 2011 23:56:15 +0530
Message-ID: <1294165576-15628-5-git-send-email-santosh.shilimkar@ti.com>
References: <1294165576-15628-1-git-send-email-santosh.shilimkar@ti.com>
 <1294165576-15628-2-git-send-email-santosh.shilimkar@ti.com>
 <1294165576-15628-3-git-send-email-santosh.shilimkar@ti.com>
 <1294165576-15628-4-git-send-email-santosh.shilimkar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:38328 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751828Ab1ADS0k (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 4 Jan 2011 13:26:40 -0500
In-Reply-To: <1294165576-15628-4-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@ti.com, tony@atomide.com, linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, Thara Gopinath <thara@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>

LD      init/built-in.o
LD      .tmp_vmlinux1
arch/arm/mach-omap2/built-in.o: In function `omap2_set_init_voltage':
arch/arm/mach-omap2/pm.c:181: undefined reference to `omap_voltage_domain_lookup'
arch/arm/mach-omap2/built-in.o: In function `omap4_twl_init':
arch/arm/mach-omap2/omap_twl.c:244: undefined reference to `omap_voltage_domain_lookup'
arch/arm/mach-omap2/omap_twl.c:247: undefined reference to `omap_voltage_domain_lookup'
arch/arm/mach-omap2/omap_twl.c:250: undefined reference to `omap_voltage_domain_lookup'
make: *** [.tmp_vmlinux1] Error 1

The error is reported when omap2plus_defconfig built with CONFIG_PM disabled

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Thara Gopinath <thara@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/plat-omap/include/plat/voltage.h |   10 +++++++---
 1 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/voltage.h b/arch/arm/plat-omap/include/plat/voltage.h
index 710f4ea..c095351 100644
--- a/arch/arm/plat-omap/include/plat/voltage.h
+++ b/arch/arm/plat-omap/include/plat/voltage.h
@@ -65,9 +65,6 @@ struct voltagedomain {
 	char *name;
 };
 
-/* API to get the voltagedomain pointer */
-struct voltagedomain *omap_voltage_domain_lookup(char *name);
-
 /**
  * struct omap_volt_data - Omap voltage specific data.
  * @voltage_nominal:	The possible voltage value in uV
@@ -131,6 +128,9 @@ int omap_voltage_register_pmic(struct voltagedomain *voltdm,
 		struct omap_volt_pmic_info *pmic_info);
 void omap_change_voltscale_method(struct voltagedomain *voltdm,
 		int voltscale_method);
+/* API to get the voltagedomain pointer */
+struct voltagedomain *omap_voltage_domain_lookup(char *name);
+
 int omap_voltage_late_init(void);
 #else
 static inline int omap_voltage_register_pmic(struct voltagedomain *voltdm,
@@ -144,6 +144,10 @@ static inline int omap_voltage_late_init(void)
 {
 	return -EINVAL;
 }
+static inline struct voltagedomain *omap_voltage_domain_lookup(char *name)
+{
+	return NULL;
+}
 #endif
 
 #endif
-- 
1.6.0.4

