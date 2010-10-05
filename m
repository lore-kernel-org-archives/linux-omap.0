From: Enric Balletbo i Serra <eballetbo@gmail.com>
Subject: [PATCHv4 1/6] omap3: Add external VBUS power switch and overcurrent detect on IGEP v2 board.
Date: Tue,  5 Oct 2010 16:15:17 +0200
Message-ID: <1286288122-16834-2-git-send-email-eballetbo@gmail.com>
References: <1286288122-16834-1-git-send-email-eballetbo@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f42.google.com ([74.125.82.42]:62571 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752311Ab0JEOPe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Oct 2010 10:15:34 -0400
Received: by wwe15 with SMTP id 15so288548wwe.1
        for <linux-omap@vger.kernel.org>; Tue, 05 Oct 2010 07:15:32 -0700 (PDT)
In-Reply-To: <1286288122-16834-1-git-send-email-eballetbo@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Enric Balletbo i Serra <eballetbo@gmail.com>

GPIO for various devices are missing from the board initialization.
This patch adds support for the VBUS and over current gpios.  Without this
patch, input/outputs from these two sources are ignored.

Signed-off-by: Enric Balletbo i Serra <eballetbo@gmail.com>
---
 arch/arm/mach-omap2/board-igep0020.c |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-igep0020.c b/arch/arm/mach-omap2/board-igep0020.c
index 175f043..07dbdb7 100644
--- a/arch/arm/mach-omap2/board-igep0020.c
+++ b/arch/arm/mach-omap2/board-igep0020.c
@@ -274,6 +274,22 @@ static int igep2_twl_gpio_setup(struct device *dev,
 	igep2_vmmc1_supply.dev = mmc[0].dev;
 	igep2_vmmc2_supply.dev = mmc[1].dev;
 
+	/*
+	 * REVISIT: need ehci-omap hooks for external VBUS
+	 * power switch and overcurrent detect
+	 */
+	if ((gpio_request(gpio + 1, "GPIO_EHCI_NOC") < 0) ||
+	    (gpio_direction_input(gpio + 1) < 0))
+		pr_err("IGEP2: Could not obtain gpio for EHCI NOC");
+
+	/*
+	 * TWL4030_GPIO_MAX + 0 == ledA, GPIO_USBH_CPEN
+	 * (out, active low)
+	 */
+	if ((gpio_request(gpio + TWL4030_GPIO_MAX, "GPIO_USBH_CPEN") < 0) ||
+	    (gpio_direction_output(gpio + TWL4030_GPIO_MAX, 0) < 0))
+		pr_err("IGEP2: Could not obtain gpio for USBH_CPEN");
+
 	return 0;
 };
 
-- 
1.7.0.4

