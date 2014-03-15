From: Markus Pargmann <mpa@pengutronix.de>
Subject: [PATCH v2 0/5] net: cpsw: Support for am335x chip MACIDs
Date: Sat, 15 Mar 2014 14:07:39 +0100
Message-ID: <1394888864-11007-1-git-send-email-mpa@pengutronix.de>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:44263 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756076AbaCONJB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 15 Mar 2014 09:09:01 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "David S. Miller" <davem@davemloft.net>
Cc: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de, Markus Pargmann <mpa@pengutronix.de>

Hi,

This series introduces a driver to read and use the MACIDs stored in the am335x
control module. These are read-only registers for a unique MACID. At the moment
the MACIDs are generated randomly when the mac-address property is not a valid
mac address.

In v2 I changed the precedence of mac-address and this driver. This driver is
only used when no mac-address was set by the bootloader. This way we can avoid
using random MAC addresses.  There are other minor style and documentation
fixes in v2.

Best regards,

Markus


Markus Pargmann (5):
  net: cpsw: document mac-address being optional
  net: cpsw: make cpsw.h self-contained
  net: cpsw: Add control-module macid driver
  net: cpsw: Use cpsw-ctrl-macid driver
  arm: dts: am33xx, Add device node for cpsw-ctrl-macid

 .../devicetree/bindings/net/cpsw-ctrl-macid.txt    |  32 +++++
 Documentation/devicetree/bindings/net/cpsw.txt     |   8 +-
 arch/arm/boot/dts/am33xx.dtsi                      |   9 ++
 drivers/net/ethernet/ti/Kconfig                    |   1 +
 drivers/net/ethernet/ti/Makefile                   |   2 +-
 drivers/net/ethernet/ti/cpsw-ctrl-macid.c          | 138 +++++++++++++++++++++
 drivers/net/ethernet/ti/cpsw.c                     |  16 ++-
 drivers/net/ethernet/ti/cpsw.h                     |   3 +
 8 files changed, 204 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/cpsw-ctrl-macid.txt
 create mode 100644 drivers/net/ethernet/ti/cpsw-ctrl-macid.c

-- 
1.9.0

