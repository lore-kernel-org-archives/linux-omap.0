From: Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Subject: [PATCH v2 0/3] dmaengine: cppi41: Add dma support to da8xx
Date: Tue, 17 Jan 2017 15:20:13 +0100
Message-ID: <20170117142016.11163-1-abailon@baylibre.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, ptitiano-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, b-liu-l0cyMroinI0@public.gmane.org, sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

This series add support of DA8xx to CPPI 4.1 driver.
As the CPPI 4.1 is now generic, we only had to add the glue for DA8xx.

This serie should applied on top of 
"[PATCH v2 0/7] dmaengine: cppi41: Make CPPI 4.1 driver more generic".

Changes in v2:
- most of patches of v1 has been moved to the series
  "[PATCH v2 0/7] dmaengine: cppi41: Make CPPI 4.1 driver more generic".
- some patches of v1 has been removed because they were no required
  anymore because CPPI 4.1 driver has been made more generic.
- In v1, the driver were managing the clock for DA8xx paltform.
  This is not needed as CPPI 4.1 will be a child of MUSB DA8xx glue,
  we can use PM runtime and let the DA8xx glue driver manage it.

Alexandre Bailon (3):
  dt/bindings: da8xx-usb: Add binding for the CPPI 4.1 DMA controller
  dmaengine: cppi41: Implement the glue for DA8xx
  dmaengine: cppi41: Fix teardown warnings

 .../devicetree/bindings/usb/da8xx-usb.txt          | 42 ++++++++++++++++++++++
 drivers/dma/cppi41.c                               | 28 +++++++++++++--
 2 files changed, 68 insertions(+), 2 deletions(-)

-- 
2.10.2

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
