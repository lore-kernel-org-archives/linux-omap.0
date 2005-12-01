From: Komal Shah <komal_shah802003@yahoo.com>
Subject: [PATCH]OSS AUDIO: Use struct platform driver and compilation fix
Date: Thu, 1 Dec 2005 02:49:55 -0800 (PST)
Message-ID: <20051201104956.74752.qmail@web32904.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0-894926767-1133434195=:74733"
Content-Transfer-Encoding: 8bit
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

--0-894926767-1133434195=:74733
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Id: 
Content-Disposition: inline

Tony,

Attached patch uses struct platform_driver and 
used __SEMAPHORE_INIT(name,count) instead of DECLARE_MUTEX(), which is
a non standard way.

---Komal Shah
http://komalshah.blogspot.com/


		
__________________________________ 
Start your day with Yahoo! - Make it your home page! 
http://www.yahoo.com/r/hs
--0-894926767-1133434195=:74733
Content-Type: text/plain;
	name="0007-oss-omap-audio-Use-struct-platform_driver-and-compilation-fix.txt"
Content-Description: pat2084417372
Content-Disposition: inline;
	filename="0007-oss-omap-audio-Use-struct-platform_driver-and-compilation-fix.txt"

Subject: [PATCH 7/10] oss/omap-audio: Use struct platform_driver and compilation fix.
Used __SEMAPHORE_INIT(name,count) instead of DECLARE_MUTEX().
Signed-off-by: Komal Shah <komal_shah802003@yahoo.com>

---

 sound/oss/omap-audio-aic23.c   |    2 +-
 sound/oss/omap-audio-tsc2101.c |    2 +-
 sound/oss/omap-audio.c         |   45 ++++++++++++++++++----------------------
 3 files changed, 22 insertions(+), 27 deletions(-)

applies-to: f405eb795bff80868491c667f8cf382c61f8a2be
7d7ae01634efe27fc1fba3a8b4f0064f2146837f
diff --git a/sound/oss/omap-audio-aic23.c b/sound/oss/omap-audio-aic23.c
index d58c6f5..9e3f3b6 100644
--- a/sound/oss/omap-audio-aic23.c
+++ b/sound/oss/omap-audio-aic23.c
@@ -224,7 +224,7 @@ static audio_state_t aic23_state = {
         .hw_remove      =  __exit_p(omap_aic23_remove),
         .hw_suspend     = omap_aic23_suspend,
         .hw_resume      = omap_aic23_resume,
-        .sem            = __MUTEX_INITIALIZER(aic23_state.sem),
+        .sem            = __SEMAPHORE_INIT(aic23_state.sem, 1),
 };
 
 /* This will be defined in the audio.h */
diff --git a/sound/oss/omap-audio-tsc2101.c b/sound/oss/omap-audio-tsc2101.c
index 320e377..c5fdc6c 100644
--- a/sound/oss/omap-audio-tsc2101.c
+++ b/sound/oss/omap-audio-tsc2101.c
@@ -311,7 +311,7 @@ static audio_state_t tsc2101_state = {
 	.hw_remove      = omap_tsc2101_remove,
 	.hw_suspend     = omap_tsc2101_suspend,
 	.hw_resume      = omap_tsc2101_resume,
-	.sem            = __MUTEX_INITIALIZER(tsc2101_state.sem),
+	.sem		= __SEMAPHORE_INIT(tsc2101_state.sem, 1),
 };
 
 /* This will be defined in the Audio.h */
diff --git a/sound/oss/omap-audio.c b/sound/oss/omap-audio.c
index afcf98d..523dffd 100644
--- a/sound/oss/omap-audio.c
+++ b/sound/oss/omap-audio.c
@@ -44,7 +44,7 @@
 #include <linux/soundcard.h>
 #include <linux/sysrq.h>
 #include <linux/delay.h>
-#include <linux/device.h>
+#include <linux/platform_device.h>
 #include <linux/completion.h>
 
 #include <asm/uaccess.h>
@@ -106,15 +106,15 @@ static int audio_open(struct inode *inod
 
 static int audio_release(struct inode *inode, struct file *file);
 
-static int audio_probe(struct device *dev);
+static int audio_probe(struct platform_device *pdev);
 
-static int audio_remove(struct device *dev);
+static int audio_remove(struct platform_device *pdev);
 
-static void audio_shutdown(struct device *dev);
+static void audio_shutdown(struct platform_device *pdev);
 
-static int audio_suspend(struct device *dev, pm_message_t mesg, u32 level);
+static int audio_suspend(struct platform_device *pdev, pm_message_t mesg);
 
-static int audio_resume(struct device *dev, u32 level);
+static int audio_resume(struct platform_device *pdev);
 
 static void audio_free(struct device *dev);
 
@@ -142,14 +142,15 @@ static struct file_operations omap_audio
 };
 
 /* Driver information */
-static struct device_driver omap_audio_driver = {
-	.name		= OMAP_AUDIO_NAME,
-	.bus		= &platform_bus_type,
+static struct platform_driver omap_audio_driver = {
 	.probe		= audio_probe,
 	.remove		= audio_remove,
 	.suspend	= audio_suspend,
-	.resume		= audio_resume,
 	.shutdown	= audio_shutdown,
+	.resume		= audio_resume,
+	.driver		= {
+		.name	= OMAP_AUDIO_NAME,
+	},
 };
 
 /* Device Information */
@@ -283,7 +284,7 @@ static void audio_free(struct device *de
  * WARNING!!!!  : It is expected that the codec would have registered with us by now
  *
  *********************************************************************************/
-static int audio_probe(struct device *dev)
+static int audio_probe(struct platform_device *pdev)
 {
 	int ret;
 	FN_IN;
@@ -301,7 +302,7 @@ static int audio_probe(struct device *de
  * audio_remove() Function to handle removal operations
  *
  *********************************************************************************/
-static int audio_remove(struct device *dev)
+static int audio_remove(struct platform_device *pdev)
 {
 	FN_IN;
 	if (audio_state.hw_remove) {
@@ -316,7 +317,7 @@ static int audio_remove(struct device *d
  * audio_shutdown(): Function to handle shutdown operations
  *
  *********************************************************************************/
-static void audio_shutdown(struct device *dev)
+static void audio_shutdown(struct platform_device *pdev)
 {
 	FN_IN;
 	if (audio_state.hw_cleanup) {
@@ -331,16 +332,13 @@ static void audio_shutdown(struct device
  * audio_suspend(): Function to handle suspend operations 
  *
  *********************************************************************************/
-static int audio_suspend(struct device *dev, pm_message_t mesg, u32 level)
+static int audio_suspend(struct platform_device *pdev, pm_message_t mesg)
 {
 	int ret = 0;
 
 #ifdef CONFIG_PM
-	void *data = dev->driver_data;
+	void *data = pdev->dev.driver_data;
 	FN_IN;
-	if (level != SUSPEND_POWER_DOWN) {
-		return 0;
-	}
 	if (audio_state.hw_suspend) {
 		ret = audio_ldm_suspend(data);
 		if (ret == 0)
@@ -362,16 +360,13 @@ static int audio_suspend(struct device *
  * audio_resume(): Function to handle resume operations
  *
  *********************************************************************************/
-static int audio_resume(struct device *dev, u32 level)
+static int audio_resume(struct platform_device *dev)
 {
 	int ret = 0;
 
 #ifdef	CONFIG_PM
-	void *data = dev->driver_data;
+	void *data = pdev->dev.driver_data;
 	FN_IN;
-	if (level != RESUME_POWER_ON) {
-		return 0;
-	}
 	if (audio_state.hw_resume) {
 		ret = audio_ldm_resume(data);
 		if (ret == 0)
@@ -452,7 +447,7 @@ int audio_register_codec(audio_state_t *
 		goto register_out;
 	}
 
-	ret = driver_register(&omap_audio_driver);
+	ret = platform_driver_register(&omap_audio_driver);
 	if (ret != 0) {
 		printk(KERN_ERR "Device Register failed =%d\n", ret);
 		ret = -ENODEV;
@@ -487,7 +482,7 @@ int audio_unregister_codec(audio_state_t
 		return -EPERM;
 	}
 
-	driver_unregister(&omap_audio_driver);
+	platform_driver_unregister(&omap_audio_driver);
 	platform_device_unregister(&omap_audio_device);
 
 	memset(&audio_state, 0, sizeof(audio_state_t));
---
0.99.9.GIT

--0-894926767-1133434195=:74733
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--0-894926767-1133434195=:74733--
