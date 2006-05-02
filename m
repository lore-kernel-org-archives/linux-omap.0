From: lamikr <lamikr@cc.jyu.fi>
Subject: [PATCH 1/3] aic23 omap alsa driver method reference fix.
Date: Tue, 02 May 2006 23:39:17 +0300
Message-ID: <4457C375.80508@cc.jyu.fi>
Reply-To: lamikr@cc.jyu.fi
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
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
To: OMAP-Linux <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Fix the undefined reference from aic23 omap alsa driver to in
tlv320aic23.c driver's aic23_write_value method . In addition force the
tlv320aic23 i2c driver and it dependencies always to be selected when
the aic23 omap alsa sound driver is selected.

Signed-off-by: Mika Laitio <lamikr@cc.jyu.fi>


---

 sound/arm/Kconfig                |    2 ++
 sound/arm/omap/omap-alsa-aic23.c |    4 ++--
 2 files changed, 4 insertions(+), 2 deletions(-)

3f247c941cb140eb6e530cb62bf93ab61bfd4136
diff --git a/sound/arm/Kconfig b/sound/arm/Kconfig
index cccdf23..742bf8a 100644
--- a/sound/arm/Kconfig
+++ b/sound/arm/Kconfig
@@ -37,6 +37,8 @@ config SND_OMAP_AIC23
     tristate "OMAP AIC23 alsa driver (osk5912)"
     depends on ARCH_OMAP && SND
     select SND_PCM
+    select I2C
+    select I2C_OMAP
     select SENSORS_TLV320AIC23
     help
       Say Y here if you have a OSK platform board
diff --git a/sound/arm/omap/omap-alsa-aic23.c
b/sound/arm/omap/omap-alsa-aic23.c
index f490616..18b7395 100644
--- a/sound/arm/omap/omap-alsa-aic23.c
+++ b/sound/arm/omap/omap-alsa-aic23.c
@@ -113,12 +113,12 @@ static snd_pcm_hardware_t aic23_snd_omap
  * codec dependent code.
  */
 
-extern int tlv320aic23_write_value(u8 reg, u16 value);
+extern int aic23_write_value(u8 reg, u16 value);
 
 /* TLV320AIC23 is a write only device */
 void audio_aic23_write(u8 address, u16 data)
 {
-    tlv320aic23_write_value(address, data);
+    aic23_write_value(address, data);
 }
 EXPORT_SYMBOL_GPL(audio_aic23_write);
 
-- 
1.2.2
