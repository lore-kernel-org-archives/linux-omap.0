From: Jouni Hogander <jouni.hogander@nokia.com>
Subject: [PATCH 09/10] 34XX: PM: Workaround for non-existing usb clockdomain
Date: Fri, 16 May 2008 14:05:15 +0300
Message-ID: <1210935915-28078-1-git-send-email-jouni.hogander@nokia.com>
References: <874p8yv7dq.fsf@trdhcp146196.ntc.nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:48278 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754003AbYEPLFX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 May 2008 07:05:23 -0400
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m4GB5BpY020201
	for <linux-omap@vger.kernel.org>; Fri, 16 May 2008 14:05:21 +0300
In-Reply-To: <874p8yv7dq.fsf@trdhcp146196.ntc.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: jouni.hogander@nokia.com

There is no usb clkdm in core powerdomain in chip revisions greater
that es1, but hw supervised mode needs to be enabled for it. Othervise
core powerdomain wont enter retention.

Signed-off-by: Jouni Hogander <jouni.hogander@nokia.com>
---
 arch/arm/mach-omap2/pm34xx.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 43240d3..dbc3cf1 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -600,6 +600,15 @@ static void __init prcm_setup_regs(void)
 		__raw_writel(PRM_VOLTCTRL_AUTO_RET,
 			     OMAP3430_PRM_VOLTCTRL);
 	}
+
+	if (is_sil_rev_greater_than(OMAP3430_REV_ES1_0)) {
+		/* This hack is taken from ti code. There is no usb clkdm in
+		 * core, but this still needs to be written: allow idle of usb
+		 * clkdm? */
+		v = cm_read_mod_reg(CORE_MOD, CM_CLKSTCTRL);
+		v |= 0x30;
+		cm_write_mod_reg(v, CORE_MOD, CM_CLKSTCTRL);
+	}
 }
 
 static int __init pwrdms_setup(struct powerdomain *pwrdm)
-- 
1.5.5

