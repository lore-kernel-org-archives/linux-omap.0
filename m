From: lamikr <lamikr@cc.jyu.fi>
Subject: [PATCH 2/3] aic23 omap oss driver method reference fix.
Date: Tue, 02 May 2006 23:39:39 +0300
Message-ID: <4457C38B.1080602@cc.jyu.fi>
Reply-To: lamikr@cc.jyu.fi
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
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
To: OMAP-Linux <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Fix the undefined reference from aic23 omap OSS driver to in
tlv320aic23.c driver's aic23_write_value method . In addition force the
tlv320aic23 i2c driver and it dependencies always to be selected when
the aic23 omap OSS sound driver is selected.

Signed-off-by: Mika Laitio <lamikr@cc.jyu.fi>


---

 sound/oss/Kconfig            |    2 ++
 sound/oss/omap-audio-aic23.c |    4 ++--
 2 files changed, 4 insertions(+), 2 deletions(-)

6702c21da8ccaab93332c4e8b2f0e52885164d6c
diff --git a/sound/oss/Kconfig b/sound/oss/Kconfig
index 88a648f..4f49cb9 100644
--- a/sound/oss/Kconfig
+++ b/sound/oss/Kconfig
@@ -29,6 +29,8 @@ config SOUND_OMAP_TSC2101
 config SOUND_OMAP_AIC23
     tristate "AIC23 Stereo Codec"
     depends on SOUND_OMAP && ( MACH_OMAP_INNOVATOR || MACH_OMAP_OSK )
+    select I2C
+    select I2C_OMAP if ARCH_OMAP
     select SENSORS_TLV320AIC23 if ARCH_OMAP
     ---help---
       AIC23 Audio Codec Driver for OMAP will be enabled.
diff --git a/sound/oss/omap-audio-aic23.c b/sound/oss/omap-audio-aic23.c
index 679edb0..1e41b1d 100644
--- a/sound/oss/omap-audio-aic23.c
+++ b/sound/oss/omap-audio-aic23.c
@@ -250,12 +250,12 @@ static audio_state_t aic23_state = {
 /* This will be defined in the audio.h */
 static struct file_operations *omap_audio_fops;
 
-extern int tlv320aic23_write_value(u8 reg, u16 value);
+extern int aic23_write_value(u8 reg, u16 value);
 
 /* TLV320AIC23 is a write only device */
 static __inline__ void audio_aic23_write(u8 address, u16 data)
 {
-        tlv320aic23_write_value(address, data);
+        aic23_write_value(address, data);
 }
 
 static int aic23_update(int flag, int val)
-- 
1.2.2
