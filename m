From: Kalle Jokiniemi <ext-kalle.jokiniemi@nokia.com>
Subject: [PATCH 2/2] Add early init for voltage controller configuration and off mode polarity.
Date: Wed,  6 Aug 2008 11:41:08 +0300
Message-ID: <1218012068-30107-2-git-send-email-ext-kalle.jokiniemi@nokia.com>
References: <>
 <1218012068-30107-1-git-send-email-ext-kalle.jokiniemi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:34740 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756199AbYHFIjJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 6 Aug 2008 04:39:09 -0400
Received: from esebh107.NOE.Nokia.com (esebh107.ntc.nokia.com [172.21.143.143])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m768cj5P016234
	for <linux-omap@vger.kernel.org>; Wed, 6 Aug 2008 03:39:07 -0500
In-Reply-To: <1218012068-30107-1-git-send-email-ext-kalle.jokiniemi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: peter.de-schrijver@nokia.com, Kalle Jokiniemi <ext-kalle.jokiniemi@nokia.com>

From: ext Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>

Signed-off-by: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>
Signed-off-by: Kalle Jokiniemi <ext-kalle.jokiniemi@nokia.com>
---
 arch/arm/mach-omap2/pm34xx.c |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index a6cfc46..fc72c11 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -484,3 +484,15 @@ static void __init configure_vc(void)
 #endif
 
 }
+
+static int __init omap3_pm_early_init(void)
+{
+	prm_clear_mod_reg_bits(OMAP3430_OFFMODE_POL, OMAP3430_GR_MOD,
+				OMAP3_PRM_POLCTRL_OFFSET);
+
+	configure_vc();
+
+	return 0;
+}
+
+arch_initcall(omap3_pm_early_init);
-- 
1.5.4.3

