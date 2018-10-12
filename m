From: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [PATCH 0/2] net: ethernet: ti: cpsw fix mcast packet lost
Date: Fri, 12 Oct 2018 18:28:13 +0300
Message-ID: <20181012152815.31320-1-ivan.khoronzhuk@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: grygorii.strashko@ti.com, davem@davemloft.net
Cc: linux-omap@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
List-Id: linux-omap@vger.kernel.org

The patchset omits redundant refresh of mcast address table and
prevents mcast packet lost.

Based on net-next/master
tested on am572x evm

Ivan Khoronzhuk (2):
  net: ethernet: ti: cpsw_ale: use const for API having pointer on mac
    address
  net: ethernet: ti: cpsw: fix lost of mcast packets while rx_mode
    update

 drivers/net/ethernet/ti/cpsw.c     | 46 ++++++++++++++++++------------
 drivers/net/ethernet/ti/cpsw_ale.c | 12 ++++----
 drivers/net/ethernet/ti/cpsw_ale.h |  8 +++---
 3 files changed, 38 insertions(+), 28 deletions(-)

-- 
2.17.1
