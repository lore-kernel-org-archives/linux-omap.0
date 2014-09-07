From: Markus Pargmann <mpa@pengutronix.de>
Subject: [PATCH v6 0/7] DT doc: net: cpsw mac-address is optional
Date: Sun,  7 Sep 2014 19:19:28 +0200
Message-ID: <1410110375-3570-1-git-send-email-mpa@pengutronix.de>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:58144 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752605AbaIGRUf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 7 Sep 2014 13:20:35 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "David S. Miller" <davem@davemloft.net>
Cc: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Wolfram Sang <wsa@the-dreams.de>, Steven Rostedt <rostedt@goodmis.org>, Mugunthan V N <mugunthanvnm@ti.com>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de, Markus Pargmann <mpa@pengutronix.de>

This series adds support to the cpsw driver to read the MACIDs of the am335x
chip and use them as fallback. These addresses are only used if there are no
mac addresses in the devicetree, for example set by a bootloader.

v6 moves the machine check in patch 5 out of cpsw_am33xx_cm_get_macid() so that
this function is only called for am33xx.

Best regards,

Markus


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
 drivers/net/ethernet/ti/cpsw.c                 | 45 ++++++++++++++++++++++++--
 drivers/net/ethernet/ti/cpsw.h                 |  1 +
 5 files changed, 57 insertions(+), 3 deletions(-)

-- 
2.1.0

