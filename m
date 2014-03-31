From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 03/55] ARM: OMAP2+: PRM: remove unnecessary cpu_is_XXX calls
 from prm_init / exit
Date: Mon, 31 Mar 2014 18:15:42 +0300
Message-ID: <1396278994-12624-4-git-send-email-t-kristo@ti.com>
References: <1396278994-12624-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1396278994-12624-1-git-send-email-t-kristo@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org, tony@atomide.com, paul@pwsan.com
Cc: linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Done in preparation to make PRM its own driver, as the cpu_is_XXX calls are
not available outside mach-omap2 folder.

The init functions are called only from cpu specific init chain, and thus
don't need to double check against cpu type.

The exit calls check against the data provided during init-time registration
and thus don't need cpu check either.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/prm2xxx.c |   13 +------------
 arch/arm/mach-omap2/prm3xxx.c |   10 +---------
 arch/arm/mach-omap2/prm44xx.c |   10 +---------
 3 files changed, 3 insertions(+), 30 deletions(-)

diff --git a/arch/arm/mach-omap2/prm2xxx.c b/arch/arm/mach-omap2/prm2xxx.c
index 45f83dd..a7f1cac 100644
--- a/arch/arm/mach-omap2/prm2xxx.c
+++ b/arch/arm/mach-omap2/prm2xxx.c
@@ -18,9 +18,6 @@
 #include <linux/io.h>
 #include <linux/irq.h>
 
-#include "soc.h"
-#include "common.h"
-#include "vp.h"
 #include "powerdomain.h"
 #include "clockdomain.h"
 #include "prm2xxx_3xxx_private.h"
@@ -261,19 +258,11 @@ static struct prm_ll_data omap2xxx_prm_ll_data = {
 
 int __init omap2xxx_prm_init(void)
 {
-	if (!cpu_is_omap24xx())
-		return 0;
-
 	return prm_register(&omap2xxx_prm_ll_data);
 }
 
 static void __exit omap2xxx_prm_exit(void)
 {
-	if (!cpu_is_omap24xx())
-		return;
-
-	/* Should never happen */
-	WARN(prm_unregister(&omap2xxx_prm_ll_data),
-	     "%s: prm_ll_data function pointer mismatch\n", __func__);
+	prm_unregister(&omap2xxx_prm_ll_data);
 }
 __exitcall(omap2xxx_prm_exit);
diff --git a/arch/arm/mach-omap2/prm3xxx.c b/arch/arm/mach-omap2/prm3xxx.c
index 6d3e9c2..1a39954 100644
--- a/arch/arm/mach-omap2/prm3xxx.c
+++ b/arch/arm/mach-omap2/prm3xxx.c
@@ -639,9 +639,6 @@ static struct prm_ll_data omap3xxx_prm_ll_data = {
 
 int __init omap3xxx_prm_init(void)
 {
-	if (!cpu_is_omap34xx())
-		return 0;
-
 	return prm_register(&omap3xxx_prm_ll_data);
 }
 
@@ -664,11 +661,6 @@ omap_subsys_initcall(omap3xxx_prm_late_init);
 
 static void __exit omap3xxx_prm_exit(void)
 {
-	if (!cpu_is_omap34xx())
-		return;
-
-	/* Should never happen */
-	WARN(prm_unregister(&omap3xxx_prm_ll_data),
-	     "%s: prm_ll_data function pointer mismatch\n", __func__);
+	prm_unregister(&omap3xxx_prm_ll_data);
 }
 __exitcall(omap3xxx_prm_exit);
diff --git a/arch/arm/mach-omap2/prm44xx.c b/arch/arm/mach-omap2/prm44xx.c
index 3655e16..be96881 100644
--- a/arch/arm/mach-omap2/prm44xx.c
+++ b/arch/arm/mach-omap2/prm44xx.c
@@ -660,9 +660,6 @@ static struct prm_ll_data omap44xx_prm_ll_data = {
 
 int __init omap44xx_prm_init(void)
 {
-	if (!cpu_is_omap44xx() && !soc_is_omap54xx() && !soc_is_dra7xx())
-		return 0;
-
 	return prm_register(&omap44xx_prm_ll_data);
 }
 
@@ -679,11 +676,6 @@ omap_subsys_initcall(omap44xx_prm_late_init);
 
 static void __exit omap44xx_prm_exit(void)
 {
-	if (!cpu_is_omap44xx())
-		return;
-
-	/* Should never happen */
-	WARN(prm_unregister(&omap44xx_prm_ll_data),
-	     "%s: prm_ll_data function pointer mismatch\n", __func__);
+	prm_unregister(&omap44xx_prm_ll_data);
 }
 __exitcall(omap44xx_prm_exit);
-- 
1.7.9.5
