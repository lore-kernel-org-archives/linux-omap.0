From: Ameya Palande <ameya.palande@nokia.com>
Subject: [PATCH] OMAP: PM: Export functions from OMAP NOOP PM interface
Date: Tue, 22 Sep 2009 18:54:18 +0300
Message-ID: <1253634858-7883-1-git-send-email-ameya.palande@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:32952 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751761AbZIVPye (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Sep 2009 11:54:34 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com, paul@pwsan.com

Without this patch, a driver which uses these symbols will break when user
selects NOOP PM interface.

Signed-off-by: Ameya Palande <ameya.palande@nokia.com>
---
 arch/arm/plat-omap/omap-pm-noop.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/omap-pm-noop.c b/arch/arm/plat-omap/omap-pm-noop.c
index 3b075de..10463a4 100644
--- a/arch/arm/plat-omap/omap-pm-noop.c
+++ b/arch/arm/plat-omap/omap-pm-noop.c
@@ -157,6 +157,7 @@ const struct omap_opp *omap_pm_dsp_get_opp_table(void)
 
 	return NULL;
 }
+EXPORT_SYMBOL(omap_pm_dsp_get_opp_table);
 
 void omap_pm_dsp_set_min_opp(u8 opp_id)
 {
@@ -181,7 +182,7 @@ void omap_pm_dsp_set_min_opp(u8 opp_id)
 	 *
 	 */
 }
-
+EXPORT_SYMBOL(omap_pm_dsp_set_min_opp);
 
 u8 omap_pm_dsp_get_opp(void)
 {
@@ -197,6 +198,7 @@ u8 omap_pm_dsp_get_opp(void)
 
 	return 0;
 }
+EXPORT_SYMBOL(omap_pm_dsp_get_opp);
 
 u8 omap_pm_vdd1_get_opp(void)
 {
@@ -208,6 +210,7 @@ u8 omap_pm_vdd1_get_opp(void)
 
 	return 0;
 }
+EXPORT_SYMBOL(omap_pm_vdd1_get_opp);
 
 u8 omap_pm_vdd2_get_opp(void)
 {
@@ -219,6 +222,7 @@ u8 omap_pm_vdd2_get_opp(void)
 
 	return 0;
 }
+EXPORT_SYMBOL(omap_pm_vdd2_get_opp);
 
 /*
  * CPUFreq-originated constraint
@@ -259,6 +263,7 @@ void omap_pm_cpu_set_freq(unsigned long f)
 	 * CDP should just be able to set the VDD1 OPP clock rate here.
 	 */
 }
+EXPORT_SYMBOL(omap_pm_cpu_set_freq);
 
 unsigned long omap_pm_cpu_get_freq(void)
 {
@@ -270,6 +275,7 @@ unsigned long omap_pm_cpu_get_freq(void)
 
 	return 0;
 }
+EXPORT_SYMBOL(omap_pm_cpu_get_freq);
 
 /*
  * Device context loss tracking
-- 
1.6.2.4

