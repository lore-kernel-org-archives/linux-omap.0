From: Florian Vaussard <florian.vaussard@epfl.ch>
Subject: [PATCH 0/2] ARM: omap/dts: Add support for Gumstix Overo with Tobi expansion
Date: Fri, 31 Aug 2012 18:06:10 +0200
Message-ID: <1346429172-5902-1-git-send-email-florian.vaussard@epfl.ch>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp4.epfl.ch ([128.178.224.218]:40439 "HELO smtp4.epfl.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754392Ab2HaQGz (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 31 Aug 2012 12:06:55 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org
Cc: Tony Lindgren <tony@atomide.com>, Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>, Benoit Cousson <b-cousson@ti.com>, Steve Sakoman <steve@sakoman.com>, Florian Vaussard <florian.vaussard@epfl.ch>, Philippe Retornaz <philippe.retornaz@epfl.ch>, linux-arm-kernel@lists.infradead.org

The Gumstix Overo is a computer on module using an OMAP3 processor.
This module must be plugged into an expansion board.

This patchset adds a first device tree support for the Overo, using the
Tobi expansion board. The current support is able to boot and mount
the rootfs from MMC, with a few extra features.

The first patch creates the device tree for both the Overo and the
Tobi expansion board, and updates the dtb build target.

The second patch updates the omap/dts documentation.

This patchset applies on tony's tree [1], devel-dt branch.

Regards,

Florian

[1] http://git.kernel.org/?p=linux/kernel/git/tmlind/linux-omap.git;a=summary


Florian Vaussard (2):
  ARM: omap/dts: Add support for Gumstix Overo with Tobi expansion
    board
  ARM: omap/dts: update the documentation

 .../devicetree/bindings/arm/omap/omap.txt          |    3 +
 arch/arm/boot/dts/omap3-overo.dtsi                 |   42 ++++++++++++++++++++
 arch/arm/boot/dts/omap3-tobi.dts                   |   35 ++++++++++++++++
 arch/arm/mach-omap2/Makefile.boot                  |    2 +-
 4 files changed, 81 insertions(+), 1 deletions(-)
 create mode 100644 arch/arm/boot/dts/omap3-overo.dtsi
 create mode 100644 arch/arm/boot/dts/omap3-tobi.dts

-- 
1.7.5.4

