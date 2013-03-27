From: Vaibhav Hiremath <hvaibhav@ti.com>
Subject: [PATCH 0/5] ARM: dts: AM33XX: Cleanup and pinctrl binding support
Date: Wed, 27 Mar 2013 18:29:11 +0530
Message-ID: <1364389156-8273-1-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:38935 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751049Ab3C0M7a (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 27 Mar 2013 08:59:30 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, b-cousson@ti.com, mporter@ti.com, devicetree-discuss@lists.ozlabs.org, Vaibhav Hiremath <hvaibhav@ti.com>

This patch series fixes the numbering schema for I2C and GPIO
module and adds the pin-control binding for I2C, UART, GPIO-LED across
supported platforms (EVM, EVM-SK and Bone).

I have divided patches based on functionality and _not_
into EVM/Board perspective.

Vaibhav Hiremath (5):
  ARM: dts: AM33XX: Fix the i2c numbering to match hardware/TRM
  ARM: dts: AM33XX: Add default pinctrl binding for I2C device
  ARM: dts: AM33XX: Fix gpio numbering to match hardware/TRM
  ARM: dts: AM33XX: Add pinctrl binding to gpio-leds node
  ARM: dts: AM33XX: Add default pinctrl binding for UART0 device

 arch/arm/boot/dts/am335x-bone.dts  |   35 +++++++++++++++++++++----
 arch/arm/boot/dts/am335x-evm.dts   |   48 +++++++++++++++++++++++++++++------
 arch/arm/boot/dts/am335x-evmsk.dts |   43 ++++++++++++++++++++++++-------
 arch/arm/boot/dts/am33xx.dtsi      |   14 +++++-----
 4 files changed, 108 insertions(+), 32 deletions(-)

