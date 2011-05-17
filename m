From: Ricardo Neri <ricardo.neri@ti.com>
Subject: [PATCH 2/2] OMAP4: Add device for HDMI OMAP4 audio for ASoC machine driver
Date: Mon, 16 May 2011 22:14:39 -0500
Message-ID: <1305602079-3852-3-git-send-email-ricardo.neri@ti.com>
References: <1305602079-3852-1-git-send-email-ricardo.neri@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:32971 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751576Ab1EQDQI (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 16 May 2011 23:16:08 -0400
In-Reply-To: <1305602079-3852-1-git-send-email-ricardo.neri@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tony@atomide.com, b-cousson@ti.com, paul@pwsan.com
Cc: Ricardo Neri <ricardo.neri@ti.com>

This device is used by the OMAP4 HDMI audio machine driver to register the
HDMI sound card.

Signed-off-by: Ricardo Neri <ricardo.neri@ti.com>
---
 arch/arm/mach-omap2/devices.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index 56e2e98..6add0d2 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -300,6 +300,14 @@ static struct platform_device omap_pcm = {
 };
 
 /*
+ * Device for the ASoC OMAP4 HDMI machine driver
+ */
+static struct platform_device omap4_hdmi_audio = {
+	.name	= "omap4-hdmi-audio",
+	.id	= -1,
+};
+
+/*
  * OMAP2420 has 2 McBSP ports
  * OMAP2430 has 5 McBSP ports
  * OMAP3 has 5 McBSP ports
@@ -327,6 +335,8 @@ static void omap_init_audio(void)
 			NULL, 0, false);
 		WARN(IS_ERR(od_hdmi), "%s: could not build omap_device for %s\n",
 			__func__, dev_hdmi_name);
+
+		platform_device_register(&omap4_hdmi_audio);
 	}
 
 	platform_device_register(&omap_mcbsp1);
-- 
1.7.0.4

