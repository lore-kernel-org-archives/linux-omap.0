From: Markus Pargmann <mpa@pengutronix.de>
Subject: [PATCH v3 0/7] net: cpsw: Support for am335x chip MACIDs
Date: Sat, 16 Aug 2014 17:18:28 +0200
Message-ID: <1408202315-20006-1-git-send-email-mpa@pengutronix.de>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:44776 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751531AbaHPPTV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 16 Aug 2014 11:19:21 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "David S. Miller" <davem@davemloft.net>
Cc: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Wolfram Sang <wsa@the-dreams.de>, Steven Rostedt <rostedt@goodmis.org>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de, Markus Pargmann <mpa@pengutronix.de>

Hi,

This series adds support to the cpsw driver to read the MACIDs of the am335x
chip and use them as fallback. These addresses are only used if there are no
mac addresses in the devicetree, for example set by a bootloader.

In v3 I removed the previously seperate driver and included the changes into
the main cpsw driver. I now check for a am33xx machine to not make this
operation when running on davinci.

Patches 1-4 are some minor fixes for the cpsw driver.
Patch 5 adds the readout support.
Patches 6 and 7 are for am33xx.dtsi to actually enable this feature.

Best regards,

Markus Pargmann


Markus Pargmann (7):
  DT doc: net: cpsw mac-address is optional
  net: cpsw: Add missing return value
  net: cpsw: header, Add missing include
  net: cpsw: Replace pr_err by dev_err
  net: cpsw: Add am33xx MACID readout
  am33xx: define syscon control module device node
  arm: dts: am33xx, Add syscon phandle to cpsw node

 Documentation/devicetree/bindings/net/cpsw.txt |  6 +++-
 arch/arm/boot/dts/am33xx.dtsi                  |  6 ++++
 drivers/net/ethernet/ti/Kconfig                |  2 ++
 drivers/net/ethernet/ti/Makefile               |  1 +
 drivers/net/ethernet/ti/cpsw.c                 | 49 ++++++++++++++++++++++++--
 drivers/net/ethernet/ti/cpsw.h                 |  1 +
 6 files changed, 61 insertions(+), 4 deletions(-)

-- 
2.0.1

