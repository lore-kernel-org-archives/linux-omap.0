From: Mugunthan V N <mugunthanvnm@ti.com>
Subject: [net-next PATCH 0/3] Adding phy register fixup in DT
Date: Mon, 22 Apr 2013 23:50:35 +0530
Message-ID: <1366654838-26479-1-git-send-email-mugunthanvnm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, Mugunthan V N <mugunthanvnm@ti.com>
List-Id: linux-omap@vger.kernel.org

In earlier days phy fixup was added to phy frame work in board files.
As there won't be any board files here after the same has to be done in DT
This patch series adds the following features
* support for adding phy resigter fixup via DT
* adds phy id for EVMsk n DTS file
* adds phy fixup for AM335x EVM and EVMsk

Mugunthan V N (3):
  drivers: of: add phy fixup support in DT
  ARM: dts: AM33XX: Add CPSW phy_id device tree data to am335x-evmsk
  ARM: dts: AM33XX: add phy fixup for evm and evmsk boards

 .../devicetree/bindings/net/phy-fixup.txt          |   26 ++++++
 arch/arm/boot/dts/am335x-evm.dts                   |   10 +++
 arch/arm/boot/dts/am335x-evmsk.dts                 |   18 ++++
 drivers/of/of_net.c                                |   92 ++++++++++++++++++++
 include/linux/of_net.h                             |    6 ++
 5 files changed, 152 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/phy-fixup.txt

-- 
1.7.9.5
