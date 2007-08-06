From: Kevin Hilman <khilman@mvista.com>
Subject: [PATCH omap-fixes] ARM: OMAP: cleanup: remove OMAP_MCBSP Kconfig
	warnings
Date: Mon, 06 Aug 2007 08:13:12 -0700
Message-ID: <20070806151312.217287034@mvista.com>
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

When the OMAP patches are applied and the kernel is built for a
non-ARM target, there are a handful of Kconfig warnings due to the use
of OMAP_MCBSP in arch-independent Kconfig files.  

This patch simply removes the 'select OMAP_MCBSP' in these
arch-independent files since it is already 'default y' in
arch/arm/plat-omap/Kconfig

Signed-off-by: Kevin Hilman <khilman@mvista.com>

---
 sound/arm/Kconfig |    3 ---
 1 file changed, 3 deletions(-)

Index: dev/sound/arm/Kconfig
===================================================================
--- dev.orig/sound/arm/Kconfig
+++ dev/sound/arm/Kconfig
@@ -39,7 +39,6 @@ config SND_OMAP_AIC23
 	select SND_PCM
 	select I2C
 	select I2C_OMAP if ARCH_OMAP
-	select OMAP_MCBSP
 	select SENSORS_TLV320AIC23
 	help
 	  Say Y here if you have a OSK platform board
@@ -53,7 +52,6 @@ config SND_OMAP_TSC2101
  	depends on ARCH_OMAP && SND
  	select SND_PCM
          select SPI_TSC2101
-	 select OMAP_MCBSP
  	help
  	  Say Y here if you have a OMAP platform board
  	  and want to use its TSC2101 audio chip. Driver has
@@ -66,7 +64,6 @@ config SND_SX1
  	tristate "Siemens SX1 Egold alsa driver"
  	depends on ARCH_OMAP && SND
  	select SND_PCM
-	select OMAP_MCBSP
  	help
  	  Say Y here if you have a OMAP310 based Siemens SX1.
 
--
