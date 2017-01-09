From: Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Subject: [PATCH 2/4] usb: musb: Add support of cppi41 dma controller for da8xx to Kconfig
Date: Mon,  9 Jan 2017 17:39:00 +0100
Message-ID: <20170109163902.5268-3-abailon@baylibre.com>
References: <20170109163902.5268-1-abailon@baylibre.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170109163902.5268-1-abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: b-liu-l0cyMroinI0@public.gmane.org
Cc: vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, ptitiano-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, david-nq/r/kbU++upp/zk7JDF2g@public.gmane.org, Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Currently, cppi41 driver can only be built for omap platform.
As da8xx platform has a cppi41 dma controller, update the Kconfig
to also support the da8xx.

Signed-off-by: Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
---
 drivers/dma/Kconfig      | 2 +-
 drivers/usb/musb/Kconfig | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index 0d6a96e..8fe9de7 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -515,7 +515,7 @@ config TIMB_DMA
 
 config TI_CPPI41
 	tristate "AM33xx CPPI41 DMA support"
-	depends on ARCH_OMAP
+	depends on (ARCH_OMAP || ARCH_DAVINCI_DA8XX)
 	select DMA_ENGINE
 	help
 	  The Communications Port Programming Interface (CPPI) 4.1 DMA engine
diff --git a/drivers/usb/musb/Kconfig b/drivers/usb/musb/Kconfig
index 72a2a50..3018518 100644
--- a/drivers/usb/musb/Kconfig
+++ b/drivers/usb/musb/Kconfig
@@ -160,8 +160,8 @@ config USB_TI_CPPI_DMA
 	  Enable DMA transfers when TI CPPI DMA is available.
 
 config USB_TI_CPPI41_DMA
-	bool 'TI CPPI 4.1 (AM335x)'
-	depends on ARCH_OMAP && DMADEVICES
+	bool 'TI CPPI 4.1 (AM335x or DA8xx)'
+	depends on (ARCH_OMAP || ARCH_DAVINCI_DA8XX) && DMADEVICES
 	select TI_CPPI41
 
 config USB_TUSB_OMAP_DMA
-- 
2.10.2

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
