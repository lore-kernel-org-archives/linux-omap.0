From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 1/2] arm: omap1: devices: need to return with a value
Date: Tue, 19 Oct 2010 10:30:54 +0300
Message-ID: <1287473455-25773-2-git-send-email-balbi@ti.com>
References: <1287473455-25773-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:33069 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932760Ab0JSHbU (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 19 Oct 2010 03:31:20 -0400
In-Reply-To: <1287473455-25773-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, linux-arm-kernel@lists.infradead.org, Felipe Balbi <balbi@ti.com>

Get rid of the following warning:

arch/arm/mach-omap1/devices.c: In function 'omap_init_wdt':
arch/arm/mach-omap1/devices.c:298: warning: 'return' with
no value, in function returning non-void

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/mach-omap1/devices.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap1/devices.c b/arch/arm/mach-omap1/devices.c
index 63d68cf..a037aba 100644
--- a/arch/arm/mach-omap1/devices.c
+++ b/arch/arm/mach-omap1/devices.c
@@ -295,7 +295,7 @@ static struct platform_device omap_wdt_device = {
 static int __init omap_init_wdt(void)
 {
 	if (!cpu_is_omap16xx())
-		return;
+		return -ENODEV;
 
 	platform_device_register(&omap_wdt_device);
 	return 0;
-- 
1.7.3.rc0.35.g8ac8c

