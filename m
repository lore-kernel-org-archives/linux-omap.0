From: Enric Balletbo i Serra <eballetbo@gmail.com>
Subject: [PATCHv2 1/6] omap3: Add external VBUS power switch and overcurrent detect on IGEP v2 board.
Date: Fri,  1 Oct 2010 21:45:48 +0200
Message-ID: <1285962353-9586-2-git-send-email-eballetbo@gmail.com>
References: <1285962353-9586-1-git-send-email-eballetbo@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:46567 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751093Ab0JATqH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Oct 2010 15:46:07 -0400
Received: by wwj40 with SMTP id 40so1814964wwj.1
        for <linux-omap@vger.kernel.org>; Fri, 01 Oct 2010 12:46:06 -0700 (PDT)
In-Reply-To: <1285962353-9586-1-git-send-email-eballetbo@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Enric Balletbo i Serra <eballetbo@gmail.com>

GPIO for various devices are missing from the board initialization.
This patch adds support for the VBUS and over current gpios.  Without this
patch, input/outputs from these two sources are ignored.

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

