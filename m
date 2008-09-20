From: "Zavala Trujillo, Diego" <diegozt@ti.com>
Subject: [Patch] OMAP: ARM: Fix Comp for LDP on DeviceType
Date: Sat, 20 Sep 2008 02:11:05 -0500
Message-ID: <13B9B4C6EF24D648824FF11BE896716203657CAE29@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:39546 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750891AbYITHLM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 20 Sep 2008 03:11:12 -0400
Received: from dlep95.itg.ti.com ([157.170.170.107])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id m8K7B6Fi022185
	for <linux-omap@vger.kernel.org>; Sat, 20 Sep 2008 02:11:11 -0500
Received: from dlee74.ent.ti.com (localhost [127.0.0.1])
	by dlep95.itg.ti.com (8.13.8/8.13.8) with ESMTP id m8K7B6eX006759
	for <linux-omap@vger.kernel.org>; Sat, 20 Sep 2008 02:11:06 -0500 (CDT)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Zavala Trujillo, Diego" <diegozt@ti.com>



Regards,
Fix the compilation for the 3430LDP.
Replace omap_device_type for omap_type.
---
 arch/arm/mach-omap2/board-ldp.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)
 mode change 100644 => 100755 arch/arm/mach-omap2/board-ldp.c

diff --git a/arch/arm/mach-omap2/board-ldp.c b/arch/arm/mach-omap2/board-ldp.c
old mode 100644
new mode 100755
index 9263be9..02359d5
--- a/arch/arm/mach-omap2/board-ldp.c
+++ b/arch/arm/mach-omap2/board-ldp.c
@@ -54,7 +54,7 @@ static int __init msecure_init(void)
 
 #ifdef CONFIG_RTC_DRV_TWL4030
 	/* 3430ES2.0 doesn't have msecure/gpio-22 line connected to T2 */
-	if (omap_device_type() == OMAP2_DEVICE_TYPE_GP &&
+	if (omap_type() == OMAP2_DEVICE_TYPE_GP &&
 			system_rev < OMAP3430_REV_ES2_0) {
 		u32 msecure_pad_config_reg = omap_ctrl_base_get() + 0xA3C;
 		int mux_mask = 0x04;
-- 
1.5.6.4

