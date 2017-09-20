From: Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Subject: [PATCH v2 0/4] Update MUSB CPPI 4.1 driver to correctly manage the DA8xx
Date: Wed, 20 Sep 2017 21:26:08 +0200
Message-ID: <20170920192612.16169-1-abailon@baylibre.com>
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

Changes in v2:
 - Fix some typo (indentation and symbols name)
 - Limit the number of channels to 4 for DA8xx
 - Remove duplicated defines

Changes in v3:
 - Fix a stupid type (two NULL check reversed)

Alexandre Bailon (4):
  usb: musb: musb_cppi41: Fix the address of teardown and autoreq
    registers
  usb: musb: musb_cppi41: Fix cppi41_set_dma_mode() for DA8xx
  usb: musb: musb_cppi41: Configure the number of channels for DA8xx
  usb: musb: da8xx: Remove duplicated defines

 drivers/usb/musb/da8xx.c       |  3 --
 drivers/usb/musb/musb_cppi41.c | 94 ++++++++++++++++++++++++++++++++++++------
 2 files changed, 82 insertions(+), 15 deletions(-)

-- 
2.13.5

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
