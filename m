From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: [PATCH] ARM: OMAP2: Fix SPI driver failure on 2420 when running multi-omap config
Date: Thu, 21 Aug 2008 11:20:09 +0300
Message-ID: <1219306810-12232-2-git-send-email-jarkko.nikula@nokia.com>
References: <1219306810-12232-1-git-send-email-jarkko.nikula@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:28925 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753799AbYHUIUq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 21 Aug 2008 04:20:46 -0400
Received: from esebh106.NOE.Nokia.com (esebh106.ntc.nokia.com [172.21.138.213])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m7L8KX2i031779
	for <linux-omap@vger.kernel.org>; Thu, 21 Aug 2008 11:20:43 +0300
In-Reply-To: <1219306810-12232-1-git-send-email-jarkko.nikula@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Jarkko Nikula <jarkko.nikula@nokia.com>

SPI driver will do unhandled fault on OMAP2420 if trying to probe
non-existing SPI busses. Register those additional busses runtime only
for cpus having them.

Signed-off-by: Jarkko Nikula <jarkko.nikula@nokia.com>
---
 arch/arm/mach-omap2/devices.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index cc5c294..bd49a0f 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -255,10 +255,12 @@ static void omap_init_mcspi(void)
 	platform_device_register(&omap2_mcspi1);
 	platform_device_register(&omap2_mcspi2);
 #if defined(CONFIG_ARCH_OMAP2430) || defined(CONFIG_ARCH_OMAP3)
-	platform_device_register(&omap2_mcspi3);
+	if (cpu_is_omap2430() || cpu_is_omap343x())
+		platform_device_register(&omap2_mcspi3);
 #endif
 #ifdef CONFIG_ARCH_OMAP3
-	platform_device_register(&omap2_mcspi4);
+	if (cpu_is_omap343x())
+		platform_device_register(&omap2_mcspi4);
 #endif
 }
 
-- 
1.5.6.3

