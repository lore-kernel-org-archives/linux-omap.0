From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 4/5] OMAP4: board-4430sdp: Register platform device for digimic codec
Date: Tue, 22 Nov 2011 16:01:59 +0200
Message-ID: <1321970520-8909-5-git-send-email-peter.ujfalusi@ti.com>
References: <1321970520-8909-1-git-send-email-peter.ujfalusi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aob106.obsmtp.com ([74.125.149.76]:45060 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755710Ab1KVOC0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 22 Nov 2011 09:02:26 -0500
Received: by mail-ey0-f181.google.com with SMTP id 24so220277eyx.40
        for <linux-omap@vger.kernel.org>; Tue, 22 Nov 2011 06:02:25 -0800 (PST)
In-Reply-To: <1321970520-8909-1-git-send-email-peter.ujfalusi@ti.com>
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

