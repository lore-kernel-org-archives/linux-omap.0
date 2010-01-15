From: Nishanth Menon <nm@ti.com>
Subject: [PM-WIP-OPP][PATCH] pm: omap3: fix build error for PM disabled
Date: Fri, 15 Jan 2010 07:13:06 -0600
Message-ID: <1263561186-12994-1-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:47450 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752177Ab0AONNM (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 15 Jan 2010 08:13:12 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Nishanth Menon <nm@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Paul Walmsley <paul@pwsan.com>

omap3_pm_init_opp_table should be under #ifdef CONFIG_PM
else build fails when PM is disabled. Reported by Paul originally.

Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Paul Walmsley <paul@pwsan.com>
Reported-by: Paul Walmsley <paul@pwsan.com>

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-omap2/pm.h |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
index d257225..5fc056f 100644
--- a/arch/arm/mach-omap2/pm.h
+++ b/arch/arm/mach-omap2/pm.h
@@ -69,7 +69,13 @@ static inline void omap3_pm_init_vc(struct prm_setup_vc *setup_vc)
  * Initialize the basic opp table here, board files could choose to modify opp
  * table after the basic initialization
  */
+#ifdef CONFIG_PM
 extern void omap3_pm_init_opp_table(void);
+#else
+static inline void omap3_pm_init_opp_table(void)
+{
+}
+#endif
 
 extern int omap3_pm_get_suspend_state(struct powerdomain *pwrdm);
 extern int omap3_pm_set_suspend_state(struct powerdomain *pwrdm, int state);
-- 
1.6.3.3

