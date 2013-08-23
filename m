From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH v2 0/5] cpsw: support for control module register
Date: Fri, 23 Aug 2013 10:43:32 +0200
Message-ID: <1377247417-27386-1-git-send-email-zonque@gmail.com>
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
To: netdev@vger.kernel.org
Cc: nsekhar@ti.com, sergei.shtylyov@cogentembedded.com, davem@davemloft.net, ujhelyi.m@gmail.com, mugunthanvnm@ti.com, vaibhav.bedia@ti.com, d-gerlach@ti.com, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, Daniel Mack <zonque@gmail.com>
List-Id: linux-omap@vger.kernel.org

v1 -> v2:
	* combine devm_request_mem_region() and devm_ioremap() and use
	  devm_ioremap_resource() (reported by Sergei Shtylyov)
	* fix multi-line comment style (reported by Sergei Shtylyov)
	* fix ti,rmii-clock-ext property name (reported by Sekhar)
	* rebased to net-next (reported by Mugunthan V N, David Miller)
	* add a new compatible type, and handle AM33xx specific
	  registers that way (reported by Sekhar)
	* move gmii_sel_reg modifications to the open routine
	  (reported by Mugunthan V N)


Daniel Mack (5):
  net: ethernet: cpsw: switch to devres allocations
  net: ethernet: cpsw: add optional third memory region for CONTROL
    module
  net: ethernet: cpsw: introduce ti,am3352-cpsw compatible string
  net: ethernet: cpsw: add support for hardware interface mode config
  ARM: dts: am33xx: adopt to cpsw changes

 Documentation/devicetree/bindings/net/cpsw.txt |  10 +-
 arch/arm/boot/dts/am33xx.dtsi                  |   5 +-
 drivers/net/ethernet/ti/cpsw.c                 | 254 ++++++++++++++-----------
 drivers/net/ethernet/ti/cpsw.h                 |   2 +
 4 files changed, 159 insertions(+), 112 deletions(-)

-- 
1.8.3.1
