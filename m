From: "Andrew F. Davis" <afd@ti.com>
Subject: [PATCH v4 1/4] ARM: OMAP2+: Add omap_secure_init callback hook for secure initialization
Date: Thu, 2 Jan 2020 16:19:40 -0500
Message-ID: <20200102211943.20480-2-afd@ti.com>
References: <20200102211943.20480-1-afd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200102211943.20480-1-afd@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Lokesh Vutla <lokeshvutla@ti.com>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, "Andrew F . Davis" <afd@ti.com>
List-Id: linux-omap@vger.kernel.org

This can be used for detecting secure features or making early device
init sequence changes based on device security type.

Signed-off-by: Andrew F. Davis <afd@ti.com>
---
 arch/arm/mach-omap2/io.c          | 11 +++++++++++
 arch/arm/mach-omap2/omap-secure.c |  4 ++++
 arch/arm/mach-omap2/omap-secure.h |  2 ++
 3 files changed, 17 insertions(+)

diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index 349e48042982..f28047233665 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -51,6 +51,7 @@
 #include "prm33xx.h"
 #include "prm44xx.h"
 #include "opp2xxx.h"
+#include "omap-secure.h"
 
 /*
  * omap_clk_soc_init: points to a function that does the SoC-specific
@@ -430,6 +431,7 @@ void __init omap2420_init_early(void)
 	omap_hwmod_init_postsetup();
 	omap_clk_soc_init = omap2420_dt_clk_init;
 	rate_table = omap2420_rate_table;
+	omap_secure_init();
 }
 
 void __init omap2420_init_late(void)
@@ -454,6 +456,7 @@ void __init omap2430_init_early(void)
 	omap_hwmod_init_postsetup();
 	omap_clk_soc_init = omap2430_dt_clk_init;
 	rate_table = omap2430_rate_table;
+	omap_secure_init();
 }
 
 void __init omap2430_init_late(void)
@@ -481,6 +484,7 @@ void __init omap3_init_early(void)
 	omap3xxx_clockdomains_init();
 	omap3xxx_hwmod_init();
 	omap_hwmod_init_postsetup();
+	omap_secure_init();
 }
 
 void __init omap3430_init_early(void)
@@ -533,6 +537,7 @@ void __init ti814x_init_early(void)
 	dm814x_hwmod_init();
 	omap_hwmod_init_postsetup();
 	omap_clk_soc_init = dm814x_dt_clk_init;
+	omap_secure_init();
 }
 
 void __init ti816x_init_early(void)
@@ -549,6 +554,7 @@ void __init ti816x_init_early(void)
 	dm816x_hwmod_init();
 	omap_hwmod_init_postsetup();
 	omap_clk_soc_init = dm816x_dt_clk_init;
+	omap_secure_init();
 }
 #endif
 
@@ -566,6 +572,7 @@ void __init am33xx_init_early(void)
 	am33xx_hwmod_init();
 	omap_hwmod_init_postsetup();
 	omap_clk_soc_init = am33xx_dt_clk_init;
+	omap_secure_init();
 }
 
 void __init am33xx_init_late(void)
@@ -589,6 +596,7 @@ void __init am43xx_init_early(void)
 	omap_hwmod_init_postsetup();
 	omap_l2_cache_init();
 	omap_clk_soc_init = am43xx_dt_clk_init;
+	omap_secure_init();
 }
 
 void __init am43xx_init_late(void)
@@ -617,6 +625,7 @@ void __init omap4430_init_early(void)
 	omap_hwmod_init_postsetup();
 	omap_l2_cache_init();
 	omap_clk_soc_init = omap4xxx_dt_clk_init;
+	omap_secure_init();
 }
 
 void __init omap4430_init_late(void)
@@ -643,6 +652,7 @@ void __init omap5_init_early(void)
 	omap54xx_hwmod_init();
 	omap_hwmod_init_postsetup();
 	omap_clk_soc_init = omap5xxx_dt_clk_init;
+	omap_secure_init();
 }
 
 void __init omap5_init_late(void)
@@ -666,6 +676,7 @@ void __init dra7xx_init_early(void)
 	dra7xx_hwmod_init();
 	omap_hwmod_init_postsetup();
 	omap_clk_soc_init = dra7xx_dt_clk_init;
+	omap_secure_init();
 }
 
 void __init dra7xx_init_late(void)
diff --git a/arch/arm/mach-omap2/omap-secure.c b/arch/arm/mach-omap2/omap-secure.c
index 24298e47b9f1..e936732cdc4f 100644
--- a/arch/arm/mach-omap2/omap-secure.c
+++ b/arch/arm/mach-omap2/omap-secure.c
@@ -163,3 +163,7 @@ u32 rx51_secure_rng_call(u32 ptr, u32 count, u32 flag)
 				      NO_FLAG,
 				      3, ptr, count, flag, 0);
 }
+
+void __init omap_secure_init(void)
+{
+}
diff --git a/arch/arm/mach-omap2/omap-secure.h b/arch/arm/mach-omap2/omap-secure.h
index 20046e8f8ecb..9aeeb236a224 100644
--- a/arch/arm/mach-omap2/omap-secure.h
+++ b/arch/arm/mach-omap2/omap-secure.h
@@ -72,6 +72,8 @@ extern u32 rx51_secure_dispatcher(u32 idx, u32 process, u32 flag, u32 nargs,
 extern u32 rx51_secure_update_aux_cr(u32 set_bits, u32 clear_bits);
 extern u32 rx51_secure_rng_call(u32 ptr, u32 count, u32 flag);
 
+void omap_secure_init(void);
+
 #ifdef CONFIG_SOC_HAS_REALTIME_COUNTER
 void set_cntfreq(void);
 #else
-- 
2.17.1
