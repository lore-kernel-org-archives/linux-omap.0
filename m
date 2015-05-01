From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 00/12] MUSB patches to select all DMA drivers
Date: Fri,  1 May 2015 12:29:26 -0700
Message-ID: <1430508578-5208-1-git-send-email-tony@atomide.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Cc: Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>, George Cherian <george.cherian-l0cyMroinI0@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi all,

Here are few patches that allow building in all the MUSB DMA
drivers for distros. This also allows us to get rid of most
of the ifdefs, and also simplifies the musb_host_rx monster
function a bit.

Regards,

Tony

Tony Lindgren (12):
  usb: musb: Fix up DMA related macros
  usb: musb: Set up function pointers for DMA
  usb: musb: Get rid of the DMA ifdefs for musb_core.c
  usb: musb: Remove DMA ifdef for musb_gadget.c short_packet
  usb: musb: Remove the rest of DMA related ifdefs in musb_gadget.c
  usb: musb: Remove ifdefs for TX DMA for musb_host.c
  usb: musb: Remove ifdefs for musb_host_rx in musb_host.c part1
  usb: musb: Remove ifdefs for musb_host_rx in musb_host.c part2
  usb: musb: Remove ifdefs for musb_host_rx in musb_host.c part3
  usb: musb: Remove ifdefs for musb_host_rx in musb_host.c part4
  usb: musb: Remove ifdefs for musb_host_rx in musb_host.c part5
  usb: musb: Allow building in all the DMA code

 drivers/usb/musb/Kconfig         |  38 ++-
 drivers/usb/musb/am35x.c         |   6 +-
 drivers/usb/musb/blackfin.c      |   5 +
 drivers/usb/musb/cppi_dma.c      |   9 +-
 drivers/usb/musb/da8xx.c         |   6 +-
 drivers/usb/musb/davinci.c       |   7 +-
 drivers/usb/musb/jz4740.c        |   6 +-
 drivers/usb/musb/musb_core.c     |  29 ++-
 drivers/usb/musb/musb_core.h     |   5 +
 drivers/usb/musb/musb_cppi41.c   |   8 +-
 drivers/usb/musb/musb_dma.h      |  67 +++++-
 drivers/usb/musb/musb_dsps.c     |   6 +-
 drivers/usb/musb/musb_gadget.c   |  52 ++--
 drivers/usb/musb/musb_host.c     | 509 ++++++++++++++++++++++++---------------
 drivers/usb/musb/musbhsdma.c     |   9 +-
 drivers/usb/musb/omap2430.c      |   5 +
 drivers/usb/musb/tusb6010.c      |   8 +-
 drivers/usb/musb/tusb6010.h      |   6 -
 drivers/usb/musb/tusb6010_omap.c |   9 +-
 drivers/usb/musb/ux500.c         |   6 +-
 drivers/usb/musb/ux500_dma.c     |   8 +-
 21 files changed, 509 insertions(+), 295 deletions(-)

-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
