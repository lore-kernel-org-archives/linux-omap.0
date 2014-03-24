From: Sathya Prakash M R <sathyap@ti.com>
Subject: [PATCH V3 0/6] Add Display support for AM43xx
Date: Mon, 24 Mar 2014 16:31:50 +0530
Message-ID: <1395658916-9032-1-git-send-email-sathyap@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:48670 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752846AbaCXLCC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 24 Mar 2014 07:02:02 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com, devicetree@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Sathya Prakash M R <sathyap@ti.com>

This patch series adds DSS support to the AM43x. The DPI LCD
panel is supported on both am43x-epos-evm and am437x-gp-evm.
The LCD panel is from OSD model: OSD057T0559-34TS

Version 1 of this series can be found below[1]:
[1]: https://patchwork.kernel.org/patch/3274421/

Tested on am43x-epos-evm and am437x-gp-evm.

Dependent patches :
Sourav patches adding device nodes for epos [2] and gp [3] evm
[2]: https://patchwork.kernel.org/patch/3246701/
[3]: https://patchwork.kernel.org/patch/3246751/

AM43xx has a dedicated display pll. Hence tomi patch improving
func clock handling is needed [4]
[4]: https://patchwork.kernel.org/patch/3196221/

Tomi patch adding DT support to DSS [5]
[5]: https://patchwork.kernel.org/patch/3516341/

Changes from V2:
fixed minor comments on dt changes and added missing signoff

Sathya Prakash M R (5):
  OMAPDSS: Add DSS features for AM43xx
  ARM: OMAP2+: AM43xx DSS Hwmod
  ARM: am43xx-clocks.dtsi: Set parent for disp_clk
  ARM: am4372.dtsi: add omapdss information
  ARM: DTS: AM43xx: Add DSS nodes

Tomi Valkeinen (1):
  ARM: AM43xx: fix dpll init in bypass mode

 arch/arm/boot/dts/am4372.dtsi              |   35 ++++++++++
 arch/arm/boot/dts/am437x-gp-evm.dts        |   77 ++++++++++++++++++++
 arch/arm/boot/dts/am43x-epos-evm.dts       |   73 +++++++++++++++++++
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
 14 files changed, 379 insertions(+), 2 deletions(-)

-- 
1.7.9.5

