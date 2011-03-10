From: Kalle Jokiniemi <kalle.jokiniemi@nokia.com>
Subject: [PATCH 2/2] OMAP3: wdtimer: Disable SMART idle mode
Date: Thu, 10 Mar 2011 11:32:49 +0200
Message-ID: <1299749569-22673-3-git-send-email-kalle.jokiniemi@nokia.com>
References: <1299749569-22673-1-git-send-email-kalle.jokiniemi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.128.26]:17650 "EHLO mgw-da02.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752210Ab1CJJej (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 10 Mar 2011 04:34:39 -0500
In-Reply-To: <1299749569-22673-1-git-send-email-kalle.jokiniemi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com, khilman@ti.com, linux-omap@vger.kernel.org
Cc: ilkka.koskinen@nokia.com, jhnikula@gmail.com, b-cousson@ti.com, Kalle Jokiniemi <kalle.jokiniemi@nokia.com>

The smart idle mode in wdtimer2 prevents CORE power domain
idle transitions. Disable SMART idle mode to allow
FORCE idle mode to be used.

Signed-off-by: Kalle Jokiniemi <kalle.jokiniemi@nokia.com>
---
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index 196a834..0be56bd 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -1240,7 +1240,10 @@ static struct omap_hwmod_ocp_if omap3xxx_l4_wkup__wd_timer2 = {
 /*
  * 'wd_timer' class
  * 32-bit watchdog upward counter that generates a pulse on the reset pin on
- * overflow condition
+ * overflow condition.
+ *
+ * Disallow SIDLE_SMART to use SIDLE_FORCE instead as the CORE power domain
+ * sleep transitions only work when wdtimer2 is in SIDLE_FORCE mode.
  */
 
 static struct omap_hwmod_class_sysconfig omap3xxx_wd_timer_sysc = {
@@ -1250,7 +1253,7 @@ static struct omap_hwmod_class_sysconfig omap3xxx_wd_timer_sysc = {
 	.sysc_flags	= (SYSC_HAS_SIDLEMODE | SYSC_HAS_EMUFREE |
 			   SYSC_HAS_ENAWAKEUP | SYSC_HAS_SOFTRESET |
 			   SYSC_HAS_AUTOIDLE | SYSC_HAS_CLOCKACTIVITY),
-	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART),
+	.idlemodes	= (SIDLE_FORCE | SIDLE_NO), /* SIDLE_SMART disabled */
 	.sysc_fields    = &omap_hwmod_sysc_type1,
 };
 
-- 
1.7.1

