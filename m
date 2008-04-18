From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCH 10/19] Code clean-up for sound/arm/omap/omap-alsa-sx1.c
Date: Fri, 18 Apr 2008 04:00:57 -0400
Message-ID: <1208505666-13744-11-git-send-email-edubezval@gmail.com>
References: <1208505666-13744-1-git-send-email-edubezval@gmail.com>
 <1208505666-13744-2-git-send-email-edubezval@gmail.com>
 <1208505666-13744-3-git-send-email-edubezval@gmail.com>
 <1208505666-13744-4-git-send-email-edubezval@gmail.com>
 <1208505666-13744-5-git-send-email-edubezval@gmail.com>
 <1208505666-13744-6-git-send-email-edubezval@gmail.com>
 <1208505666-13744-7-git-send-email-edubezval@gmail.com>
 <1208505666-13744-8-git-send-email-edubezval@gmail.com>
 <1208505666-13744-9-git-send-email-edubezval@gmail.com>
 <1208505666-13744-10-git-send-email-edubezval@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:18858 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756633AbYDRIBg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 Apr 2008 04:01:36 -0400
In-Reply-To: <1208505666-13744-10-git-send-email-edubezval@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Felipe Balbi <me@felipebalbi.com>, Ragner Magalhaes <ragner.magalhaes@indt.org.br>, Eduardo Valentin <eduardo.valentin@indt.org.br>

From: Eduardo Valentin <eduardo.valentin@indt.org.br>

Removed lots of whitespaces and a few errors and
warnings reported by checkpatch.pl.

Signed-off-by: Eduardo Valentin <eduardo.valentin@indt.org.br>
---
 sound/arm/omap/omap-alsa-sx1.c |   72 +++++++++++++++++++++++++++------------
 1 files changed, 50 insertions(+), 22 deletions(-)

diff --git a/sound/arm/omap/omap-alsa-sx1.c b/sound/arm/omap/omap-alsa-sx1.c
index c4691cd..efcabff 100644
--- a/sound/arm/omap/omap-alsa-sx1.c
+++ b/sound/arm/omap/omap-alsa-sx1.c
@@ -14,19 +14,18 @@
 #include <linux/soundcard.h>
 #include <linux/platform_device.h>
 #include <linux/clk.h>
-#include <asm/io.h>
-#include <asm/arch/mcbsp.h>
-
+#include <linux/io.h>
+#include <linux/connector.h>
 #include <linux/slab.h>
 #include <linux/pm.h>
+
 #include <asm/arch/dma.h>
 #include <asm/arch/clock.h>
 #include <asm/arch/gpio.h>
-
+#include <asm/arch/mcbsp.h>
 #include <asm/arch/omap-alsa.h>
-#include "omap-alsa-sx1.h"
 
-#include <linux/connector.h>
+#include "omap-alsa-sx1.h"
 
 /* Connector implementation */
 static struct cb_id cn_sx1snd_id = { CN_IDX_SX1SND, CN_VAL_SX1SND };
@@ -36,9 +35,10 @@ static void cn_sx1snd_callback(void *data)
 {
 	struct cn_msg *msg = (struct cn_msg *)data;
 
-	printk("%s: %lu: idx=%x, val=%x, seq=%u, ack=%u, len=%d: %s.\n",
-			__func__, jiffies, msg->id.idx, msg->id.val,
-			msg->seq, msg->ack, msg->len, (char *)msg->data);
+	printk(KERN_INFO
+		"%s: %lu: idx=%x, val=%x, seq=%u, ack=%u, len=%d: %s.\n",
+		__func__, jiffies, msg->id.idx, msg->id.val,
+		msg->seq, msg->ack, msg->len, (char *)msg->data);
 }
 
 /* Send IPC message to sound server */
@@ -63,7 +63,7 @@ int cn_sx1snd_send(unsigned int cmd, unsigned int arg1, unsigned int arg2)
 	memcpy(m + 1, data, m->len);
 
 	err = cn_netlink_send(m, CN_IDX_SX1SND, gfp_any());
-	snd_printd("sent= %02X %02X %02X, err=%d\n", cmd,arg1,arg2,err);
+	snd_printd("sent= %02X %02X %02X, err=%d\n", cmd, arg1, arg2, err);
 	kfree(m);
 
 	if (err == -ESRCH)
@@ -150,15 +150,42 @@ static void egold_set_samplerate(long sample_rate)
 	clkgdv	= CODEC_CLOCK / (sample_rate * (DEFAULT_BITPERSAMPLE * 2 - 1));
 #endif
 	switch (sample_rate) {
-		case 8000:	clkgdv = 71; egold_rate = FRQ_8000; break;
-		case 11025:	clkgdv = 51; egold_rate = FRQ_11025; break;
-		case 12000:	clkgdv = 47; egold_rate = FRQ_12000; break;
-		case 16000:	clkgdv = 35; egold_rate = FRQ_16000; break;
-		case 22050:	clkgdv = 25; egold_rate = FRQ_22050; break;
-		case 24000:	clkgdv = 23; egold_rate = FRQ_24000; break;
-		case 32000:	clkgdv = 17; egold_rate = FRQ_32000; break;
-		case 44100:	clkgdv = 12; egold_rate = FRQ_44100; break;
-		case 48000:	clkgdv = 11; egold_rate = FRQ_48000; break;
+	case 8000:
+		clkgdv = 71;
+		egold_rate = FRQ_8000;
+		break;
+	case 11025:
+		clkgdv = 51;
+		egold_rate = FRQ_11025;
+		break;
+	case 12000:
+		clkgdv = 47;
+		egold_rate = FRQ_12000;
+		break;
+	case 16000:
+		clkgdv = 35;
+		egold_rate = FRQ_16000;
+		break;
+	case 22050:
+		clkgdv = 25;
+		egold_rate = FRQ_22050;
+		break;
+	case 24000:
+		clkgdv = 23;
+		egold_rate = FRQ_24000;
+		break;
+	case 32000:
+		clkgdv = 17;
+		egold_rate = FRQ_32000;
+		break;
+	case 44100:
+		clkgdv = 12;
+		egold_rate = FRQ_44100;
+		break;
+	case 48000:
+		clkgdv = 11;
+		egold_rate = FRQ_48000;
+		break;
 	}
 
 	srgr1 = (FWID(DEFAULT_BITPERSAMPLE - 1) | CLKGDV(clkgdv));
@@ -234,8 +261,8 @@ static int __init snd_omap_alsa_egold_probe(struct platform_device *pdev)
 		return -ENODEV;
 
 	codec_cfg->hw_constraints_rates	= &egold_hw_constraints_rates;
-	codec_cfg->snd_omap_alsa_playback= &egold_snd_omap_alsa_playback;
-	codec_cfg->snd_omap_alsa_capture  = &egold_snd_omap_alsa_capture;
+	codec_cfg->snd_omap_alsa_playback = &egold_snd_omap_alsa_playback;
+	codec_cfg->snd_omap_alsa_capture = &egold_snd_omap_alsa_capture;
 	codec_cfg->codec_configure_dev	= egold_configure;
 	codec_cfg->codec_set_samplerate	= egold_set_samplerate;
 	codec_cfg->codec_clock_setup	= egold_clock_setup;
@@ -262,7 +289,8 @@ static int __init omap_alsa_egold_init(void)
 {
 	int retval;
 
-	retval = cn_add_callback(&cn_sx1snd_id, cn_sx1snd_name, cn_sx1snd_callback);
+	retval = cn_add_callback(&cn_sx1snd_id, cn_sx1snd_name,
+					cn_sx1snd_callback);
 	if (retval)
 		printk(KERN_WARNING "cn_sx1snd failed to register\n");
 	return platform_driver_register(&omap_alsa_driver);
-- 
1.5.5-rc3.GIT

