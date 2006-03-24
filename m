From: Komal Shah <komal_shah802003@yahoo.com>
Subject: [PATCH] OMAP: OSS: sem2mutex conversion
Date: Fri, 24 Mar 2006 05:46:08 -0800 (PST)
Message-ID: <20060324134608.77318.qmail@web32911.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0-464739785-1143207968=:76385"
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

--0-464739785-1143207968=:76385
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Id: 
Content-Disposition: inline

 
 

---Komal Shah
http://komalshah.blogspot.com/

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
--0-464739785-1143207968=:76385
Content-Type: text/plain; name="0008-OMAP-OSS-sem2mutex-conversion.txt"
Content-Description: 4198930708-0008-OMAP-OSS-sem2mutex-conversion.txt
Content-Disposition: inline; filename="0008-OMAP-OSS-sem2mutex-conversion.txt"

Subject: [PATCH] OMAP: OSS: sem2mutex conversion

Signed-off-by: Komal Shah <komal_shah802003@yahoo.com>

---

 sound/oss/omap-audio-tsc2101.c |    4 ++--
 sound/oss/omap-audio.c         |   12 ++++++------
 sound/oss/omap-audio.h         |    2 +-
 3 files changed, 9 insertions(+), 9 deletions(-)

62f9d1526185a03bcd0defb273d38927cd5ee7b4
diff --git a/sound/oss/omap-audio-tsc2101.c b/sound/oss/omap-audio-tsc2101.c
index 13dc7af..f8e6dac 100644
--- a/sound/oss/omap-audio-tsc2101.c
+++ b/sound/oss/omap-audio-tsc2101.c
@@ -33,8 +33,8 @@
 #include <linux/errno.h>
 #include <linux/sound.h>
 #include <linux/soundcard.h>
+#include <linux/mutex.h>
 
-#include <asm/semaphore.h>
 #include <asm/uaccess.h>
 #include <asm/hardware.h>
 #include <asm/arch/dma.h>
@@ -326,7 +326,7 @@ static audio_state_t tsc2101_state = {
 	.hw_remove      = omap_tsc2101_remove,
 	.hw_suspend     = omap_tsc2101_suspend,
 	.hw_resume      = omap_tsc2101_resume,
-	.sem		= __SEMAPHORE_INIT(tsc2101_state.sem, 1),
+	.mutex		= __MUTEX_INITIALIZER(tsc2101_state.mutex),
 };
 
 /* This will be defined in the Audio.h */
diff --git a/sound/oss/omap-audio.c b/sound/oss/omap-audio.c
index 3885700..cc1f14a 100644
--- a/sound/oss/omap-audio.c
+++ b/sound/oss/omap-audio.c
@@ -46,11 +46,11 @@
 #include <linux/delay.h>
 #include <linux/platform_device.h>
 #include <linux/completion.h>
+#include <linux/mutex.h>
 
 #include <asm/uaccess.h>
 #include <asm/io.h>
 #include <asm/hardware.h>
-#include <asm/semaphore.h>
 
 #include "omap-audio-dma-intfc.h"
 #include "omap-audio.h"
@@ -438,7 +438,7 @@ int audio_register_codec(audio_state_t *
 	}
 
 	memcpy(&audio_state, codec_state, sizeof(audio_state_t));
-	sema_init(&audio_state.sem, 1);
+	mutex_init(&audio_state.mutex);
 
 	ret = platform_device_register(&omap_audio_device);
 	if (ret != 0) {
@@ -1024,7 +1024,7 @@ static int audio_open(struct inode *inod
 		return -ESTALE;
 	}
 
-	down(&state->sem);
+	mutex_lock(&state->mutex);
 
 	/* access control */
 	err = -ENODEV;
@@ -1092,7 +1092,7 @@ static int audio_open(struct inode *inod
 	err = 0;
 
       out:
-	up(&state->sem);
+	mutex_unlock(&state->mutex);
 	if (err) {
 		module_put(state->owner);
 		module_put(THIS_MODULE);
@@ -1114,7 +1114,7 @@ static int audio_release(struct inode *i
 
 	FN_IN;
 
-	down(&state->sem);
+	mutex_lock(&state->mutex);
 
 	if (file->f_mode & FMODE_READ) {
 		audio_discard_buf(is);
@@ -1145,7 +1145,7 @@ static int audio_release(struct inode *i
 			state->hw_shutdown(state->data);
 	}
 
-	up(&state->sem);
+	mutex_unlock(&state->mutex);
 
 	module_put(state->owner);
 	module_put(THIS_MODULE);
diff --git a/sound/oss/omap-audio.h b/sound/oss/omap-audio.h
index 58eff31..c039dee 100644
--- a/sound/oss/omap-audio.h
+++ b/sound/oss/omap-audio.h
@@ -101,7 +101,7 @@ typedef struct {
 	int (*hw_suspend) (void);
 	int (*hw_resume) (void);
 	struct pm_dev *pm_dev;
-	struct semaphore sem;	/* to protect against races in attach() */
+	struct mutex mutex;	/* to protect against races in attach() */
 } audio_state_t;
 
 #ifdef AUDIO_PM
-- 
1.1.6

--0-464739785-1143207968=:76385
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--0-464739785-1143207968=:76385--
