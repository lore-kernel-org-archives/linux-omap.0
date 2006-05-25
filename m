From: lamikr <lamikr@cc.jyu.fi>
Subject: [PATCH 1/3] aic23: Kconfig fixes for alsa and oss drivers.
Date: Thu, 25 May 2006 23:52:59 +0300
Message-ID: <4476192B.5070703@cc.jyu.fi>
Reply-To: lamikr@cc.jyu.fi
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------040801000908080605030804"
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

This is a multi-part message in MIME format.
--------------040801000908080605030804
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Kconfig fixes to prevent unselecting I2C and I2C-omap drivers is aic23
sound driver is selected.

Signed-off-by: Mika Laitio <lamikr@cc.jyu.fi>

--------------040801000908080605030804
Content-Type: text/plain;
 name="0001-aic23-Kconfig-fixes.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="0001-aic23-Kconfig-fixes.txt"

>From nobody Mon Sep 17 00:00:00 2001
From: Mika Laitio <lamikr@cc.jyu.fi>
Date: Thu May 25 22:46:18 2006 +0300
Subject: [PATCH 1/3] aic23: Kconfig fixes for alsa and oss drivers. I2C and I2C-OMAP must be build if aic23 driver is build.

Signed-off-by: Mika Laitio <lamikr@cc.jyu.fi>


---

 sound/arm/Kconfig |    2 ++
 sound/oss/Kconfig |    2 ++
 2 files changed, 4 insertions(+), 0 deletions(-)

fafc1b62f86a4e85df544d38427a057e5304b6ea
diff --git a/sound/arm/Kconfig b/sound/arm/Kconfig
index cccdf23..fdf75e1 100644
--- a/sound/arm/Kconfig
+++ b/sound/arm/Kconfig
@@ -37,6 +37,8 @@ config SND_OMAP_AIC23
 	tristate "OMAP AIC23 alsa driver (osk5912)"
 	depends on ARCH_OMAP && SND
 	select SND_PCM
+	select I2C
+	select I2C_OMAP if ARCH_OMAP
 	select SENSORS_TLV320AIC23
 	help
 	  Say Y here if you have a OSK platform board
diff --git a/sound/oss/Kconfig b/sound/oss/Kconfig
index 146cebf..3c2c587 100644
--- a/sound/oss/Kconfig
+++ b/sound/oss/Kconfig
@@ -29,6 +29,8 @@ config SOUND_OMAP_TSC2101
 config SOUND_OMAP_AIC23
 	tristate "AIC23 Stereo Codec"
 	depends on SOUND_OMAP && ( MACH_OMAP_INNOVATOR || MACH_OMAP_OSK )
+	select I2C
+	select I2C_OMAP if ARCH_OMAP
 	select SENSORS_TLV320AIC23 if ARCH_OMAP
 	---help---
 	  AIC23 Audio Codec Driver for OMAP will be enabled.
-- 
1.2.2


--------------040801000908080605030804
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------040801000908080605030804--
