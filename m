From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: [PATCH 3/4] SPI: Remove sound card self registration code from the
 TSC2301 mixer
Date: Thu, 22 Mar 2007 11:14:57 +0200
Message-ID: <20070322111457.475553db.jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Feature to create and register sound card instance in tsc2301-mixer.c
was used in early development of the driver but otherwise there is no use
for it so patch removes that unused code.

Signed-off-by: Jarkko Nikula <jarkko.nikula@nokia.com>
---
 drivers/spi/tsc2301-mixer.c |   62 +------------------------------------------
 1 files changed, 1 insertions(+), 61 deletions(-)

diff --git a/drivers/spi/tsc2301-mixer.c b/drivers/spi/tsc2301-mixer.c
index 27eba13..31ec87c 100644
--- a/drivers/spi/tsc2301-mixer.c
+++ b/drivers/spi/tsc2301-mixer.c
@@ -1,6 +1,4 @@
 /*
- * drivers/spi/tsc2301-mixer.c
- *
  * ALSA Mixer implementation for TSC2301
  *
  * Copyright (C) 2006 Nokia Corporation.
@@ -52,11 +50,6 @@
 #include <sound/core.h>
 #include <sound/control.h>
 
-#ifdef TSC2301_MIXER_SELF_REGISTRATION
-static char *id = NULL;
-MODULE_PARM_DESC(id, "TSC2301 ALSA Mixer Driver");
-#endif
-
 /* shadow register indexes */
 enum {
 	/* audio control and volume registers */
@@ -78,10 +71,6 @@ struct tsc2301_mixer {
 	struct tsc2301 *tsc;
 	struct mutex mutex;
 
-#ifdef TSC2301_MIXER_SELF_REGISTRATION
-	struct snd_card *card;
-#endif
-
 	/* shadow registers holding TSC2301 audio registers. Used to hold
 	 * their states during the sleep and also to reduce communication with
 	 * the chip since get callback functions could get register values
@@ -919,41 +908,6 @@ int tsc2301_mixer_register_controls(struct device *dev, struct snd_card *card)
 	return 0;
 }
 
-#ifdef TSC2301_MIXER_SELF_REGISTRATION
-static int tsc2301_mixer_register_card(struct tsc2301 *tsc)
-{
-	struct snd_card *card;
-	int err;
-
-	/* create new sound card instance */
-	card = snd_card_new(-1, id, THIS_MODULE, 0);
-	if (card == NULL)
-		return -ENOMEM;
-
-	tsc->mixer->card = card;
-
-	strcpy(card->driver, "TSC2301");
-	strcpy(card->shortname, "TSC2301");
-	sprintf(card->longname, "TSC2301 ALSA Mixer");
-	strcpy(card->mixername, "TSC2301 Mixer");
-
-	/* register mixer controls for the sound card */
-	if ((err = tsc2301_mixer_register_controls(&tsc->spi->dev, card)) != 0)
-		goto err1;
-
-	/* register the sound card instance */
-	if ((err = snd_card_register(card)) != 0)
-		goto err1;
-
-	printk(KERN_INFO "TSC2301 ALSA Mixer support initialized\n");
-
-	return 0;
-err1:
-	snd_card_free(card);
-	return err;
-}
-#endif
-
 int tsc2301_mixer_init(struct tsc2301 *tsc,
 		       struct tsc2301_platform_data *pdata)
 {
@@ -1020,24 +974,14 @@ int tsc2301_mixer_init(struct tsc2301 *tsc,
 
 	tsc2301_flush_shadow_regs(tsc);
 
-#ifdef TSC2301_MIXER_SELF_REGISTRATION
-	err = tsc2301_mixer_register_card(tsc);
-	if (err < 0)
-		goto err2;
-#endif
-
 	if (mix->platform_init != NULL) {
 		err = mix->platform_init(&tsc->spi->dev);
 		if (err < 0)
-			goto err3;
+			goto err2;
 	}
 
 	return 0;
-err3:
-#ifdef TSC2301_MIXER_SELF_REGISTRATION
-	snd_card_free(mix->card);
 err2:
-#endif
 	if (mix->mixer_gpios != NULL)
 		kfree(mix->mixer_gpios);
 err1:
@@ -1049,10 +993,6 @@ void tsc2301_mixer_exit(struct tsc2301 *tsc)
 {
 	struct tsc2301_mixer *mixer = tsc->mixer;
 
-#ifdef TSC2301_MIXER_SELF_REGISTRATION
-	snd_card_free(mixer->card);
-#endif
-
 	if (mixer->platform_cleanup != NULL)
 		mixer->platform_cleanup(&tsc->spi->dev);
 
-- 
1.4.4.4
