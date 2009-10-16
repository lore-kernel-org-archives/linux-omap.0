From: Tero Kristo <tero.kristo@nokia.com>
Subject: [PATCH 04/17] OMAP3: PM: Do not enable IO wake-up on boot
Date: Fri, 16 Oct 2009 13:48:57 +0300
Message-ID: <1255690150-16853-5-git-send-email-tero.kristo@nokia.com>
References: <>
 <1255690150-16853-1-git-send-email-tero.kristo@nokia.com>
 <1255690150-16853-2-git-send-email-tero.kristo@nokia.com>
 <1255690150-16853-3-git-send-email-tero.kristo@nokia.com>
 <1255690150-16853-4-git-send-email-tero.kristo@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:32310 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758523AbZJPLEp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Oct 2009 07:04:45 -0400
Received: from esebh106.NOE.Nokia.com (esebh106.ntc.nokia.com [172.21.138.213])
	by mgw-mx06.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id n9GB2s8p011846
	for <linux-omap@vger.kernel.org>; Fri, 16 Oct 2009 14:03:16 +0300
In-Reply-To: <1255690150-16853-4-git-send-email-tero.kristo@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Jouni Hogander <jouni.hogander@nokia.com>

From: Jouni Hogander <jouni.hogander@nokia.com>

IO wake-ups are enabled/disabled in idle loop. No need to enable them on boot.

Signed-off-by: Jouni Hogander <jouni.hogander@nokia.com>
---
 arch/arm/mach-omap2/pm34xx.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 52a3f2b..4addc41 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -1027,9 +1027,8 @@ static void __init prcm_setup_regs(void)
 			     OMAP3_PRM_CLKSRC_CTRL_OFFSET);
 
 	/* setup wakup source */
-	prm_write_mod_reg(OMAP3430_EN_IO | OMAP3430_EN_GPIO1 |
-			  OMAP3430_EN_GPT1 | OMAP3430_EN_GPT12,
-			  WKUP_MOD, PM_WKEN);
+	prm_write_mod_reg(OMAP3430_EN_GPIO1 | OMAP3430_EN_GPT1 |
+			  OMAP3430_EN_GPT12, WKUP_MOD, PM_WKEN);
 	/* No need to write EN_IO, that is always enabled */
 	prm_write_mod_reg(OMAP3430_EN_GPIO1 | OMAP3430_EN_GPT1 |
 			  OMAP3430_EN_GPT12,
-- 
1.5.4.3

