From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 14/17] ARM: OMAP2: hwmod: AMx3xx: remove redundant reset info
Date: Thu, 24 Sep 2015 17:26:55 +0300
Message-ID: <1443104818-993-15-git-send-email-t-kristo@ti.com>
References: <1443104818-993-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1443104818-993-1-git-send-email-t-kristo@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org, tony@atomide.com, s-anna@ti.com, paul@pwsan.com
Cc: linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

AMx3xx reset info is now parsed from DT, so the data under hwmod
database can be removed.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 .../mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c |   30 --------------------
 arch/arm/mach-omap2/omap_hwmod_33xx_data.c         |    8 ------
 arch/arm/mach-omap2/omap_hwmod_43xx_data.c         |    8 ------
 3 files changed, 46 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c b/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c
index 907a452b..7405e78 100644
--- a/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c
@@ -27,8 +27,6 @@
 #include "common.h"
 
 #define CLKCTRL(oh, clkctrl) ((oh).prcm.omap4.clkctrl_offs = (clkctrl))
-#define RSTCTRL(oh, rstctrl) ((oh).prcm.omap4.rstctrl_offs = (rstctrl))
-#define RSTST(oh, rstst) ((oh).prcm.omap4.rstst_offs = (rstst))
 
 /*
  * 'l3' class
@@ -143,10 +141,6 @@ static struct omap_hwmod_class am33xx_pruss_hwmod_class = {
 	.name	= "pruss",
 };
 
-static struct omap_hwmod_rst_info am33xx_pruss_resets[] = {
-	{ .name = "pruss", .rst_shift = 1 },
-};
-
 /* pru-icss */
 /* Pseudo hwmod for reset control purpose only */
 struct omap_hwmod am33xx_pruss_hwmod = {
@@ -159,8 +153,6 @@ struct omap_hwmod am33xx_pruss_hwmod = {
 			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
-	.rst_lines	= am33xx_pruss_resets,
-	.rst_lines_cnt	= ARRAY_SIZE(am33xx_pruss_resets),
 };
 
 /* gfx */
@@ -169,10 +161,6 @@ static struct omap_hwmod_class am33xx_gfx_hwmod_class = {
 	.name	= "gfx",
 };
 
-static struct omap_hwmod_rst_info am33xx_gfx_resets[] = {
-	{ .name = "gfx", .rst_shift = 0, .st_shift = 0},
-};
-
 struct omap_hwmod am33xx_gfx_hwmod = {
 	.name		= "gfx",
 	.class		= &am33xx_gfx_hwmod_class,
@@ -183,8 +171,6 @@ struct omap_hwmod am33xx_gfx_hwmod = {
 			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
-	.rst_lines	= am33xx_gfx_resets,
-	.rst_lines_cnt	= ARRAY_SIZE(am33xx_gfx_resets),
 };
 
 /*
@@ -1397,17 +1383,9 @@ static void omap_hwmod_am33xx_clkctrl(void)
 	CLKCTRL(am33xx_aes0_hwmod , AM33XX_CM_PER_AES0_CLKCTRL_OFFSET);
 }
 
-static void omap_hwmod_am33xx_rst(void)
-{
-	RSTCTRL(am33xx_pruss_hwmod, AM33XX_RM_PER_RSTCTRL_OFFSET);
-	RSTCTRL(am33xx_gfx_hwmod, AM33XX_RM_GFX_RSTCTRL_OFFSET);
-	RSTST(am33xx_gfx_hwmod, AM33XX_RM_GFX_RSTST_OFFSET);
-}
-
 void omap_hwmod_am33xx_reg(void)
 {
 	omap_hwmod_am33xx_clkctrl();
-	omap_hwmod_am33xx_rst();
 }
 
 static void omap_hwmod_am43xx_clkctrl(void)
@@ -1470,15 +1448,7 @@ static void omap_hwmod_am43xx_clkctrl(void)
 	CLKCTRL(am33xx_aes0_hwmod , AM43XX_CM_PER_AES0_CLKCTRL_OFFSET);
 }
 
-static void omap_hwmod_am43xx_rst(void)
-{
-	RSTCTRL(am33xx_pruss_hwmod, AM43XX_RM_PER_RSTCTRL_OFFSET);
-	RSTCTRL(am33xx_gfx_hwmod, AM43XX_RM_GFX_RSTCTRL_OFFSET);
-	RSTST(am33xx_gfx_hwmod, AM43XX_RM_GFX_RSTST_OFFSET);
-}
-
 void omap_hwmod_am43xx_reg(void)
 {
 	omap_hwmod_am43xx_clkctrl();
-	omap_hwmod_am43xx_rst();
 }
diff --git a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c b/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
index cc0791d..e4fc8b3 100644
--- a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
@@ -64,10 +64,6 @@ static struct omap_hwmod am33xx_l4_hs_hwmod = {
 	},
 };
 
-static struct omap_hwmod_rst_info am33xx_wkup_m3_resets[] = {
-	{ .name = "wkup_m3", .rst_shift = 3, .st_shift = 5 },
-};
-
 /* wkup_m3  */
 static struct omap_hwmod am33xx_wkup_m3_hwmod = {
 	.name		= "wkup_m3",
@@ -79,13 +75,9 @@ static struct omap_hwmod am33xx_wkup_m3_hwmod = {
 	.prcm		= {
 		.omap4	= {
 			.clkctrl_offs	= AM33XX_CM_WKUP_WKUP_M3_CLKCTRL_OFFSET,
-			.rstctrl_offs	= AM33XX_RM_WKUP_RSTCTRL_OFFSET,
-			.rstst_offs	= AM33XX_RM_WKUP_RSTST_OFFSET,
 			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
-	.rst_lines	= am33xx_wkup_m3_resets,
-	.rst_lines_cnt	= ARRAY_SIZE(am33xx_wkup_m3_resets),
 };
 
 /*
diff --git a/arch/arm/mach-omap2/omap_hwmod_43xx_data.c b/arch/arm/mach-omap2/omap_hwmod_43xx_data.c
index e97a894..d486c42 100644
--- a/arch/arm/mach-omap2/omap_hwmod_43xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_43xx_data.c
@@ -52,10 +52,6 @@ static struct omap_hwmod am43xx_l4_hs_hwmod = {
 	},
 };
 
-static struct omap_hwmod_rst_info am33xx_wkup_m3_resets[] = {
-	{ .name = "wkup_m3", .rst_shift = 3, .st_shift = 5 },
-};
-
 static struct omap_hwmod am43xx_wkup_m3_hwmod = {
 	.name		= "wkup_m3",
 	.class		= &am33xx_wkup_m3_hwmod_class,
@@ -66,13 +62,9 @@ static struct omap_hwmod am43xx_wkup_m3_hwmod = {
 	.prcm		= {
 		.omap4	= {
 			.clkctrl_offs	= AM43XX_CM_WKUP_WKUP_M3_CLKCTRL_OFFSET,
-			.rstctrl_offs	= AM43XX_RM_WKUP_RSTCTRL_OFFSET,
-			.rstst_offs	= AM43XX_RM_WKUP_RSTST_OFFSET,
 			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
-	.rst_lines	= am33xx_wkup_m3_resets,
-	.rst_lines_cnt	= ARRAY_SIZE(am33xx_wkup_m3_resets),
 };
 
 static struct omap_hwmod am43xx_control_hwmod = {
-- 
1.7.9.5
