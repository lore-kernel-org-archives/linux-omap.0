From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 6/8] ASoC: sdp3430: No need to configure pin mux for extmute
Date: Mon, 31 Dec 2012 11:51:47 +0100
Message-ID: <1356951109-4286-7-git-send-email-peter.ujfalusi@ti.com>
References: <1356951109-4286-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:55804 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751262Ab2LaKwu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 31 Dec 2012 05:52:50 -0500
In-Reply-To: <1356951109-4286-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Grant Likely <grant.likely@secretlab.ca>
Cc: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, NeilBrown <neilb@suse.de>

The codec driver takes care of this.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/omap/sdp3430.c | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/sound/soc/omap/sdp3430.c b/sound/soc/omap/sdp3430.c
index f2e2651..216cbdd 100644
--- a/sound/soc/omap/sdp3430.c
+++ b/sound/soc/omap/sdp3430.c
@@ -24,7 +24,6 @@
 
 #include <linux/clk.h>
 #include <linux/platform_device.h>
-#include <linux/i2c/twl.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/soc.h>
@@ -32,20 +31,12 @@
 
 #include <asm/mach-types.h>
 #include <linux/platform_data/gpio-omap.h>
-#include <linux/platform_data/asoc-ti-mcbsp.h>
 
-/* Register descriptions for twl4030 codec part */
-#include <linux/mfd/twl4030-audio.h>
 #include <linux/module.h>
 
 #include "omap-mcbsp.h"
 #include "omap-pcm.h"
 
-/* TWL4030 PMBR1 Register */
-#define TWL4030_INTBR_PMBR1		0x0D
-/* TWL4030 PMBR1 Register GPIO6 mux bit */
-#define TWL4030_GPIO6_PWM0_MUTE(value)	(value << 2)
-
 static struct snd_soc_card snd_soc_sdp3430;
 
 static int sdp3430_hw_params(struct snd_pcm_substream *substream,
@@ -212,7 +203,6 @@ static struct platform_device *sdp3430_snd_device;
 static int __init sdp3430_soc_init(void)
 {
 	int ret;
-	u8 pin_mux;
 
 	if (!machine_is_omap_3430sdp())
 		return -ENODEV;
@@ -226,14 +216,6 @@ static int __init sdp3430_soc_init(void)
 
 	platform_set_drvdata(sdp3430_snd_device, &snd_soc_sdp3430);
 
-	/* Set TWL4030 GPIO6 as EXTMUTE signal */
-	twl_i2c_read_u8(TWL4030_MODULE_INTBR, &pin_mux,
-						TWL4030_INTBR_PMBR1);
-	pin_mux &= ~TWL4030_GPIO6_PWM0_MUTE(0x03);
-	pin_mux |= TWL4030_GPIO6_PWM0_MUTE(0x02);
-	twl_i2c_write_u8(TWL4030_MODULE_INTBR, pin_mux,
-						TWL4030_INTBR_PMBR1);
-
 	ret = platform_device_add(sdp3430_snd_device);
 	if (ret)
 		goto err1;
-- 
1.8.0.2

