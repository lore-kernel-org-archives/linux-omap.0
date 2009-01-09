From: Jouni Hogander <jouni.hogander@nokia.com>
Subject: [PATCH 2/2] OMAP3: PM: Emu_pwrdm is switched off by hardware even when sdti is in use
Date: Fri,  9 Jan 2009 09:52:33 +0200
Message-ID: <1231487553-17892-3-git-send-email-jouni.hogander@nokia.com>
References: <1231487553-17892-1-git-send-email-jouni.hogander@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:25128 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752768AbZAIHws (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 9 Jan 2009 02:52:48 -0500
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id n097q00a031774
	for <linux-omap@vger.kernel.org>; Fri, 9 Jan 2009 01:52:26 -0600
Received: from localhost.localdomain (trdhcp147193.ntc.nokia.com [172.22.147.193])
	by mgw-int02.ntc.nokia.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id n097pfA9025740
	for <linux-omap@vger.kernel.org>; Fri, 9 Jan 2009 09:51:44 +0200
In-Reply-To: <1231487553-17892-1-git-send-email-jouni.hogander@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Using sdti doesn't keep emu_pwrdm on if hardware supervised pwrdm
transitions are used. This causes sdti stop to work when power
management is initialized and hardware supervised pwrdm control is
enabled. This patch disables hardware supervised pwrdm control for
emu_pwrdm. Now emu_pwrdm is switched off on boot by software when it
is not used.

Signed-off-by: Jouni Hogander <jouni.hogander@nokia.com>
---
 arch/arm/mach-omap2/clockdomains.h |    6 +++++-
 arch/arm/mach-omap2/pm34xx.c       |   11 ++++++++++-
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/clockdomains.h b/arch/arm/mach-omap2/clockdomains.h
index bafa650..3d4eaca 100644
--- a/arch/arm/mach-omap2/clockdomains.h
+++ b/arch/arm/mach-omap2/clockdomains.h
@@ -251,10 +251,14 @@ static struct clockdomain per_clkdm = {
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
 };
 
+/*
+ * Disable hw supervised mode for emu_clkdm, because emu_pwrdm is
+ * switched of even if sdti is in use
+ */
 static struct clockdomain emu_clkdm = {
 	.name		= "emu_clkdm",
 	.pwrdm		= { .name = "emu_pwrdm" },
-	.flags		= CLKDM_CAN_ENABLE_AUTO | CLKDM_CAN_SWSUP,
+	.flags		= /* CLKDM_CAN_ENABLE_AUTO |  */CLKDM_CAN_SWSUP,
 	.clktrctrl_mask = OMAP3430_CLKTRCTRL_EMU_MASK,
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
 };
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 1d54e96..43aac5f 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -605,9 +605,18 @@ static int __init pwrdms_setup(struct powerdomain *pwrdm)
 	return set_pwrdm_state(pwrst->pwrdm, pwrst->next_state);
 }
 
+/*
+ * Enable hw supervised mode for all clockdomains if it's
+ * supported. Initiate sleep transition for other clockdomains, if
+ * they are not used
+ */
 static int __init clkdms_setup(struct clockdomain *clkdm)
 {
-	omap2_clkdm_allow_idle(clkdm);
+	if (clkdm->flags & CLKDM_CAN_ENABLE_AUTO)
+		omap2_clkdm_allow_idle(clkdm);
+	else if (clkdm->flags & CLKDM_CAN_FORCE_SLEEP &&
+		 atomic_read(&clkdm->usecount) == 0)
+		omap2_clkdm_sleep(clkdm);
 	return 0;
 }
 
-- 
1.6.0.1

