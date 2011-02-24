From: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Subject: [PATCH v11 2/8] OMAP4: hwmod data: add dmtimer version information
Date: Thu, 24 Feb 2011 16:56:45 +0530
Message-ID: <1298546811-27055-3-git-send-email-tarun.kanti@ti.com>
References: <1298546811-27055-1-git-send-email-tarun.kanti@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:41064 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756167Ab1BXLYo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Feb 2011 06:24:44 -0500
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id p1OBOeti027439
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 24 Feb 2011 05:24:43 -0600
In-Reply-To: <1298546811-27055-1-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tarun Kanti DebBarma <tarun.kanti@ti.com>

OMAP4 has two groups of timers: version 1 timers are 1, 2, 10,
while the rest of the timers, 3-9, 11 are version 2 timers.
The version information is required by the driver so that they
could be handled correctly by it.

Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    3 +++
 arch/arm/plat-omap/include/plat/dmtimer.h  |    2 ++
 2 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index 79a8601..ee57742 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -25,6 +25,7 @@
 #include <plat/gpio.h>
 #include <plat/dma.h>
 #include <plat/mcspi.h>
+#include <plat/dmtimer.h>
 
 #include "omap_hwmod_common_data.h"
 
@@ -3940,6 +3941,7 @@ static struct omap_hwmod_class_sysconfig omap44xx_timer_1ms_sysc = {
 static struct omap_hwmod_class omap44xx_timer_1ms_hwmod_class = {
 	.name	= "timer",
 	.sysc	= &omap44xx_timer_1ms_sysc,
+	.rev = OMAP_TIMER_IP_VERSION_1,
 };
 
 static struct omap_hwmod_class_sysconfig omap44xx_timer_sysc = {
@@ -3955,6 +3957,7 @@ static struct omap_hwmod_class_sysconfig omap44xx_timer_sysc = {
 static struct omap_hwmod_class omap44xx_timer_hwmod_class = {
 	.name	= "timer",
 	.sysc	= &omap44xx_timer_sysc,
+	.rev = OMAP_TIMER_IP_VERSION_2,
 };
 
 /* timer1 */
diff --git a/arch/arm/plat-omap/include/plat/dmtimer.h b/arch/arm/plat-omap/include/plat/dmtimer.h
index d6c70d2..05a967e 100644
--- a/arch/arm/plat-omap/include/plat/dmtimer.h
+++ b/arch/arm/plat-omap/include/plat/dmtimer.h
@@ -55,6 +55,8 @@
  * in OMAP4 can be distinguished.
  */
 #define OMAP_TIMER_IP_VERSION_1                        0x1
+#define OMAP_TIMER_IP_VERSION_2                        0x2
+
 struct omap_dm_timer;
 extern struct omap_dm_timer *gptimer_wakeup;
 extern struct sys_timer omap_timer;
-- 
1.6.0.4

