From: Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Subject: [PATCH v3 0/3] usb: musb: cppi41: Add a way to manage DMA irq
Date: Thu, 19 Jan 2017 11:06:56 +0100
Message-ID: <20170119100659.11370-1-abailon@baylibre.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: b-liu-l0cyMroinI0@public.gmane.org
Cc: vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, ptitiano-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org, grygorii.strashko-l0cyMroinI0@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

This series was "dmaengine: cppi41: Make the driver more generic".
I have tried to separate as munch I could CPPI 4.1 MUSB driver changes.

Currently, the DMA interrupt is managed by the CPPI 4.1 driver.
The issue here is the CPPI 4.1 driver must access to MUSB glue registers
to manage its interrupt.
In order to move the interrupts management from CPPI 4.1 driver to MUSB
(and then make it more generic), update the MUSB CPPI 4.1 driver with
changes that will help to manage DMA interrupt from MUSB driver.

Changes in v3:
- Move a patch from another series to this one to avoid build error report
  from kbuild test robot
- Instead of adding and exporting function, add one callback and a pointer
  to musb in struct dma_controller
- Surround the DMA function introduced in musb_dsps with #ifdef / #endif.

Changes in v2:
- Fix some typo in commit messages
- Add more explanation about some changes made by patch 2 in commit message

Alexandre Bailon (3):
  usb: musb: dma: Add a DMA completion platform callback
  usb: musb: cppi41: Detect aborted transfers in cppi41_dma_callback()
  usb: musb: dsps: Manage CPPI 4.1 DMA interrupt in dsps

 drivers/dma/cppi41.c           | 28 ++++------------
 drivers/usb/musb/musb_cppi41.c | 20 ++++++++----
 drivers/usb/musb/musb_dma.h    |  4 +++
 drivers/usb/musb/musb_dsps.c   | 72 ++++++++++++++++++++++++++++++++++++++++--
 4 files changed, 95 insertions(+), 29 deletions(-)

-- 
2.10.2

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
