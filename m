From: Pekon Gupta <pekon@ti.com>
Subject: [PATCH v1 0/5] add parallel NAND support for TI's new OMAPx and AMxx platforms
Date: Wed, 5 Feb 2014 18:58:29 +0530
Message-ID: <1391606914-9947-1-git-send-email-pekon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:42557 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750757AbaBEN2k (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 5 Feb 2014 08:28:40 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, bcousson@baylibre.com
Cc: linux-omap <linux-omap@vger.kernel.org>, Pekon Gupta <pekon@ti.com>

This patch-set adds and updates parallel NAND support on following TI platforms
 - AM335x (am335x-evm)
 - DRA7xx (dra7-evm
 - AM43xx (am43X-epos-evm)

In addition, following OMAP2+/GPMC patch is also added in this series as
it add checks DRA7xx and AM43xxx platforms for non-DT kernels.
	ARM: OMAP2+: gpmc: update gpmc_hwecc_bch_capable() for new platforms


Minal Shah (1):
  ARM: dts: dra7: add support for parallel NAND flash

Pekon Gupta (4):
  ARM: OMAP2+: gpmc: update gpmc_hwecc_bch_capable() for new platforms
    and ECC schemes
  ARM: dts: am335x-evm: NAND: update MTD partition table
  ARM: dts: AM33xx: updated default ECC scheme in nand-ecc-opt
  ARM: dts: am43xx: add support for parallel NAND flash

 arch/arm/boot/dts/am335x-evm.dts     |  51 +++++++--------
 arch/arm/boot/dts/am4372.dtsi        |  24 +++++++
 arch/arm/boot/dts/am43x-epos-evm.dts | 107 ++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/dra7-evm.dts       | 117 +++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/dra7.dtsi          |  20 ++++++
 arch/arm/boot/dts/omap3430-sdp.dts   |   3 +-
 arch/arm/mach-omap2/gpmc-nand.c      |  31 ++++++----
 7 files changed, 315 insertions(+), 38 deletions(-)

-- 
1.8.5.1.163.gd7aced9

