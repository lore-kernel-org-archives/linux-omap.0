From: Tero Kristo <tero.kristo@nokia.com>
Subject: [PATCH 1/1] omap3_fclks_active() now uses generic serial clock check
Date: Tue,  3 Jun 2008 13:50:42 +0300
Message-ID: <1212490242-5888-2-git-send-email-tero.kristo@nokia.com>
References: <>
 <1212490242-5888-1-git-send-email-tero.kristo@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:37920 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751547AbYFCI5P (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 Jun 2008 04:57:15 -0400
Received: from esebh108.NOE.Nokia.com (esebh108.ntc.nokia.com [172.21.143.145])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m538uvXb009735
	for <linux-omap@vger.kernel.org>; Tue, 3 Jun 2008 11:57:12 +0300
Received: from localhost.localdomain (sokoban.ntc.nokia.com [172.22.144.95])
	by mgw-int02.ntc.nokia.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id m538ul2G027396
	for <linux-omap@vger.kernel.org>; Tue, 3 Jun 2008 11:56:48 +0300
In-Reply-To: <1212490242-5888-1-git-send-email-tero.kristo@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
---
 arch/arm/mach-omap2/pm34xx.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index ada87ba..2574586 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -245,8 +245,7 @@ static int omap3_fclks_active(void)
 	fck_per = cm_read_mod_reg(OMAP3430_PER_MOD,
 				  CM_FCLKEN);
 	gpio_fclk_mask(&fck_per);
-	fck_core1 &= ~(0x3 << 13);
-	fck_per &= ~(0x1 << 11);
+	omap_serial_fclk_mask(&fck_core1, &fck_per);
 	if (fck_core1 | fck_core3 | fck_sgx | fck_dss |
 	    fck_cam | fck_per | fck_usbhost)
 		return 1;
-- 
1.5.4.3

