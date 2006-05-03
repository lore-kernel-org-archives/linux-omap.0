From: Dirk Behme <dirk.behme@googlemail.com>
Subject: [PATCH] ARM: OMAP: Fix aic23 audio drivers
Date: Wed, 03 May 2006 20:41:59 +0200
Message-ID: <4458F977.2060708@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------030408000409020607070908"
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

This is a multi-part message in MIME format.
--------------030408000409020607070908
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


ARM: OMAP: Fix OMAP aic23 audio drivers because function
name tlv320aic23_write_value() was switched to
aic23_write_value().

Signed-off-by: Dirk Behme <dirk.behme_at_gmail.com>

--------------030408000409020607070908
Content-Type: text/plain;
 name="tlv320_aic23_name_patch.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="tlv320_aic23_name_patch.txt"

--- ./sound/arm/omap/omap-alsa-aic23.c_orig	2006-05-03 20:12:02.000000000 +0200
+++ ./sound/arm/omap/omap-alsa-aic23.c	2006-05-03 20:30:01.000000000 +0200
@@ -113,12 +113,12 @@ static snd_pcm_hardware_t aic23_snd_omap
  * codec dependent code.
  */
 
-extern int tlv320aic23_write_value(u8 reg, u16 value);
+extern int aic23_write_value(u8 reg, u16 value);
 
 /* TLV320AIC23 is a write only device */
 void audio_aic23_write(u8 address, u16 data)
 {
-	tlv320aic23_write_value(address, data);
+	aic23_write_value(address, data);
 }
 EXPORT_SYMBOL_GPL(audio_aic23_write);
 
--- ./sound/oss/omap-audio-aic23.c_orig	2006-05-03 20:29:49.000000000 +0200
+++ ./sound/oss/omap-audio-aic23.c	2006-05-03 20:30:40.000000000 +0200
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


--------------030408000409020607070908
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------030408000409020607070908--
