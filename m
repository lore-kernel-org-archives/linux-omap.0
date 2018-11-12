From: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [PATCH net-next 0/4] net: ethernet: ti: cpsw: allow vlan h/w timestamping
Date: Mon, 12 Nov 2018 16:00:19 +0200
Message-ID: <20181112140023.12407-1-ivan.khoronzhuk@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: grygorii.strashko@ti.com, davem@davemloft.net
Cc: linux-omap@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
List-Id: linux-omap@vger.kernel.org

The patchset adds several improvements and allows vlan h/w ts.

Based on net-next/master

Ivan Khoronzhuk (4):
  net: ethernet: ti: cpts: correct debug for expired txq skb
  net: ethernet: ti: cpts: purge staled skbs from txq
  net: ethernet: ti: cpts: move enable/disable flags outside of cpts
    module
  net: ethernet: ti: cpsw: allow vlan tagged packets to be timestamped

 drivers/net/ethernet/ti/cpsw.c        | 51 ++++++++++++++-------------
 drivers/net/ethernet/ti/cpts.c        | 32 +++++++++++++----
 drivers/net/ethernet/ti/cpts.h        | 38 --------------------
 drivers/net/ethernet/ti/netcp_ethss.c | 32 +++++++++--------
 4 files changed, 69 insertions(+), 84 deletions(-)

-- 
2.17.1
