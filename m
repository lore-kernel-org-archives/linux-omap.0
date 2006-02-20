From: "Daniel Petrini" <d.pensator@gmail.com>
Subject: [PATCH] Alsa modularisations and support for tsc2101 3/7
Date: Mon, 20 Feb 2006 13:50:35 -0400
Message-ID: <9268368b0602200950r3c0aa443kdd3b91cd42c05230@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="----=_Part_178_9882741.1140457835143"
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
To: OMAP-Linux <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

------=_Part_178_9882741.1140457835143
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

ALSA Omap Patch

This patch makes (small) necessary modifications for aic23 mixer and alsa-d=
ma
in order to work with the new modularisation

signed-off by Daniel Petrini <d.pensator@gmail.com>
signed-off by Mika Laitio <lamikr@cc.jyu.fi>


Daniel Petrini
--
INdT - Manaus - Brazil

------=_Part_178_9882741.1140457835143
Content-Type: text/x-patch; name=alsa3-20060214.patch; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Attachment-Id: f_ejx2ls39
Content-Disposition: attachment; filename="alsa3-20060214.patch"

ALSA Omap Patch

This patch makes (small) necessary modifications for aic23 mixer and alsa-dma
in order to work with the new modularisation

signed-off by Daniel Petrini <d.pensator@gmail.com>
signed-off by Mika Laitio <lamikr@cc.jyu.fi>

Index: linux-omap-2.6.git-q/sound/arm/omap-alsa-mixer.c
===================================================================
--- linux-omap-2.6.git-q.orig/sound/arm/omap-alsa-mixer.c	2006-02-16 08:30:07.000000000 -0400
+++ linux-omap-2.6.git-q/sound/arm/omap-alsa-mixer.c	2006-02-16 08:38:18.000000000 -0400
@@ -1,5 +1,5 @@
 /*
- * sound/arm/omap-alsa-mixer.c
+ * sound/arm/omap/omap-alsa-mixer.c
  * 
  * Alsa Driver Mixer for generic codecs for omap boards
  *
@@ -39,20 +39,10 @@
 
 #include <linux/config.h>
 #include <sound/driver.h>
-#include <linux/module.h>
-#include <linux/device.h>
-#include <linux/init.h>
-#include <linux/errno.h>
-#include <linux/ioctl.h>
-#include <linux/delay.h>
-#include <linux/slab.h>
-
-#include <asm/hardware.h>
-#include <asm/mach-types.h>
-#include <asm/arch/dma.h>
 #include <asm/arch/aic23.h>
 
-#include "omap-aic23.h"
+#include <asm/arch/omap-alsa.h>
+#include <../arch/arm/mach-omap1/omap-alsa-aic23.h>
 #include <sound/initval.h>
 #include <sound/control.h>
 
@@ -411,31 +401,6 @@ static snd_kcontrol_new_t snd_omap_contr
 	OMAP_MUX("Capture Source", ANALOG_AUDIO_CONTROL_ADDR, AAC_INDEX, INSEL_MIC),
 };
 
-void snd_omap_init_mixer(void)
-{
-	u16 vol_reg;
-
-	/* Line's default values */
-	omap_regs[LINE_INDEX].l_reg = DEFAULT_INPUT_VOLUME & INPUT_VOLUME_MASK;
-	omap_regs[LINE_INDEX].r_reg = DEFAULT_INPUT_VOLUME & INPUT_VOLUME_MASK;
-	omap_regs[LINE_INDEX].sw = 0;
-	SND_OMAP_WRITE(LEFT_LINE_VOLUME_ADDR, DEFAULT_INPUT_VOLUME & INPUT_VOLUME_MASK);
-	SND_OMAP_WRITE(RIGHT_LINE_VOLUME_ADDR, DEFAULT_INPUT_VOLUME & INPUT_VOLUME_MASK);
-	
-	/* Analog Audio Control's default values */
-	omap_regs[AAC_INDEX].l_reg = DEFAULT_ANALOG_AUDIO_CONTROL;
-	
-	/* Headphone's default values */
-	vol_reg = LZC_ON;
-	vol_reg &= ~OUTPUT_VOLUME_MASK;
-	vol_reg |= DEFAULT_OUTPUT_VOLUME;
-	omap_regs[PCM_INDEX].l_reg = DEFAULT_OUTPUT_VOLUME;
-	omap_regs[PCM_INDEX].r_reg = DEFAULT_OUTPUT_VOLUME;
-	omap_regs[PCM_INDEX].sw = 1;
-	SND_OMAP_WRITE(LEFT_CHANNEL_VOLUME_ADDR, vol_reg);
-	SND_OMAP_WRITE(RIGHT_CHANNEL_VOLUME_ADDR, vol_reg);
-}
-
 #ifdef CONFIG_PM
 
 void snd_omap_suspend_mixer(void)
@@ -474,7 +439,32 @@ void snd_omap_resume_mixer(void)
 }
 #endif
 
-int snd_omap_mixer(struct snd_card_omap_aic23 *chip)
+void snd_omap_init_mixer(void)
+{
+	u16 vol_reg;
+
+	/* Line's default values */
+	omap_regs[LINE_INDEX].l_reg = DEFAULT_INPUT_VOLUME & INPUT_VOLUME_MASK;
+	omap_regs[LINE_INDEX].r_reg = DEFAULT_INPUT_VOLUME & INPUT_VOLUME_MASK;
+	omap_regs[LINE_INDEX].sw = 0;
+	SND_OMAP_WRITE(LEFT_LINE_VOLUME_ADDR, DEFAULT_INPUT_VOLUME & INPUT_VOLUME_MASK);
+	SND_OMAP_WRITE(RIGHT_LINE_VOLUME_ADDR, DEFAULT_INPUT_VOLUME & INPUT_VOLUME_MASK);
+	
+	/* Analog Audio Control's default values */
+	omap_regs[AAC_INDEX].l_reg = DEFAULT_ANALOG_AUDIO_CONTROL;
+	
+	/* Headphone's default values */
+	vol_reg = LZC_ON;
+	vol_reg &= ~OUTPUT_VOLUME_MASK;
+	vol_reg |= DEFAULT_OUTPUT_VOLUME;
+	omap_regs[PCM_INDEX].l_reg = DEFAULT_OUTPUT_VOLUME;
+	omap_regs[PCM_INDEX].r_reg = DEFAULT_OUTPUT_VOLUME;
+	omap_regs[PCM_INDEX].sw = 1;
+	SND_OMAP_WRITE(LEFT_CHANNEL_VOLUME_ADDR, vol_reg);
+	SND_OMAP_WRITE(RIGHT_CHANNEL_VOLUME_ADDR, vol_reg);
+}
+
+int snd_omap_mixer(struct snd_card_omap_codec *chip)
 {
 	snd_card_t *card;
 	unsigned int idx;
@@ -493,4 +483,3 @@ int snd_omap_mixer(struct snd_card_omap_
 
 	return 0;
 }
-
Index: linux-omap-2.6.git-q/sound/arm/omap-alsa-dma.h
===================================================================
--- linux-omap-2.6.git-q.orig/sound/arm/omap-alsa-dma.h	2006-02-16 08:30:07.000000000 -0400
+++ linux-omap-2.6.git-q/sound/arm/omap-alsa-dma.h	2006-02-16 08:38:03.000000000 -0400
@@ -30,7 +30,7 @@
 
 /************************** INCLUDES *************************************/
 
-#include "omap-aic23.h"
+#include <asm/arch/omap-alsa.h>
 
 /************************** GLOBAL MACROS *************************************/
 
Index: linux-omap-2.6.git-q/sound/arm/omap-alsa-dma.c
===================================================================
--- linux-omap-2.6.git-q.orig/sound/arm/omap-alsa-dma.c	2006-02-16 08:30:07.000000000 -0400
+++ linux-omap-2.6.git-q/sound/arm/omap-alsa-dma.c	2006-02-16 08:38:03.000000000 -0400
@@ -66,20 +66,20 @@
 
 #include <asm/arch/mcbsp.h>
 
-#include "omap-aic23.h"
+#include <asm/arch/omap-alsa.h>
 
 #undef DEBUG
 //#define DEBUG
-#ifdef DEBUG
-#define DPRINTK(ARGS...)  printk(KERN_INFO "<%s>: ",__FUNCTION__);printk(ARGS)
-#define FN_IN printk(KERN_INFO "[%s]: start\n", __FUNCTION__)
-#define FN_OUT(n) printk(KERN_INFO "[%s]: end(%u)\n",__FUNCTION__, n)
-#else
-
-#define DPRINTK( x... )
-#define FN_IN
-#define FN_OUT(x)
-#endif
+//#ifdef DEBUG
+//#define DPRINTK(ARGS...)  printk(KERN_INFO "<%s>: ",__FUNCTION__);printk(ARGS)
+//#define FN_IN printk(KERN_INFO "[%s]: start\n", __FUNCTION__)
+//#define FN_OUT(n) printk(KERN_INFO "[%s]: end(%u)\n",__FUNCTION__, n)
+//#else
+
+//#define DPRINTK( x... )
+//#define FN_IN
+//#define FN_OUT(x)
+//#endif
 
 #define ERR(ARGS...) printk(KERN_ERR "{%s}-ERROR: ", __FUNCTION__);printk(ARGS);
 



------=_Part_178_9882741.1140457835143
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


------=_Part_178_9882741.1140457835143--
