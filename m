From: Tero Kristo <tero.kristo@nokia.com>
Subject: [PATCH] OMAP3: PM: Force write last pad config register into save area
Date: Tue, 17 Nov 2009 18:34:53 +0200
Message-ID: <1258475693-22068-1-git-send-email-tero.kristo@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:63507 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753019AbZKQQwx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Nov 2009 11:52:53 -0500
Received: from vaebh106.NOE.Nokia.com (vaebh106.europe.nokia.com [10.160.244.32])
	by mgw-mx06.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id nAHGqbDA007062
	for <linux-omap@vger.kernel.org>; Tue, 17 Nov 2009 18:52:57 +0200
Received: from localhost.localdomain (sokoban.ntc.nokia.com [172.22.144.95])
	by mgw-da01.ext.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id nAHGqitd009613
	for <linux-omap@vger.kernel.org>; Tue, 17 Nov 2009 18:52:45 +0200
In-Reply-To: <>
References: <>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: Tero Kristo <tero.kristo@nokia.com>

Due to OMAP3 errata XYZ, the save of the last pad register (ETK_D14 and
ETK_D15) can fail sometimes when there is simultaneous OCP access to the
SCM register area. Fixed by writing the last register to the save area.

Also, optimized the delay loop for the HW save to include an udelay(1),
which limits the number of unnecessary HW accesses to SCM register area
during the save.

Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
---
 arch/arm/mach-omap2/pm34xx.c |   10 +++++++++-
 1 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 4b01303..4ead40e 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -155,7 +155,15 @@ static void omap3_core_save_context(void)
 	/* wait for the save to complete */
 	while (!(omap_ctrl_readl(OMAP343X_CONTROL_GENERAL_PURPOSE_STATUS)
 			& PADCONF_SAVE_DONE))
-		;
+		udelay(1);
+
+	/*
+	 * Force write last pad into memory, as this can fail in some
+	 * cases according to errata XYZ
+	 */
+	omap_ctrl_writel(omap_ctrl_readl(OMAP343X_PADCONF_ETK_D14),
+		OMAP343X_CONTROL_MEM_WKUP + 0x2a0);
+
 	/* Save the Interrupt controller context */
 	omap_intc_save_context();
 	/* Save the GPMC context */
-- 
1.5.4.3

