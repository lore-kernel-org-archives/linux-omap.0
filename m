From: AnilKumar Ch <anilkumar@ti.com>
Subject: [PATCH v2 0/2] Add D_CAN device tree data to AM335x-EVM
Date: Wed, 25 Jul 2012 17:53:30 +0530
Message-ID: <1343219012-19472-1-git-send-email-anilkumar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:51498 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756555Ab2GYMYl (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 25 Jul 2012 08:24:41 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, wg@grandegger.com, mkl@pengutronix.de, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, grant.likely@secretlab.ca, AnilKumar Ch <anilkumar@ti.com>

Thid patch series adds device tree data to AM335x-EVM file and
adds pinmux settings required to configure two of the AM335x EVM
pins to D_CAN TX/RX pins.

Changes from v1:
	- These two patches separated from c_can DT support
	  patch series.

AnilKumar Ch (2):
  arm/dts: AM33XX: Add D_CAN device tree data
  arm/dts: AM33XX: Configure pinmuxs for D_CAN1 on AM335x-EVM

 arch/arm/boot/dts/am335x-evm.dts |   13 +++++++++++++
 arch/arm/boot/dts/am33xx.dtsi    |    5 +++++
 2 files changed, 18 insertions(+)

-- 
1.7.9.5

