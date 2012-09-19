From: AnilKumar Ch <anilkumar@ti.com>
Subject: [PATCH RESEND 0/5] ARM: dts: AM33XX: Add device tree data
Date: Thu, 20 Sep 2012 02:49:25 +0530
Message-ID: <1348089570-16161-1-git-send-email-anilkumar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:49385 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751703Ab2ISVUF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 Sep 2012 17:20:05 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: b-cousson@ti.com, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, AnilKumar Ch <anilkumar@ti.com>

Add device tree data of pinctrl, d_can, lis331dlh and tmp275 drivers
for AM33XX family of devices. These patches were submitted earlier
and reviewed. Re-sending to apply cleanly on linux-omap/devel-dt
tree. These patches were tested on am33xx-evm and am335x-bone.

AnilKumar Ch (5):
  ARM: dts: AM33XX: Add basic pinctrl device tree data
  ARM: dts: AM33XX: Add D_CAN device tree data
  ARM: OMAP2+: AM33XX: Add clock entries to omap_clk data
  ARM: dts: AM33XX: Add lis331dlh device tree data to am335x-evm
  ARM: dts: AM33XX: Add temperature sensor device tree data to
    am335x-evm

 arch/arm/boot/dts/am335x-evm.dts     |   44 ++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/am33xx.dtsi        |   27 +++++++++++++++++++++
 arch/arm/mach-omap2/clock33xx_data.c |    1 +
 3 files changed, 72 insertions(+)

-- 
1.7.9.5

