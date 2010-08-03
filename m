From: Enric Balletbo i Serra <eballetbo@gmail.com>
Subject: [PATCH 2/4] omap3: configure GPIO's for external VBUS power switch and overcurrent detect on IGEP v2 board.
Date: Tue,  3 Aug 2010 13:56:12 +0200
Message-ID: <1280836574-32467-3-git-send-email-eballetbo@gmail.com>
References: <1280836574-32467-1-git-send-email-eballetbo@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:39296 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753016Ab0HCL4Y (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 Aug 2010 07:56:24 -0400
Received: by mail-ww0-f44.google.com with SMTP id 40so5028695wwj.1
        for <linux-omap@vger.kernel.org>; Tue, 03 Aug 2010 04:56:23 -0700 (PDT)
In-Reply-To: <1280836574-32467-1-git-send-email-eballetbo@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Enric Balletbo i Serra <eballetbo@iseebcn.com>, Enric Balletbo i Serra <eballetbo@gmail.com>

From: Enric Balletbo i Serra <eballetbo@iseebcn.com>


Signed-off-by: Enric Balletbo i Serra <eballetbo@gmail.com>
---
 arch/arm/mach-omap2/board-igep0020.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-igep0020.c b/arch/arm/mach-omap2/board-igep0020.c
index 6b5f9c8..d88fc08 100644
--- a/arch/arm/mach-omap2/board-igep0020.c
+++ b/arch/arm/mach-omap2/board-igep0020.c
@@ -285,6 +285,16 @@ static int igep2_twl_gpio_setup(struct device *dev,
 	igep2_vmmc1_supply.dev = mmc[0].dev;
 	igep2_vmmc2_supply.dev = mmc[1].dev;
 
+	/* REVISIT: need ehci-omap hooks for external VBUS
+	 * power switch and overcurrent detect
+	 */
+	gpio_request(gpio + 1, "GPIO_EHCI_NOC");
+	gpio_direction_input(gpio + 1);
+
+	/* TWL4030_GPIO_MAX + 0 == ledA, GPIO_USBH_CPEN (out, active low) */
+	gpio_request(gpio + TWL4030_GPIO_MAX, "GPIO_USB_CPEN");
+	gpio_direction_output(gpio + TWL4030_GPIO_MAX, 0);
+
 	return 0;
 };
 
-- 
1.7.0.4

