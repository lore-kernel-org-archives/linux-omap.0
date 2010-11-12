From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 4/4] arm: omap1: devices: need to return with a value
Date: Thu, 11 Nov 2010 17:03:34 -0800
Message-ID: <20101112010334.3827.77064.stgit@baageli.muru.com>
References: <20101112010245.3827.75329.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:51164 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756699Ab0KLBDj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Nov 2010 20:03:39 -0500
In-Reply-To: <20101112010245.3827.75329.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org, Felipe Balbi <balbi@ti.com>

From: Felipe Balbi <balbi@ti.com>

Get rid of the following warning:

arch/arm/mach-omap1/devices.c: In function 'omap_init_wdt':
arch/arm/mach-omap1/devices.c:298: warning: 'return' with
no value, in function returning non-void

while at that, also change:

platform_device_register();
return 0;

into:

return platform_device_register();

Signed-off-by: Felipe Balbi <balbi@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap1/devices.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap1/devices.c b/arch/arm/mach-omap1/devices.c
index ea0d80a..e7f9ee6 100644
--- a/arch/arm/mach-omap1/devices.c
+++ b/arch/arm/mach-omap1/devices.c
@@ -321,10 +321,9 @@ static struct platform_device omap_wdt_device = {
 static int __init omap_init_wdt(void)
 {
 	if (!cpu_is_omap16xx())
-		return;
+		return -ENODEV;
 
-	platform_device_register(&omap_wdt_device);
-	return 0;
+	return platform_device_register(&omap_wdt_device);
 }
 subsys_initcall(omap_init_wdt);
 #endif

