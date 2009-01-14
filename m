From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: [PATCH OMAPZOOM] Kill compile warning in pm_34xx.c
Date: Wed, 14 Jan 2009 20:38:13 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB02E6782B14@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:58958 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753927AbZANPIf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 Jan 2009 10:08:35 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id n0EF8SAZ005567
	for <linux-omap@vger.kernel.org>; Wed, 14 Jan 2009 09:08:34 -0600
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id n0EF8Qup004192
	for <linux-omap@vger.kernel.org>; Wed, 14 Jan 2009 20:38:27 +0530 (IST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Pandita, Vikram" <vikram.pandita@ti.com>

From: Anand Gadiyar <gadiyar@ti.com>

Fix this compilation warning in pm_34xx.c

  CC      arch/arm/mach-omap2/pm_34xx.o
arch/arm/mach-omap2/pm_34xx.c:214: warning: function declaration isn't a prototype

Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
---
diff --git a/arch/arm/mach-omap2/pm_34xx.c b/arch/arm/mach-omap2/pm_34xx.c
index aeeb055..abe9618 100644
--- a/arch/arm/mach-omap2/pm_34xx.c
+++ b/arch/arm/mach-omap2/pm_34xx.c
@@ -210,7 +210,7 @@ u32 omap3_start_rng(void)
 }
 #endif /* #ifdef OMAP3_START_RNG */
 
-void omap3_push_sram_functions()
+void omap3_push_sram_functions(void)
 {
 	_omap_sram_idle = omap_sram_push(omap34xx_cpu_suspend,
 				omap34xx_cpu_suspend_sz);
