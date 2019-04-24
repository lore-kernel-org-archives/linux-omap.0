From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [RFC PATCH v3 net-next 00/11] net: ethernet: ti: introduce new cpsw switchdev based driver
Date: Thu, 25 Apr 2019 01:24:16 +0300
Message-ID: <1556144667-27997-1-git-send-email-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
To: netdev@vger.kernel.org, Ilias Apalodimas <ilias.apalodimas@linaro.org>, Andrew Lunn <andrew@lunn.ch>, "David S . Miller" <davem@davemloft.net>, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>, Jiri Pirko <jiri@resnulli.us>
Cc: Florian Fainelli <f.fainelli@gmail.com>, Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Murali Karicheri <m-karicheri2@ti.com>, Ivan Vecera <ivecera@redhat.com>, Grygorii Strashko <grygorii.strashko@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi All,

This series based on work [1][2] done by Ilias Apalodimas <ilias.apalodimas@linaro.org>.

This the RFC v3 which introduces new CPSW switchdev based driver which is 
operating in dual-emac mode by default, thus working as 2 individual
network interfaces. When both interfaces joined the bridge - CPSW driver
will enter a switch mode and discard dual_mac configuration. The CPSW will
be switched back to dual_mac mode if any port leaves the bridge. All
configuration is going to be implemented via switchdev API.

patches #1 - 2: preparation patcces which also moves common code to cpsw_priv.c
patch #3: Adds functions to ALE for modifying VLANs/MDBs.
patch #4: Adds support of force untagged VLAN traffic to Host P0 port which
 required for proper support of default VLANs.
patch #5: Prepares cpsw driver for switchdev mode, without changing any
of the funtionality.
patches #6-9: Introduce TI CPSW switch driver based on switchdev and new
 DT bindings, resolve build dependencies
patch #10: CPSW switchdev driver documentation (tbd)
patch #11: DT nodes for new CPSW switchdev driver added for DRA7/am571x-idk as
and example.

Most of the contents of the previous cover-letter have been added in
new driver documentation, so please refer to that for configuration,
testing and future work.

These patches can be found at:
 git@git.ti.com:~gragst/ti-linux-kernel/gragsts-ti-linux-kernel.git
 branch: lkml-5.1-switch-tbd

[1] Dependencies:
 This series depends on prerequisite series
 https://lkml.org/lkml/2019/4/23/476

[1] https://patchwork.ozlabs.org/cover/929367/
[2] https://patches.linaro.org/cover/136709/

Changes in v3:
- alot of work done to split properly common code between legacy and switchdev
  CPSW drivers and clean up code
- CPSW switchdev interface updated to the current LKML switchdev interface
- actually new CPSW switchdev based driver introduced
- optimized dual_mac mode in new driver. Main change is that in promiscuous
mode P0_UNI_FLOOD (both ports) is enabled in addition to ALLMULTI (current
port) instead of ALE_BYPASS.  So, port in non promiscuous mode will keep
possibility of mcast and vlan filtering.
- changed bridge join sequnce: now switch mode will be enabled only when
both ports joined the bridge. CPSW will be switched to dual_mac mode if any
port leave bridge. ALE table is completly cleared and then refiled while
switching to switch mode - this simplidies code a lot, but introduces some
limitation to bridge setup sequence:
 ip link add name br0 type bridge
 ip link set dev br0 type bridge ageing_time 1000
 ip link set dev br0 type bridge vlan_filtering 0 <- disable
 echo 0 > /sys/class/net/br0/bridge/default_vlan

 ip link set dev sw0p1 up <- add ports
 ip link set dev sw0p2 up
 ip link set dev sw0p1 master br0
 ip link set dev sw0p2 master br0

 echo 1 > /sys/class/net/br0/bridge/default_vlan <- enable
 ip link set dev br0 type bridge vlan_filtering 1
 bridge vlan add dev br0 vid 1 pvid untagged self
- STP tested with vlan_filtering 1/0. To make STP work I've had to set
  NO_SA_UPDATE for all slave ports (see comment in code). It also required to
  statically register STP mcast address {0x01, 0x80, 0xc2, 0x0, 0x0, 0x0};
- allowed build both TI_CPSW and TI_CPSW_SWITCHDEV drivers
- PTP can be enabled on both ports in dual_mac mode

- Future work:
1. port QDISC_CBS and QDISC_MQPRIO support
2. Add support for more Bridge flags and SWITCHDEV_ATTR
3. Add support for ageing configuration
4. More testing and documentation updates

Issues:
1. I've not found that configuring VLANs on Bridge port itself
 bridge vlan add dev br0 vid 100 pvid untagged self
 does not allow to set PVID on Host P0 port. The only way to set it is to
 change default_vlan, introduces some mess in ALE table (also causes overwrite
 of already configfured PVID).
	bridge vlan add dev sw0p1 vid 100 pvid untagged master
 	ip link set dev br0 type bridge vlan_filtering 0
 	echo 2 > /sys/class/net/br0/bridge/default_vlan
 	ip link set dev br0 type bridge vlan_filtering 1
 (but it could be our mess also:()
2. Are there any way to identify Bridge default_vlan while processing
  SWITCHDEV_OBJ_ID_PORT_VLAN??

Grygorii Strashko (7):
  net: ethernet: ti: cpts: use devm_get_clk_from_child
  net: ethernet: ti: cpsw: move set of common functions in cpsw_priv
  net: ethernet: ti: cpsw: allow untagged traffic on host port
  dt-bindings: net: ti: add new cpsw switch driver bindings
  net: ethernet: ti: cpsw: fix build of cpsw drivers
  phy: ti: phy-gmii-sel: dependency from ti cpsw-switchdev driver
  ARM: dts: am57xx-idk: add dt nodes for new cpsw switch dev driver

Ilias Apalodimas (4):
  net: ethernet: ti: cpsw: ale: add functions to modify VLANs/MDBs
  net: ethernet: ti: cpsw: add switchdev API for cpsw driver
  net: ethernet: ti: cpsw: introduce cpsw switch driver based on
    switchdev
  Documentation: networking: add cpsw switchdev based driver
    documentation

 .../bindings/net/ti,cpsw-switch.txt           |  117 +
 .../device_drivers/ti/cpsw_switchdev.txt      |  159 ++
 arch/arm/boot/dts/am571x-idk.dts              |   28 +
 arch/arm/boot/dts/am57xx-idk-common.dtsi      |    2 +-
 arch/arm/boot/dts/dra7-l4.dtsi                |   53 +
 drivers/net/ethernet/ti/Kconfig               |   20 +-
 drivers/net/ethernet/ti/Makefile              |    2 +
 drivers/net/ethernet/ti/cpsw.c                |  596 +-----
 drivers/net/ethernet/ti/cpsw_ale.c            |  199 +-
 drivers/net/ethernet/ti/cpsw_ale.h            |   15 +
 drivers/net/ethernet/ti/cpsw_new.c            | 1891 +++++++++++++++++
 drivers/net/ethernet/ti/cpsw_priv.c           |  562 ++++-
 drivers/net/ethernet/ti/cpsw_priv.h           |   51 +-
 drivers/net/ethernet/ti/cpsw_switchdev.c      |  394 ++++
 drivers/net/ethernet/ti/cpsw_switchdev.h      |   22 +
 drivers/net/ethernet/ti/cpts.c                |    2 +-
 drivers/phy/ti/Kconfig                        |    4 +-
 17 files changed, 3521 insertions(+), 596 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/ti,cpsw-switch.txt
 create mode 100644 Documentation/networking/device_drivers/ti/cpsw_switchdev.txt
 create mode 100644 drivers/net/ethernet/ti/cpsw_new.c
 create mode 100644 drivers/net/ethernet/ti/cpsw_switchdev.c
 create mode 100644 drivers/net/ethernet/ti/cpsw_switchdev.h

-- 
2.17.1
