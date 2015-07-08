From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v3 0/9] usb: dwc3: add dual-role support
Date: Wed, 8 Jul 2015 13:31:55 +0300
Message-ID: <1436351524-28385-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: balbi-l0cyMroinI0@public.gmane.org
Cc: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, Joao.Pinto-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi,

Adds dual role support to dwc3 controller driver.
Series depends on [1] for core OTG/dual-role support.

Patches are based on v4.2-rc1.

Tested on am437x-gp-evm and dra7-evm after platform related patches are
applied. Those are sent seprately.

You will also need the fixes mentioned in [2]

[1] core OTG/DRD support - http://thread.gmane.org/gmane.linux.kernel/1991413
[2] fixes needed for dwc3 to work on dra7
- https://patchwork.kernel.org/patch/6732611/
- https://patchwork.kernel.org/patch/6725291/
- http://article.gmane.org/gmane.linux.usb.general/127693

cheers,
-roger

Felipe Balbi (1):
  usb: dwc3: core: Adapt to named interrupts

George Cherian (1):
  usb: dwc3: dwc3-omap: Make the wrapper interrupt shared

Roger Quadros (7):
  usb: dwc3: add dual-role support
  usb: dwc3: core.h: add some register definitions
  usb: dwc3: core: make dual-role work with OTG irq
  usb: dwc3: save/restore OTG registers during suspend/resume
  usb: dwc3: gadget: Fix suspend/resume during dual-role mode
  usb: dwc3: core: Prevent otg events from disabling themselves
  usb: dwc3: core: don't break during suspend/resume while we're
    dual-role

 drivers/usb/dwc3/core.c          | 409 +++++++++++++++++++++++++++++++++++++--
 drivers/usb/dwc3/core.h          | 113 +++++++++++
 drivers/usb/dwc3/dwc3-omap.c     |   4 +-
 drivers/usb/dwc3/gadget.c        |   8 +-
 drivers/usb/dwc3/platform_data.h |   1 +
 5 files changed, 513 insertions(+), 22 deletions(-)

-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
