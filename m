From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH 0/4] Add USB Host support for OMAP5 uevm
Date: Wed, 24 Jul 2013 17:32:32 +0300
Message-ID: <1374676356-31286-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:49075 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753113Ab3GXOdG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 24 Jul 2013 10:33:06 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, benoit.cousson@linaro.org
Cc: t-kristo@ti.com, mturquette@linaro.org, balbi@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, Roger Quadros <rogerq@ti.com>

Hi,

These patches provide USB host support for the OMAP5 uEVM board.

They depend on the OMAP clock tree DT data series by Tero Kristo [1]

In patch 3 we also provide USB PHY clock for Panda. This should make
the clock alias patch [2] redundant and it should be reverted when
this series gets in.

[1] - http://thread.gmane.org/gmane.linux.ports.arm.omap/101582

[2] - ARM: OMAP2+: Provide alias to USB PHY clock
http://git.kernel.org/cgit/linux/kernel/git/tmlind/linux-omap.git/commit/?h=omap-for-v3.11/fixes&id=741532c4a995be11815cb72d4d7a48f442a22fea

cheers,
-roger

---
Roger Quadros (4):
  ARM: OMAP5: hwmod data: Add USB Host and TLL modules
  ARM: dts: OMAP5: Add 60MHz clock reference to USB Host module
  ARM: dts: omap4-panda: Provide USB PHY clock
  ARM: dts: omap5-uevm: Provide USB PHY clock

 arch/arm/boot/dts/omap4-panda-common.dtsi  |    8 +-
 arch/arm/boot/dts/omap5-uevm.dts           |    8 +-
 arch/arm/boot/dts/omap5.dtsi               |    2 +
 arch/arm/mach-omap2/omap_hwmod_54xx_data.c |  157 ++++++++++++++++++++++++++++
 4 files changed, 163 insertions(+), 12 deletions(-)

-- 
1.7.4.1

