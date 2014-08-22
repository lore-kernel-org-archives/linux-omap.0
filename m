From: Nishanth Menon <nm@ti.com>
Subject: [PATCH 10/10] ARM: DRA7: Add hook in SoC initcalls to enable pm
 initialization
Date: Fri, 22 Aug 2014 09:02:34 -0500
Message-ID: <1408716154-26101-11-git-send-email-nm@ti.com>
References: <1408716154-26101-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1408716154-26101-1-git-send-email-nm@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>, Tony Lindgren <tony@atomide.com>, Tero Kristo <t-kristo@ti.com>, Paul Walmsley <paul@pwsan.com>
Cc: Nishanth Menon <nm@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Keerthy <j-keerthy@ti.com>, linux-kernel@vger.kernel.org, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

From: Rajendra Nayak <rnayak@ti.com>

With consolidated code, now we can add the required hooks for
DRA7 to enable power management.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
[nm@ti.com: minor modifications]
Signed-off-by: Nishanth Menon <nm@ti.com>
---
Note: Minor checkpatch warning exists for 80 char limit that was ignored.

 arch/arm/mach-omap2/common.h |    2 +-
 arch/arm/mach-omap2/io.c     |    3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/common.h b/arch/arm/mach-omap2/common.h
index 5bb1592..b6d2989 100644
--- a/arch/arm/mach-omap2/common.h
+++ b/arch/arm/mach-omap2/common.h
@@ -60,7 +60,7 @@ static inline int omap3_pm_init(void)
 }
 #endif
 
-#if defined(CONFIG_PM) && (defined(CONFIG_ARCH_OMAP4) || defined(CONFIG_SOC_OMAP5))
+#if defined(CONFIG_PM) && (defined(CONFIG_ARCH_OMAP4) || defined(CONFIG_SOC_OMAP5) || defined(CONFIG_SOC_DRA7XX))
 int omap4_pm_init(void);
 int omap4_pm_init_early(void);
 #else
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index 2890c2d..831805e 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -698,6 +698,7 @@ void __init dra7xx_init_early(void)
 	omap2_set_globals_cm(OMAP2_L4_IO_ADDRESS(DRA7XX_CM_CORE_AON_BASE),
 			     OMAP2_L4_IO_ADDRESS(OMAP54XX_CM_CORE_BASE));
 	omap2_set_globals_prcm_mpu(OMAP2_L4_IO_ADDRESS(OMAP54XX_PRCM_MPU_BASE));
+	omap4_pm_init_early();
 	omap_prm_base_init();
 	omap_cm_base_init();
 	omap44xx_prm_init();
@@ -712,6 +713,8 @@ void __init dra7xx_init_early(void)
 void __init dra7xx_init_late(void)
 {
 	omap_common_late_init();
+	omap4_pm_init();
+	omap2_clk_enable_autoidle_all();
 }
 #endif
 
-- 
1.7.9.5
