From: Ricardo Neri <rneri@dextratech.com>
Subject: [RESEND PATCH v3 2/5] ARM: OMAP4: Assign IDs to DSS HDMI devices
Date: Fri,  4 Jan 2013 17:26:24 -0600
Message-ID: <1357341987-3327-3-git-send-email-rneri@dextratech.com>
References: <1357341987-3327-1-git-send-email-rneri@dextratech.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from spamfilter.dextratech.com ([187.141.251.67]:52712 "EHLO
	mail.dextratech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755201Ab3ADX0l (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Jan 2013 18:26:41 -0500
In-Reply-To: <1357341987-3327-1-git-send-email-rneri@dextratech.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com, broonie@opensource.wolfsonmicro.com, lrg@ti.com, tony@atomide.com
Cc: peter.ujfalusi@ti.com, dzuniga@dextratech.com, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org, Ricardo Neri <rneri@dextratech.com>

While Pandaboard and SDP4430 have only one HDMI output connector, it may be
possible that future boards and SoCs support more than one HDMI output.
Thus, we define the identifier of the device. This is used by display
common code to identify and create the platform devices for HDMI audio drivers.

Signed-off-by: Ricardo Neri <rneri@dextratech.com>
---
 arch/arm/mach-omap2/board-4430sdp.c    |    3 +++
 arch/arm/mach-omap2/board-omap4panda.c |    3 +++
 2 files changed, 6 insertions(+)

diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index 3669c12..5a486d9 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -666,6 +666,9 @@ static struct omap_dss_device sdp4430_hdmi_device = {
 	.type = OMAP_DISPLAY_TYPE_HDMI,
 	.channel = OMAP_DSS_CHANNEL_DIGIT,
 	.data = &sdp4430_hdmi_data,
+	.dev = {
+		.id = -1,
+	},
 };
 
 static struct picodlp_panel_data sdp4430_picodlp_pdata = {
diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-omap2/board-omap4panda.c
index bfcd397..9f336a3 100644
--- a/arch/arm/mach-omap2/board-omap4panda.c
+++ b/arch/arm/mach-omap2/board-omap4panda.c
@@ -440,6 +440,9 @@ static struct omap_dss_device  omap4_panda_hdmi_device = {
 	.type = OMAP_DISPLAY_TYPE_HDMI,
 	.channel = OMAP_DSS_CHANNEL_DIGIT,
 	.data = &omap4_panda_hdmi_data,
+	.dev = {
+		.id = -1,
+	},
 };
 
 static struct omap_dss_device *omap4_panda_dss_devices[] = {
-- 
1.7.10.4

