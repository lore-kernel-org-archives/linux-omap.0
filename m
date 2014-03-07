From: Sricharan R <r.sricharan-l0cyMroinI0@public.gmane.org>
Subject: [RFC PATCH 0/9] drivers: dma: Add support for dma-channel router
Date: Fri, 7 Mar 2014 17:46:07 +0530
Message-ID: <1394194576-23741-1-git-send-email-r.sricharan@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: r.sricharan-l0cyMroinI0@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: santosh.shilimkar-l0cyMroinI0@public.gmane.org, rnayak-l0cyMroinI0@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, nm-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

In some SoCs the dma request lines from the peripherals are
routed to the dma-controller through a crossbar. With this the
dma controller's available request lines are shared between the
peripherals.

This adds support to register the crossbar router associated with
a dma-channel and let the dma-controller driver map/unmap
the peripheral dma crossbar line to dma-controller's request
line.

This is on top of Russell's OMAP dma engine rework series

	http://www.spinics.net/lists/linux-omap/msg102969.html

Sricharan R (9):
  drivers: dma: omap-dma: Avoid hard-coding of the dma-request channels
  drivers: dma: of-dma: Add support for dma-request line routers
  drivers: dma: omap-dma: Add a seperate xlate function to get router
    data
  drivers: omap-dma: Add crossbar line as a resource to omap_chan
    structure
  drivers: dma: Add dma crossbar driver
  arm: dts: dra: Add dma crossbar node
  arm: dts: dra: Add dma-request router phandle to dma-specs
  arm: dra: Enable dma crossbar support on dra7xx
  arm: dts: dra7: Change the total dma-req numbers to crossbar channels

 .../devicetree/bindings/arm/omap/dma-crossbar.txt  |   26 +++
 arch/arm/boot/dts/dra7.dtsi                        |   47 +++--
 arch/arm/configs/omap2plus_defconfig               |    1 +
 drivers/dma/Kconfig                                |    7 +
 drivers/dma/Makefile                               |    1 +
 drivers/dma/of-dma.c                               |   82 +++++++-
 drivers/dma/omap-dma-xbar.c                        |  219 ++++++++++++++++++++
 drivers/dma/omap-dma-xbar.h                        |   32 +++
 drivers/dma/omap-dma.c                             |   72 ++++++-
 include/linux/of_dma.h                             |   22 ++
 10 files changed, 479 insertions(+), 30 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/omap/dma-crossbar.txt
 create mode 100644 drivers/dma/omap-dma-xbar.c
 create mode 100644 drivers/dma/omap-dma-xbar.h

-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
