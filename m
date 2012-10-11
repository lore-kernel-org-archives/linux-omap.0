From: Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH V2 0/3] ARM: dts: omap5: EMIF and LPDDR2 device tree data
Date: Thu, 11 Oct 2012 18:17:46 +0530
Message-ID: <1349959669-16366-1-git-send-email-lokeshvutla@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:39298 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756326Ab2JKMsB (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 11 Oct 2012 08:48:01 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, b-cousson@ti.com, lokeshvutla@ti.com

This patch series adds Device tree data for the EMIF 
sdram controllers in OMAP5 and LPDDR2 memory devices 
in OMAP5-evm board.

Testing:
- Boot tested on OMAP5430 evm.
- Built EMIF as a module.

Changes from v1:
* Created a seperate dtsi file for Samsung LPDDR2 memory device 
  used in OMAP5-evm.
* Passing reg and interrupt fields from dt for EMIF1 and EMIF2.

Lokesh Vutla (3):
  ARM: dts: omap5-evm: Fix size of memory defined for EVM
  ARM: dts: omap5: EMIF device tree data for OMAP5 boards
  ARM: dts: omap5-evm: LPDDR2 memory device details for EVM

 arch/arm/boot/dts/omap5-evm.dts           |   13 +++++-
 arch/arm/boot/dts/omap5.dtsi              |   24 +++++++++++
 arch/arm/boot/dts/samsung_k3pe0e000b.dtsi |   67 +++++++++++++++++++++++++++++
 3 files changed, 103 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/samsung_k3pe0e000b.dtsi

-- 
1.7.10.4

