From: Mugunthan V N <mugunthanvnm@ti.com>
Subject: [net-next PATCH 0/2] network performance improvement patches for TI CPSW and Davinci EMAC drivers
Date: Wed, 27 Mar 2013 20:11:58 +0530
Message-ID: <1364395320-14973-1-git-send-email-mugunthanvnm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:44816 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751837Ab3C0OmN (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 27 Mar 2013 10:42:13 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, linux-omap@vger.kernel.org, Mugunthan V N <mugunthanvnm@ti.com>

This patch series improves network performance of TI CPSW and Davinci EMAC
drivers during bulk transfer. During heavy Tx load CPDMA may run out of
descriptors and tx queue is stopped. When it descriptors are available it
is reported to the stack via netif_start_queue which doesn't schedule tx
queue immediately, so there can be dead time during continuous transfer,
this can be fixed by using netif_wake_queue api which will schedule tx queue
immediately.

Mugunthan V N (2):
  drivers: net: ethernet: cpsw: use netif_wake_queue() while restarting
    tx queue
  drivers: net: ethernet: davinci_emac: use netif_wake_queue() while
    restarting tx queue

 drivers/net/ethernet/ti/cpsw.c         |    2 +-
 drivers/net/ethernet/ti/davinci_emac.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
1.7.9.5

