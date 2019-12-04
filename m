From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH 0/2] net: ethernet: ti: cpsw_switchdev: fix unmet direct dependencies detected for NET_SWITCHDEV
Date: Wed, 4 Dec 2019 19:45:31 +0200
Message-ID: <20191204174533.32207-1-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Randy Dunlap <rdunlap@infradead.org>, netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, Tony Lindgren <tony@atomide.com>
Cc: Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Grygorii Strashko <grygorii.strashko@ti.com>
List-Id: linux-omap@vger.kernel.org

This series fixes Kconfig warning with CONFIG_COMPILE_TEST=y reported by
Randy Dunlap <rdunlap@infradead.org> [1]

[1] https://lkml.org/lkml/2019/12/3/1373

Grygorii Strashko (2):
  net: ethernet: ti: cpsw_switchdev: fix unmet direct dependencies
    detected for NET_SWITCHDEV
  arm: omap2plus_defconfig: enable NET_SWITCHDEV

 arch/arm/configs/omap2plus_defconfig | 3 ++-
 drivers/net/ethernet/ti/Kconfig      | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

-- 
2.17.1
