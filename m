From: Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Subject: [PATCH 0/2] Update MUSB CPPI 4.1 driver to correctly manage the DA8xx
Date: Sun, 13 Aug 2017 14:04:21 +0200
Message-ID: <20170813120423.16371-1-abailon@baylibre.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: b-liu-l0cyMroinI0@public.gmane.org
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, ptitiano-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

A couple of weeks ago, Sekhar reported a warning issue happening in
CPPI 4.1. The teardown sequence was not correctly programmed.
The caused was a couple of difference between the DSPS and the DA8xx.
These differences are the way to program the autoreq, the teardown and
the DMA mode.
This series intends to fix the teardown and to correctly program
the DMA mode.

This series has been roughly tested.
I have only tried it on the DA580 LCK and the BeagleBone Black.
Only the device mode (msc and ecm) have been tested.

Alexandre Bailon (2):
  usb: musb: musb_cppi41: Fix the address of teardown and autoreq
    registers
  usb: musb: musb_cppi41: Fix cppi41_set_dma_mode() for DA8xx

 drivers/usb/musb/musb_cppi41.c | 63 +++++++++++++++++++++++++++++++++++++-----
 1 file changed, 56 insertions(+), 7 deletions(-)

-- 
2.13.0

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
