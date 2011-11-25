From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v3 4/5] OMAP4: board-4430sdp: Register platform device for digimic codec
Date: Fri, 25 Nov 2011 14:20:35 +0200
Message-ID: <1322223636-31623-5-git-send-email-peter.ujfalusi@ti.com>
References: <1322223636-31623-1-git-send-email-peter.ujfalusi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:34696 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755099Ab1KYMVR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 25 Nov 2011 07:21:17 -0500
Received: by mail-bw0-f50.google.com with SMTP id zu17so5123573bkb.23
        for <linux-omap@vger.kernel.org>; Fri, 25 Nov 2011 04:21:16 -0800 (PST)
In-Reply-To: <1322223636-31623-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Tony Lindgren <tony@atomide.com>
Cc: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, Benoit Cousson <b-cousson@ti.com>

OMAP4 SDP/Blaze boards have onboard digital microphones.
Register the platform device for the dmic-codec to be
able to use the microphones.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/mach-omap2/board-4430sdp.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index 5156468..503bf28 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -372,11 +372,17 @@ static struct platform_device sdp4430_vbat = {
 	},
 };
 
+static struct platform_device sdp4430_dmic_codec = {
+	.name	= "dmic-codec",
+	.id	= -1,
+};
+
 static struct platform_device *sdp4430_devices[] __initdata = {
 	&sdp4430_gpio_keys_device,
 	&sdp4430_leds_gpio,
 	&sdp4430_leds_pwm,
 	&sdp4430_vbat,
+	&sdp4430_dmic_codec,
 };
 
 static struct omap_musb_board_data musb_board_data = {
-- 
1.7.8.rc3

