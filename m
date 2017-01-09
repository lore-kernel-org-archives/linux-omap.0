From: Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Subject: [PATCH 00/11] dmaengine: cppi41: Add dma support to da8xx
Date: Mon,  9 Jan 2017 17:06:45 +0100
Message-ID: <20170109160656.3470-1-abailon@baylibre.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
Cc: dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, ptitiano-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, b-liu-l0cyMroinI0@public.gmane.org, Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

This series adds support of da8xx to cppi41 dma controller driver.
This update the cppi41 driver to make it more generic (was only supporting
the am335x), and implement the support for the da8xx.
Some other changes are required in platform and musb drivers to make the dma
work on da8xx (though, it should build correctly and should not cause
any issues).

The changes have been tested on the beaglebone black and omapl138-lcd.
I haven't noticed any regression on beaglebone black
(though I have noticed some performence issues since 4.9).

On on da8xx, I have sometime some warnings happening during a teardown.
I only got them while I was running some corner cases and I'm still trying
to fix them. 
Anyway, this warnings doesn't seem to cause any issues as usb keep working
after they happen.

I also got some issues related to pm runtime.
I tried to fix them with the series "dmaengine: cppi41: PM runtime fixes",
but I still get few warnings sometime (again, doesn't seem to cause any issue).

Alexandre Bailon (11):
  dmaengine: cppi41: rename platform variables
  dmaengine: cppi41: Split out the interrupt handler
  dmaengine: cppi41: Move some constants to glue layer
  dmaengine: cppi41: init_sched(): Get number of channels from DT
  dmaengine: cppi41: Add a way to test if the driver is running on
    am335x
  dmaengine: cppi41: Only configure am335x's registers on amm335x
    platform
  dt/bindings: da8xx-usb: Add binding for the cppi41 dma controller
  dmaengine: cppi41: Implement the glue for da8xx
  dmaengine: cppi41: Fix a race between PM runtime and channel abort
  dmaengine: cppi41: Fix da8xx interrupt issue
  dmaengine: cppi41: Fix teardown warnings

 .../devicetree/bindings/usb/da8xx-usb.txt          |  39 ++++
 drivers/dma/cppi41.c                               | 252 +++++++++++++++++----
 2 files changed, 247 insertions(+), 44 deletions(-)

-- 
2.10.2

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
