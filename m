From: Sathya Prakash M R <sathyap@ti.com>
Subject: [PATCH 0/4] Add Display support for AM43xx
Date: Tue, 3 Dec 2013 14:03:44 +0530
Message-ID: <1386059629-1234-1-git-send-email-sathyap@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:50351 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751478Ab3LCIeI (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 3 Dec 2013 03:34:08 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, tomi.valkeinen@ti.com, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, rob.herring@calxeda.com, pawel.moll@arm.com, mark.rutland@arm.com, paul@pwsan.com
Cc: Sathya Prakash M R <sathyap@ti.com>

This patch series adds DSS support to the AM43x. The DPI LCD
panel is supported on both am43x-epos-evm and am437x-gp-evm.
The LCD panel is from OSD model: OSD057T0559-34TS

Done on top of 3.13-rc1 and below dependent patches

Sourav patches adding device nodes for epos [1] and gp [2] evm
[1]: https://patchwork.kernel.org/patch/3246701/
[2]: https://patchwork.kernel.org/patch/3246751/

Tomi patch adding DT support to DSS [3]
[3]: https://patchwork.kernel.org/patch/2841721/

AM43xx has a dedicated display pll. Hence tomi patch improving
func clock handling is needed [4]
[4]: https://patchwork.kernel.org/patch/3196221/

Tested on am43x-epos-evm and am437x-gp-evm.

Sathya Prakash M R (3):
  OMAPDSS: Add DSS features for AM43xx
  ARM: OMAP2+: AM43xx DSS Hwmod
  ARM: DTS: AM43x: Add DSS node

Tomi Valkeinen (1):
  ARM: AM43xx: fix dpll init in bypass mode

 arch/arm/boot/dts/am4372.dtsi              |   28 ++++++++
 arch/arm/boot/dts/am437x-gp-evm.dts        |   68 ++++++++++++++++++
 arch/arm/boot/dts/am43x-epos-evm.dts       |   64 +++++++++++++++++
 arch/arm/boot/dts/am43xx-clocks.dtsi       |    2 +
 arch/arm/mach-omap2/clkt_dpll.c            |    4 +-
 arch/arm/mach-omap2/display.c              |    2 +
 arch/arm/mach-omap2/omap_hwmod_43xx_data.c |  104 ++++++++++++++++++++++++++++
 arch/arm/mach-omap2/prcm43xx.h             |    1 +
 drivers/video/omap2/dss/dispc.c            |    1 +
 drivers/video/omap2/dss/dpi.c              |    2 +
 drivers/video/omap2/dss/dsi.c              |    1 +
 drivers/video/omap2/dss/dss.c              |   11 +++
 drivers/video/omap2/dss/dss_features.c     |   67 ++++++++++++++++++
 include/video/omapdss.h                    |    1 +
 14 files changed, 354 insertions(+), 2 deletions(-)

-- 
1.7.9.5

