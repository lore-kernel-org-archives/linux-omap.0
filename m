From: Archit Taneja <archit@ti.com>
Subject: [PATCH v3 0/6] v4l: VPE mem to mem driver
Date: Thu, 29 Aug 2013 18:02:46 +0530
Message-ID: <1377779572-22624-1-git-send-email-archit@ti.com>
References: <1376996457-17275-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <1376996457-17275-1-git-send-email-archit@ti.com>
Sender: linux-media-owner@vger.kernel.org
To: linux-media@vger.kernel.org
Cc: hverkuil@xs4all.nl, laurent.pinchart@ideasonboard.com, tomi.valkeinen@ti.com, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>
List-Id: linux-omap@vger.kernel.org

VPE(Video Processing Engine) is an IP found on DRA7xx, this series adds VPE as a
mem to mem v4l2 driver, and VPDMA as a helper library.

The first version of the patch series described VPE in detail, you can have a
look at it here:

http://www.spinics.net/lists/linux-media/msg66518.html

The only change in v3 is that DMA allocation APIs for motion vector buffers
instead of kzalloc as they can take up to 100Kb of memory. The descriptors used
by VPDMA are still allocated via kzalloc. The allocation/mapping api for VPDMA
was renamed such that we know it's for allocating descriptor lists and
descriptor payloads.

Archit Taneja (6):
  v4l: ti-vpe: Create a vpdma helper library
  v4l: ti-vpe: Add helpers for creating VPDMA descriptors
  v4l: ti-vpe: Add VPE mem to mem driver
  v4l: ti-vpe: Add de-interlacer support in VPE
  arm: dra7xx: hwmod data: add VPE hwmod data and ocp_if info
  experimental: arm: dts: dra7xx: Add a DT node for VPE

 arch/arm/boot/dts/dra7.dtsi                |   11 +
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c  |   42 +
 drivers/media/platform/Kconfig             |   16 +
 drivers/media/platform/Makefile            |    2 +
 drivers/media/platform/ti-vpe/Makefile     |    5 +
 drivers/media/platform/ti-vpe/vpdma.c      |  846 ++++++++++++
 drivers/media/platform/ti-vpe/vpdma.h      |  202 +++
 drivers/media/platform/ti-vpe/vpdma_priv.h |  640 +++++++++
 drivers/media/platform/ti-vpe/vpe.c        | 2050 ++++++++++++++++++++++++++++
 drivers/media/platform/ti-vpe/vpe_regs.h   |  496 +++++++
 10 files changed, 4310 insertions(+)
 create mode 100644 drivers/media/platform/ti-vpe/Makefile
 create mode 100644 drivers/media/platform/ti-vpe/vpdma.c
 create mode 100644 drivers/media/platform/ti-vpe/vpdma.h
 create mode 100644 drivers/media/platform/ti-vpe/vpdma_priv.h
 create mode 100644 drivers/media/platform/ti-vpe/vpe.c
 create mode 100644 drivers/media/platform/ti-vpe/vpe_regs.h

-- 
1.8.1.2
