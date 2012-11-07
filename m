From: Jon Hunter <jon-hunter@ti.com>
Subject: [PATCH V2 05/14] ARM: OMAP3: Correct HWMOD DMTIMER SYSC register declarations
Date: Wed, 7 Nov 2012 13:01:21 -0600
Message-ID: <1352314890-22224-6-git-send-email-jon-hunter@ti.com>
References: <1352314890-22224-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:36360 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754116Ab2KGTBo (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 7 Nov 2012 14:01:44 -0500
In-Reply-To: <1352314890-22224-1-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Jon Hunter <jon-hunter@ti.com>

Currently, the OMAP3 HWMOD data defines two TIOCP_CFG register structures
(referred to as the SYSC register in the HWMOD data) where timers 1, 2 and 10
use one of the defintions and the other timers use the other definition. For
OMAP3 devices the structure of the DMTIMER TIOCP_CFG register is the same for
all 12 instances of the DMTIMER. Please note that this is a difference between
OMAP3 and OMAP4 and could be the source of the confusion.

For OMAP3 devices, the DMTIMER TIOCP_CFG register has the fields,
clock-activity, emufree, idlemode, enwakeup, softreset and autoidle for all
12 timers. Therefore, remove one of the SYSC register definitions for the
DMTIMERs and ensure the appropriate register fields are defined for all
DMTIMERs.

Signed-off-by: Jon Hunter <jon-hunter@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |   27 ++++++---------------------
 1 file changed, 6 insertions(+), 21 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index f67b7ee..679c0ec 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -149,28 +149,13 @@ static struct omap_hwmod omap3xxx_debugss_hwmod = {
 };
 
 /* timer class */
-static struct omap_hwmod_class_sysconfig omap3xxx_timer_1ms_sysc = {
-	.rev_offs	= 0x0000,
-	.sysc_offs	= 0x0010,
-	.syss_offs	= 0x0014,
-	.sysc_flags	= (SYSC_HAS_SIDLEMODE | SYSC_HAS_CLOCKACTIVITY |
-				SYSC_HAS_ENAWAKEUP | SYSC_HAS_SOFTRESET |
-				SYSC_HAS_EMUFREE | SYSC_HAS_AUTOIDLE),
-	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART),
-	.sysc_fields	= &omap_hwmod_sysc_type1,
-};
-
-static struct omap_hwmod_class omap3xxx_timer_1ms_hwmod_class = {
-	.name = "timer",
-	.sysc = &omap3xxx_timer_1ms_sysc,
-};
-
 static struct omap_hwmod_class_sysconfig omap3xxx_timer_sysc = {
 	.rev_offs	= 0x0000,
 	.sysc_offs	= 0x0010,
 	.syss_offs	= 0x0014,
-	.sysc_flags	= (SYSC_HAS_SIDLEMODE | SYSC_HAS_ENAWAKEUP |
-			   SYSC_HAS_SOFTRESET | SYSC_HAS_AUTOIDLE),
+	.sysc_flags	= (SYSC_HAS_SIDLEMODE | SYSC_HAS_CLOCKACTIVITY |
+			   SYSC_HAS_ENAWAKEUP | SYSC_HAS_SOFTRESET |
+			   SYSC_HAS_EMUFREE | SYSC_HAS_AUTOIDLE),
 	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART),
 	.sysc_fields	= &omap_hwmod_sysc_type1,
 };
@@ -220,7 +205,7 @@ static struct omap_hwmod omap3xxx_timer1_hwmod = {
 		},
 	},
 	.dev_attr	= &capability_alwon_dev_attr,
-	.class		= &omap3xxx_timer_1ms_hwmod_class,
+	.class		= &omap3xxx_timer_hwmod_class,
 };
 
 /* timer2 */
@@ -237,7 +222,7 @@ static struct omap_hwmod omap3xxx_timer2_hwmod = {
 			.idlest_idle_bit = OMAP3430_ST_GPT2_SHIFT,
 		},
 	},
-	.class		= &omap3xxx_timer_1ms_hwmod_class,
+	.class		= &omap3xxx_timer_hwmod_class,
 };
 
 /* timer3 */
@@ -379,7 +364,7 @@ static struct omap_hwmod omap3xxx_timer10_hwmod = {
 		},
 	},
 	.dev_attr	= &capability_pwm_dev_attr,
-	.class		= &omap3xxx_timer_1ms_hwmod_class,
+	.class		= &omap3xxx_timer_hwmod_class,
 };
 
 /* timer11 */
-- 
1.7.9.5

