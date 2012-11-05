From: Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH V3 0/3] ARM: dts: omap5: EMIF and LPDDR2 device tree data
Date: Mon, 5 Nov 2012 18:22:49 +0530
Message-ID: <1352119972-13710-1-git-send-email-lokeshvutla@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:39967 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752193Ab2KEMxI (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 5 Nov 2012 07:53:08 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: b-cousson@ti.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, santosh.shilimkar@ti.com, devicetree-discuss@lists.ozlabs.org, lokeshvutla@ti.com

This patch series adds Device tree data for the EMIF 
sdram controllers in OMAP5 and LPDDR2 memory devices 
in OMAP5-evm board.

Testing:
- Boot tested on OMAP5430 evm.
- Built EMIF as a module.

Changes from v2:
* Rebased on top of
  git://git.kernel.org/pub/scm/linux/kernel/git/bcousson/linux-omap-dt.git for_3.8/dts
* Addressed few other comments from Benoit.

Lokesh Vutla (3):
  ARM: dts: omap5-evm: Fix size of memory defined for EVM
  ARM: dts: omap5: EMIF device tree data for OMAP5 boards
  ARM: dts: omap5-evm: LPDDR2 memory device details for EVM

 arch/arm/boot/dts/omap5-evm.dts           |   13 +++++-
 arch/arm/boot/dts/omap5.dtsi              |   22 ++++++++++
 arch/arm/boot/dts/samsung_k3pe0e000b.dtsi |   67 +++++++++++++++++++++++++++++
 3 files changed, 101 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/samsung_k3pe0e000b.dtsi

-- 
1.7.9.5

