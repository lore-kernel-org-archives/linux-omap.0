From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCHv4 00/10] ARM: DRA7: add display support
Date: Mon, 1 Jun 2015 09:23:08 +0300
Message-ID: <1433139798-23450-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:34580 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751461AbbFAGX7 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 1 Jun 2015 02:23:59 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: paul@pwsan.com, Tero Kristo <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

Hi,

This series adds the arch/arm/ side of the display support for DRA7 (DRA72x,
DRA74x, AM54xx) SoCs. Also support for HDMI output on x15 and DRA72 EVM boards
is added.

The difference to v4 is that the DESHDCP patches were moved to the beginning of
the series to fix boot issues if bisecting.

 Tomi

Tomi Valkeinen (10):
  arm: dra7: add DESHDCP clock
  CLK: TI: always enable DESHDCP clock
  arm/dts: dra7xx: add 'ti,set-rate-parent' for dss_dss_clk
  ARM: DRA7: hwmod: add DMM hwmod description
  ARM: DRA7: hwmod: set DSS submodule parent hwmods
  ARM: OMAP: display: change compat names to array
  ARM: OMAP2+: display: detect DRA7 DSS
  arm/dts: dra7.dtsi: add DSS support
  arm/dts: dra72-evm.dts: add HDMI
  arm/dts: am57xx-beagle-x15.dts: add HDMI

 arch/arm/boot/dts/am57xx-beagle-x15.dts   |  81 ++++++++++++++++++++++
 arch/arm/boot/dts/dra7.dtsi               |  43 ++++++++++++
 arch/arm/boot/dts/dra72-evm.dts           | 110 ++++++++++++++++++++++++++++++
 arch/arm/boot/dts/dra72x.dtsi             |  11 +++
 arch/arm/boot/dts/dra74x.dtsi             |  15 ++++
 arch/arm/boot/dts/dra7xx-clocks.dtsi      |  11 +++
 arch/arm/mach-omap2/display.c             |  32 +++++----
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c |  33 +++++++++
 drivers/clk/ti/clk-7xx.c                  |   8 ++-
 9 files changed, 328 insertions(+), 16 deletions(-)

-- 
2.1.4

