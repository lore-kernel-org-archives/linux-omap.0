From: Mugunthan V N <mugunthanvnm@ti.com>
Subject: [PATCH 0/2] Add CPSW VLAN Support
Date: Tue, 29 Jan 2013 01:42:23 +0530
Message-ID: <1359403945-28585-1-git-send-email-mugunthanvnm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:52905 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751155Ab3A1UOk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 28 Jan 2013 15:14:40 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Mugunthan V N <mugunthanvnm@ti.com>

CPSW is capable of filtering VLAN packets in hardware. This patch series
implements VLAN support to CPSW driver.
This patch series is tested on net-next with AM335x EVM with ping test.


Mugunthan V N (2):
  drivers: net: cpsw: Add helper functions for VLAN ALE implementation
  drivers: net:ethernet: cpsw: add support for VLAN

 Documentation/devicetree/bindings/net/cpsw.txt |    2 +
 drivers/net/ethernet/ti/cpsw.c                 |  108 ++++++++++++++-
 drivers/net/ethernet/ti/cpsw_ale.c             |  172 +++++++++++++++++++++++-
 drivers/net/ethernet/ti/cpsw_ale.h             |   11 ++
 include/linux/platform_data/cpsw.h             |    1 +
 5 files changed, 288 insertions(+), 6 deletions(-)

-- 
1.7.9.5

