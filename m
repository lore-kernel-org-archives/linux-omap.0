From: Dirk Behme <dirk.behme@googlemail.com>
Subject: [PATCH] ARM: OMAP: Convert omap-alsa-sx1.c to new struct format
Date: Sat, 19 May 2007 16:51:52 +0200
Message-ID: <464F0F08.4080302@googlemail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------050505000905090808020607"
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
--------------050505000905090808020607
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


Convert omap-alsa-sx1.c to new struct format to make this file compile 
again.

Signed-off-by: Dirk Behme <dirk.behme@gmail.com>




--------------050505000905090808020607
Content-Type: text/plain;
 name="fix_omap_alsa_sx1.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fix_omap_alsa_sx1.txt"

Index: linux-osk/sound/arm/omap/omap-alsa-sx1.c
===================================================================
--- linux-osk.orig/sound/arm/omap/omap-alsa-sx1.c
+++ linux-osk/sound/arm/omap/omap-alsa-sx1.c
@@ -82,13 +82,13 @@ static unsigned int rates[] = {
 	 32000, 44100, 48000,
 };
 
-static snd_pcm_hw_constraint_list_t egold_hw_constraints_rates = {
+static struct snd_pcm_hw_constraint_list egold_hw_constraints_rates = {
 	.count	= ARRAY_SIZE(rates),
 	.list	= rates,
 	.mask	= 0,
 };
 
-static snd_pcm_hardware_t egold_snd_omap_alsa_playback = {
+static struct snd_pcm_hardware egold_snd_omap_alsa_playback = {
 	.info = (SNDRV_PCM_INFO_INTERLEAVED | SNDRV_PCM_INFO_BLOCK_TRANSFER |
 		 SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_MMAP_VALID),
 	.formats = (SNDRV_PCM_FMTBIT_S16_LE),
@@ -109,7 +109,7 @@ static snd_pcm_hardware_t egold_snd_omap
 	.fifo_size		= 0,
 };
 
-static snd_pcm_hardware_t egold_snd_omap_alsa_capture = {
+static struct snd_pcm_hardware egold_snd_omap_alsa_capture = {
 	.info = (SNDRV_PCM_INFO_INTERLEAVED | SNDRV_PCM_INFO_BLOCK_TRANSFER |
 		 SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_MMAP_VALID),
 	.formats = (SNDRV_PCM_FMTBIT_S16_LE),

--------------050505000905090808020607
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------050505000905090808020607--
