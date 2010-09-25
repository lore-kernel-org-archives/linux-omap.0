From: Enric Balletbo i Serra <eballetbo@gmail.com>
Subject: [PATCH 1/6] omap3: Add GPIO's for external VBUS power switch and overcurrent detect on IGEP v2 board.
Date: Sat, 25 Sep 2010 20:19:01 +0200
Message-ID: <1285438746-7311-2-git-send-email-eballetbo@gmail.com>
References: <1285438746-7311-1-git-send-email-eballetbo@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:42781 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751448Ab0IYSTR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 25 Sep 2010 14:19:17 -0400
Received: by wyb28 with SMTP id 28so2805411wyb.19
        for <linux-omap@vger.kernel.org>; Sat, 25 Sep 2010 11:19:15 -0700 (PDT)
In-Reply-To: <1285438746-7311-1-git-send-email-eballetbo@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: Enric Balletbo i Serra <eballetbo@gmail.com>

Signed-off-by: Enric Balletbo i Serra <eballetbo@gmail.com>
---
 arch/arm/mach-omap2/board-igep0020.c |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-igep0020.c b/arch/arm/mach-omap2/board-igep0020.c
index 175f043..1052a63 100644
--- a/arch/arm/mach-omap2/board-igep0020.c
+++ b/arch/arm/mach-omap2/board-igep0020.c
@@ -274,6 +274,20 @@ static int igep2_twl_gpio_setup(struct device *dev,
 	igep2_vmmc1_supply.dev = mmc[0].dev;
 	igep2_vmmc2_supply.dev = mmc[1].dev;
 
+	/*
+	 * REVISIT: need ehci-omap hooks for external VBUS
+	 * power switch and overcurrent detect
+	 */
+	gpio_request(gpio + 1, "GPIO_EHCI_NOC");
+	gpio_direction_input(gpio + 1);
+
+	/*
+	 * TWL4030_GPIO_MAX + 0 == ledA, GPIO_USBH_CPEN
+	 * (out, active low)
+	 */
+	gpio_request(gpio + TWL4030_GPIO_MAX, 0);
+	gpio_direction_output(gpio + TWL4030_GPIO_MAX, 0);
+
 	return 0;
 };
 
-- 
1.7.0.4

