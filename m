From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 0/9] usb: gadget: generic map/unmap routines
Date: Tue, 24 Jan 2012 13:45:21 +0200
Message-ID: <1327405543-27589-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux USB Mailing List <linux-usb@vger.kernel.org>
Cc: Felipe Balbi <balbi@ti.com>, Greg Kroah-Hartman <gregkh@suse.de>, Thomas Dahlmann <dahlmann.thomas@arcor.de>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, "open list:DESIGNWARE USB3 D..." <linux-omap@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, "open list:AMD GEODE CS5536..." <linux-geode@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

Hi all,

here's a rebased version of generic map/unmap patchset.

Also available on generic-map-unmap branch of my tree, some
of the patches have been tested before and already have a
Tested-by tag.

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

 drivers/usb/dwc3/core.h                |    2 -
 drivers/usb/dwc3/ep0.c                 |   16 +++++-
 drivers/usb/dwc3/gadget.c              |   93 ++++++--------------------------
 drivers/usb/dwc3/gadget.h              |    2 -
 drivers/usb/gadget/amd5536udc.c        |   33 ++---------
 drivers/usb/gadget/goku_udc.c          |   18 +++----
 drivers/usb/gadget/langwell_udc.c      |   45 +++-------------
 drivers/usb/gadget/net2272.c           |   18 +++----
 drivers/usb/gadget/net2280.c           |   19 +++----
 drivers/usb/gadget/r8a66597-udc.c      |   10 +---
 drivers/usb/gadget/udc-core.c          |   52 ++++++++++++++++++
 drivers/usb/renesas_usbhs/mod_gadget.c |   73 ++++++-------------------
 include/linux/usb/gadget.h             |   10 ++++
 13 files changed, 149 insertions(+), 242 deletions(-)

-- 
1.7.8.2
