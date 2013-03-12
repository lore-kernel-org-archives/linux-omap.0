From: Andrew Chew <achew@nvidia.com>
Subject: [PATCH 1/1] ARM: OMAP: board-4430sdp: Provide regulator to pwm-backlight
Date: Mon, 11 Mar 2013 18:54:26 -0700
Message-ID: <1363053266-515-1-git-send-email-achew@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from hqemgate03.nvidia.com ([216.228.121.140]:15952 "EHLO
	hqemgate03.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754615Ab3CLByZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 11 Mar 2013 21:54:25 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: peter.ujfalusi@ti.com
Cc: thierry.reding@avionic-design.de, acourbot@nvidia.com, achew@nvidia.com, linux-omap@vger.kernel.org

The pwm-backlight driver now takes a mandatory regulator that is gotten
during driver probe.  Initialize a dummy regulator to satisfy this
requirement.

Signed-off-by: Andrew Chew <achew@nvidia.com>
---
This patch, along with many more soon to follow, attempts to satisfy the new
mandatory regulator that pwm-backlight will grab during probe.  The only
board in mach-omap2 to use the pwm-backlight appears to be the 4430sdp.

I thought I'd start small and use this board as an example.

I tested similar code in my Tegra board, so it should be okay.  Of course,
I don't have a 4430sdp to test with.

 arch/arm/mach-omap2/board-4430sdp.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index 35f3ad0..62022c0 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -291,6 +291,10 @@ static struct platform_device sdp4430_leds_pwm = {
 	},
 };
 
+/* Dummy regulator for pwm-backlight driver */
+static struct regulator_consumer_supply backlight_supply =
+	REGULATOR_SUPPLY("enable", NULL);
+
 static struct platform_pwm_backlight_data sdp4430_backlight_data = {
 	.max_brightness = 127,
 	.dft_brightness = 127,
@@ -718,6 +722,7 @@ static void __init omap_4430sdp_init(void)
 
 	omap4_i2c_init();
 	omap_sfh7741prox_init();
+	regulator_register_always_on(-1, "bl-enable", &backlight_supply, 1, 0);
 	platform_add_devices(sdp4430_devices, ARRAY_SIZE(sdp4430_devices));
 	omap_serial_init();
 	omap_sdrc_init(NULL, NULL);
-- 
1.7.9.5

