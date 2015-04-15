From: Tero Kristo <t-kristo@ti.com>
Subject: [RFC PATCH 22/35] ARM: OMAP2+: PM: remove code from __init section
Date: Wed, 15 Apr 2015 15:53:09 +0300
Message-ID: <1429102402-5276-23-git-send-email-t-kristo@ti.com>
References: <1429102402-5276-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:42529 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755478AbbDOMxI (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 15 Apr 2015 08:53:08 -0400
In-Reply-To: <1429102402-5276-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, paul@pwsan.com, linux-omap@vger.kernel.org

Needed by hwmod module boot.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/pm.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
index 58920bc..4891559 100644
--- a/arch/arm/mach-omap2/pm.c
+++ b/arch/arm/mach-omap2/pm.c
@@ -108,7 +108,7 @@ static void __init omap2_init_processor_devices(void)
 	}
 }
 
-int __init omap_pm_clkdms_setup(struct clockdomain *clkdm, void *unused)
+int omap_pm_clkdms_setup(struct clockdomain *clkdm, void *unused)
 {
 	/* XXX The usecount test is racy */
 	if ((clkdm->flags & CLKDM_CAN_ENABLE_AUTO) &&
@@ -128,8 +128,8 @@ int __init omap_pm_clkdms_setup(struct clockdomain *clkdm, void *unused)
  * opp entry and sets the voltage domain to the voltage specified
  * in the opp entry
  */
-static int __init omap2_set_init_voltage(char *vdd_name, char *clk_name,
-					 const char *oh_name)
+static int omap2_set_init_voltage(char *vdd_name, char *clk_name,
+				  const char *oh_name)
 {
 	struct voltagedomain *voltdm;
 	struct clk *clk;
@@ -296,7 +296,7 @@ static int __init omap2_common_pm_init(void)
 }
 omap_postcore_initcall(omap2_common_pm_init);
 
-int __init omap2_common_pm_late_init(void)
+int omap2_common_pm_late_init(void)
 {
 	if (of_have_populated_dt()) {
 		omap3_twl_init();
-- 
1.7.9.5

