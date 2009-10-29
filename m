From: Kalle Jokiniemi <kalle.jokiniemi@digia.com>
Subject: [PATCH 1/3] OMAP:PM: Fix non-cpu idle builds using omap3_pm_init_cpuidle
Date: Thu, 29 Oct 2009 10:30:18 +0200
Message-ID: <1256805020-7402-2-git-send-email-kalle.jokiniemi@digia.com>
References: <>
 <1256805020-7402-1-git-send-email-kalle.jokiniemi@digia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp1.digia.com ([82.118.214.156]:12133 "EHLO smtp1.digia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753093AbZJ2IaH (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 29 Oct 2009 04:30:07 -0400
In-Reply-To: <1256805020-7402-1-git-send-email-kalle.jokiniemi@digia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: khilman@deeprootsystems.com
Cc: linux-omap@vger.kernel.org, rnayak@ti.com, jouni.hogander@nokia.com, Kalle Jokiniemi <kalle.jokiniemi@digia.com>

Building without CONFIG_CPU_IDLE causes build to fail if
cpu idle parameters are tried to pass using
omap3_pm_init_cpuidle function.

Fixed by defining a dummy function for non-cpu idle
builds.

Signed-off-by: Kalle Jokiniemi <kalle.jokiniemi@digia.com>
---
 arch/arm/mach-omap2/pm.h |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
index b576424..b9421e8 100644
--- a/arch/arm/mach-omap2/pm.h
+++ b/arch/arm/mach-omap2/pm.h
@@ -49,7 +49,14 @@ struct cpuidle_params {
 };
 
 extern void omap3_pm_init_vc(struct prm_setup_vc *setup_vc);
+#ifdef CONFIG_CPU_IDLE
 extern void omap3_pm_init_cpuidle(struct cpuidle_params *cpuidle_board_params);
+#else
+static inline void omap3_pm_init_cpuidle(
+			struct cpuidle_params *cpuidle_board_params)
+{
+}
+#endif
 
 extern int resource_set_opp_level(int res, u32 target_level, int flags);
 extern int resource_access_opp_lock(int res, int delta);
-- 
1.5.4.3

