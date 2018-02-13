From: Suman Anna <s-anna@ti.com>
Subject: [PATCH 7/9] ARM: OMAP2+: Cleanup omap_mcbsp_dev_attr and other legacy
 data
Date: Mon, 12 Feb 2018 19:32:41 -0600
Message-ID: <20180213013243.8378-8-s-anna@ti.com>
References: <20180213013243.8378-1-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180213013243.8378-1-s-anna@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: Keerthy <j-keerthy@ti.com>, Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

The omap_mcbsp_dev_attr data was used to supply instance-specific
data for legacy non-DT devices. The legacy McBSP device support
including the usage of the hwmod class revision data has been
dropped in commit 48f6693790aa ("ARM: OMAP2+: Remove unused legacy
code for McBSP") and this data is therefore no longer needed.
So, cleanup the structure and all the associated data in various
hwmod data files.

Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
Signed-off-by: Suman Anna <s-anna@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_2430_data.c  |  2 --
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c  | 21 ---------------------
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c  |  3 ---
 arch/arm/mach-omap2/omap_hwmod_54xx_data.c  |  2 --
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c   |  1 -
 include/linux/platform_data/asoc-ti-mcbsp.h | 12 ------------
 6 files changed, 41 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_2430_data.c b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
index cdbd09b21168..74eefd30518c 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2430_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
@@ -14,7 +14,6 @@
  */
 
 #include <linux/i2c-omap.h>
-#include <linux/platform_data/asoc-ti-mcbsp.h>
 #include <linux/platform_data/hsmmc-omap.h>
 #include <linux/omap-dma.h>
 
@@ -223,7 +222,6 @@ static struct omap_hwmod_class_sysconfig omap2430_mcbsp_sysc = {
 static struct omap_hwmod_class omap2430_mcbsp_hwmod_class = {
 	.name = "mcbsp",
 	.sysc = &omap2430_mcbsp_sysc,
-	.rev  = MCBSP_CONFIG_TYPE2,
 };
 
 static struct omap_hwmod_opt_clk mcbsp_opt_clks[] = {
diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index 23008cb35140..23336b6c7125 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -22,7 +22,6 @@
 #include <linux/omap-dma.h>
 #include "l3_3xxx.h"
 #include "l4_3xxx.h"
-#include <linux/platform_data/asoc-ti-mcbsp.h>
 
 #include "soc.h"
 #include "omap_hwmod.h"
@@ -896,7 +895,6 @@ static struct omap_hwmod_class_sysconfig omap3xxx_mcbsp_sysc = {
 static struct omap_hwmod_class omap3xxx_mcbsp_hwmod_class = {
 	.name = "mcbsp",
 	.sysc = &omap3xxx_mcbsp_sysc,
-	.rev  = MCBSP_CONFIG_TYPE3,
 };
 
 /* McBSP functional clock mapping */
@@ -911,7 +909,6 @@ static struct omap_hwmod_opt_clk mcbsp234_opt_clks[] = {
 };
 
 /* mcbsp1 */
-
 static struct omap_hwmod omap3xxx_mcbsp1_hwmod = {
 	.name		= "mcbsp1",
 	.class		= &omap3xxx_mcbsp_hwmod_class,
@@ -928,11 +925,6 @@ static struct omap_hwmod omap3xxx_mcbsp1_hwmod = {
 };
 
 /* mcbsp2 */
-
-static struct omap_mcbsp_dev_attr omap34xx_mcbsp2_dev_attr = {
-	.sidetone	= "mcbsp2_sidetone",
-};
-
 static struct omap_hwmod omap3xxx_mcbsp2_hwmod = {
 	.name		= "mcbsp2",
 	.class		= &omap3xxx_mcbsp_hwmod_class,
@@ -946,15 +938,9 @@ static struct omap_hwmod omap3xxx_mcbsp2_hwmod = {
 	},
 	.opt_clks	= mcbsp234_opt_clks,
 	.opt_clks_cnt	= ARRAY_SIZE(mcbsp234_opt_clks),
-	.dev_attr	= &omap34xx_mcbsp2_dev_attr,
 };
 
 /* mcbsp3 */
-
-static struct omap_mcbsp_dev_attr omap34xx_mcbsp3_dev_attr = {
-	.sidetone	= "mcbsp3_sidetone",
-};
-
 static struct omap_hwmod omap3xxx_mcbsp3_hwmod = {
 	.name		= "mcbsp3",
 	.class		= &omap3xxx_mcbsp_hwmod_class,
@@ -968,12 +954,9 @@ static struct omap_hwmod omap3xxx_mcbsp3_hwmod = {
 	},
 	.opt_clks	= mcbsp234_opt_clks,
 	.opt_clks_cnt	= ARRAY_SIZE(mcbsp234_opt_clks),
-	.dev_attr	= &omap34xx_mcbsp3_dev_attr,
 };
 
 /* mcbsp4 */
-
-
 static struct omap_hwmod omap3xxx_mcbsp4_hwmod = {
 	.name		= "mcbsp4",
 	.class		= &omap3xxx_mcbsp_hwmod_class,
@@ -990,8 +973,6 @@ static struct omap_hwmod omap3xxx_mcbsp4_hwmod = {
 };
 
 /* mcbsp5 */
-
-
 static struct omap_hwmod omap3xxx_mcbsp5_hwmod = {
 	.name		= "mcbsp5",
 	.class		= &omap3xxx_mcbsp_hwmod_class,
@@ -1020,7 +1001,6 @@ static struct omap_hwmod_class omap3xxx_mcbsp_sidetone_hwmod_class = {
 };
 
 /* mcbsp2_sidetone */
-
 static struct omap_hwmod omap3xxx_mcbsp2_sidetone_hwmod = {
 	.name		= "mcbsp2_sidetone",
 	.class		= &omap3xxx_mcbsp_sidetone_hwmod_class,
@@ -1029,7 +1009,6 @@ static struct omap_hwmod omap3xxx_mcbsp2_sidetone_hwmod = {
 };
 
 /* mcbsp3_sidetone */
-
 static struct omap_hwmod omap3xxx_mcbsp3_sidetone_hwmod = {
 	.name		= "mcbsp3_sidetone",
 	.class		= &omap3xxx_mcbsp_sidetone_hwmod_class,
diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index 5a313483b3b8..e4f8ae9cd637 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -27,8 +27,6 @@
 
 #include <linux/omap-dma.h>
 
-#include <linux/platform_data/asoc-ti-mcbsp.h>
-
 #include "omap_hwmod.h"
 #include "omap_hwmod_common_data.h"
 #include "cm1_44xx.h"
@@ -1679,7 +1677,6 @@ static struct omap_hwmod_class_sysconfig omap44xx_mcbsp_sysc = {
 static struct omap_hwmod_class omap44xx_mcbsp_hwmod_class = {
 	.name	= "mcbsp",
 	.sysc	= &omap44xx_mcbsp_sysc,
-	.rev	= MCBSP_CONFIG_TYPE4,
 };
 
 /* mcbsp1 */
diff --git a/arch/arm/mach-omap2/omap_hwmod_54xx_data.c b/arch/arm/mach-omap2/omap_hwmod_54xx_data.c
index f901b17bd73a..c72cd84b07ec 100644
--- a/arch/arm/mach-omap2/omap_hwmod_54xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_54xx_data.c
@@ -23,7 +23,6 @@
 #include <linux/i2c-omap.h>
 
 #include <linux/omap-dma.h>
-#include <linux/platform_data/asoc-ti-mcbsp.h>
 
 #include "omap_hwmod.h"
 #include "omap_hwmod_common_data.h"
@@ -985,7 +984,6 @@ static struct omap_hwmod_class_sysconfig omap54xx_mcbsp_sysc = {
 static struct omap_hwmod_class omap54xx_mcbsp_hwmod_class = {
 	.name	= "mcbsp",
 	.sysc	= &omap54xx_mcbsp_sysc,
-	.rev	= MCBSP_CONFIG_TYPE4,
 };
 
 /* mcbsp1 */
diff --git a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
index d66dc806425d..62352d1e6361 100644
--- a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
@@ -23,7 +23,6 @@
 #include <linux/i2c-omap.h>
 
 #include <linux/omap-dma.h>
-#include <linux/platform_data/asoc-ti-mcbsp.h>
 
 #include "omap_hwmod.h"
 #include "omap_hwmod_common_data.h"
diff --git a/include/linux/platform_data/asoc-ti-mcbsp.h b/include/linux/platform_data/asoc-ti-mcbsp.h
index e684543254f3..e319d0a2ec82 100644
--- a/include/linux/platform_data/asoc-ti-mcbsp.h
+++ b/include/linux/platform_data/asoc-ti-mcbsp.h
@@ -25,10 +25,6 @@
 #include <linux/spinlock.h>
 #include <linux/clk.h>
 
-#define MCBSP_CONFIG_TYPE2	0x2
-#define MCBSP_CONFIG_TYPE3	0x3
-#define MCBSP_CONFIG_TYPE4	0x4
-
 /* Platform specific configuration */
 struct omap_mcbsp_ops {
 	void (*request)(unsigned int);
@@ -47,14 +43,6 @@ struct omap_mcbsp_platform_data {
 	int (*force_ick_on)(struct clk *clk, bool force_on);
 };
 
-/**
- * omap_mcbsp_dev_attr - OMAP McBSP device attributes for omap_hwmod
- * @sidetone: name of the sidetone device
- */
-struct omap_mcbsp_dev_attr {
-	const char *sidetone;
-};
-
 void omap3_mcbsp_init_pdata_callback(struct omap_mcbsp_platform_data *pdata);
 
 #endif
-- 
2.15.1
