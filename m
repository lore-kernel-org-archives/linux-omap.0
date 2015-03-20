From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv5 02/35] ARM: OMAP2+: PRCM: rename of_prcm_init to
 omap_prcm_init
Date: Fri, 20 Mar 2015 20:44:13 +0200
Message-ID: <1426877086-17131-3-git-send-email-t-kristo@ti.com>
References: <1426877086-17131-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1426877086-17131-1-git-send-email-t-kristo@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org, tony@atomide.com, paul@pwsan.com, sakari.ailus@iki.fi
Cc: linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

This avoids conflicts in the global namespace, and is more descriptive
of the purpose anyway.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/io.c         |    2 +-
 arch/arm/mach-omap2/prm.h        |    2 +-
 arch/arm/mach-omap2/prm_common.c |    8 +++++++-
 3 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index c4871c5..f504f71 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -764,7 +764,7 @@ int __init omap_clk_init(void)
 	ti_clk_init_features();
 
 	if (of_have_populated_dt()) {
-		ret = of_prcm_init();
+		ret = omap_prcm_init();
 		if (ret)
 			return ret;
 
diff --git a/arch/arm/mach-omap2/prm.h b/arch/arm/mach-omap2/prm.h
index b9061a6..ba9b933 100644
--- a/arch/arm/mach-omap2/prm.h
+++ b/arch/arm/mach-omap2/prm.h
@@ -19,7 +19,7 @@
 extern void __iomem *prm_base;
 extern u16 prm_features;
 extern void omap2_set_globals_prm(void __iomem *prm);
-int of_prcm_init(void);
+int omap_prcm_init(void);
 void omap3_prcm_legacy_iomaps_init(void);
 # endif
 
diff --git a/arch/arm/mach-omap2/prm_common.c b/arch/arm/mach-omap2/prm_common.c
index bfaa7ba..c5cfaa9 100644
--- a/arch/arm/mach-omap2/prm_common.c
+++ b/arch/arm/mach-omap2/prm_common.c
@@ -625,7 +625,13 @@ static struct ti_clk_ll_ops omap_clk_ll_ops = {
 	.clk_writel = prm_clk_writel,
 };
 
-int __init of_prcm_init(void)
+/**
+ * omap_prcm_init - low level init for the PRCM drivers
+ *
+ * Initializes the low level clock infrastructure for PRCM drivers.
+ * Returns 0 in success, negative error value in failure.
+ */
+int __init omap_prcm_init(void)
 {
 	struct device_node *np;
 	void __iomem *mem;
-- 
1.7.9.5
