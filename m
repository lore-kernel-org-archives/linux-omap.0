From: Nishanth Menon <nm@ti.com>
Subject: [PATCH V4 6/6] ARM: OMAP3+: use cpu0-cpufreq driver in device tree supported boot
Date: Fri, 12 Apr 2013 17:54:38 -0500
Message-ID: <1365807278-554-7-git-send-email-nm@ti.com>
References: <1365807278-554-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:32791 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758735Ab3DLWzM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 12 Apr 2013 18:55:12 -0400
In-Reply-To: <1365807278-554-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@deeprootsystems.com>, Mike Turquette <mturquette@linaro.org>, Nishanth Menon <nm@ti.com>

With OMAP3+ and AM33xx supported SoC having defined CPU device tree
entries with operating-points and clock nodes defined, we can now use
the SoC generic cpufreq-cpu0 driver by registering appropriate device.

Cc: Benoit Cousson <b-cousson@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Tony Lindgren <tony@atomide.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
---
Introduced as a result of alignment in http://marc.info/?t=136450773400004&r=1&w=2
previous versions do not use this approach.

This would probably be good to get merged *after* Rafael's tree is merged in.

[Probably belongs to Kevin/Tony's tree?]

 arch/arm/mach-omap2/pm.c |   11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
index 8d15f9a..6cf95160 100644
--- a/arch/arm/mach-omap2/pm.c
+++ b/arch/arm/mach-omap2/pm.c
@@ -267,7 +267,12 @@ static void __init omap4_init_voltages(void)
 
 static inline void omap_init_cpufreq(void)
 {
-	struct platform_device_info devinfo = { .name = "omap-cpufreq", };
+	struct platform_device_info devinfo = { };
+
+	if (!of_have_populated_dt())
+		devinfo.name = "omap-cpufreq";
+	else
+		devinfo.name = "cpufreq-cpu0";
 	platform_device_register_full(&devinfo);
 }
 
@@ -301,9 +306,9 @@ int __init omap2_common_pm_late_init(void)
 		/* Smartreflex device init */
 		omap_devinit_smartreflex();
 
-		/* cpufreq dummy device instantiation */
-		omap_init_cpufreq();
 	}
+	/* cpufreq dummy device instantiation */
+	omap_init_cpufreq();
 
 #ifdef CONFIG_SUSPEND
 	suspend_set_ops(&omap_pm_ops);
-- 
1.7.9.5

