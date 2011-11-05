From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP2+: devices: Fixes for McPDM
Date: Fri, 4 Nov 2011 17:09:49 -0700
Message-ID: <20111105000949.GI31337@atomide.com>
References: <1320309682-30513-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:19680 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751561Ab1KEAJw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Nov 2011 20:09:52 -0400
Content-Disposition: inline
In-Reply-To: <1320309682-30513-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: linux-omap@vger.kernel.org, Benoit Cousson <b-cousson@ti.com>, Kevin Hilman <khilman@ti.com>

* Peter Ujfalusi <peter.ujfalusi@ti.com> [111103 01:07]:
> Clean up the omap-mcpdm init function since this part comes via sound
> tree, and there has been changes regarding to hwmod/omap_device_build.
> 
> Missed patches:
> The ARM: OMAP2+: devices: Remove all omap_device_pm_latency structures
> OMAP: omap_device: when building return platform_device instead of
> omap_device

Applying into fixes with comments updated as below.

Tony


From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Date: Thu, 3 Nov 2011 10:41:22 +0200
Subject: [PATCH] ARM: OMAP2+: devices: Fixes for McPDM

Commit f718e2c034bf6ff872106344935006230764cb12 (ARM: OMAP2+: devices:
Remove all omap_device_pm_latency structures) removed these structures.
Commit 3528c58eb9e818b7821501afa2916eb12131994a (OMAP: omap_device:
when building return platform_device instead of omap_device) now
returns platform_device instead of omap_device.

Fix up the omap-mcpdm init function since this part comes via sound
tree, and there has been changes regarding to hwmod/omap_device_build.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
CC: Benoit Cousson <b-cousson@ti.com>
CC: Kevin Hilman <khilman@ti.com>
[tony@atomide.com: updated comments]
Signed-off-by: Tony Lindgren <tony@atomide.com>

--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -318,18 +318,10 @@ static inline void omap_init_audio(void) {}
 #if defined(CONFIG_SND_OMAP_SOC_MCPDM) || \
 		defined(CONFIG_SND_OMAP_SOC_MCPDM_MODULE)
 
-static struct omap_device_pm_latency omap_mcpdm_latency[] = {
-	{
-		.deactivate_func = omap_device_idle_hwmods,
-		.activate_func = omap_device_enable_hwmods,
-		.flags = OMAP_DEVICE_LATENCY_AUTO_ADJUST,
-	},
-};
-
 static void omap_init_mcpdm(void)
 {
 	struct omap_hwmod *oh;
-	struct omap_device *od;
+	struct platform_device *pdev;
 
 	oh = omap_hwmod_lookup("mcpdm");
 	if (!oh) {
@@ -337,11 +329,8 @@ static void omap_init_mcpdm(void)
 		return;
 	}
 
-	od = omap_device_build("omap-mcpdm", -1, oh, NULL, 0,
-				omap_mcpdm_latency,
-				ARRAY_SIZE(omap_mcpdm_latency), 0);
-	if (IS_ERR(od))
-		printk(KERN_ERR "Could not build omap_device for omap-mcpdm-dai\n");
+	pdev = omap_device_build("omap-mcpdm", -1, oh, NULL, 0, NULL, 0, 0);
+	WARN(IS_ERR(pdev), "Can't build omap_device for omap-mcpdm.\n");
 }
 #else
 static inline void omap_init_mcpdm(void) {}
