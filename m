From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 2/5] omap: hwmod: add syss reset done flags to omap2,
	omap3 hwmods
Date: Mon, 07 Mar 2011 22:44:29 -0700
Message-ID: <20110308054428.1309.70008.stgit@twilight.localdomain>
References: <20110308054315.1309.10538.stgit@twilight.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:60571 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752672Ab1CHFp0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Mar 2011 00:45:26 -0500
In-Reply-To: <20110308054315.1309.10538.stgit@twilight.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Kevin Hilman <khilman@ti.com>, "Govindraj.R" <govindraj.raja@ti.com>, Rajendra Nayak <rnayak@ti.com>, Benoit Cousson <b-cousson@ti.com>, "Avinash.H.M" <avinashhm@ti.com>

From: Avinash.H.M <avinashhm@ti.com>

Some of the omap2, omap3 peripherals support software reset. This
can be done through the softreset bit in sysconfig register.
The reset status can be checked through resetdone bit of
sysstatus register. syss_has_reset_status is added to the hwmod
database of peripherals which have resetdone bit in sysstatus register.

Cc: Rajendra Nayak <rnayak@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Benoit Cousson <b-cousson@ti.com>
Cc: Kevin Hilman <khilman@ti.com>
Reviewed-by: Govindraj.R <govindraj.raja@ti.com>
Signed-off-by: Avinash.H.M <avinashhm@ti.com>
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/omap_hwmod_2420_data.c |   11 ++++++-----
 arch/arm/mach-omap2/omap_hwmod_2430_data.c |   12 +++++++-----
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |   13 ++++++++-----
 3 files changed, 21 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_2420_data.c b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
index f323c6b..de3ac63 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2420_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
@@ -366,7 +366,7 @@ static struct omap_hwmod_class_sysconfig omap2420_wd_timer_sysc = {
 	.sysc_offs	= 0x0010,
 	.syss_offs	= 0x0014,
 	.sysc_flags	= (SYSC_HAS_EMUFREE | SYSC_HAS_SOFTRESET |
-			   SYSC_HAS_AUTOIDLE),
+			   SYSC_HAS_AUTOIDLE | SYSS_HAS_RESET_STATUS),
 	.sysc_fields    = &omap_hwmod_sysc_type1,
 };
 
@@ -407,7 +407,7 @@ static struct omap_hwmod_class_sysconfig uart_sysc = {
 	.syss_offs	= 0x58,
 	.sysc_flags	= (SYSC_HAS_SIDLEMODE |
 			   SYSC_HAS_ENAWAKEUP | SYSC_HAS_SOFTRESET |
-			   SYSC_HAS_AUTOIDLE),
+			   SYSC_HAS_AUTOIDLE | SYSS_HAS_RESET_STATUS),
 	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART),
 	.sysc_fields    = &omap_hwmod_sysc_type1,
 };
@@ -818,7 +818,7 @@ static struct omap_hwmod_class_sysconfig i2c_sysc = {
 	.rev_offs	= 0x00,
 	.sysc_offs	= 0x20,
 	.syss_offs	= 0x10,
-	.sysc_flags	= SYSC_HAS_SOFTRESET,
+	.sysc_flags	= (SYSC_HAS_SOFTRESET | SYSS_HAS_RESET_STATUS),
 	.sysc_fields	= &omap_hwmod_sysc_type1,
 };
 
@@ -990,7 +990,8 @@ static struct omap_hwmod_class_sysconfig omap242x_gpio_sysc = {
 	.sysc_offs	= 0x0010,
 	.syss_offs	= 0x0014,
 	.sysc_flags	= (SYSC_HAS_ENAWAKEUP | SYSC_HAS_SIDLEMODE |
-			   SYSC_HAS_SOFTRESET | SYSC_HAS_AUTOIDLE),
+			   SYSC_HAS_SOFTRESET | SYSC_HAS_AUTOIDLE |
+			   SYSS_HAS_RESET_STATUS),
 	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART),
 	.sysc_fields    = &omap_hwmod_sysc_type1,
 };
@@ -1132,7 +1133,7 @@ static struct omap_hwmod_class_sysconfig omap2420_dma_sysc = {
 	.syss_offs	= 0x0028,
 	.sysc_flags	= (SYSC_HAS_SOFTRESET | SYSC_HAS_MIDLEMODE |
 			   SYSC_HAS_CLOCKACTIVITY | SYSC_HAS_EMUFREE |
-			   SYSC_HAS_AUTOIDLE),
+			   SYSC_HAS_AUTOIDLE | SYSS_HAS_RESET_STATUS),
 	.idlemodes	= (MSTANDBY_FORCE | MSTANDBY_NO | MSTANDBY_SMART),
 	.sysc_fields	= &omap_hwmod_sysc_type1,
 };
diff --git a/arch/arm/mach-omap2/omap_hwmod_2430_data.c b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
index de0015d..a791957 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2430_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
@@ -422,7 +422,7 @@ static struct omap_hwmod_class_sysconfig omap2430_wd_timer_sysc = {
 	.sysc_offs	= 0x0010,
 	.syss_offs	= 0x0014,
 	.sysc_flags	= (SYSC_HAS_EMUFREE | SYSC_HAS_SOFTRESET |
-			   SYSC_HAS_AUTOIDLE),
+			   SYSC_HAS_AUTOIDLE | SYSS_HAS_RESET_STATUS),
 	.sysc_fields    = &omap_hwmod_sysc_type1,
 };
 
@@ -463,7 +463,7 @@ static struct omap_hwmod_class_sysconfig uart_sysc = {
 	.syss_offs	= 0x58,
 	.sysc_flags	= (SYSC_HAS_SIDLEMODE |
 			   SYSC_HAS_ENAWAKEUP | SYSC_HAS_SOFTRESET |
-			   SYSC_HAS_AUTOIDLE),
+			   SYSC_HAS_AUTOIDLE | SYSS_HAS_RESET_STATUS),
 	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART),
 	.sysc_fields    = &omap_hwmod_sysc_type1,
 };
@@ -849,7 +849,8 @@ static struct omap_hwmod_class_sysconfig i2c_sysc = {
 	.rev_offs	= 0x00,
 	.sysc_offs	= 0x20,
 	.syss_offs	= 0x10,
-	.sysc_flags	= (SYSC_HAS_SOFTRESET | SYSC_HAS_AUTOIDLE),
+	.sysc_flags	= (SYSC_HAS_SOFTRESET | SYSC_HAS_AUTOIDLE |
+			   SYSS_HAS_RESET_STATUS),
 	.sysc_fields	= &omap_hwmod_sysc_type1,
 };
 
@@ -1047,7 +1048,8 @@ static struct omap_hwmod_class_sysconfig omap243x_gpio_sysc = {
 	.sysc_offs	= 0x0010,
 	.syss_offs	= 0x0014,
 	.sysc_flags	= (SYSC_HAS_ENAWAKEUP | SYSC_HAS_SIDLEMODE |
-			   SYSC_HAS_SOFTRESET | SYSC_HAS_AUTOIDLE),
+			   SYSC_HAS_SOFTRESET | SYSC_HAS_AUTOIDLE |
+			   SYSS_HAS_RESET_STATUS),
 	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART),
 	.sysc_fields    = &omap_hwmod_sysc_type1,
 };
@@ -1219,7 +1221,7 @@ static struct omap_hwmod_class_sysconfig omap2430_dma_sysc = {
 	.syss_offs	= 0x0028,
 	.sysc_flags	= (SYSC_HAS_SOFTRESET | SYSC_HAS_MIDLEMODE |
 			   SYSC_HAS_CLOCKACTIVITY | SYSC_HAS_EMUFREE |
-			   SYSC_HAS_AUTOIDLE),
+			   SYSC_HAS_AUTOIDLE | SYSS_HAS_RESET_STATUS),
 	.idlemodes	= (MSTANDBY_FORCE | MSTANDBY_NO | MSTANDBY_SMART),
 	.sysc_fields	= &omap_hwmod_sysc_type1,
 };
diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index e9d0012..33bae0a 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -545,7 +545,8 @@ static struct omap_hwmod_class_sysconfig omap3xxx_wd_timer_sysc = {
 	.syss_offs	= 0x0014,
 	.sysc_flags	= (SYSC_HAS_SIDLEMODE | SYSC_HAS_EMUFREE |
 			   SYSC_HAS_ENAWAKEUP | SYSC_HAS_SOFTRESET |
-			   SYSC_HAS_AUTOIDLE | SYSC_HAS_CLOCKACTIVITY),
+			   SYSC_HAS_AUTOIDLE | SYSC_HAS_CLOCKACTIVITY |
+			   SYSS_HAS_RESET_STATUS),
 	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART),
 	.sysc_fields    = &omap_hwmod_sysc_type1,
 };
@@ -557,7 +558,7 @@ static struct omap_hwmod_class_sysconfig i2c_sysc = {
 	.syss_offs	= 0x10,
 	.sysc_flags	= (SYSC_HAS_CLOCKACTIVITY | SYSC_HAS_SIDLEMODE |
 			   SYSC_HAS_ENAWAKEUP | SYSC_HAS_SOFTRESET |
-			   SYSC_HAS_AUTOIDLE),
+			   SYSC_HAS_AUTOIDLE | SYSS_HAS_RESET_STATUS),
 	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART),
 	.sysc_fields    = &omap_hwmod_sysc_type1,
 };
@@ -599,7 +600,7 @@ static struct omap_hwmod_class_sysconfig uart_sysc = {
 	.syss_offs	= 0x58,
 	.sysc_flags	= (SYSC_HAS_SIDLEMODE |
 			   SYSC_HAS_ENAWAKEUP | SYSC_HAS_SOFTRESET |
-			   SYSC_HAS_AUTOIDLE),
+			   SYSC_HAS_AUTOIDLE | SYSS_HAS_RESET_STATUS),
 	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART),
 	.sysc_fields    = &omap_hwmod_sysc_type1,
 };
@@ -1404,7 +1405,8 @@ static struct omap_hwmod_class_sysconfig omap3xxx_gpio_sysc = {
 	.sysc_offs	= 0x0010,
 	.syss_offs	= 0x0014,
 	.sysc_flags	= (SYSC_HAS_ENAWAKEUP | SYSC_HAS_SIDLEMODE |
-			   SYSC_HAS_SOFTRESET | SYSC_HAS_AUTOIDLE),
+			   SYSC_HAS_SOFTRESET | SYSC_HAS_AUTOIDLE |
+			   SYSS_HAS_RESET_STATUS),
 	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART),
 	.sysc_fields    = &omap_hwmod_sysc_type1,
 };
@@ -1658,7 +1660,8 @@ static struct omap_hwmod_class_sysconfig omap3xxx_dma_sysc = {
 	.syss_offs	= 0x0028,
 	.sysc_flags	= (SYSC_HAS_SIDLEMODE | SYSC_HAS_SOFTRESET |
 			   SYSC_HAS_MIDLEMODE | SYSC_HAS_CLOCKACTIVITY |
-			   SYSC_HAS_EMUFREE | SYSC_HAS_AUTOIDLE),
+			   SYSC_HAS_EMUFREE | SYSC_HAS_AUTOIDLE |
+			   SYSS_HAS_RESET_STATUS),
 	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART |
 			   MSTANDBY_FORCE | MSTANDBY_NO | MSTANDBY_SMART),
 	.sysc_fields	= &omap_hwmod_sysc_type1,


