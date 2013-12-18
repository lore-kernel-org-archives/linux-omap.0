From: Markus Pargmann <mpa@pengutronix.de>
Subject: [PATCH 1/6] DT doc: net: cpsw mac-address is optional
Date: Wed, 18 Dec 2013 17:47:17 +0100
Message-ID: <1387385242-1161-2-git-send-email-mpa@pengutronix.de>
References: <1387385242-1161-1-git-send-email-mpa@pengutronix.de>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:42026 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755199Ab3LRQsW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 Dec 2013 11:48:22 -0500
In-Reply-To: <1387385242-1161-1-git-send-email-mpa@pengutronix.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "David S. Miller" <davem@davemloft.net>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>
Cc: linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de, Markus Pargmann <mpa@pengutronix.de>

mac-address is an optional property. If no mac-address is set, a random
mac-address will be generated.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 Documentation/devicetree/bindings/net/cpsw.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/cpsw.txt b/Documentation/devicetree/bindings/net/cpsw.txt
index 05d660e..c39f077 100644
--- a/Documentation/devicetree/bindings/net/cpsw.txt
+++ b/Documentation/devicetree/bindings/net/cpsw.txt
@@ -30,10 +30,10 @@ Required properties:
 - phy_id		: Specifies slave phy id
 - phy-mode		: The interface between the SoC and the PHY (a string
 			  that of_get_phy_mode() can understand)
-- mac-address		: Specifies slave MAC address
 
 Optional properties:
 - dual_emac_res_vlan	: Specifies VID to be used to segregate the ports
+- mac-address		: Specifies slave MAC address
 
 Note: "ti,hwmods" field is used to fetch the base address and irq
 resources from TI, omap hwmod data base during device registration.
-- 
1.8.5.1

