From: Mugunthan V N <mugunthanvnm@ti.com>
Subject: [net-next PATCH v3 0/6] Adding pinctrl PM support for CPSW and MDIO
Date: Sun, 26 May 2013 23:53:30 +0530
Message-ID: <1369592616-23972-1-git-send-email-mugunthanvnm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:46009 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754621Ab3EZSWx (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 26 May 2013 14:22:53 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, benoit.cousson@linaro.org, paul@pwsan.com, Mugunthan V N <mugunthanvnm@ti.com>

This patch series adds the following features
* Adding pinctrl PM support for CPSW and MDIO for Power Optimization
* Adding phy address to the CPSW node for EVMsk board

Changes from initial version
* Fixed the multiline function call indentation as per David Miller
  recommendation.

Changes from v2
* Fixed the multi comment style as per net coding style
* Fixed checkpatch error (more than 80 characters)


Hebbar Gururaja (1):
  net: cpsw: enhance pinctrl support

Mugunthan V N (5):
  net: davinci_mdio: enhance pinctrl support
  ARM: dts: AM33XX: Add pinmux configuration for CPSW to beaglebone
  ARM: dts: AM33XX: Add CPSW phy_id device tree data to am335x-evmsk
  ARM: dts: AM33XX: Add pinmux configuration for CPSW to EVMsk
  ARM: dts: AM33XX: Add pinmux configuration for CPSW to am335x EVM

 arch/arm/boot/dts/am335x-bone.dts      |   38 +++++++++++++++++++++
 arch/arm/boot/dts/am335x-evm.dts       |   36 ++++++++++++++++++++
 arch/arm/boot/dts/am335x-evmsk.dts     |   58 ++++++++++++++++++++++++++++++++
 drivers/net/ethernet/ti/cpsw.c         |   48 ++++++++++++++++++++++++++
 drivers/net/ethernet/ti/davinci_mdio.c |   45 +++++++++++++++++++++++++
 5 files changed, 225 insertions(+)

-- 
1.7.9.5

