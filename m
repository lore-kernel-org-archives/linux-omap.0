From: Sanjeev Premi <premi@ti.com>
Subject: [PATCH 2/2] omap3evm: Add keypad as wakeup source
Date: Tue,  3 Nov 2009 18:59:21 +0530
Message-ID: <1257254961-22506-1-git-send-email-premi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:49408 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753383AbZKCN3U (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 Nov 2009 08:29:20 -0500
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id nA3DTMpH011280
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 3 Nov 2009 07:29:24 -0600
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Sanjeev Premi <premi@ti.com>

Add keypad as wakeup source from 'suspend'
state.

Signed-off-by: Sanjeev Premi <premi@ti.com>
---
 arch/arm/mach-omap2/board-omap3evm.c |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index 660ef8c..6a1a0cd 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -343,6 +343,16 @@ static struct platform_device *omap3_evm_devices[] __initdata = {
 	&omap3evm_smc911x_device,
 };
 
+/*
+ * Set wakeup sources for the board
+ */
+static void __init omap3_evm_wakeup_sources(void)
+{
+	pr_info("omap3evm: Adding wakeup sources");
+
+	omap_cfg_reg(AF26_34XX_SYS_NIRQ);
+}
+
 static void __init omap3_evm_init(void)
 {
 	omap3_evm_i2c_init();
@@ -359,6 +369,8 @@ static void __init omap3_evm_init(void)
 #endif
 	usb_musb_init();
 	ads7846_dev_init();
+
+	omap3_evm_wakeup_sources();
 }
 
 static void __init omap3_evm_map_io(void)
-- 
1.6.2.2

