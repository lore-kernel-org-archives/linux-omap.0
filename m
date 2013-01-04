From: Ricardo Neri <rneri@dextratech.com>
Subject: [RESEND PATCH v3 3/5] ARM4: OMAP4+: HDMI: Relocate devices for audio codec and card
Date: Fri,  4 Jan 2013 17:26:25 -0600
Message-ID: <1357341987-3327-4-git-send-email-rneri@dextratech.com>
References: <1357341987-3327-1-git-send-email-rneri@dextratech.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from spamfilter.dextratech.com ([187.141.251.67]:52726 "EHLO
	mail.dextratech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755254Ab3ADX0m (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Jan 2013 18:26:42 -0500
In-Reply-To: <1357341987-3327-1-git-send-email-rneri@dextratech.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com, broonie@opensource.wolfsonmicro.com, lrg@ti.com, tony@atomide.com
Cc: peter.ujfalusi@ti.com, dzuniga@dextratech.com, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org, Ricardo Neri <rneri@dextratech.com>

Relocate the creation the platform devices for audio the HDMI audio codec and
the audio card to display.c. This allows the display code to create the required
platform devices based on what is wired on the board. Thus, as many devices as
required are created; or none if the HDMI ouptut is not implemented.

Signed-off-by: Ricardo Neri <rneri@dextratech.com>
---
 arch/arm/mach-omap2/board-4430sdp.c    |    6 ------
 arch/arm/mach-omap2/board-omap4panda.c |    6 ------
 arch/arm/mach-omap2/devices.c          |    7 -------
 arch/arm/mach-omap2/display.c          |   31 +++++++++++++++++++++++++++++++
 4 files changed, 31 insertions(+), 19 deletions(-)

diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index 5a486d9..0830d98 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -383,11 +383,6 @@ static struct platform_device sdp4430_dmic_codec = {
 	.id	= -1,
 };
 
-static struct platform_device sdp4430_hdmi_audio_codec = {
-	.name	= "hdmi-audio-codec",
-	.id	= -1,
-};
-
 static struct omap_abe_twl6040_data sdp4430_abe_audio_data = {
 	.card_name = "SDP4430",
 	.has_hs		= ABE_TWL6040_LEFT | ABE_TWL6040_RIGHT,
@@ -422,7 +417,6 @@ static struct platform_device *sdp4430_devices[] __initdata = {
 	&sdp4430_vbat,
 	&sdp4430_dmic_codec,
 	&sdp4430_abe_audio,
-	&sdp4430_hdmi_audio_codec,
 };
 
 static struct omap_musb_board_data musb_board_data = {
diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-omap2/board-omap4panda.c
index 9f336a3..561a5a7 100644
--- a/arch/arm/mach-omap2/board-omap4panda.c
+++ b/arch/arm/mach-omap2/board-omap4panda.c
@@ -126,11 +126,6 @@ static struct platform_device panda_abe_audio = {
 	},
 };
 
-static struct platform_device panda_hdmi_audio_codec = {
-	.name	= "hdmi-audio-codec",
-	.id	= -1,
-};
-
 static struct platform_device btwilink_device = {
 	.name	= "btwilink",
 	.id	= -1,
@@ -140,7 +135,6 @@ static struct platform_device *panda_devices[] __initdata = {
 	&leds_gpio,
 	&wl1271_device,
 	&panda_abe_audio,
-	&panda_hdmi_audio_codec,
 	&btwilink_device,
 };
 
diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index 66518b2..6d37438 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -355,11 +355,6 @@ static inline void omap_init_dmic(void) {}
 #if defined(CONFIG_SND_OMAP_SOC_OMAP_HDMI) || \
 		defined(CONFIG_SND_OMAP_SOC_OMAP_HDMI_MODULE)
 
-static struct platform_device omap_hdmi_audio = {
-	.name	= "omap-hdmi-audio-card",
-	.id	= -1,
-};
-
 static void __init omap_init_hdmi_audio(void)
 {
 	struct omap_hwmod *oh;
@@ -375,8 +370,6 @@ static void __init omap_init_hdmi_audio(void)
 		-1, oh, NULL, 0, NULL, 0, 0);
 	WARN(IS_ERR(pdev),
 	     "Can't build omap_device for omap-hdmi-audio-dai.\n");
-
-	platform_device_register(&omap_hdmi_audio);
 }
 #else
 static inline void omap_init_hdmi_audio(void) {}
diff --git a/arch/arm/mach-omap2/display.c b/arch/arm/mach-omap2/display.c
index 282c814e..6cc9cea 100644
--- a/arch/arm/mach-omap2/display.c
+++ b/arch/arm/mach-omap2/display.c
@@ -414,6 +414,37 @@ int __init omap_display_init(struct omap_dss_board_info *board_data)
 		}
 	}
 
+	/* Create devices for HDMI audio drivers */
+	for (i = 0; i < board_data->num_devices; i++) {
+		struct platform_device *au_pdev;
+		struct omap_dss_device *dssdev = board_data->devices[i];
+		bool card_created = false;
+
+		if (dssdev->type != OMAP_DISPLAY_TYPE_HDMI)
+			continue;
+
+		/* We need only one device for the audio card */
+		if (card_created == false) {
+			au_pdev = create_simple_dss_pdev("omap-hdmi-audio-card",
+							 -1, NULL, 0, dss_pdev);
+			if (IS_ERR(au_pdev)) {
+				pr_err("Could not build platform_device for omap-hdmi-audio-card\n");
+				return PTR_ERR(au_pdev);
+			}
+			card_created = true;
+		}
+
+		/* One device for each HDMI connector in the board */
+		au_pdev = create_simple_dss_pdev("hdmi-audio-codec",
+						  dssdev->dev.id,
+						  NULL, 0, dss_pdev);
+		if (IS_ERR(au_pdev)) {
+			pr_err("Could not build platform_device for hdmi-audio-codec\n");
+			return PTR_ERR(au_pdev);
+		}
+
+	}
+
 	return 0;
 }
 
-- 
1.7.10.4

