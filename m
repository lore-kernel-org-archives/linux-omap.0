From: "Guzman Lugo, Fernando" <x0095840@ti.com>
Subject: [PATCH] OMAP3: mailbox initialization for all omap versions
Date: Fri, 26 Mar 2010 14:30:34 -0500
Message-ID: <496565EC904933469F292DDA3F1663E602CADC372D@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:33199 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751946Ab0CZTah convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 26 Mar 2010 15:30:37 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, "ameya.palande@nokia.com" <ameya.palande@nokia.com>, "felipe.contreras@nokia.com" <felipe.contreras@nokia.com>

>From 47783fc3e030d4e49d20ba412661cc1f38d8aec0 Mon Sep 17 00:00:00 2001
From: Fernando Guzman Lugo <x0095840@ti.com>
Date: Fri, 26 Mar 2010 13:06:32 -0600
Subject: [PATCH] OMAP3: mailbox initialization for all omap versions

This removes the check for omap2420, omap3430, omap44xx
and initialize mailbox for all versions

Signed-off-by: Fernando Guzman Lugo <x0095840@ti.com>
---
 arch/arm/mach-omap2/devices.c |    9 ++-------
 1 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index 18ad931..d6f01be 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -196,13 +196,8 @@ static struct platform_device mbox_device = {
 
 static inline void omap_init_mbox(void)
 {
-	if (cpu_is_omap2420() || cpu_is_omap3430() || cpu_is_omap44xx()) {
-		mbox_device.num_resources = ARRAY_SIZE(omap_mbox_resources);
-		mbox_device.resource = omap_mbox_resources;
-	} else {
-		pr_err("%s: platform not supported\n", __func__);
-		return;
-	}
+	mbox_device.num_resources = ARRAY_SIZE(omap_mbox_resources);
+	mbox_device.resource = omap_mbox_resources;
 	platform_device_register(&mbox_device);
 }
 #else
-- 
1.6.0.4

