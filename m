From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH] ARM: OMAP4: PM: fix errata handling when CONFIG_PM=n
Date: Wed, 14 Nov 2012 16:54:27 -0800
Message-ID: <1352940867-8806-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-da0-f46.google.com ([209.85.210.46]:51620 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755497Ab2KOAya (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 Nov 2012 19:54:30 -0500
Received: by mail-da0-f46.google.com with SMTP id n41so421619dak.19
        for <linux-omap@vger.kernel.org>; Wed, 14 Nov 2012 16:54:30 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, Tero Kristo <t-kristo@ti.com>

From: Kevin Hilman <khilman@ti.com>

commit c9621844 (ARM: OMAP4: PM: add errata support) introduced errata
handling for OMAP4, but was broken when CONFIG_PM=n.

When CONFIG_PM=n, pm44xx.c is not compiled, yet that is where pm44xx_errata
is defined.  However, these errata are needed for the SMP boot/hotplug case
also, and are primarily used in omap-smp.c.

Move the definition of pm44xx_errata to omap-smp.c so that it's available
even in the CONFIG_PM=n case.

Cc: Tero Kristo <t-kristo@ti.com>
Signed-off-by: Kevin Hilman <khilman@ti.com>
---
This patch applies on top of Tony's fixes-non-critical-part-2.
The bug was introduced in my for_3.8-fixes-pm tag (now included in Tony's fixes-non-critical-part2.)


 arch/arm/mach-omap2/omap-smp.c | 2 ++
 arch/arm/mach-omap2/pm44xx.c   | 1 -
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/omap-smp.c b/arch/arm/mach-omap2/omap-smp.c
index 49a08df..cd42d92 100644
--- a/arch/arm/mach-omap2/omap-smp.c
+++ b/arch/arm/mach-omap2/omap-smp.c
@@ -40,6 +40,8 @@
 
 #define OMAP5_CORE_COUNT	0x2
 
+u16 pm44xx_errata;
+
 /* SCU base address */
 static void __iomem *scu_base;
 
diff --git a/arch/arm/mach-omap2/pm44xx.c b/arch/arm/mach-omap2/pm44xx.c
index 0adbd7d..04922d1 100644
--- a/arch/arm/mach-omap2/pm44xx.c
+++ b/arch/arm/mach-omap2/pm44xx.c
@@ -34,7 +34,6 @@ struct power_state {
 };
 
 static LIST_HEAD(pwrst_list);
-u16 pm44xx_errata;
 
 #ifdef CONFIG_SUSPEND
 static int omap4_pm_suspend(void)
-- 
1.8.0

