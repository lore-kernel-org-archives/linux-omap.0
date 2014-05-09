From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 00/11] ARM: OMAP: OMAP5 & AM43x DSS
Date: Fri, 9 May 2014 14:56:08 +0300
Message-ID: <1399636579-8062-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:53764 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751142AbaEIL5B (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 9 May 2014 07:57:01 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>
Cc: Paul Walmsley <paul@pwsan.com>, Archit Taneja <archit@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

Hi,

Here are arch/arm/ patches to add display support for OMAP5 and AM43x.

I have these in my tree, in a branch I will send to Tony for merging. Most of
these patches have already been around the lists, but I wanted to send them one
more time to verify that all looks right and everybody is fine with them.

 Tomi

Archit Taneja (1):
  ARM: OMAP2+: hwmod: OMAP5 DSS hwmod data

Sathya Prakash M R (4):
  ARM: AM43xx: hwmod: add DSS hwmod data
  ARM: dts: am43xx: add ti,set-rate-parent for disp_clk
  ARM: dts: am4372.dtsi: add DSS information
  ARM: dts: am437x-gp-evm: add LCD data

Tomi Valkeinen (6):
  ARM: dts: am43x-epos-evm: add LCD data
  ARM: dts: omap5-clocks.dtsi: add dss iclk
  ARM: dts: omap5-clocks.dtsi: add ti,set-rate-parent to dss_dss_clk
  ARM: dts: omap5.dtsi: add DSS nodes
  ARM: dts: omap5-uevm.dts: add tca6424a
  ARM: dts: omap5-uevm.dts: add display nodes

 arch/arm/boot/dts/am4372.dtsi              |  30 +++
 arch/arm/boot/dts/am437x-gp-evm.dts        |  97 ++++++++++
 arch/arm/boot/dts/am43x-epos-evm.dts       | 101 ++++++++++
 arch/arm/boot/dts/am43xx-clocks.dtsi       |   1 +
 arch/arm/boot/dts/omap5-uevm.dts           |  89 +++++++++
 arch/arm/boot/dts/omap5.dtsi               |  70 +++++++
 arch/arm/boot/dts/omap54xx-clocks.dtsi     |   9 +
 arch/arm/mach-omap2/omap_hwmod_43xx_data.c | 104 +++++++++++
 arch/arm/mach-omap2/omap_hwmod_54xx_data.c | 283 +++++++++++++++++++++++++++++
 arch/arm/mach-omap2/prcm43xx.h             |   1 +
 10 files changed, 785 insertions(+)

-- 
1.9.1

