From: Mugunthan V N <mugunthanvnm@ti.com>
Subject: [PATCH 0/3] add pin-mux configuration for AM33xx CPSW
Date: Mon, 25 Mar 2013 12:57:55 +0530
Message-ID: <1364196478-16688-1-git-send-email-mugunthanvnm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:56857 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754999Ab3CYH2N (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 25 Mar 2013 03:28:13 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: devicetree-discuss@lists.ozlabs.org, b-cousson@ti.com, benoit.cousson@linaro.org, tony@atomide.com, Mugunthan V N <mugunthanvnm@ti.com>

Adding pinmux configuration to AM33xx board dts file.

Mugunthan V N (3):
  ARM: dts: AM33XX: Add pinmux configuration for CPSW to beaglebone
  ARM: dts: AM33XX: Add pinmux configuration for CPSW to EVMsk
  ARM: dts: AM33XX: Add pinmux configuration for CPSW to am335x EVM

 arch/arm/boot/dts/am335x-bone.dts  |   25 +++++++++++++++++++++++-
 arch/arm/boot/dts/am335x-evm.dts   |   24 ++++++++++++++++++++++-
 arch/arm/boot/dts/am335x-evmsk.dts |   38 +++++++++++++++++++++++++++++++++++-
 3 files changed, 84 insertions(+), 3 deletions(-)

-- 
1.7.9.5

