From: Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Subject: [RESEND PATCH v6 0/4] usb: musb: da8xx: Add DMA support
Date: Fri, 24 Mar 2017 15:35:56 +0100
Message-ID: <20170324143600.4704-1-abailon@baylibre.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: b-liu-l0cyMroinI0@public.gmane.org
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ptitiano-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

This series update MUSB driver to add DMA support to DA8xx.
It should be applied on top of:
"[PATCH v4 0/3] dmaengine: cppi41: Add dma support to da8xx" and
"[PATCH v3] ARM: davinci: Make the usb20 clock available to PM runtime"

Changes in v6:
- Rebased on linux-next. Some patches were conflicting with a series
  adding suspend and resume support.

Changes in v5:
- Fix a typo in commit message of patch 4

Changes in v4:
- Update and clarify the commit message of patch 5
- Fix the typo in patch 3

Changes in v3:
- Remove PM runtime callbacks.
  I have update arch/arm/mach-davinci/pm_domain.c to let PM runtime control
  the usb20 clock.
- Only use PM runtime sync operation.

Changes in v2:
- Clock and IRQ management has been moved to MUSB DA8xx glue
  (was in CPPI 4.1 driver)
- I have added a partial support PM runtime. The goal was to use PM
  runtime to manage clock of MUSB and CPPI 4.1 (they use the same clock).
- CPPI 4.1 is now achild of MUSB DA8xx glue.

Alexandre Bailon (4):
  usb: musb: Use shared irq
  usb: musb: Add support of CPPI 4.1 DMA controller to DA8xx
  usb: musb: musb_cppi41: Workaround DMA stall issue during teardown
  usb: musb: da8xx: Add a primary support of PM runtime

 drivers/usb/musb/Kconfig       |  4 +--
 drivers/usb/musb/da8xx.c       | 63 ++++++++++++++++++++++++++++--------------
 drivers/usb/musb/musb_core.c   |  2 +-
 drivers/usb/musb/musb_core.h   |  1 +
 drivers/usb/musb/musb_cppi41.c |  4 +++
 5 files changed, 51 insertions(+), 23 deletions(-)

-- 
2.10.2

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
