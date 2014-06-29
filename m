From: Andre Heider <a.heider@gmail.com>
Subject: [PATCH 00/13] uio_pruss: add support for devicetree and am33xx
Date: Sun, 29 Jun 2014 18:21:34 +0200
Message-ID: <1404058907-21112-1-git-send-email-a.heider@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f173.google.com ([74.125.82.173]:51442 "EHLO
	mail-we0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750830AbaF2QVz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 29 Jun 2014 12:21:55 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Matt Porter <mporter@linaro.org>, "Hans J . Koch" <hjk@hansjkoch.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

Hi,

this series adds PRUv2 support to uio_pruss through devicetree, makes the
device usable on am33xx and enables it on beaglebone black.
Inspired by old patches from Matt Porter found in a downstream tree.

To archieve that this series:
* adds a flag to omap_hwmod.c to get PRUSS out of hardreset (patch 5 and 6)
* adds devicetree support to uio_pruss (patch 7 and 9)
* adds the device to the am33xx dtsi and boneblack dts (patch 12 and 13)

Bits and pieces:
* some cleanup (patch 1-4)
* take care of a fact that SRAM on am33xx is not exposed through UIO (patch 8)
* add runtime pm support to enable clocks (patch 10)
* allow the driver to be compiled on SOC_AM33XX (patch 11)

This is only tested on beaglebone black (as that's the only hardware of the
PRUSS enabled families I have) with some basic GPIO and IRQ tests.

Notes:
* I just got this hardware and I don't know if this UIO PRUSS business is
  desired. Looking at the userspace driver I'd guess not so much ;), but this
  interface is there for older generations anyway, and this small series lets
  me use the device.
* is the hardreset thing I did there the right thing to do? I think the
  proper way would be a reset controller (which apparently doesn't yet exist
  for this SoC?) and let the driver deassert/assert on probe/remove?
* the platform device path has a clk_enable() / clk_put() calls. Are those
  now redundant with the introduced pm_runtime_enable() pm_runtime_disable()
  calls?

Thanks,
Andre

Andre Heider (13):
  uio: uio_pruss: use struct device
  uio: uio_pruss: use devm_kzalloc()
  uio: uio_pruss: use devm_ioremap_resource()
  uio: uio_pruss: use dmam_alloc_coherent()
  ARM: OMAP2+: hwmod: Introduce a flag to deassert the HW reset line
  ARM: AM33XX: hwmod: deassert PRUSS' hardreset lines
  Documentation: devicetree: add bindings for TI PRUSS
  uio: uio_pruss: make the UIO SRAM memory region optional
  uio: uio_pruss: add devicetree support
  uio: uio_pruss: add runtime pm support
  uio: uio_pruss: enable the driver for am33xx SoCs
  ARM: dts: am33xx: add the PRUSSv2 device
  ARM: dts: am335x-boneblack: enable the PRUSSv2 device

 .../devicetree/bindings/misc/ti,pruss.txt          |  19 +++
 arch/arm/boot/dts/am335x-boneblack.dts             |   4 +
 arch/arm/boot/dts/am33xx.dtsi                      |   9 ++
 arch/arm/mach-omap2/omap_hwmod.c                   |   2 +
 arch/arm/mach-omap2/omap_hwmod.h                   |   2 +
 .../mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c |   1 +
 drivers/uio/Kconfig                                |   4 +-
 drivers/uio/uio_pruss.c                            | 144 ++++++++++++---------
 8 files changed, 123 insertions(+), 62 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/misc/ti,pruss.txt

-- 
2.0.0

