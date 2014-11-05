From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 5/5] ARM: OMAP4+: Remove unused omap_l3_noc platform init
Date: Wed,  5 Nov 2014 10:35:50 -0800
Message-ID: <1415212550-24692-6-git-send-email-tony@atomide.com>
References: <1415212550-24692-1-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:19641 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751278AbaKEShu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Nov 2014 13:37:50 -0500
In-Reply-To: <1415212550-24692-1-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org

Omap4 and later have been booting in device tree only
mode for quite some time now. This initcall is no longer
needed. Note that omap3 uses a different driver omap_l3_smx,
and the initcall for that one is still needed until omap3
boots in device tree only mode.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/devices.c | 34 ----------------------------------
 1 file changed, 34 deletions(-)

diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index 5544797..492ef16 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -67,40 +67,6 @@ static int __init omap3_l3_init(void)
 }
 omap_postcore_initcall(omap3_l3_init);
 
-static int __init omap4_l3_init(void)
-{
-	int i;
-	struct omap_hwmod *oh[3];
-	struct platform_device *pdev;
-	char oh_name[L3_MODULES_MAX_LEN];
-
-	/* If dtb is there, the devices will be created dynamically */
-	if (of_have_populated_dt())
-		return -ENODEV;
-
-	/*
-	 * To avoid code running on other OMAPs in
-	 * multi-omap builds
-	 */
-	if (!cpu_is_omap44xx() && !soc_is_omap54xx())
-		return -ENODEV;
-
-	for (i = 0; i < L3_MODULES; i++) {
-		snprintf(oh_name, L3_MODULES_MAX_LEN, "l3_main_%d", i+1);
-
-		oh[i] = omap_hwmod_lookup(oh_name);
-		if (!(oh[i]))
-			pr_err("could not look up %s\n", oh_name);
-	}
-
-	pdev = omap_device_build_ss("omap_l3_noc", 0, oh, 3, NULL, 0);
-
-	WARN(IS_ERR(pdev), "could not build omap_device for %s\n", oh_name);
-
-	return PTR_RET(pdev);
-}
-omap_postcore_initcall(omap4_l3_init);
-
 #if defined(CONFIG_VIDEO_OMAP2) || defined(CONFIG_VIDEO_OMAP2_MODULE)
 
 static struct resource omap2cam_resources[] = {
-- 
2.1.1

