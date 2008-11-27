From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 5/5] OMAP3: PM: Ensure modem is reset during PRCM init
Date: Wed, 26 Nov 2008 16:05:49 -0800
Message-ID: <1227744349-12118-6-git-send-email-khilman@deeprootsystems.com>
References: <1227744349-12118-1-git-send-email-khilman@deeprootsystems.com>
 <1227744349-12118-2-git-send-email-khilman@deeprootsystems.com>
 <1227744349-12118-3-git-send-email-khilman@deeprootsystems.com>
 <1227744349-12118-4-git-send-email-khilman@deeprootsystems.com>
 <1227744349-12118-5-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.29]:24440 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755522AbYK0AGM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 26 Nov 2008 19:06:12 -0500
Received: by yw-out-2324.google.com with SMTP id 9so359573ywe.1
        for <linux-omap@vger.kernel.org>; Wed, 26 Nov 2008 16:06:11 -0800 (PST)
In-Reply-To: <1227744349-12118-5-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Rogue bootloaders may enable the modem and thus keep the
D2D power- and clock-domains from going into retention.
Reset modem on boot to be sure it is in known state.

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/pm34xx.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 7c5577a..e22a11f 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -418,6 +418,12 @@ static void __init omap3_iva_idle(void)
 
 static void __init prcm_setup_regs(void)
 {
+	/* reset modem */
+	prm_write_mod_reg(OMAP3430_RM_RSTCTRL_CORE_MODEM_SW_RSTPWRON |
+			  OMAP3430_RM_RSTCTRL_CORE_MODEM_SW_RST,
+			  CORE_MOD, RM_RSTCTRL);
+	prm_write_mod_reg(0, CORE_MOD, RM_RSTCTRL);
+
 	/* XXX Reset all wkdeps. This should be done when initializing
 	 * powerdomains */
 	prm_write_mod_reg(0, OMAP3430_IVA2_MOD, PM_WKDEP);
-- 
1.6.0.3

