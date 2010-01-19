From: Eduardo Valentin <eduardo.valentin@nokia.com>
Subject: [PATCH 1/1] OMAP3: PM: Fix compilation issue of omap3_pm_init_opp_table
Date: Tue, 19 Jan 2010 13:57:34 +0200
Message-ID: <1263902254-3015-1-git-send-email-eduardo.valentin@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:30817 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753959Ab0ASL6K (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 Jan 2010 06:58:10 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Nishanth Menon <nm@ti.com>, ext Kevin Hilman <khilman@deeprootsystems.com>
Cc: Linux-OMAP <linux-omap@vger.kernel.org>, Eduardo Valentin <eduardo.valentin@nokia.com>

From: Eduardo Valentin <eduardo.valentin@nokia.com>

This patch removes the compilation error when compiling
kernel with CONFIG_PM=N. The problem was that omap3_pm_init_opp_table
was not defined if CONFIG_PM=N.

Signed-off-by: Eduardo Valentin <eduardo.valentin@nokia.com>
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
1.6.5.7.g9ecb2

