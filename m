From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 0/9] Add a generic request map/unmap routine
Date: Mon, 19 Dec 2011 12:30:22 +0200
Message-ID: <1324290632-23758-1-git-send-email-balbi@ti.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux USB Mailing List <linux-usb@vger.kernel.org>
Cc: Felipe Balbi <balbi@ti.com>, Greg Kroah-Hartman <gregkh@suse.de>, Thomas Dahlmann <dahlmann.thomas@arcor.de>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, "open list:DESIGNWARE USB3 D..." <linux-omap@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, "open list:AMD GEODE CS5536..." <linux-geode@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

Hi all,

here's a more complete map/unmap rework patchset.

Please give it a try and reply with your Tested-by ASAP.

These patches were written on top of the Scatter/Gather
support patchset, so if you want to try it out, you might
need those first, as an alternative, you can drop patch 2
of this series if you're not testing against dwc3 and it
should apply fine on top of greg/usb-next

Felipe Balbi (9):
  usb: gadget: add generic map/unmap request utilities
  usb: dwc3: gadget: use generic map/unmap routines
  usb: gadget: langwell: use generic map/unmap functions
  usb: renesas: gadget: use generic map/unmap routines
  usb: gadget: amd5536: use generic map/unmap routines
  usb: gadget: r8a66597: use generic map/unmap routines
  usb: gadget: net2272: use generic map/umap routines
  usb: gadget: net2280: use generic map/unmap routines
  usb: gadget: goku: use generic map/unmap routines

 drivers/usb/dwc3/gadget.c              |   80 +++++---------------------------
 drivers/usb/gadget/amd5536udc.c        |   32 ++-----------
 drivers/usb/gadget/goku_udc.c          |   17 +++----
 drivers/usb/gadget/langwell_udc.c      |   45 +++---------------
 drivers/usb/gadget/net2272.c           |   18 +++----
 drivers/usb/gadget/net2280.c           |   19 ++++----
 drivers/usb/gadget/r8a66597-udc.c      |   10 +---
 drivers/usb/gadget/udc-core.c          |   53 +++++++++++++++++++++
 drivers/usb/renesas_usbhs/mod_gadget.c |   60 +++---------------------
 include/linux/usb/gadget.h             |   10 ++++
 10 files changed, 120 insertions(+), 224 deletions(-)

-- 
1.7.8.rc3
