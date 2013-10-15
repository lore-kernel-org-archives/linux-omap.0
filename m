From: Archit Taneja <archit@ti.com>
Subject: [PATCH v4 0/2] DMM DT adaptation
Date: Tue, 15 Oct 2013 12:34:18 +0530
Message-ID: <1381820660-5501-1-git-send-email-archit@ti.com>
References: <1379063679-4869-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1379063679-4869-1-git-send-email-archit@ti.com>
Sender: linux-doc-owner@vger.kernel.org
To: bcousson@baylibre.com, tony@atomide.com, mark.rutland@arm.com
Cc: tomi.valkeinen@ti.com, robdclark@gmail.com, linux-doc@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, Archit Taneja <archit@ti.com>
List-Id: linux-omap@vger.kernel.org

The DMM/Tiler block can used by omapdrm to allocate frame buffers. With the
removal of address and irq data from the omap4 hwmods, the probe of DMM driver
fails and omapdrm isn't able to utilize the DMM hardware.

Add DMM bindings for omap4 and omap5.

Changes in v4:
- Clean up documentation further.

Changes in v3:
- Fix mistakes in documentation and remove aliases for dmm nodes.

Changes in v2:
- No changes, split out into a separate series containing only DT related parts.

Archit Taneja (2):
  arm: dts: omap4+: Add DMM bindings
  drm: omap: Enable DT support for DMM

 Documentation/devicetree/bindings/arm/omap/dmm.txt | 22 ++++++++++++++++++++++
 arch/arm/boot/dts/omap4.dtsi                       |  7 +++++++
 arch/arm/boot/dts/omap5.dtsi                       |  7 +++++++
 drivers/gpu/drm/omapdrm/omap_dmm_tiler.c           | 11 +++++++++++
 4 files changed, 47 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/omap/dmm.txt

-- 
1.8.1.2

