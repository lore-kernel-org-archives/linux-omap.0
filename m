From: Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Subject: [PATCH v3 0/4]  dmaengine: cppi41: Make CPPI 4.1 driver more generic
Date: Thu, 19 Jan 2017 11:37:01 +0100
Message-ID: <20170119103705.13532-1-abailon@baylibre.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
Cc: dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, ptitiano-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, b-liu-l0cyMroinI0@public.gmane.org, sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org, grygorii.strashko-l0cyMroinI0@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Most of the patch of this series were part of
"[PATCH 00/11] dmaengine: cppi41: Add dma support to da8xx"

This series intend to make the CPPI 4.1 more generic in order to
add a new platform (the DA8xx).
To achieve that, all the IRQ code present in CPPI 4.1 driver has been moved
to MUSB DSPS driver.
Other changes mainly update the glue layer and platform code to make the
whole driver more generic.

This series is to apply on top of 
"[PATCH v3 0/3] usb: musb: cppi41: Add a way to manage DMA irq".

Changes in v3:
- To prevent build error report from kbuild test robot, move the first
  patch of v2 to another patchset.
- Make CPPI 4.1 driver compatible with old and new binddings.
- Remove the patch updating the am33xx-usb binddings.
- Remove useless changes in patch 4
- Remove a patch that was fixing PM runtime issue that was happenning
  during a teardown. Tony Lindgren's patches fix the issue.

Alexandre Bailon (4):
  dmaengine: cppi41: Remove usbss_mem
  dmaengine: cppi41: rename platform variables
  dmaengine: cppi41: Move some constants to glue layer
  dmaengine: cppi41: init_sched(): Get number of channels from DT

 drivers/dma/cppi41.c | 81 +++++++++++++++++++++++++++++++---------------------
 1 file changed, 48 insertions(+), 33 deletions(-)

-- 
2.10.2

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
