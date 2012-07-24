From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 3/5] arm: omap: debug-leds: add section annotation to probe
Date: Tue, 24 Jul 2012 11:54:00 +0300
Message-ID: <1343120042-16695-4-git-send-email-balbi@ti.com>
References: <1343120042-16695-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog132.obsmtp.com ([74.125.149.250]:48010 "EHLO
	na3sys009aog132.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752476Ab2GXI5V (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 24 Jul 2012 04:57:21 -0400
Received: by lbom4 with SMTP id m4so9136923lbo.2
        for <linux-omap@vger.kernel.org>; Tue, 24 Jul 2012 01:57:19 -0700 (PDT)
In-Reply-To: <1343120042-16695-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Felipe Balbi <balbi@ti.com>

put our probe function on __devinit section, so
it can be freed on some cases.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/plat-omap/debug-leds.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-omap/debug-leds.c b/arch/arm/plat-omap/debug-leds.c
index 615d085..392daa8 100644
--- a/arch/arm/plat-omap/debug-leds.c
+++ b/arch/arm/plat-omap/debug-leds.c
@@ -236,7 +236,7 @@ fpga_led_set(struct led_classdev *cdev, enum led_brightness value)
 	spin_unlock_irqrestore(&lock, flags);
 }
 
-static void __init newled_init(struct device *dev)
+static void __devinit newled_init(struct device *dev)
 {
 	unsigned	i;
 	struct dbg_led	*led;
@@ -254,7 +254,7 @@ static void __init newled_init(struct device *dev)
 
 /*-------------------------------------------------------------------------*/
 
-static int /* __init */ fpga_probe(struct platform_device *pdev)
+static int __devinit fpga_probe(struct platform_device *pdev)
 {
 	struct resource	*iomem;
 
-- 
1.7.11

