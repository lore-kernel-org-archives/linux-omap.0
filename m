From: Mugunthan V N <mugunthanvnm@ti.com>
Subject: [PATCH v3 0/2] Add CPSW VLAN Support
Date: Fri, 1 Feb 2013 00:33:18 +0530
Message-ID: <1359659000-25995-1-git-send-email-mugunthanvnm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:43319 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751945Ab3AaTFV (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 31 Jan 2013 14:05:21 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Mugunthan V N <mugunthanvnm@ti.com>

CPSW is capable of filtering VLAN packets in hardware. This patch series
implements VLAN support to CPSW driver.
This patch series is tested on net-next with AM335x EVM with ping test.

Changes from initial version
* added vlan support to existing add/delete unicast/multicast apis
* Made driver as default VLAN enabled so that drivers need to be recompiled
  when stack is compiled with VLAN

Changes from V2
* Moved repeated code to static inline function
* Made vlan add/delete function return type to void as it is not used in
  the current driver implementation
* Modified cpsw_add_default_vlan for better readability
* changed BIT(1) port representation to defines

Mugunthan V N (2):
  drivers: net: cpsw: Add helper functions for VLAN ALE implementation
  drivers: net:ethernet: cpsw: add support for VLAN

 Documentation/devicetree/bindings/net/cpsw.txt |    2 +
 drivers/net/ethernet/ti/cpsw.c                 |   93 +++++++++++++++++++--
 drivers/net/ethernet/ti/cpsw_ale.c             |  105 +++++++++++++++++++++---
 drivers/net/ethernet/ti/cpsw_ale.h             |   24 ++++--
 include/linux/platform_data/cpsw.h             |    1 +
 5 files changed, 201 insertions(+), 24 deletions(-)

-- 
1.7.9.5

