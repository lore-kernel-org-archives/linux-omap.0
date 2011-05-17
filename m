From: Ricardo Neri <ricardo.neri@ti.com>
Subject: [PATCH 1/2] OMAP4: HDMI: Add OMAP device for HDMI audio CPU DAI
Date: Mon, 16 May 2011 22:14:38 -0500
Message-ID: <1305602079-3852-2-git-send-email-ricardo.neri@ti.com>
References: <1305602079-3852-1-git-send-email-ricardo.neri@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:52637 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751495Ab1EQDQI (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 16 May 2011 23:16:08 -0400
In-Reply-To: <1305602079-3852-1-git-send-email-ricardo.neri@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tony@atomide.com, b-cousson@ti.com, paul@pwsan.com
Cc: Ricardo Neri <ricardo.neri@ti.com>

Add device for HDMI audio. This device uses hwmod data from
dss_hdmi. This device is to be used by the ASoC HDMI CPU DAI to
obtain base memory address and DMA request number.

Signed-off-by: Ricardo Neri <ricardo.neri@ti.com>
---
 arch/arm/mach-omap2/devices.c |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index 7b85585..56e2e98 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -313,6 +313,22 @@ OMAP_MCBSP_PLATFORM_DEVICE(5);
 
 static void omap_init_audio(void)
 {
+	struct omap_hwmod *oh_hdmi;
+	struct omap_device *od_hdmi;
+	char *oh_hdmi_name = "dss_hdmi";
+	char *dev_hdmi_name = "hdmi-audio-dai";
+
+	if (cpu_is_omap44xx()) {
+		oh_hdmi = omap_hwmod_lookup(oh_hdmi_name);
+		WARN(!oh_hdmi, "%s: could not find omap_hwmod for %s\n",
+			__func__, oh_hdmi_name);
+
+		od_hdmi = omap_device_build(dev_hdmi_name, -1, oh_hdmi, NULL, 0,
+			NULL, 0, false);
+		WARN(IS_ERR(od_hdmi), "%s: could not build omap_device for %s\n",
+			__func__, dev_hdmi_name);
+	}
+
 	platform_device_register(&omap_mcbsp1);
 	platform_device_register(&omap_mcbsp2);
 	if (cpu_is_omap243x() || cpu_is_omap34xx() || cpu_is_omap44xx()) {
-- 
1.7.0.4

