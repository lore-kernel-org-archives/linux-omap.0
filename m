From: Tero Kristo <tero.kristo@nokia.com>
Subject: [PATCH 05/17] OMAP:PM: Precedence fix
Date: Fri, 16 Oct 2009 13:48:58 +0300
Message-ID: <1255690150-16853-6-git-send-email-tero.kristo@nokia.com>
References: <>
 <1255690150-16853-1-git-send-email-tero.kristo@nokia.com>
 <1255690150-16853-2-git-send-email-tero.kristo@nokia.com>
 <1255690150-16853-3-git-send-email-tero.kristo@nokia.com>
 <1255690150-16853-4-git-send-email-tero.kristo@nokia.com>
 <1255690150-16853-5-git-send-email-tero.kristo@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:32312 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758523AbZJPLEq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Oct 2009 07:04:46 -0400
Received: from esebh106.NOE.Nokia.com (esebh106.ntc.nokia.com [172.21.138.213])
	by mgw-mx06.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id n9GB2s8r011846
	for <linux-omap@vger.kernel.org>; Fri, 16 Oct 2009 14:03:18 +0300
In-Reply-To: <1255690150-16853-5-git-send-email-tero.kristo@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Carlos Chinea <carlos.chinea@nokia.com>

From: Carlos Chinea <carlos.chinea@nokia.com>

Signed-off-by: Carlos Chinea <carlos.chinea@nokia.com>
Signed-off-by: Jouni Hogander <jouni.hogander@nokia.com>
---
 arch/arm/mach-omap2/pm34xx.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 4addc41..588ab79 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -225,8 +225,8 @@ static void omap3_core_save_context(void)
 	control_padconf_off |= START_PADCONF_SAVE;
 	omap_ctrl_writel(control_padconf_off, OMAP343X_CONTROL_PADCONF_OFF);
 	/* wait for the save to complete */
-	while (!omap_ctrl_readl(OMAP343X_CONTROL_GENERAL_PURPOSE_STATUS)
-			& PADCONF_SAVE_DONE)
+	while (!(omap_ctrl_readl(OMAP343X_CONTROL_GENERAL_PURPOSE_STATUS)
+			& PADCONF_SAVE_DONE))
 		;
 	/* Save the Interrupt controller context */
 	omap3_intc_save_context();
-- 
1.5.4.3

