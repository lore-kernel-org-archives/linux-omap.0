From: Mugunthan V N <mugunthanvnm@ti.com>
Subject: [PATCH v4 0/2] Add CPSW VLAN Support
Date: Tue, 5 Feb 2013 23:56:46 +0530
Message-ID: <1360088808-8971-1-git-send-email-mugunthanvnm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Mugunthan V N <mugunthanvnm@ti.com>
List-Id: linux-omap@vger.kernel.org

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

Changes from V3
* Dropped default VLAN id passing from DT, will find a way to pass it through
  ethtool or similar interface and submit the patch.

Mugunthan V N (2):
  drivers: net: cpsw: Add helper functions for VLAN ALE implementation
  drivers: net:ethernet: cpsw: add support for VLAN

 drivers/net/ethernet/ti/cpsw.c     |  114 ++++++++++++++++++++++++++++++++++--
 drivers/net/ethernet/ti/cpsw_ale.c |  107 +++++++++++++++++++++++++++++----
 drivers/net/ethernet/ti/cpsw_ale.h |   24 ++++++--
 include/linux/platform_data/cpsw.h |    1 +
 4 files changed, 222 insertions(+), 24 deletions(-)

-- 
1.7.9.5
