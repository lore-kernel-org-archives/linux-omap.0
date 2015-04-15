From: Tero Kristo <t-kristo@ti.com>
Subject: [RFC PATCH 21/35] ARM: OMAP2+: SR: remove code from __init section
Date: Wed, 15 Apr 2015 15:53:08 +0300
Message-ID: <1429102402-5276-22-git-send-email-t-kristo@ti.com>
References: <1429102402-5276-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:47059 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753421AbbDOMxG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 15 Apr 2015 08:53:06 -0400
In-Reply-To: <1429102402-5276-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, paul@pwsan.com, linux-omap@vger.kernel.org

Needed by hwmod module boot.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/sr_device.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/sr_device.c b/arch/arm/mach-omap2/sr_device.c
index d7cff26..c453fe4 100644
--- a/arch/arm/mach-omap2/sr_device.c
+++ b/arch/arm/mach-omap2/sr_device.c
@@ -32,8 +32,8 @@
 static bool sr_enable_on_init;
 
 /* Read EFUSE values from control registers for OMAP3430 */
-static void __init sr_set_nvalues(struct omap_volt_data *volt_data,
-				struct omap_sr_data *sr_data)
+static void sr_set_nvalues(struct omap_volt_data *volt_data,
+			   struct omap_sr_data *sr_data)
 {
 	struct omap_sr_nvalue_table *nvalue_table;
 	int i, j, count = 0;
@@ -93,7 +93,7 @@ static void __init sr_set_nvalues(struct omap_volt_data *volt_data,
 	sr_data->nvalue_count = j;
 }
 
-static int __init sr_dev_init(struct omap_hwmod *oh, void *user)
+static int sr_dev_init(struct omap_hwmod *oh, void *user)
 {
 	struct omap_sr_data *sr_data;
 	struct platform_device *pdev;
@@ -171,7 +171,7 @@ void __init omap_enable_smartreflex_on_init(void)
 	sr_enable_on_init = true;
 }
 
-int __init omap_devinit_smartreflex(void)
+int omap_devinit_smartreflex(void)
 {
 	return omap_hwmod_for_each_by_class("smartreflex", sr_dev_init, NULL);
 }
-- 
1.7.9.5

