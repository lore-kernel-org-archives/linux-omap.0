From: Kevin Hilman <khilman@mvista.com>
Subject: [PATCH] ARM: OMAP: silence Kconfig warnings for non-ARM build
Date: Fri,  3 Aug 2007 15:00:53 -0700
Message-ID: <11861784532833-git-send-email-khilman@mvista.com>
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

Not sure if this is the right Kconfig magic, but when the OMAP patches
are applied and the kernel is built for a non-ARM target, there are
a handful of Kconfig warnings.  This patch cleans that up.

Signed-off-by: Kevin Hilman <khilman@mvista.com>
---
 sound/arm/Kconfig |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/sound/arm/Kconfig b/sound/arm/Kconfig
index 3646307..76f8072 100644
--- a/sound/arm/Kconfig
+++ b/sound/arm/Kconfig
@@ -33,6 +33,7 @@ config SND_PXA2XX_AC97
 	  Say Y or M if you want to support any AC97 codec attached to
 	  the PXA2xx AC97 interface.
 
+if ARCH_OMAP
 config SND_OMAP_AIC23
 	tristate "OMAP AIC23 alsa driver (osk5912)"
 	depends on ARCH_OMAP && SND
@@ -99,5 +100,6 @@ config SND_OMAP24XX_EAC
 
 	  To compile this driver as a module, choose M here: the module
 	  will be called snd-omap24xx-eac.
+endif
 
 endmenu
-- 
1.5.2
