From: Mugunthan V N <mugunthanvnm@ti.com>
Subject: [net PATCH 0/2] Fixes for davinci MDIO on suspend/resume
Date: Tue, 11 Jun 2013 15:32:03 +0530
Message-ID: <1370944925-11374-1-git-send-email-mugunthanvnm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, linux-omap@vger.kernel.org, Mugunthan V N <mugunthanvnm@ti.com>
List-Id: linux-omap@vger.kernel.org

This patch series fixes the following issues with Davinci MDIO
* Bring up MDIO driver earlier than Ethernet driver so that ethernet driver
  can communicate with the phy as soon as it is resumed.
* On suspend/resume cycle the MDIO divider will be set to reset value so
  this has to be programmed after resume.

Mugunthan V N (2):
  drivers: net: davinci_mdio: moving mdio resume earlier than cpsw
    ethernet driver
  drivers: net: davinci_mdio: restore mdio clk divider in mdio resume

 drivers/net/ethernet/ti/davinci_mdio.c |    9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

-- 
1.7.9.5
