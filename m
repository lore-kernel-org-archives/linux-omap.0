From: Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Subject: [PATCH v3 0/3] dmaengine: cppi41: Add dma support to da8xx
Date: Thu, 19 Jan 2017 12:13:31 +0100
Message-ID: <20170119111334.14718-1-abailon@baylibre.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
Cc: dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, ptitiano-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, b-liu-l0cyMroinI0@public.gmane.org, sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org, grygorii.strashko-l0cyMroinI0@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

This series add support of DA8xx to CPPI 4.1 driver.
As the CPPI 4.1 is now generic, we only had to add the glue for DA8xx.

This serie should applied on top of 
"[PATCH v3 0/4] dmaengine: cppi41: Make CPPI 4.1 driver more generic".

Changes in v3:
- Removed some useless property from DT bindings.
- Update kconfig in patch 2. Was prevously made in another patchset.

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
  dmaengine: cppi41: Add support of DA8xx to CPPI 4.1
  dmaengine: cppi41: Fix teardown warnings

 .../devicetree/bindings/usb/da8xx-usb.txt          | 39 ++++++++++++++++++++++
 drivers/dma/Kconfig                                |  6 ++--
 drivers/dma/cppi41.c                               | 28 ++++++++++++++--
 3 files changed, 68 insertions(+), 5 deletions(-)

-- 
2.10.2

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
