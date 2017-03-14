From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 3/4] ARM: OMAP2+: Remove unnecessary hwmod clockact
Date: Tue, 14 Mar 2017 14:06:38 -0700
Message-ID: <20170314210639.2065-4-tony@atomide.com>
References: <20170314210639.2065-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170314210639.2065-1-tony@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org
Cc: Tero Kristo <t-kristo@ti.com>, Paul Walmsley <paul@pwsan.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

The clockact is not really needed in struct omap_hwmod_class_sysconfig.
It can be replaced with CLOCKACT_TEST_ICLK where it's used.

Cc: Paul Walmsley <paul@pwsan.com>
Cc: Tero Kristo <t-kristo@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/omap_hwmod.c                   | 2 +-
 arch/arm/mach-omap2/omap_hwmod.h                   | 1 -
 arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c | 1 -
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c         | 4 ----
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c         | 2 --
 arch/arm/mach-omap2/omap_hwmod_54xx_data.c         | 2 --
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c          | 1 -
 7 files changed, 1 insertion(+), 12 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -1328,7 +1328,7 @@ static void _enable_sysc(struct omap_hwmod *oh)
 	 */
 	if ((oh->flags & HWMOD_SET_DEFAULT_CLOCKACT) &&
 	    (sf & SYSC_HAS_CLOCKACTIVITY))
-		_set_clockactivity(oh, oh->class->sysc->clockact, &v);
+		_set_clockactivity(oh, CLOCKACT_TEST_ICLK, &v);
 
 	_write_sysconfig(v, oh);
 
diff --git a/arch/arm/mach-omap2/omap_hwmod.h b/arch/arm/mach-omap2/omap_hwmod.h
--- a/arch/arm/mach-omap2/omap_hwmod.h
+++ b/arch/arm/mach-omap2/omap_hwmod.h
@@ -411,7 +411,6 @@ struct omap_hwmod_class_sysconfig {
 	struct omap_hwmod_sysc_fields *sysc_fields;
 	u8 srst_udelay;
 	u8 idlemodes;
-	u8 clockact;
 };
 
 /**
diff --git a/arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c b/arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c
--- a/arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c
@@ -55,7 +55,6 @@ static struct omap_hwmod_class_sysconfig omap2xxx_timer_sysc = {
 			   SYSC_HAS_ENAWAKEUP | SYSC_HAS_SOFTRESET |
 			   SYSC_HAS_AUTOIDLE | SYSS_HAS_RESET_STATUS),
 	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART),
-	.clockact       = CLOCKACT_TEST_ICLK,
 	.sysc_fields	= &omap_hwmod_sysc_type1,
 };
 
diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -149,7 +149,6 @@ static struct omap_hwmod_class_sysconfig omap3xxx_timer_sysc = {
 			   SYSC_HAS_EMUFREE | SYSC_HAS_AUTOIDLE |
 			   SYSS_HAS_RESET_STATUS),
 	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART),
-	.clockact	= CLOCKACT_TEST_ICLK,
 	.sysc_fields	= &omap_hwmod_sysc_type1,
 };
 
@@ -424,7 +423,6 @@ static struct omap_hwmod_class_sysconfig i2c_sysc = {
 			   SYSC_HAS_ENAWAKEUP | SYSC_HAS_SOFTRESET |
 			   SYSC_HAS_AUTOIDLE | SYSS_HAS_RESET_STATUS),
 	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART),
-	.clockact	= CLOCKACT_TEST_ICLK,
 	.sysc_fields    = &omap_hwmod_sysc_type1,
 };
 
@@ -1045,7 +1043,6 @@ static struct omap_hwmod_class_sysconfig omap3xxx_mcbsp_sysc = {
 			   SYSC_HAS_SIDLEMODE | SYSC_HAS_SOFTRESET),
 	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART),
 	.sysc_fields	= &omap_hwmod_sysc_type1,
-	.clockact	= 0x2,
 };
 
 static struct omap_hwmod_class omap3xxx_mcbsp_hwmod_class = {
@@ -1210,7 +1207,6 @@ static struct omap_hwmod_sysc_fields omap34xx_sr_sysc_fields = {
 static struct omap_hwmod_class_sysconfig omap34xx_sr_sysc = {
 	.sysc_offs	= 0x24,
 	.sysc_flags	= (SYSC_HAS_CLOCKACTIVITY | SYSC_NO_CACHE),
-	.clockact	= CLOCKACT_TEST_ICLK,
 	.sysc_fields	= &omap34xx_sr_sysc_fields,
 };
 
diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -1320,7 +1320,6 @@ static struct omap_hwmod_class_sysconfig omap44xx_i2c_sysc = {
 			   SYSC_HAS_SOFTRESET | SYSS_HAS_RESET_STATUS),
 	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART |
 			   SIDLE_SMART_WKUP),
-	.clockact	= CLOCKACT_TEST_ICLK,
 	.sysc_fields	= &omap_hwmod_sysc_type1,
 };
 
@@ -2548,7 +2547,6 @@ static struct omap_hwmod_class_sysconfig omap44xx_timer_1ms_sysc = {
 			   SYSC_HAS_SIDLEMODE | SYSC_HAS_SOFTRESET |
 			   SYSS_HAS_RESET_STATUS),
 	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART),
-	.clockact	= CLOCKACT_TEST_ICLK,
 	.sysc_fields	= &omap_hwmod_sysc_type1,
 };
 
diff --git a/arch/arm/mach-omap2/omap_hwmod_54xx_data.c b/arch/arm/mach-omap2/omap_hwmod_54xx_data.c
--- a/arch/arm/mach-omap2/omap_hwmod_54xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_54xx_data.c
@@ -839,7 +839,6 @@ static struct omap_hwmod_class_sysconfig omap54xx_i2c_sysc = {
 			   SYSC_HAS_SOFTRESET | SYSS_HAS_RESET_STATUS),
 	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART |
 			   SIDLE_SMART_WKUP),
-	.clockact	= CLOCKACT_TEST_ICLK,
 	.sysc_fields	= &omap_hwmod_sysc_type1,
 };
 
@@ -1530,7 +1529,6 @@ static struct omap_hwmod_class_sysconfig omap54xx_timer_1ms_sysc = {
 	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART |
 			   SIDLE_SMART_WKUP),
 	.sysc_fields	= &omap_hwmod_sysc_type2,
-	.clockact	= CLOCKACT_TEST_ICLK,
 };
 
 static struct omap_hwmod_class omap54xx_timer_1ms_hwmod_class = {
diff --git a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
--- a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
@@ -1098,7 +1098,6 @@ static struct omap_hwmod_class_sysconfig dra7xx_i2c_sysc = {
 			   SYSC_HAS_SOFTRESET | SYSS_HAS_RESET_STATUS),
 	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART |
 			   SIDLE_SMART_WKUP),
-	.clockact	= CLOCKACT_TEST_ICLK,
 	.sysc_fields	= &omap_hwmod_sysc_type1,
 };
 
-- 
2.11.1
