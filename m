From: "Lopez Cruz, Misael" <x0052729@ti.com>
Subject: [PATCH 3/3] ASoC: Add headset jack detection for SDP3430 machine
 driver
Date: Thu, 26 Feb 2009 01:57:53 -0600
Message-ID: <2C7D3DF36ADFFC479B44490D912B616705EC8B1C05@dlee07.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:51318 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752126AbZBZH6I convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 Feb 2009 02:58:08 -0500
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Add headset jack detection for SDP3430 boards using SoC jack
reporting interface. Headset detection on SDP3430 board is
achieved through TWL4030 GPIO_2 pin.

Signed-off-by: Misael Lopez Cruz <x0052729@ti.com>
---
 sound/soc/omap/sdp3430.c |   31 ++++++++++++++++++++++++++++++-
 1 files changed, 30 insertions(+), 1 deletions(-)

diff --git a/sound/soc/omap/sdp3430.c b/sound/soc/omap/sdp3430.c
index 7a996d9..7695675 100644
--- a/sound/soc/omap/sdp3430.c
+++ b/sound/soc/omap/sdp3430.c
@@ -28,6 +28,7 @@
 #include <sound/pcm.h>
 #include <sound/soc.h>
 #include <sound/soc-dapm.h>
+#include <sound/jack.h>
 
 #include <asm/mach-types.h>
 #include <mach/hardware.h>
@@ -141,6 +142,18 @@ static int sdp3430_twl4030_init(struct snd_soc_codec *codec)
 	return ret;
 }
 
+/* Jack detection */
+struct snd_soc_jack *sdp3430_jack;
+
+struct snd_soc_jack_pin sdp3430_jack_pins[] = {
+	{
+		.pin = "Headset Jack",
+		.mask = SND_JACK_HEADSET,
+		.invert = 0,
+		.gpio = (OMAP_MAX_GPIO_LINES + 2),
+	},
+};
+
 /* Digital audio interface glue - connects codec <--> CPU */
 static struct snd_soc_dai_link sdp3430_dai = {
 	.name = "TWL4030",
@@ -191,7 +204,23 @@ static int __init sdp3430_soc_init(void)
 	if (ret)
 		goto err1;
 
-	return 0;
+	/* Jack detection */
+	sdp3430_jack = kzalloc(sizeof(struct snd_soc_jack), GFP_KERNEL);
+	if (!sdp3430_jack) {
+		printk(KERN_ERR "SDP3430 SoC Jack allocation failed\n");
+		return -ENOMEM;
+	}
+
+	snd_soc_jack_new(&snd_soc_sdp3430, "SDP3430 SoC Jack",
+				SND_JACK_HEADSET, sdp3430_jack);
+	if (ret)
+		return ret;
+
+	ret = snd_soc_jack_add_pins(sdp3430_jack,
+				ARRAY_SIZE(sdp3430_jack_pins),
+				sdp3430_jack_pins);
+
+	return ret;
 
 err1:
 	printk(KERN_ERR "Unable to add platform device\n");
-- 
1.5.4.3
