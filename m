From: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: [RESEND][PATCH] ASoC: ams-delta: Convert to use
	snd_soc_register_card()
Date: Wed, 03 Oct 2012 12:46:57 +0200
Message-ID: <1582731.dIkBtAuyKn@vclass>
References: <20120906073633.GC22330@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20120906073633.GC22330@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, Liam Girdwood <lrg@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

The old method of registering with the ASoC core by creating a
"soc-audio" platform device no longer works for Amstrad Delta sound card
after recent changes to drvdata handling (commit
0998d0631001288a5974afc0b2a5f568bcdecb4d, 'device-core: Ensure drvdata =
NULL when no driver is bound'.

Use snd_soc_register_card() method instead, as suggested by the ASoC
core generated warning message, and move both the card and codec
platform device registration to the arch board file where those belong.

Created and tested against linux-3.6-rc5.

Signed-off-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
---
On Thu, 6 Sep 2012 15:36:35 Mark Brown wrote:
> On Sat, Sep 01, 2012 at 11:09:18AM +0200, Janusz Krzysztofik wrote:
> 
> > I see your point, however for now I can see no better way of referencing 
> > the data (of type struct snd_soc_card) then passing it to 
> > snd_soc_register_card(). But for this to work, I would have to register 
> > successfully an ams-delta specific platform device first, not the soc-
> > audio. This, even if still done from the sound/soc/omap/ams-delta.c, not 
> > from an arch board file, would require now not existing ams-delta ASoC 
> > platform driver probe/remove callbacks at least. I'm still not convinced 
> > if such modification would be acceptable in the middle of the rc cycle.
> 
> > If there is a simpler, less intrusive way to do this, then sorry, I 
> > still can't see it.
> 
> Like I already said just make it a static variable.

Mark,
Sorry, I was still not able to understand what you actually meant, and
to come out with a working fix other than I initially proposed. If what
I've prepared now is not acceptable as a fix, than hard luck, please
consider queueing it for 3.7, and 3.6 must go with Amstrad Delta sound
not working unless someone else is still able to fix it.

Tony,
Please give your ack on the arch/arm/mach-omap1 bits if acceptable. I
believe there should be no merge conflicts if this change goes through
sound/soc.

Thanks,
Janusz

 arch/arm/mach-omap1/board-ams-delta.c |   12 ++++++
 sound/soc/omap/ams-delta.c            |   63 +++++++++++++++-----------------
 2 files changed, 42 insertions(+), 33 deletions(-)

diff --git a/arch/arm/mach-omap1/board-ams-delta.c b/arch/arm/mach-omap1/board-ams-delta.c
index c534698..5ab9c6b 100644
--- a/arch/arm/mach-omap1/board-ams-delta.c
+++ b/arch/arm/mach-omap1/board-ams-delta.c
@@ -444,16 +444,28 @@ static struct omap1_cam_platform_data ams_delta_camera_platform_data = {
 	.lclk_khz_max	= 1334,		/* results in 5fps CIF, 10fps QCIF */
 };
 
+static struct platform_device ams_delta_audio_device = {
+	.name   = "ams-delta-audio",
+	.id     = -1,
+};
+
+static struct platform_device cx20442_codec_device = {
+	.name   = "cx20442-codec",
+	.id     = -1,
+};
+
 static struct platform_device *ams_delta_devices[] __initdata = {
 	&latch1_gpio_device,
 	&latch2_gpio_device,
 	&ams_delta_kp_device,
 	&ams_delta_camera_device,
+	&ams_delta_audio_device,
 };
 
 static struct platform_device *late_devices[] __initdata = {
 	&ams_delta_nand_device,
 	&ams_delta_lcd_device,
+	&cx20442_codec_device,
 };
 
 static void __init ams_delta_init(void)
diff --git a/sound/soc/omap/ams-delta.c b/sound/soc/omap/ams-delta.c
index 7d4fa8e..7b18b74 100644
--- a/sound/soc/omap/ams-delta.c
+++ b/sound/soc/omap/ams-delta.c
@@ -575,56 +575,53 @@ static struct snd_soc_card ams_delta_audio_card = {
 };
 
 /* Module init/exit */
-static struct platform_device *ams_delta_audio_platform_device;
-static struct platform_device *cx20442_platform_device;
-
-static int __init ams_delta_module_init(void)
+static __devinit int ams_delta_probe(struct platform_device *pdev)
 {
+	struct snd_soc_card *card = &ams_delta_audio_card;
 	int ret;
 
-	if (!(machine_is_ams_delta()))
-		return -ENODEV;
-
-	ams_delta_audio_platform_device =
-			platform_device_alloc("soc-audio", -1);
-	if (!ams_delta_audio_platform_device)
-		return -ENOMEM;
+	card->dev = &pdev->dev;
 
-	platform_set_drvdata(ams_delta_audio_platform_device,
-				&ams_delta_audio_card);
-
-	ret = platform_device_add(ams_delta_audio_platform_device);
-	if (ret)
-		goto err;
-
-	/*
-	 * Codec platform device could be registered from elsewhere (board?),
-	 * but I do it here as it makes sense only if used with the card.
-	 */
-	cx20442_platform_device =
-		platform_device_register_simple("cx20442-codec", -1, NULL, 0);
+	ret = snd_soc_register_card(card);
+	if (ret) {
+		dev_err(&pdev->dev, "snd_soc_register_card failed (%d)\n", ret);
+		card->dev = NULL;
+		return ret;
+	}
 	return 0;
-err:
-	platform_device_put(ams_delta_audio_platform_device);
-	return ret;
 }
-late_initcall(ams_delta_module_init);
 
-static void __exit ams_delta_module_exit(void)
+static int __devexit ams_delta_remove(struct platform_device *pdev)
 {
+	struct snd_soc_card *card = platform_get_drvdata(pdev);
+
 	if (tty_unregister_ldisc(N_V253) != 0)
-		dev_warn(&ams_delta_audio_platform_device->dev,
+		dev_warn(&pdev->dev,
 			"failed to unregister V253 line discipline\n");
 
 	snd_soc_jack_free_gpios(&ams_delta_hook_switch,
 			ARRAY_SIZE(ams_delta_hook_switch_gpios),
 			ams_delta_hook_switch_gpios);
 
-	platform_device_unregister(cx20442_platform_device);
-	platform_device_unregister(ams_delta_audio_platform_device);
+	snd_soc_unregister_card(card);
+	card->dev = NULL;
+	return 0;
 }
-module_exit(ams_delta_module_exit);
+
+#define DRV_NAME "ams-delta-audio"
+
+static struct platform_driver ams_delta_driver = {
+	.driver = {
+		.name = DRV_NAME,
+		.owner = THIS_MODULE,
+	},
+	.probe = ams_delta_probe,
+	.remove = __devexit_p(ams_delta_remove),
+};
+
+module_platform_driver(ams_delta_driver);
 
 MODULE_AUTHOR("Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>");
 MODULE_DESCRIPTION("ALSA SoC driver for Amstrad E3 (Delta) videophone");
 MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:" DRV_NAME);
-- 
1.7.3.4
