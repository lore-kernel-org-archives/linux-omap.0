From: AnilKumar Ch <anilkumar@ti.com>
Subject: [PATCH 0/3] can: Add D_CAN raminit support to am335x-evm
Date: Wed, 14 Nov 2012 23:38:22 +0530
Message-ID: <1352916505-12343-1-git-send-email-anilkumar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:35500 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755430Ab2KNSJC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 Nov 2012 13:09:02 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: wg@grandegger.com, mkl@pengutronix.de
Cc: swarren@wwwdotorg.org, linux-can@vger.kernel.org, tony@atomide.com, b-cousson@ti.com, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, grant.likely@secretlab.ca, devicetree-discuss@lists.ozlabs.org, AnilKumar Ch <anilkumar@ti.com>

This patch series adds d_can raminit support to c_can/d_can driver,
which is required to init/de-init D_CAN message RAM (holds message
objects). Added corresponding DT changes to get resource of RAMINIT
register and device instance.

These patches were tested on AM335x-EVM along with pinctrl data addition
patch, which is not added to am335x-evm.dts (only supports CPLD profile#0)
because d_can1 is supported under CPLD profile#1.

AnilKumar Ch (3):
  can: c_can: Add d_can raminit support
  ARM: dts: AM33XX: Add d_can instances to aliases
  ARM: dts: AM33XX: Add memory resource to d_can node

 arch/arm/boot/dts/am33xx.dtsi          |    8 ++++++--
 drivers/net/can/c_can/c_can.c          |   12 +++++++++++
 drivers/net/can/c_can/c_can.h          |    3 +++
 drivers/net/can/c_can/c_can_platform.c |   34 +++++++++++++++++++++++++++++++-
 4 files changed, 54 insertions(+), 3 deletions(-)

-- 
1.7.9.5

