From: Nishanth Menon <nm@ti.com>
Subject: [PATCH v5 1/3] omap3: beaglexm: fix EHCI power up GPIO dir
Date: Tue, 11 Jan 2011 11:13:35 -0600
Message-ID: <1294766017-12182-2-git-send-email-nm@ti.com>
References: <[PATCH v4 0/3] OMAP3: beaglexm: GPIO fixes>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:40304 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932329Ab1AKRNr (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 11 Jan 2011 12:13:47 -0500
In-Reply-To: <[PATCH v4 0/3] OMAP3: beaglexm: GPIO fixes>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: l-o <linux-omap@vger.kernel.org>
Cc: l-a <linux-arm-kernel@lists.infradead.org>, Kevin <khilman@ti.com>, Tony <tony@atomide.com>, Koen Kooi <koen@beagleboard.org>, Aaro <aaro.koskinen@nokia.com>, Nishanth Menon <nm@ti.com>

From: Koen Kooi <koen@beagleboard.org>

EHCI enable power pin is inverted (active high) in comparison
to vanilla beagle which is active low. Handle this case conditionally.

Without this fix, Beagle XM 4 port EHCI will not function and no
networking will be available

[nm@ti.com: split up, added descriptive changelogs]
Signed-off-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Koen Kooi <koen@beagleboard.org>
---
 arch/arm/mach-omap2/board-omap3beagle.c |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index 6c12760..af1166b 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -297,9 +297,15 @@ static int beagle_twl_gpio_setup(struct device *dev,
 	gpio_request(gpio + 1, "EHCI_nOC");
 	gpio_direction_input(gpio + 1);
 
-	/* TWL4030_GPIO_MAX + 0 == ledA, EHCI nEN_USB_PWR (out, active low) */
+	/*
+	 * TWL4030_GPIO_MAX + 0 == ledA, EHCI nEN_USB_PWR (out, XM active
+	 * high / others active low)
+	 */
 	gpio_request(gpio + TWL4030_GPIO_MAX, "nEN_USB_PWR");
-	gpio_direction_output(gpio + TWL4030_GPIO_MAX, 0);
+	if (omap3_beagle_get_rev() == OMAP3BEAGLE_BOARD_XM)
+		gpio_direction_output(gpio + TWL4030_GPIO_MAX, 1);
+	else
+		gpio_direction_output(gpio + TWL4030_GPIO_MAX, 0);
 
 	/* TWL4030_GPIO_MAX + 1 == ledB, PMU_STAT (out, active low LED) */
 	gpio_leds[2].gpio = gpio + TWL4030_GPIO_MAX + 1;
-- 
1.6.3.3

