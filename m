From: Pekon Gupta <pekon@ti.com>
Subject: [PATCH v2 0/2] add parallel NAND support for TI's new OMAPx and AMxx platforms
Date: Wed, 12 Mar 2014 15:15:45 +0530
Message-ID: <1394617547-25240-1-git-send-email-pekon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:52397 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752954AbaCLJp6 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 12 Mar 2014 05:45:58 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, bcousson@baylibre.com
Cc: linux-omap <linux-omap@vger.kernel.org>, Pekon Gupta <pekon@ti.com>

*changes v1 -> v2*
 - AM335x (am335x-evm): <already accepted, so dropping in v2>
 - DRA7xx (dra7-evm): resending
 - AM43xx (am43X-epos-evm): fix MTD NAND.filesystem partition offset


*Original v1*
This patch-set adds and updates parallel NAND support on following TI platforms
 - AM335x (am335x-evm)
 - DRA7xx (dra7-evm
 - AM43xx (am43X-epos-evm)

In addition, following OMAP2+/GPMC patch is also added in this series as
it add checks DRA7xx and AM43xxx platforms for non-DT kernels.
	ARM: OMAP2+: gpmc: update gpmc_hwecc_bch_capable() for new platforms


Minal Shah (1):
  ARM: dts: dra7: add support for parallel NAND flash

Pekon Gupta (1):
  ARM: dts: am43xx: fix starting offset of NAND.filesystem MTD partition

 arch/arm/boot/dts/am43x-epos-evm.dts |   2 +-
 arch/arm/boot/dts/dra7-evm.dts       | 117 +++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/dra7.dtsi          |  20 ++++++
 3 files changed, 138 insertions(+), 1 deletion(-)

-- 
1.8.5.1.163.gd7aced9

