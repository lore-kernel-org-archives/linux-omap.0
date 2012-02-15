From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH 0/4] spi/omap: Adaptation to Device Tree
Date: Wed, 15 Feb 2012 18:37:33 +0100
Message-ID: <1329327457-2121-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:35451 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751873Ab2BORht (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 15 Feb 2012 12:37:49 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: grant.likely@secretlab.ca
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, Benoit Cousson <b-cousson@ti.com>

Hi Grant,

You might think I'm harassing you with all these series, but it looks like
you are the maintainer of all the stuff I care about for the moment :-)

Here are a couple of SPI patches + the addition of a SPI ethernet device
needed for sdp4430 board.

This driver is still relying on a valid bus_number which is clearly bad.
A cleanup is definitively needed, and will be done later.

This series is based on lo/master (a37cdd9) + for_3.4/dt_base branch to get
the needed cleanup and fixes for OMAP.

Please note that due to the changes in the various OMAP DTS files, I have
to base this series on top of my other DT series (gpio for example), otherwise
the merge of the two series will generate some merge conflict in the DTS since
they are both adding some new nodes at the exact same location.

I'm not sure how this should be handled.

This series is available here for reference:
  git://git.kernel.org/pub/scm/linux/kernel/git/bcousson/linux-omap-dt.git for_3.4/dt_spi_eth

Regards,
Benoit


Benoit Cousson (4):
  spi/omap: Add DT support to McSPI driver
  arm/dts: OMAP4: Add SPI controller nodes
  arm/dts: OMAP3: Add SPI controller nodes
  arm/dts: omap4-sdp: Add ks8851 ethernet SPI device

 Documentation/devicetree/bindings/spi/omap-spi.txt |   20 +++++++
 arch/arm/boot/dts/omap3.dtsi                       |   32 +++++++++++
 arch/arm/boot/dts/omap4-sdp.dts                    |   21 +++++++
 arch/arm/boot/dts/omap4.dtsi                       |   32 +++++++++++
 arch/arm/mach-omap2/devices.c                      |    4 +-
 drivers/spi/spi-omap2-mcspi.c                      |   56 +++++++++++++++++---
 6 files changed, 156 insertions(+), 9 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/spi/omap-spi.txt

