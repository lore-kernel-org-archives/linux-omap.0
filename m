From: Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Subject: [PATCH 0/4] usb: musb: da8xx: Add DMA support
Date: Mon,  9 Jan 2017 17:38:58 +0100
Message-ID: <20170109163902.5268-1-abailon@baylibre.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: b-liu-l0cyMroinI0@public.gmane.org
Cc: vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, ptitiano-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, david-nq/r/kbU++upp/zk7JDF2g@public.gmane.org, Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

This series update musb driver to add DMA support to da8xx.
To work correctly, the follwings patches are required:
"dmaengine: cppi41: Add dma support to da8xx",
"ARM: davinci: da850: Share the usb20 clock",
"ARM: dts: da850: Enable cppi41 dma",
"dmaengine: cppi41: PM runtime fixes"

I haven't changed yet the davinci_all_defconfig to enable the DMA mode
by default. I'm planning to do it once all the warnings happening during
the teardwon will be fixed.

The series has been tested on beaglebone black and omapl138-lcdk
in both host mode (pendrive, headset, wifi, webcam) and device mode
(MSC, CDC).
Expect few warnings on omapl138-lcdk, I haven't noticed any issues.

Alexandre Bailon (4):
  usb: musb: da8xx: Use the right dma controller
  usb: musb: Add support of cppi41 dma controller for da8xx to Kconfig
  usb: musb: Use shared irq
  usb: musb: musb_cppi41: Workaround dma stall issue during teardown

 drivers/dma/Kconfig            | 2 +-
 drivers/usb/musb/Kconfig       | 4 ++--
 drivers/usb/musb/da8xx.c       | 8 ++++----
 drivers/usb/musb/musb_core.c   | 2 +-
 drivers/usb/musb/musb_core.h   | 1 +
 drivers/usb/musb/musb_cppi41.c | 4 ++++
 6 files changed, 13 insertions(+), 8 deletions(-)

-- 
2.10.2

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
