From: Sneeker Yeh <sneeker.yeh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v3 0/5] Add support for Fujitsu USB host controller
Date: Sun, 25 Jan 2015 16:13:23 +0800
Message-ID: <1422173608-24355-1-git-send-email-Sneeker.Yeh@tw.fujitsu.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Mathias Nyman <mathias.nyman-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Andy Green <andy.green-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Jassi Brar <jaswinder.singh-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Sneeker Yeh <Sneeker.Yeh-l16TxrwUIHTQFUHtdCDX3A@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

These patches add support for XHCI compliant Host controller found
on Fujitsu Socs, and are based on http://lwn.net/Articles/629162/
The first patch is to add Fujitsu glue layer of Synopsis DesignWare USB3 driver
and last four patch is about quirk implementation of errata in Synopsis
DesignWare USB3 IP.

Patch 1 introduces a quirk with device disconnection management necessary
Synopsys Designware USB3 IP with versions < 3.00a and hardware configuration
DWC_USB3_SUSPEND_ON_DISCONNECT_EN=1. It solves a problem where without the
quirk, that host controller will die after a usb device is disconnected from
port of root hub.

Patch 2 is to set Synopsis quirk in xhci platform driver based on xhci platform
data.

Patch 3 is to add a revison number 2.90a and 3.00a of Synopsis DesignWare USB3
IP core driver.

Patch 4 introduces using a quirk based on a errata of Synopsis
DesignWare USB3 IP which is versions < 3.00a and has hardware configuration
DWC_USB3_SUSPEND_ON_DISCONNECT_EN=1, which cannot be read from software. As a
result this quirk has to be enabled via platform data or device tree.

Patch 5 introduces Fujitsu Specific Glue layer in Synopsis DesignWare USB3 IP
driver. 

Successfully tested on Fujitsu mb86s7x board.

Changes since v2 (RFC):
[https://lkml.org/lkml/2014/12/15/929]
 - based on Felipe's comment, re-order patches to avoid breaking bisectability,
 - based on Felipe's comment, add comment to structure's member, and sort it
   alphabetically,
 - based on Felipe's comment, add another v2.90 revision number in dwc3 IP.

Changes since v1 (RFC):
[https://lkml.org/lkml/2014/12/15/929]
 - based on Arnd's comment, remove entire unnecessary Fujitsu EHCI/OHCI glue,
 - based on Felipe's comment, fix mis-using of runtime-pm API and setting dma
   mask, remove unnecessary comment, and refactor suspend/resume handler in
   Fujitsu Specific Glue layer in dwc3,
 - based on Felipe's comment, add more commit log and comments in Synopsis
   quirk implementation, and separate it into four patches.

Sneeker Yeh (5):
  xhci: add a quirk for device disconnection errata for Synopsis
    Designware USB3     core
  xhci: Platform: Set Synopsis device disconnection quirk based on
    platform data
  usb: dwc3: add revision number DWC3_REVISION_290A and
    DWC3_REVISION_300A
  usb: dwc3: Add quirk for Synopsis device disconnection errata
  usb: dwc3: add Fujitsu Specific Glue layer

 Documentation/devicetree/bindings/usb/dwc3.txt     |   17 ++
 .../devicetree/bindings/usb/fujitsu-dwc3.txt       |   33 ++++
 drivers/usb/dwc3/Kconfig                           |   11 ++
 drivers/usb/dwc3/Makefile                          |    1 +
 drivers/usb/dwc3/core.c                            |    6 +
 drivers/usb/dwc3/core.h                            |    6 +
 drivers/usb/dwc3/dwc3-mb86s70.c                    |  206 ++++++++++++++++++++
 drivers/usb/dwc3/host.c                            |    4 +
 drivers/usb/dwc3/platform_data.h                   |    8 +
 drivers/usb/host/xhci-hub.c                        |    4 +
 drivers/usb/host/xhci-plat.c                       |    3 +
 drivers/usb/host/xhci.c                            |   29 +++
 drivers/usb/host/xhci.h                            |   24 +++
 include/linux/usb/xhci_pdriver.h                   |    4 +
 14 files changed, 356 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/fujitsu-dwc3.txt
 create mode 100644 drivers/usb/dwc3/dwc3-mb86s70.c

-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
