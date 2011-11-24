From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 4/5] OMAP4: board-4430sdp: Register platform device for digimic codec
Date: Thu, 24 Nov 2011 15:54:48 +0200
Message-ID: <1322142889-12017-5-git-send-email-peter.ujfalusi@ti.com>
References: <1322142889-12017-1-git-send-email-peter.ujfalusi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:40136 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754757Ab1KXNzs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 24 Nov 2011 08:55:48 -0500
Received: by mail-fx0-f52.google.com with SMTP id a26so4764168faa.39
        for <linux-omap@vger.kernel.org>; Thu, 24 Nov 2011 05:55:47 -0800 (PST)
In-Reply-To: <1322142889-12017-1-git-send-email-peter.ujfalusi@ti.com>
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

