From: "Avinash.H.M" <avinashhm@ti.com>
Subject: [PATCH] omap: hwmod: add syss reset done flags to omap2, omap3 hwmods
Date: Thu, 24 Feb 2011 15:38:43 +0530
Message-ID: <1298542123-3654-1-git-send-email-avinashhm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:39637 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753863Ab1BXKJa (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 24 Feb 2011 05:09:30 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: "Avinash.H.M" <avinashhm@ti.com>, Rajendra Nayak <rnayak@ti.com>, Paul Walmsley <paul@pwsan.com>, Benoit Cousson <b-cousson@ti.com>, Kevin Hilman <khilman@ti.com>

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
---
The patch is based on linux-omap tree, master branch on commit:
e10eed954a2525c5d0b6dc361cdcbb46fea69d50

Testing:
build testing   : omap2plus_defconfig
boot testing    : 2420h4, 2430sdp.
[ boot test was done on omap-fixes-for-linus branch, commit
1232a185ddd500b61b8dc389ad1a357e6b425548 , since master branch wasn't booting
on 2420 and 2430 ].

pm testing      : tested core off in cpuidle patch in 3430sdp.
[ kevins 'i2c: OMAP: fix static suspend vs. runtime suspend' fix was needed to
have core off working. ]. core off works in cpuidle patch.

below configurations needed for core off in cpuidle:
echo 1 > /debug/pm_debug/sleep_while_idle
echo 1 > /debug/pm_debug/enable_off_mode
echo 5 > /sys/devices/platform/omap/omap_uart.0/sleep_timeout
echo 5 > /sys/devices/platform/omap/omap_uart.1/sleep_timeout
echo 5 > /sys/devices/platform/omap/omap_uart.2/sleep_timeout
echo enabled > /sys/devices/platform/omap/omap_uart.0/tty/ttyO0/power/wakeup
echo enabled > /sys/devices/platform/omap/omap_uart.1/tty/ttyO1/power/wakeup
echo enabled > /sys/devices/platform/omap/omap_uart.2/tty/ttyO2/power/wakeup

 arch/arm/mach-omap2/omap_hwmod_2420_data.c |   11 ++++++-----
 arch/arm/mach-omap2/omap_hwmod_2430_data.c |   12 +++++++-----
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |   13 ++++++++-----
 3 files changed, 21 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_2420_data.c b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
index b85c630..e8046b4 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2420_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
@@ -308,7 +308,7 @@ static struct omap_hwmod_class_sysconfig omap2420_wd_timer_sysc = {
 	.sysc_offs	= 0x0010,
 	.syss_offs	= 0x0014,
 	.sysc_flags	= (SYSC_HAS_EMUFREE | SYSC_HAS_SOFTRESET |
-			   SYSC_HAS_AUTOIDLE),
+			   SYSC_HAS_AUTOIDLE | SYSS_HAS_RESET_STATUS),
 	.sysc_fields    = &omap_hwmod_sysc_type1,
 };
 
@@ -349,7 +349,7 @@ static struct omap_hwmod_class_sysconfig uart_sysc = {
 	.syss_offs	= 0x58,
 	.sysc_flags	= (SYSC_HAS_SIDLEMODE |
 			   SYSC_HAS_ENAWAKEUP | SYSC_HAS_SOFTRESET |
-			   SYSC_HAS_AUTOIDLE),
+			   SYSC_HAS_AUTOIDLE | SYSS_HAS_RESET_STATUS),
 	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART),
 	.sysc_fields    = &omap_hwmod_sysc_type1,
 };
@@ -475,7 +475,7 @@ static struct omap_hwmod_class_sysconfig i2c_sysc = {
 	.rev_offs	= 0x00,
 	.sysc_offs	= 0x20,
 	.syss_offs	= 0x10,
-	.sysc_flags	= SYSC_HAS_SOFTRESET,
+	.sysc_flags	= (SYSC_HAS_SOFTRESET | SYSS_HAS_RESET_STATUS),
 	.sysc_fields	= &omap_hwmod_sysc_type1,
 };
 
@@ -647,7 +647,8 @@ static struct omap_hwmod_class_sysconfig omap242x_gpio_sysc = {
 	.sysc_offs	= 0x0010,
 	.syss_offs	= 0x0014,
 	.sysc_flags	= (SYSC_HAS_ENAWAKEUP | SYSC_HAS_SIDLEMODE |
-			   SYSC_HAS_SOFTRESET | SYSC_HAS_AUTOIDLE),
+			   SYSC_HAS_SOFTRESET | SYSC_HAS_AUTOIDLE |
+			   SYSS_HAS_RESET_STATUS),
 	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART),
 	.sysc_fields    = &omap_hwmod_sysc_type1,
 };
@@ -789,7 +790,7 @@ static struct omap_hwmod_class_sysconfig omap2420_dma_sysc = {
 	.syss_offs	= 0x0028,
 	.sysc_flags	= (SYSC_HAS_SOFTRESET | SYSC_HAS_MIDLEMODE |
 			   SYSC_HAS_CLOCKACTIVITY | SYSC_HAS_EMUFREE |
-			   SYSC_HAS_AUTOIDLE),
+			   SYSC_HAS_AUTOIDLE | SYSS_HAS_RESET_STATUS),
 	.idlemodes	= (MSTANDBY_FORCE | MSTANDBY_NO | MSTANDBY_SMART),
 	.sysc_fields	= &omap_hwmod_sysc_type1,
 };
diff --git a/arch/arm/mach-omap2/omap_hwmod_2430_data.c b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
index 8ecfbcd..115eed5 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2430_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
@@ -307,7 +307,7 @@ static struct omap_hwmod_class_sysconfig omap2430_wd_timer_sysc = {
 	.sysc_offs	= 0x0010,
 	.syss_offs	= 0x0014,
 	.sysc_flags	= (SYSC_HAS_EMUFREE | SYSC_HAS_SOFTRESET |
-			   SYSC_HAS_AUTOIDLE),
+			   SYSC_HAS_AUTOIDLE | SYSS_HAS_RESET_STATUS),
 	.sysc_fields    = &omap_hwmod_sysc_type1,
 };
 
@@ -348,7 +348,7 @@ static struct omap_hwmod_class_sysconfig uart_sysc = {
 	.syss_offs	= 0x58,
 	.sysc_flags	= (SYSC_HAS_SIDLEMODE |
 			   SYSC_HAS_ENAWAKEUP | SYSC_HAS_SOFTRESET |
-			   SYSC_HAS_AUTOIDLE),
+			   SYSC_HAS_AUTOIDLE | SYSS_HAS_RESET_STATUS),
 	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART),
 	.sysc_fields    = &omap_hwmod_sysc_type1,
 };
@@ -474,7 +474,8 @@ static struct omap_hwmod_class_sysconfig i2c_sysc = {
 	.rev_offs	= 0x00,
 	.sysc_offs	= 0x20,
 	.syss_offs	= 0x10,
-	.sysc_flags	= (SYSC_HAS_SOFTRESET | SYSC_HAS_AUTOIDLE),
+	.sysc_flags	= (SYSC_HAS_SOFTRESET | SYSC_HAS_AUTOIDLE |
+			   SYSS_HAS_RESET_STATUS),
 	.sysc_fields	= &omap_hwmod_sysc_type1,
 };
 
@@ -672,7 +673,8 @@ static struct omap_hwmod_class_sysconfig omap243x_gpio_sysc = {
 	.sysc_offs	= 0x0010,
 	.syss_offs	= 0x0014,
 	.sysc_flags	= (SYSC_HAS_ENAWAKEUP | SYSC_HAS_SIDLEMODE |
-			   SYSC_HAS_SOFTRESET | SYSC_HAS_AUTOIDLE),
+			   SYSC_HAS_SOFTRESET | SYSC_HAS_AUTOIDLE |
+			   SYSS_HAS_RESET_STATUS),
 	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART),
 	.sysc_fields    = &omap_hwmod_sysc_type1,
 };
@@ -844,7 +846,7 @@ static struct omap_hwmod_class_sysconfig omap2430_dma_sysc = {
 	.syss_offs	= 0x0028,
 	.sysc_flags	= (SYSC_HAS_SOFTRESET | SYSC_HAS_MIDLEMODE |
 			   SYSC_HAS_CLOCKACTIVITY | SYSC_HAS_EMUFREE |
-			   SYSC_HAS_AUTOIDLE),
+			   SYSC_HAS_AUTOIDLE | SYSS_HAS_RESET_STATUS),
 	.idlemodes	= (MSTANDBY_FORCE | MSTANDBY_NO | MSTANDBY_SMART),
 	.sysc_fields	= &omap_hwmod_sysc_type1,
 };
diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index 8d81813..acf0d54 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -447,7 +447,8 @@ static struct omap_hwmod_class_sysconfig omap3xxx_wd_timer_sysc = {
 	.syss_offs	= 0x0014,
 	.sysc_flags	= (SYSC_HAS_SIDLEMODE | SYSC_HAS_EMUFREE |
 			   SYSC_HAS_ENAWAKEUP | SYSC_HAS_SOFTRESET |
-			   SYSC_HAS_AUTOIDLE | SYSC_HAS_CLOCKACTIVITY),
+			   SYSC_HAS_AUTOIDLE | SYSC_HAS_CLOCKACTIVITY |
+			   SYSS_HAS_RESET_STATUS),
 	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART),
 	.sysc_fields    = &omap_hwmod_sysc_type1,
 };
@@ -459,7 +460,7 @@ static struct omap_hwmod_class_sysconfig i2c_sysc = {
 	.syss_offs	= 0x10,
 	.sysc_flags	= (SYSC_HAS_CLOCKACTIVITY | SYSC_HAS_SIDLEMODE |
 			   SYSC_HAS_ENAWAKEUP | SYSC_HAS_SOFTRESET |
-			   SYSC_HAS_AUTOIDLE),
+			   SYSC_HAS_AUTOIDLE | SYSS_HAS_RESET_STATUS),
 	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART),
 	.sysc_fields    = &omap_hwmod_sysc_type1,
 };
@@ -501,7 +502,7 @@ static struct omap_hwmod_class_sysconfig uart_sysc = {
 	.syss_offs	= 0x58,
 	.sysc_flags	= (SYSC_HAS_SIDLEMODE |
 			   SYSC_HAS_ENAWAKEUP | SYSC_HAS_SOFTRESET |
-			   SYSC_HAS_AUTOIDLE),
+			   SYSC_HAS_AUTOIDLE | SYSS_HAS_RESET_STATUS),
 	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART),
 	.sysc_fields    = &omap_hwmod_sysc_type1,
 };
@@ -902,7 +903,8 @@ static struct omap_hwmod_class_sysconfig omap3xxx_gpio_sysc = {
 	.sysc_offs	= 0x0010,
 	.syss_offs	= 0x0014,
 	.sysc_flags	= (SYSC_HAS_ENAWAKEUP | SYSC_HAS_SIDLEMODE |
-			   SYSC_HAS_SOFTRESET | SYSC_HAS_AUTOIDLE),
+			   SYSC_HAS_SOFTRESET | SYSC_HAS_AUTOIDLE |
+			   SYSS_HAS_RESET_STATUS),
 	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART),
 	.sysc_fields    = &omap_hwmod_sysc_type1,
 };
@@ -1156,7 +1158,8 @@ static struct omap_hwmod_class_sysconfig omap3xxx_dma_sysc = {
 	.syss_offs	= 0x0028,
 	.sysc_flags	= (SYSC_HAS_SIDLEMODE | SYSC_HAS_SOFTRESET |
 			   SYSC_HAS_MIDLEMODE | SYSC_HAS_CLOCKACTIVITY |
-			   SYSC_HAS_EMUFREE | SYSC_HAS_AUTOIDLE),
+			   SYSC_HAS_EMUFREE | SYSC_HAS_AUTOIDLE |
+			   SYSS_HAS_RESET_STATUS),
 	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART |
 			   MSTANDBY_FORCE | MSTANDBY_NO | MSTANDBY_SMART),
 	.sysc_fields	= &omap_hwmod_sysc_type1,
-- 
1.7.1

