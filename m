From: Tero Kristo <tero.kristo@nokia.com>
Subject: [PATCH 01/11] OMAP3: PM: Fixed padconf save done check
Date: Fri, 23 Oct 2009 19:03:45 +0300
Message-ID: <1256313835-2391-2-git-send-email-tero.kristo@nokia.com>
References: <>
 <1256313835-2391-1-git-send-email-tero.kristo@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:21528 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752528AbZJWQSv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 23 Oct 2009 12:18:51 -0400
Received: from vaebh106.NOE.Nokia.com (vaebh106.europe.nokia.com [10.160.244.32])
	by mgw-mx03.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id n9NGIc92001696
	for <linux-omap@vger.kernel.org>; Fri, 23 Oct 2009 19:18:54 +0300
In-Reply-To: <1256313835-2391-1-git-send-email-tero.kristo@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Carlos Chinea <carlos.chinea@nokia.com>

From: Carlos Chinea <carlos.chinea@nokia.com>

Previously the operator precedence dictated that the delay loop was exited
immediately, potentially causing off-mode to be entered too soon.

Signed-off-by: Carlos Chinea <carlos.chinea@nokia.com>
Signed-off-by: Jouni Hogander <jouni.hogander@nokia.com>
---
 arch/arm/mach-omap2/pm34xx.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 01260ec..8353764 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -146,8 +146,8 @@ static void omap3_core_save_context(void)
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

