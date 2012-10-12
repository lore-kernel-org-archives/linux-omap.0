From: Omar Ramirez Luna <omar.luna@linaro.org>
Subject: [PATCH v3 0/6] OMAP: iommu: hwmod, reset handling and runtime PM
Date: Thu, 11 Oct 2012 20:06:05 -0500
Message-ID: <1350003977-32744-1-git-send-email-omar.luna@linaro.org>
Return-path: <linux-doc-owner@vger.kernel.org>
Sender: linux-doc-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Joerg Roedel <joerg.roedel@amd.com>
Cc: Russell King <linux@arm.linux.org.uk>, Omar Ramirez Luna <omar.luna@linaro.org>, Benoit Cousson <b-cousson@ti.com>, Ohad Ben-Cohen <ohad@wizery.com>, Paul Walmsley <paul@pwsan.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, devicetree-discuss@lists.ozlabs.org, linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, iommu@lists.linux-foundation.org
List-Id: linux-omap@vger.kernel.org

These patches are needed for remoteproc to work on OMAP4.

Introduced iommu hwmod support for OMAP3 (iva, isp) and
OMAP4 (ipu, dsp), along with the corresponding runtime PM
and routines to deassert reset lines, enable/disable clocks
and configure sysc registers.

Although IOMMU hwmod patches were already submitted in the past,
this series adds few more changes, like:
- New reset handling.
- Save and restore context code rework.
- Device tree bindings for OMAP3 and OMAP4.

For this series I just dropped the patches already included in
mainline.

Previous work can be found at:
[v2]
  http://www.mail-archive.com/linux-omap@vger.kernel.org/msg75701.html
[v1]
  http://www.mail-archive.com/linux-omap@vger.kernel.org/msg70447.html

[old iteration without reset, save/restore and device tree]
  http://www.mail-archive.com/linux-omap@vger.kernel.org/msg60133.html

Omar Ramirez Luna (6):
  ARM: OMAP3/4: iommu: migrate to hwmod framework
  ARM: OMAP3/4: iommu: adapt to runtime pm
  ARM: OMAP: iommu: pm runtime save and restore context
  ARM: OMAP: iommu: optimize save and restore routines
  ARM: OMAP: iommu: add device tree support
  arm/dts: OMAP3/4: Add iommu nodes

 .../devicetree/bindings/arm/omap/iommu.txt         |   10 ++
 arch/arm/boot/dts/omap3.dtsi                       |   12 +-
 arch/arm/boot/dts/omap4.dtsi                       |   17 +-
 arch/arm/mach-omap2/devices.c                      |    2 +-
 arch/arm/mach-omap2/iommu2.c                       |   74 ++------
 arch/arm/mach-omap2/omap-iommu.c                   |  176 +++++---------------
 arch/arm/plat-omap/include/plat/iommu.h            |   20 ++-
 arch/arm/plat-omap/include/plat/iommu2.h           |    4 -
 drivers/iommu/omap-iommu.c                         |  163 ++++++++++++++----
 9 files changed, 245 insertions(+), 233 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/omap/iommu.txt

-- 
1.7.9.5

