From: Jon Hunter <jon-hunter@ti.com>
Subject: [PATCH 03/10] ARM: OMAP3: Correct HWMOD DMTIMER SYSC register declarations
Date: Wed, 5 Sep 2012 14:04:25 -0500
Message-ID: <1346871872-24413-4-git-send-email-jon-hunter@ti.com>
References: <1346871872-24413-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:33124 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758989Ab2IETEu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Sep 2012 15:04:50 -0400
In-Reply-To: <1346871872-24413-1-git-send-email-jon-hunter@ti.com>
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
index c9e3820..659f7c4 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -115,28 +115,13 @@ static struct omap_hwmod omap3xxx_iva_hwmod = {
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
@@ -176,7 +161,7 @@ static struct omap_hwmod omap3xxx_timer1_hwmod = {
 		},
 	},
 	.dev_attr	= &capability_alwon_dev_attr,
-	.class		= &omap3xxx_timer_1ms_hwmod_class,
+	.class		= &omap3xxx_timer_hwmod_class,
 };
 
 /* timer2 */
@@ -193,7 +178,7 @@ static struct omap_hwmod omap3xxx_timer2_hwmod = {
 			.idlest_idle_bit = OMAP3430_ST_GPT2_SHIFT,
 		},
 	},
-	.class		= &omap3xxx_timer_1ms_hwmod_class,
+	.class		= &omap3xxx_timer_hwmod_class,
 };
 
 /* timer3 */
@@ -332,7 +317,7 @@ static struct omap_hwmod omap3xxx_timer10_hwmod = {
 		},
 	},
 	.dev_attr	= &capability_pwm_dev_attr,
-	.class		= &omap3xxx_timer_1ms_hwmod_class,
+	.class		= &omap3xxx_timer_hwmod_class,
 };
 
 /* timer11 */
-- 
1.7.9.5

