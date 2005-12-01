From: Komal Shah <komal_shah802003@yahoo.com>
Subject: [PATCH] ALSA AUDIO: Use struct platform driver
Date: Thu, 1 Dec 2005 02:49:37 -0800 (PST)
Message-ID: <20051201104937.37434.qmail@web32915.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1011094732-1133434177=:37214"
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

--0-1011094732-1133434177=:37214
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Id: 
Content-Disposition: inline

Tony,

Attached patch uses struct platform_driver.

---Komal Shah
http://komalshah.blogspot.com/


		
__________________________________ 
Yahoo! Music Unlimited 
Access over 1 million songs. Try it free. 
http://music.yahoo.com/unlimited/
--0-1011094732-1133434177=:37214
Content-Type: text/plain;
	name="0008-alsa-omap-audio-Use-struct-platform_driver.txt"
Content-Description: pat700073264
Content-Disposition: inline;
	filename="0008-alsa-omap-audio-Use-struct-platform_driver.txt"

Subject: [PATCH 8/10] alsa/omap-audio: Use struct platform_driver
Signed-off-by: Komal Shah <komal_shah802003@yahoo.com>

---

 sound/arm/omap-aic23.c |   29 +++++++++++++++--------------
 1 files changed, 15 insertions(+), 14 deletions(-)

applies-to: d0304cd459a90d940ed57b674f4538e8b84ebd8b
9779c089dc1deaa65449d65f88d537592867c6ae
diff --git a/sound/arm/omap-aic23.c b/sound/arm/omap-aic23.c
index 960108f..c6516f8 100644
--- a/sound/arm/omap-aic23.c
+++ b/sound/arm/omap-aic23.c
@@ -668,9 +668,9 @@ static int snd_omap_aic23_resume(snd_car
 /*
  * Driver suspend/resume - calls alsa functions. Some hints from aaci.c
  */
-static int omap_aic23_suspend(struct device *dev, pm_message_t state)
+static int omap_aic23_suspend(struct platform_device *pdev, pm_message_t state)
 {
-	snd_card_t *card = dev_get_drvdata(dev);
+	snd_card_t *card = platform_get_drvdata(pdev);
 	
 	if (card->power_state != SNDRV_CTL_POWER_D3hot) {
 		snd_omap_aic23_suspend(card, PMSG_SUSPEND);
@@ -678,9 +678,9 @@ static int omap_aic23_suspend(struct dev
 	return 0;
 }
 
-static int omap_aic23_resume(struct device *dev)
+static int omap_aic23_resume(struct platform_device *pdev)
 {
-	snd_card_t *card = dev_get_drvdata(dev);
+	snd_card_t *card = platform_get_drvdata(pdev);
 
 	if (card->power_state != SNDRV_CTL_POWER_D0) {
 		snd_omap_aic23_resume(card);
@@ -801,7 +801,7 @@ int omap_aic23_clock_off(void)
 /* 
  *  Inits alsa soudcard structure
  */
-static int __init snd_omap_aic23_probe(struct device *dev)
+static int __init snd_omap_aic23_probe(struct platform_device *pdev)
 {
 	int err = 0;
 	snd_card_t *card;
@@ -847,7 +847,7 @@ static int __init snd_omap_aic23_probe(s
 	
 	if ((err = snd_card_register(card)) == 0) {
 		printk(KERN_INFO "OSK audio support initialized\n");
-		dev_set_drvdata(dev, card); 
+		platform_set_drvdata(pdev, card); 
 		return 0;
 	}
 	
@@ -857,9 +857,9 @@ nodev:
 	return err;
 }
 
-static int snd_omap_aic23_remove(struct device *dev)
+static int snd_omap_aic23_remove(struct platform_device *pdev)
 {
-	snd_card_t *card = dev_get_drvdata(dev);
+	snd_card_t *card = platform_get_drvdata(pdev);
 	struct snd_card_omap_aic23 *chip = card->private_data;
 	
 	snd_card_free(card);
@@ -868,19 +868,20 @@ static int snd_omap_aic23_remove(struct 
 	card->private_data = NULL;
 	kfree(chip);
 	
-	dev_set_drvdata(dev, NULL); 
+	platform_set_drvdata(pdev, NULL); 
 	
 	return 0;
 	
 }
 
-static struct device_driver omap_alsa_driver = {
-	.name =		"omap_mcbsp",
-	.bus =		&platform_bus_type,
+static struct platform_driver omap_alsa_driver = {
 	.probe =	snd_omap_aic23_probe,
 	.remove =	snd_omap_aic23_remove,
 	.suspend =	omap_aic23_suspend, 
 	.resume =	omap_aic23_resume, 
+	.driver = {
+		.name =	"omap_mcbsp",
+	},
 };
 
 static int __init omap_aic23_init(void)
@@ -888,7 +889,7 @@ static int __init omap_aic23_init(void)
 	int err;
 	ADEBUG();
 
-	err = driver_register(&omap_alsa_driver);
+	err = platform_driver_register(&omap_alsa_driver);
 
 	return err;
 }
@@ -897,7 +898,7 @@ static void __exit omap_aic23_exit(void)
 {
 	ADEBUG();
 	
-	driver_unregister(&omap_alsa_driver);
+	platform_driver_unregister(&omap_alsa_driver);
 }
 
 module_init(omap_aic23_init);
---
0.99.9.GIT

--0-1011094732-1133434177=:37214
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--0-1011094732-1133434177=:37214--
