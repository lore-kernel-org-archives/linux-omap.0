From: Mugunthan V N <mugunthanvnm@ti.com>
Subject: [PATCH 1/1] drivers: net cpsw: Enable In Band mode in cpsw for 10 mbps
Date: Fri, 13 Dec 2013 18:42:55 +0530
Message-ID: <1386940375-25168-1-git-send-email-mugunthanvnm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:54350 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751872Ab3LMNNB (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 13 Dec 2013 08:13:01 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, linux-omap@vger.kernel.org, Mugunthan V N <mugunthanvnm@ti.com>

This patch adds support for enabling In Band mode in 10 mbps speed.
RGMII supports 1 Gig and 100 mbps mode for Forced mode of operation.
For 10mbps mode it should be configured to in band mode so that link
status, duplexity and speed are determined from the RGMII input data
stream

Signed-off-by: Mugunthan V N <mugunthanvnm@ti.com>
---
 drivers/net/ethernet/ti/cpsw.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/ti/cpsw.c b/drivers/net/ethernet/ti/cpsw.c
index d80dfce..989968b 100644
--- a/drivers/net/ethernet/ti/cpsw.c
+++ b/drivers/net/ethernet/ti/cpsw.c
@@ -740,6 +740,8 @@ static void _cpsw_adjust_link(struct cpsw_slave *slave,
 		/* set speed_in input in case RMII mode is used in 100Mbps */
 		if (phy->speed == 100)
 			mac_control |= BIT(15);
+		else if (phy->speed == 10)
+			mac_control |= BIT(18); /* In Band mode */
 
 		*link = true;
 	} else {
-- 
1.8.5.1.93.g077f434

