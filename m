From: Jouni Hogander <jouni.hogander@nokia.com>
Subject: [PATCH 10/10] 34XX: PM: Workaround to mask uart clocks when checking active clocks
Date: Fri, 16 May 2008 14:05:19 +0300
Message-ID: <1210935919-28099-1-git-send-email-jouni.hogander@nokia.com>
References: <874p8yv7dq.fsf@trdhcp146196.ntc.nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:48282 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754019AbYEPLFY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 May 2008 07:05:24 -0400
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m4GB5BxX020199
	for <linux-omap@vger.kernel.org>; Fri, 16 May 2008 14:05:22 +0300
In-Reply-To: <874p8yv7dq.fsf@trdhcp146196.ntc.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: jouni.hogander@nokia.com

This workaround mask uart clocks when checking for active clocks. This
has an effect that serial console stops to work as dynamic sleep is
enabled.

Signed-off-by: Jouni Hogander <jouni.hogander@nokia.com>
---
 arch/arm/mach-omap2/pm34xx.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index dbc3cf1..1355e0e 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -242,6 +242,8 @@ static int omap3_fclks_active(void)
 	fck_per = cm_read_mod_reg(OMAP3430_PER_MOD,
 				  CM_FCLKEN);
 	gpio_fclk_mask(&fck_per);
+	fck_core1 &= ~(0x3 << 13);
+	fck_per &= ~(0x1 << 11);
 	if (fck_core1 | fck_core3 | fck_sgx | fck_dss |
 	    fck_cam | fck_per | fck_usbhost)
 		return 1;
-- 
1.5.5

