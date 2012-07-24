From: AnilKumar Ch <anilkumar@ti.com>
Subject: [PATCH v2 0/4] Add AM33XX regulators device tree data
Date: Tue, 24 Jul 2012 11:48:51 +0530
Message-ID: <1343110735-10640-1-git-send-email-anilkumar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:60053 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755358Ab2GXGTP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Jul 2012 02:19:15 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, broonie@opensource.wolfsonmicro.com, AnilKumar Ch <anilkumar@ti.com>

This patch series add AM33XX regulators (tps65910/tps65217) device
tree data to am335x-evm and am335x-bone dts files. These patches
are based on Tony L "devel-dt" tree and tested on AM335x EVM and
Bone devices.

Changes from v1:
	- Incorporated all Mark Brown's review comments on v1 by
	  * moving all the regulator constraints to corresponding
	    DTS file
	  * Regulator constraints are added according to board.
	- regulator name is added.

AnilKumar Ch (4):
  ARM: OMAP2+: AM33XX: Add tps65910 device tree data
  ARM: OMAP2+: AM33XX: Add tps65217 device tree data
  arm/dts: Add tps65910 regulator DT data to am335x-evm.dts
  arm/dts: Add tps65217 regulator DT data to am335x-bone.dts

 arch/arm/boot/dts/am335x-bone.dts |   28 ++++++++++++
 arch/arm/boot/dts/am335x-evm.dts  |   28 ++++++++++++
 arch/arm/boot/dts/tps65217.dtsi   |   56 ++++++++++++++++++++++++
 arch/arm/boot/dts/tps65910.dtsi   |   86 +++++++++++++++++++++++++++++++++++++
 4 files changed, 198 insertions(+)
 create mode 100644 arch/arm/boot/dts/tps65217.dtsi
 create mode 100644 arch/arm/boot/dts/tps65910.dtsi

-- 
1.7.9.5

