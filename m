From: Andrew Chew <achew@nvidia.com>
Subject: [PATCH 1/2 v2] ARM: OMAP: board-4430sdp: Provide regulator to pwm-backlight
Date: Tue, 12 Mar 2013 15:22:13 -0700
Message-ID: <1363126934-8754-2-git-send-email-achew@nvidia.com>
References: <1363126934-8754-1-git-send-email-achew@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from hqemgate03.nvidia.com ([216.228.121.140]:8761 "EHLO
	hqemgate03.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932302Ab3CLWWU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 12 Mar 2013 18:22:20 -0400
In-Reply-To: <1363126934-8754-1-git-send-email-achew@nvidia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: peter.ujfalusi@ti.com
Cc: thierry.reding@avionic-design.de, acourbot@nvidia.com, achew@nvidia.com, linux-omap@vger.kernel.org

The pwm-backlight driver now takes a mandatory regulator that is gotten
during driver probe.  Initialize a dummy regulator to satisfy this
requirement.

Signed-off-by: Andrew Chew <achew@nvidia.com>
---
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

