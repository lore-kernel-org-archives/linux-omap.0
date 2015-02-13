From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 0/9] ARM: DRA7: add display support
Date: Fri, 13 Feb 2015 17:11:17 +0200
Message-ID: <1423840286-18377-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:43934 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752777AbbBMPMf (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 13 Feb 2015 10:12:35 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Nishanth Menon <nm@ti.com>, Felipe Balbi <balbi@ti.com>, Tero Kristo <t-kristo@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

Hi,

This series adds the arch/arm/ side of the display support for DRA7 (DRA72x,
DRA74x, AM54xx) SoCs. Also support for HDMI output on x15 and DRA72 EVM boards
is added.

The series is based on OMAPDSS driver patches in fbdev changes for 3.20, which
have been merged to Linus' tree.

The changes are very similar to OMAP5 DSS. All the other patches look fine to
me except the "RFC: ARM: DRA7: enable DSS_DESHDCP_CLKEN". That's been discussed
earlier with Paul and Tero, but I don't think we have any good solution for it
yet.

 Tomi

Tomi Valkeinen (9):
  arm/dts: dra7xx: add 'ti,set-rate-parent' for dss_dss_clk
  ARM: DRA7: hwmod: add DMM hwmod description
  ARM: DRA7: hwmod: set DSS submodule parent hwmods
  ARM: OMAP: display: change compat names to array
  ARM: OMAP2+: display: detect DRA7 DSS
  arm/dts: dra7.dtsi: add DSS support
  arm/dts: dra72-evm.dts: add HDMI
  arm/dts: am57xx-beagle-x15.dts: add HDMI
  RFC: ARM: DRA7: enable DSS_DESHDCP_CLKEN

 arch/arm/boot/dts/am57xx-beagle-x15.dts   |  80 +++++++++++++++++++++
 arch/arm/boot/dts/dra7.dtsi               |  38 ++++++++++
 arch/arm/boot/dts/dra72-evm.dts           | 111 ++++++++++++++++++++++++++++++
 arch/arm/boot/dts/dra72x.dtsi             |  11 +++
 arch/arm/boot/dts/dra74x.dtsi             |  15 ++++
 arch/arm/boot/dts/dra7xx-clocks.dtsi      |   1 +
 arch/arm/mach-omap2/display.c             |  32 +++++----
 arch/arm/mach-omap2/io.c                  |  11 +++
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c |  32 +++++++++
 9 files changed, 316 insertions(+), 15 deletions(-)

-- 
2.3.0

