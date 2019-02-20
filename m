From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH 0/6] ARM: dts: ti: cpsw: switch to phy-gmii-sel phy driver
Date: Wed, 20 Feb 2019 17:25:13 +0200
Message-ID: <1550676319-6440-1-git-send-email-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "David S. Miller" <davem@davemloft.net>, Kishon Vijay Abraham I <kishon@ti.com>, Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>
Cc: devicetree@vger.kernel.org, Grygorii Strashko <grygorii.strashko@ti.com>, netdev@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi Tony,

Hence prerequisite patches [1] have been merged already I'm sending final set
of DT patches to complete conversation of TI CPSW driver to use phy-gmii-sel
phy driver instead of cpsw-phy-sel. 

[1] https://lkml.org/lkml/2018/11/26/154

Grygorii Strashko (6):
  ARM: dts: dra7: switch to use phy-gmii-sel
  ARM: dts: dm814x: switch to use phy-gmii-sel
  ARM: dts: am4372: switch to use phy-gmii-sel
  ARM: dts: am335x: switch to use phy-gmii-sel
  dt-bindings: net: ti: deprecate cpsw-phy-sel bindings
  net: ethernet: ti: cpsw: deprecate cpsw-phy-sel driver

 .../devicetree/bindings/net/cpsw-phy-sel.txt    |  2 +-
 arch/arm/boot/dts/am335x-baltos-ir2110.dts      |  4 ----
 arch/arm/boot/dts/am335x-baltos-ir3220.dts      |  4 ----
 arch/arm/boot/dts/am335x-baltos-ir5221.dts      |  4 ----
 arch/arm/boot/dts/am335x-chiliboard.dts         |  4 ----
 arch/arm/boot/dts/am335x-icev2.dts              |  4 ----
 arch/arm/boot/dts/am335x-igep0033.dtsi          |  4 ----
 arch/arm/boot/dts/am335x-lxm.dts                |  4 ----
 .../boot/dts/am335x-moxa-uc-2100-common.dtsi    |  5 -----
 arch/arm/boot/dts/am335x-moxa-uc-8100-me-t.dts  |  5 -----
 arch/arm/boot/dts/am335x-phycore-som.dtsi       |  4 ----
 arch/arm/boot/dts/am33xx-l4.dtsi                | 15 ++++++++-------
 arch/arm/boot/dts/am437x-l4.dtsi                | 17 +++++++++--------
 arch/arm/boot/dts/am43x-epos-evm.dts            |  5 +----
 arch/arm/boot/dts/dm814x.dtsi                   | 15 +++++++++------
 arch/arm/boot/dts/dra7-l4.dtsi                  | 15 ++++++++-------
 drivers/net/ethernet/ti/Kconfig                 |  6 +++---
 drivers/net/ethernet/ti/cpsw.h                  |  6 ++++++
 18 files changed, 45 insertions(+), 78 deletions(-)

-- 
2.17.1
