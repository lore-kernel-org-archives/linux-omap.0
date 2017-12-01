From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH net-next 00/11] net: ethernet: ti: cpsw/ale clean up and optimization
Date: Thu, 30 Nov 2017 18:21:09 -0600
Message-ID: <20171201002120.13483-1-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Cc: Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>, Murali Karicheri <m-karicheri2@ti.com>, Grygorii Strashko <grygorii.strashko@ti.com>
List-Id: linux-omap@vger.kernel.org

This is set of non critical clean ups and optimizations for TI
CPSW and ALE drivers.

Rebased on top on net-next.

Grygorii Strashko (11):
  net: ethernet: ti: cpsw: drop unused var poll from
    cpsw_update_channels_res
  net: ethernet: ti: cpsw: use proper io apis
  net: ethernet: ti: cpsw: move platform data struct to .c file
  net: ethernet: ti: cpsw: move mac_hi/lo defines in cpsw.h
  net: ethernet: ti: cpsw: fix ale port numbers
  net: ethernet: ti: ale: use proper io apis
  net: ethernet: ti: ale: disable ale from stop()
  net: ethernet: ti: ale: optimize ale entry mask bits configuartion
  net: ethernet: ti: ale: move static initialization in
    cpsw_ale_create()
  net: ethernet: ti: ale: use devm_kzalloc in cpsw_ale_create()
  net: ethernet: ti: ale: fix port check in cpsw_ale_control_set/get

 drivers/net/ethernet/ti/cpsw.c        |  84 +++++++++++++++-----------
 drivers/net/ethernet/ti/cpsw.h        |  23 +------
 drivers/net/ethernet/ti/cpsw_ale.c    | 109 ++++++++++++++--------------------
 drivers/net/ethernet/ti/cpsw_ale.h    |   1 -
 drivers/net/ethernet/ti/netcp_ethss.c |   6 +-
 5 files changed, 98 insertions(+), 125 deletions(-)

-- 
2.10.5
