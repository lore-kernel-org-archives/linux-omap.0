From: Markus Pargmann <mpa@pengutronix.de>
Subject: [PATCH v2 2/5] net: cpsw: make cpsw.h self-contained
Date: Sat, 15 Mar 2014 14:07:41 +0100
Message-ID: <1394888864-11007-3-git-send-email-mpa@pengutronix.de>
References: <1394888864-11007-1-git-send-email-mpa@pengutronix.de>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:44241 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756076AbaCONIx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 15 Mar 2014 09:08:53 -0400
In-Reply-To: <1394888864-11007-1-git-send-email-mpa@pengutronix.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "David S. Miller" <davem@davemloft.net>
Cc: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de, Markus Pargmann <mpa@pengutronix.de>

cpsw.h uses the symbol MII_BUS_ID_SIZE which is defined in
<linux/phy.h>. Add the respective #include to not depend on users to
include it themselves.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 drivers/net/ethernet/ti/cpsw.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/ti/cpsw.h b/drivers/net/ethernet/ti/cpsw.h
index 574f49d..1b71067 100644
--- a/drivers/net/ethernet/ti/cpsw.h
+++ b/drivers/net/ethernet/ti/cpsw.h
@@ -15,6 +15,7 @@
 #define __CPSW_H__
 
 #include <linux/if_ether.h>
+#include <linux/phy.h>
 
 struct cpsw_slave_data {
 	char		phy_id[MII_BUS_ID_SIZE];
-- 
1.9.0

