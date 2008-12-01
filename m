From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH v2 5/5] OMAP3: PM: Ensure modem is reset during PRCM init
Date: Mon,  1 Dec 2008 08:22:46 -0800
Message-ID: <1228148566-9358-6-git-send-email-khilman@deeprootsystems.com>
References: <1228148566-9358-1-git-send-email-khilman@deeprootsystems.com>
 <1228148566-9358-2-git-send-email-khilman@deeprootsystems.com>
 <1228148566-9358-3-git-send-email-khilman@deeprootsystems.com>
 <1228148566-9358-4-git-send-email-khilman@deeprootsystems.com>
 <1228148566-9358-5-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.227]:21102 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751163AbYLAQXA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 1 Dec 2008 11:23:00 -0500
Received: by rv-out-0506.google.com with SMTP id k40so2527683rvb.1
        for <linux-omap@vger.kernel.org>; Mon, 01 Dec 2008 08:23:00 -0800 (PST)
In-Reply-To: <1228148566-9358-5-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Kevin Hilman <khilman@deeprootsystems.com>

Rogue bootloaders may enable the modem and thus keep the
D2D power- and clock-domains from going into retention.
Reset modem on boot to be sure it is in known state.

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/pm34xx.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 9a1933b..db3a34d 100644
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

