From: Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Subject: [PATCH v2 0/7] dmaengine: cppi41: Make CPPI 4.1 driver more generic
Date: Tue, 17 Jan 2017 14:45:33 +0100
Message-ID: <20170117134540.9988-1-abailon@baylibre.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, b-liu-l0cyMroinI0@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, ptitiano-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Most of the patch of this series were part of
"[PATCH 00/11] dmaengine: cppi41: Add dma support to da8xx"

This series intend to make the CPPI 4.1 more generic in order to
add a new platform (the DA8xx).
To achieve that, all the IRQ code present in CPPI 4.1 driver has been moved
to MUSB DSPS driver.
Other changes mainly update the glue layer and platform code to make the
whole driver more generic.

This series needs the patchset
"[PATCH v2 0/2] usb: musb: cppi41: Add a way to manage DMA irq" to build.

Alexandre Bailon (7):
  usb: musb: dsps: Manage CPPI 4.1 DMA interrupt in dsps
  usb: usb: dsps: update device tree bindings
  dmaengine: cppi41: Remove usbss_mem
  dmaengine: cppi41: rename platform variables
  dmaengine: cppi41: Move some constants to glue layer
  dmaengine: cppi41: init_sched(): Get number of channels from DT
  dmaengine: cppi41: Fix a race between PM runtime and channel abort

 .../devicetree/bindings/usb/am33xx-usb.txt         |   9 +-
 drivers/dma/cppi41.c                               | 120 +++++++++++----------
 drivers/usb/musb/musb_dsps.c                       |  73 ++++++++++++-
 3 files changed, 138 insertions(+), 64 deletions(-)

-- 
2.10.2

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
