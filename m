From: Andrew Chew <achew@nvidia.com>
Subject: [PATCH V3 1/2] ARM: OMAP: board-4430sdp: Provide regulator to pwm-backlight
Date: Wed, 13 Mar 2013 15:33:25 -0700
Message-ID: <1363214006-10662-2-git-send-email-achew@nvidia.com>
References: <1363214006-10662-1-git-send-email-achew@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from hqemgate04.nvidia.com ([216.228.121.35]:5666 "EHLO
	hqemgate04.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755609Ab3CMWdK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 13 Mar 2013 18:33:10 -0400
In-Reply-To: <1363214006-10662-1-git-send-email-achew@nvidia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: peter.ujfalusi@ti.com
Cc: thierry.reding@avionic-design.de, acourbot@nvidia.com, achew@nvidia.com, linux-omap@vger.kernel.org

The pwm-backlight driver now takes a mandatory regulator that is gotten
during driver probe.  Initialize a dummy regulator to satisfy this
requirement.

Signed-off-by: Andrew Chew <achew@nvidia.com>
---
Changed the device name of the backlight regulator supply to "pwm-backlight",
per Peter's comment.

Changed the name of the regulator to "backlight-enable", per Thierry's
suggestion.

 arch/arm/mach-omap2/board-4430sdp.c |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index 35f3ad0..a01a39a 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -291,6 +291,10 @@ static struct platform_device sdp4430_leds_pwm = {
 	},
 };
 
+/* Dummy regulator for pwm-backlight driver */
+static struct regulator_consumer_supply backlight_supply =
+	REGULATOR_SUPPLY("enable", "pwm-backlight");
+
 static struct platform_pwm_backlight_data sdp4430_backlight_data = {
 	.max_brightness = 127,
 	.dft_brightness = 127,
@@ -718,6 +722,8 @@ static void __init omap_4430sdp_init(void)
 
 	omap4_i2c_init();
 	omap_sfh7741prox_init();
+	regulator_register_always_on(-1, "backlight-enable",
+				     &backlight_supply, 1, 0);
 	platform_add_devices(sdp4430_devices, ARRAY_SIZE(sdp4430_devices));
 	omap_serial_init();
 	omap_sdrc_init(NULL, NULL);
-- 
1.7.9.5

