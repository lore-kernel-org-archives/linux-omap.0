From: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [PATCH v2 0/5] net: ethernet: ti: cpsw: correct common res usage
Date: Thu, 19 Jan 2017 18:58:22 +0200
Message-ID: <1484845107-30331-1-git-send-email-ivan.khoronzhuk@linaro.org>
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
To: mugunthanvnm@ti.com
Cc: grygorii.strashko@ti.com, netdev@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
List-Id: linux-omap@vger.kernel.org

This series is intended to remove unneeded redundancies connected with
common resource usage function.

Since v1:
- changed name to cpsw_get_usage_count()
- added comments to open/closw for cpsw_get_usage_count()
- added patch:
  net: ethernet: ti: cpsw: clarify ethtool ops changing num of descs

Based on net-next/master

Ivan Khoronzhuk (5):
  net: ethernet: ti: cpsw: remove dual check from common res usage
    function
  net: ethernet: ti: cpsw: don't disable interrupts in ndo_open
  net: ethernet: ti: cpsw: don't duplicate ndev_running
  net: ethernet: ti: cpsw: don't duplicate common res in rx handler
  net: ethernet: ti: cpsw: clarify ethtool ops changing num of descs

 drivers/net/ethernet/ti/cpsw.c | 200 ++++++++++++++++++-----------------------
 1 file changed, 88 insertions(+), 112 deletions(-)

-- 
2.7.4
