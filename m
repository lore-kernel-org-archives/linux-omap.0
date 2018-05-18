From: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: [PATCH 3/6] ASoC: ams_delta: use GPIO lookup table
Date: Fri, 18 May 2018 23:09:51 +0200
Message-ID: <20180518210954.29044-3-jmkrzyszt@gmail.com>
References: <20180518210954.29044-1-jmkrzyszt@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180518210954.29044-1-jmkrzyszt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Boris Brezillon <boris.brezillon@bootlin.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Mark Brown <broonie@kernel.org>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, Richard Weinberger <richard@nod.at>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, linux-mtd@lists.infradead.org, linux-fbdev@vger.kernel.org, alsa-devel@alsa-project.org, Janusz Krzysztofik <jmkrzyszt@gmail.com>
List-Id: linux-omap@vger.kernel.org

Now as the Amstrad Delta board provides GPIO lookup tables, switch from
GPIO numbers to GPIO descriptors and use the table to locate required
GPIO pins.

The card uses two pins, one for jack and the other for voice modem
codec DAI control.

For jack pin, remove hardcoded GPIO number and use GPIO descriptor
based variant of jack GPIO initialization.

For modem_codec pin, declare static variable for storing its GPIO
descriptor, obtain it on card initialization and replace obsolete
ams_delta_latch2_write() with gpiod_set_value().  For that to work,
don't request the modem_codec pin from the board init code anymore.

If the modem_codec GPIO lookup fails, skip initialization of
functionality of the card which depends on its availability.

Pin naming used by the driver should be followed while respective GPIO
lookup table is initialized by a board init code.

Created and tested against linux-4.17-rc3, on top of patch 1/6 "ARM:
OMAP1: ams-delta: add GPIO lookup tables"

Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
---
 arch/arm/mach-omap1/board-ams-delta.c |  5 -----
 sound/soc/omap/ams-delta.c            | 38 +++++++++++++++++++----------------
 2 files changed, 21 insertions(+), 22 deletions(-)

diff --git a/arch/arm/mach-omap1/board-ams-delta.c b/arch/arm/mach-omap1/board-ams-delta.c
index 4b78e73f8bf7..80f54cb54276 100644
--- a/arch/arm/mach-omap1/board-ams-delta.c
+++ b/arch/arm/mach-omap1/board-ams-delta.c
@@ -259,11 +259,6 @@ static const struct gpio latch_gpios[] __initconst = {
 		.flags	= GPIOF_OUT_INIT_LOW,
 		.label	= "scard_cmdvcc",
 	},
-	{
-		.gpio	= AMS_DELTA_GPIO_PIN_MODEM_CODEC,
-		.flags	= GPIOF_OUT_INIT_LOW,
-		.label	= "modem_codec",
-	},
 	{
 		.gpio	= AMS_DELTA_LATCH2_GPIO_BASE + 14,
 		.flags	= GPIOF_OUT_INIT_LOW,
diff --git a/sound/soc/omap/ams-delta.c b/sound/soc/omap/ams-delta.c
index 77a30f0f0c96..4dce494dfbd3 100644
--- a/sound/soc/omap/ams-delta.c
+++ b/sound/soc/omap/ams-delta.c
@@ -22,7 +22,7 @@
  *
  */
 
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/spinlock.h>
 #include <linux/tty.h>
 #include <linux/module.h>
@@ -32,7 +32,6 @@
 
 #include <asm/mach-types.h>
 
-#include <mach/board-ams-delta.h>
 #include <linux/platform_data/asoc-ti-mcbsp.h>
 
 #include "omap-mcbsp.h"
@@ -213,7 +212,6 @@ static const struct snd_kcontrol_new ams_delta_audio_controls[] = {
 static struct snd_soc_jack ams_delta_hook_switch;
 static struct snd_soc_jack_gpio ams_delta_hook_switch_gpios[] = {
 	{
-		.gpio = 4,
 		.name = "hook_switch",
 		.report = SND_JACK_HEADSET,
 		.invert = 1,
@@ -259,6 +257,7 @@ static struct timer_list cx81801_timer;
 static bool cx81801_cmd_pending;
 static bool ams_delta_muted;
 static DEFINE_SPINLOCK(ams_delta_lock);
+static struct gpio_desc *gpiod_modem_codec;
 
 static void cx81801_timeout(struct timer_list *unused)
 {
@@ -272,7 +271,7 @@ static void cx81801_timeout(struct timer_list *unused)
 	/* Reconnect the codec DAI back from the modem to the CPU DAI
 	 * only if digital mute still off */
 	if (!muted)
-		ams_delta_latch2_write(AMS_DELTA_LATCH2_MODEM_CODEC, 0);
+		gpiod_set_value(gpiod_modem_codec, 0);
 }
 
 /* Line discipline .open() */
@@ -381,8 +380,7 @@ static void cx81801_receive(struct tty_struct *tty,
 		/* Apply config pulse by connecting the codec to the modem
 		 * if not already done */
 		if (apply)
-			ams_delta_latch2_write(AMS_DELTA_LATCH2_MODEM_CODEC,
-						AMS_DELTA_LATCH2_MODEM_CODEC);
+			gpiod_set_value(gpiod_modem_codec, 1);
 		break;
 	}
 }
@@ -432,8 +430,7 @@ static int ams_delta_digital_mute(struct snd_soc_dai *dai, int mute)
 	spin_unlock_bh(&ams_delta_lock);
 
 	if (apply)
-		ams_delta_latch2_write(AMS_DELTA_LATCH2_MODEM_CODEC,
-				mute ? AMS_DELTA_LATCH2_MODEM_CODEC : 0);
+		gpiod_set_value(gpiod_modem_codec, !!mute);
 	return 0;
 }
 
@@ -469,14 +466,6 @@ static int ams_delta_cx20442_init(struct snd_soc_pcm_runtime *rtd)
 	/* Store a pointer to the codec structure for tty ldisc use */
 	cx20442_codec = rtd->codec_dai->component;
 
-	/* Set up digital mute if not provided by the codec */
-	if (!codec_dai->driver->ops) {
-		codec_dai->driver->ops = &ams_delta_dai_ops;
-	} else {
-		ams_delta_ops.startup = ams_delta_startup;
-		ams_delta_ops.shutdown = ams_delta_shutdown;
-	}
-
 	/* Add hook switch - can be used to control the codec from userspace
 	 * even if line discipline fails */
 	ret = snd_soc_card_jack_new(card, "hook_switch", SND_JACK_HEADSET,
@@ -486,7 +475,7 @@ static int ams_delta_cx20442_init(struct snd_soc_pcm_runtime *rtd)
 				"Failed to allocate resources for hook switch, "
 				"will continue without one.\n");
 	else {
-		ret = snd_soc_jack_add_gpios(&ams_delta_hook_switch,
+		ret = snd_soc_jack_add_gpiods(card->dev, &ams_delta_hook_switch,
 					ARRAY_SIZE(ams_delta_hook_switch_gpios),
 					ams_delta_hook_switch_gpios);
 		if (ret)
@@ -495,6 +484,21 @@ static int ams_delta_cx20442_init(struct snd_soc_pcm_runtime *rtd)
 				"will continue with hook switch inactive.\n");
 	}
 
+	gpiod_modem_codec = devm_gpiod_get(card->dev, "modem_codec",
+					   GPIOD_OUT_HIGH);
+	if (IS_ERR(gpiod_modem_codec)) {
+		dev_warn(card->dev, "Failed to obtain modem_codec GPIO\n");
+		return 0;
+	}
+
+	/* Set up digital mute if not provided by the codec */
+	if (!codec_dai->driver->ops) {
+		codec_dai->driver->ops = &ams_delta_dai_ops;
+	} else {
+		ams_delta_ops.startup = ams_delta_startup;
+		ams_delta_ops.shutdown = ams_delta_shutdown;
+	}
+
 	/* Register optional line discipline for over the modem control */
 	ret = tty_register_ldisc(N_V253, &cx81801_ops);
 	if (ret) {
-- 
2.16.1
